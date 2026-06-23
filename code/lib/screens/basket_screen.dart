import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/menu_data.dart';
import '../data/menu_item.dart';
import '../models/cart_model.dart';
import '../theme/app_theme.dart';

const _quickSauceNames = [
  'Chilli Sauce',
  'Garlic Sauce',
  'Mint Sauce',
  'BBQ Sauce',
  'Ketchup',
  'Tub Of Curry',
  'Tub Of Gravy',
];

const double _deliveryFee = 2.00;

MenuItem? _findMenuItem(String name) {
  for (final tab in MenuData.tabs) {
    for (final section in tab.sections) {
      for (final item in section.items) {
        if (item.name == name) return item;
      }
    }
  }
  return null;
}

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final lines = cart.lines;

    return Container(
      color: AppColors.bg,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 4),
              child: Text(
                'Basket',
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 20),
              ),
            ),
            Expanded(
              child: lines.isEmpty
                  ? _EmptyBasket()
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                      children: [
                        ...lines.map((l) => _CartRow(line: l)),
                        const SizedBox(height: 8),
                        _SauceStrip(cart: cart),
                        const SizedBox(height: 16),
                        _Summary(subtotal: cart.subtotal),
                      ],
                    ),
            ),
            if (lines.isNotEmpty)
              _PlaceOrderButton(total: cart.subtotal + _deliveryFee),
          ],
        ),
      ),
    );
  }
}

class _EmptyBasket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 44,
            color: AppColors.text3,
          ),
          const SizedBox(height: 12),
          const Text(
            'Your basket is empty',
            style: TextStyle(color: AppColors.text2, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _CartRow extends StatelessWidget {
  final CartLine line;
  const _CartRow({required this.line});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartModel>();
    final atMin = line.qty <= 1;

    return Dismissible(
      key: ValueKey(line.key),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => cart.removeLine(line),
      background: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                line.item.emoji,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${line.qty}× ${line.item.name}',
                    style: AppTextStyles.cardName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (line.size.label.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        line.size.label.toLowerCase(),
                        style: AppTextStyles.cardDesc,
                      ),
                    ),
                ],
              ),
            ),
            _QtyPill(
              qty: line.qty,
              atMin: atMin,
              onDecrement: atMin ? null : () => cart.setQty(line, line.qty - 1),
              onIncrement: () => cart.setQty(line, line.qty + 1),
            ),
            const SizedBox(width: 10),
            Text(
              '£${line.lineTotal.toStringAsFixed(2)}',
              style: AppTextStyles.cardPrice,
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyPill extends StatelessWidget {
  final int qty;
  final bool atMin;
  final VoidCallback? onDecrement;
  final VoidCallback onIncrement;
  const _QtyPill({
    required this.qty,
    required this.atMin,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyIcon(icon: Icons.remove, onTap: onDecrement, dimmed: atMin),
          SizedBox(
            width: 22,
            child: Text(
              '$qty',
              textAlign: TextAlign.center,
              style: AppTextStyles.cardName.copyWith(fontSize: 12),
            ),
          ),
          _QtyIcon(icon: Icons.add, onTap: onIncrement),
        ],
      ),
    );
  }
}

class _QtyIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool dimmed;
  const _QtyIcon({required this.icon, this.onTap, this.dimmed = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 14,
          color: dimmed ? AppColors.text3 : AppColors.text1,
        ),
      ),
    );
  }
}

class _SauceStrip extends StatelessWidget {
  final CartModel cart;
  const _SauceStrip({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Anything to dip?', style: AppTextStyles.cardName),
          const SizedBox(height: 2),
          Text('Add a sauce to your order', style: AppTextStyles.cardDesc),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _quickSauceNames.map((name) {
              final menuItem = _findMenuItem(name);
              if (menuItem == null) return const SizedBox.shrink();
              final size = menuItem.priceOptions.first;
              final isOn = cart.lines.any(
                (l) => l.item.name == name && l.size.label == size.label,
              );
              return GestureDetector(
                onTap: () {
                  final existing = cart.lines.where(
                    (l) => l.item.name == name && l.size.label == size.label,
                  );
                  if (existing.isNotEmpty) {
                    cart.removeLine(existing.first);
                  } else {
                    cart.add(menuItem, size);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: isOn
                        ? AppColors.accent.withValues(alpha: 0.16)
                        : AppColors.surface2,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isOn ? AppColors.accent : AppColors.border,
                    ),
                  ),
                  child: Text(
                    name,
                    style: AppTextStyles.sauceChip.copyWith(
                      color: isOn ? AppColors.accent : AppColors.text1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  final double subtotal;
  const _Summary({required this.subtotal});

  @override
  Widget build(BuildContext context) {
    final total = subtotal + _deliveryFee;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _SummaryLine('Subtotal', subtotal),
          const SizedBox(height: 6),
          _SummaryLine('Delivery', _deliveryFee),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: AppColors.border),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
              ),
              Text(
                '£${total.toStringAsFixed(2)}',
                style: AppTextStyles.cardPrice.copyWith(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  final String label;
  final double value;
  const _SummaryLine(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.cardDesc),
        Text('£${value.toStringAsFixed(2)}', style: AppTextStyles.cardDesc),
      ],
    );
  }
}

class _PlaceOrderButton extends StatelessWidget {
  final double total;
  const _PlaceOrderButton({required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Checkout — Session 3')));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Center(
            child: Text(
              'Place Order · £${total.toStringAsFixed(2)}',
              style: AppTextStyles.atcLabel.copyWith(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
