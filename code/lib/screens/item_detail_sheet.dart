import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../data/menu_item.dart';
import '../models/cart_model.dart';
import '../theme/app_theme.dart';

/// Opens the detail sheet for [item]. Always the entry point for items
/// with more than one price — there is no quick-add path for those,
/// by decision (Session 2, size selection).
Future<void> showItemDetailSheet(
  BuildContext context, {
  required MenuItem item,
  required List<Color> gradient,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.sheetBg,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _ItemDetailSheet(item: item, gradient: gradient),
  );
}

class _ItemDetailSheet extends StatefulWidget {
  final MenuItem item;
  final List<Color> gradient;
  const _ItemDetailSheet({required this.item, required this.gradient});

  @override
  State<_ItemDetailSheet> createState() => _ItemDetailSheetState();
}

class _ItemDetailSheetState extends State<_ItemDetailSheet> {
  int _sizeIndex = 0;
  int _qty = 1;

  void _add() {
    final selected = widget.item.priceOptions[_sizeIndex];
    HapticFeedback.lightImpact();
    context.read<CartModel>().add(widget.item, selected, qty: _qty);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final options = widget.item.priceOptions;
    final selected = options[_sizeIndex];
    final lineTotal = selected.price * _qty;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(top: 10, bottom: 6),
                decoration: BoxDecoration(
                  color: AppColors.handle,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.gradient,
                ),
              ),
              child: Center(
                child: Text(
                  widget.item.emoji,
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.item.name, style: AppTextStyles.sheetName),
                  if (widget.item.description.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      widget.item.description,
                      style: AppTextStyles.sheetDesc,
                    ),
                  ],
                  const SizedBox(height: 10),
                  Text(
                    '£${selected.price.toStringAsFixed(2)}',
                    style: AppTextStyles.sheetPrice,
                  ),
                  if (options.length > 1) ...[
                    const SizedBox(height: 20),
                    Text(
                      'choose a size',
                      style: AppTextStyles.sauceChip.copyWith(
                        color: AppColors.sheetText3,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...List.generate(options.length, (i) {
                      final opt = options[i];
                      final isOn = i == _sizeIndex;
                      return InkWell(
                        onTap: () => setState(() => _sizeIndex = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: i == options.length - 1
                                    ? Colors.transparent
                                    : AppColors.sheetDivider,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${opt.label.toLowerCase()} · £${opt.price.toStringAsFixed(2)}',
                                  style: AppTextStyles.sizeLabel,
                                ),
                              ),
                              Container(
                                width: 21,
                                height: 21,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isOn
                                        ? AppColors.accent
                                        : AppColors.handle,
                                    width: 2,
                                  ),
                                  color: isOn
                                      ? AppColors.accent
                                      : Colors.transparent,
                                ),
                                child: isOn
                                    ? const Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                  const SizedBox(height: 6),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                20,
                14,
                20,
                14 + MediaQuery.of(context).padding.bottom,
              ),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.sheetDivider)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.chipBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        _QtyButton(
                          icon: Icons.remove,
                          onTap: () {
                            if (_qty > 1) setState(() => _qty--);
                          },
                        ),
                        SizedBox(
                          width: 28,
                          child: Text(
                            '$_qty',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.qtyNumber,
                          ),
                        ),
                        _QtyButton(
                          icon: Icons.add,
                          onTap: () => setState(() => _qty++),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: _add,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Text(
                                'Add to Basket',
                                style: AppTextStyles.atcLabel,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: Text(
                                '£${lineTotal.toStringAsFixed(2)}',
                                style: AppTextStyles.atcLabel,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: AppColors.sheetBg,
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Icon(icon, size: 15, color: AppColors.sheetText),
      ),
    );
  }
}
