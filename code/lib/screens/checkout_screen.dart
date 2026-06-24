import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../theme/app_theme.dart';
import 'confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressLine1 = TextEditingController();
  final _postcode = TextEditingController();
  final _phone = TextEditingController();
  final _notes = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _addressLine1.dispose();
    _postcode.dispose();
    _phone.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _placeOrder() {
    final cart = context.read<CartModel>();
    final needsAddress = cart.isDelivery;

    if (needsAddress && !_formKey.currentState!.validate()) return;

    // Capture values now — the builder closure runs later, after clear().
    final isDelivery = cart.isDelivery;
    final total = cart.total;
    final itemCount = cart.itemCount;

    cart.clear();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ConfirmationScreen(
          isDelivery: isDelivery,
          total: total,
          itemCount: itemCount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.systemOverlay,
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: SafeArea(
          child: Column(
            children: [
              _TopBar(onBack: () => Navigator.of(context).pop()),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    _OrderTypeBanner(isDelivery: cart.isDelivery),
                    const SizedBox(height: 16),
                    if (cart.isDelivery) ...[
                      _SectionLabel('Delivery address'),
                      const SizedBox(height: 8),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _Field(
                              controller: _addressLine1,
                              hint: 'Address line 1',
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Required'
                                  : null,
                            ),
                            const SizedBox(height: 10),
                            _Field(
                              controller: _postcode,
                              hint: 'Postcode',
                              textCapitalization: TextCapitalization.characters,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Required'
                                  : null,
                            ),
                            const SizedBox(height: 10),
                            _Field(
                              controller: _phone,
                              hint: 'Phone number',
                              keyboardType: TextInputType.phone,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Required'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    _SectionLabel('Notes'),
                    const SizedBox(height: 8),
                    _Field(
                      controller: _notes,
                      hint: 'Any special requests?',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    _SectionLabel('Order summary'),
                    const SizedBox(height: 8),
                    _OrderSummary(cart: cart),
                  ],
                ),
              ),
              _CheckoutButton(total: cart.total, onTap: _placeOrder),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Top bar ──────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onBack,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 18,
                color: AppColors.text1,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Checkout',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

// ── Order type toggle ────────────────────────────────────────────
class _OrderTypeBanner extends StatelessWidget {
  final bool isDelivery;
  const _OrderTypeBanner({required this.isDelivery});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          _TypeOption(
            emoji: '🛵',
            label: 'Delivery',
            subtitle: '£2.00',
            active: isDelivery,
            onTap: () => context.read<CartModel>().setDelivery(true),
          ),
          _TypeOption(
            emoji: '🏃',
            label: 'Collection',
            subtitle: 'Free',
            active: !isDelivery,
            onTap: () => context.read<CartModel>().setDelivery(false),
          ),
        ],
      ),
    );
  }
}

class _TypeOption extends StatelessWidget {
  final String emoji;
  final String label;
  final String subtitle;
  final bool active;
  final VoidCallback onTap;
  const _TypeOption({
    required this.emoji,
    required this.label,
    required this.subtitle,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: active ? AppColors.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                '$emoji  $label',
                style: AppTextStyles.orderToggle.copyWith(
                  color: active ? Colors.white : AppColors.text2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.cardDesc.copyWith(
                  fontSize: 10,
                  color: active
                      ? Colors.white.withValues(alpha: 0.7)
                      : AppColors.text3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section label ────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTextStyles.cardDesc.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: AppColors.text3,
      ),
    );
  }
}

// ── Text field ───────────────────────────────────────────────────
class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;

  const _Field({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      validator: validator,
      style: AppTextStyles.cardName.copyWith(fontSize: 14),
      cursorColor: AppColors.accent,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.cardDesc.copyWith(fontSize: 14),
        filled: true,
        fillColor: AppColors.cardBg,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
        errorStyle: TextStyle(
          color: AppColors.accent,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ── Order summary ────────────────────────────────────────────────
class _OrderSummary extends StatelessWidget {
  final CartModel cart;
  const _OrderSummary({required this.cart});

  @override
  Widget build(BuildContext context) {
    final feeLabel = cart.isDelivery ? 'Delivery' : 'Collection';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          ...cart.lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${line.qty}× ${line.item.name}',
                      style: AppTextStyles.cardDesc.copyWith(
                        color: AppColors.text2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '£${line.lineTotal.toStringAsFixed(2)}',
                    style: AppTextStyles.cardDesc.copyWith(
                      color: AppColors.text2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, color: AppColors.border),
          ),
          _SumRow('Subtotal', cart.subtotal),
          const SizedBox(height: 4),
          _SumRow(feeLabel, cart.deliveryFee),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
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
                '£${cart.total.toStringAsFixed(2)}',
                style: AppTextStyles.cardPrice.copyWith(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SumRow extends StatelessWidget {
  final String label;
  final double value;
  const _SumRow(this.label, this.value);

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

// ── Checkout button ──────────────────────────────────────────────
class _CheckoutButton extends StatelessWidget {
  final double total;
  final VoidCallback onTap;
  const _CheckoutButton({required this.total, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: GestureDetector(
        onTap: onTap,
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
