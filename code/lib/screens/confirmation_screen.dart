import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import 'home_shell.dart';

class ConfirmationScreen extends StatelessWidget {
  final bool isDelivery;
  final double total;
  final int itemCount;

  const ConfirmationScreen({
    super.key,
    required this.isDelivery,
    required this.total,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.systemOverlay,
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(flex: 2),
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 36,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Order placed',
                  style: AppTextStyles.sectionTitle.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  isDelivery
                      ? 'Your order is on its way'
                      : 'Your order will be ready for collection',
                  style: AppTextStyles.cardDesc.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _InfoRow(
                        'Items',
                        '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
                      ),
                      const SizedBox(height: 8),
                      _InfoRow('Type', isDelivery ? 'Delivery' : 'Collection'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(height: 1, color: AppColors.border),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total paid',
                            style: AppTextStyles.sectionTitle.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '£${total.toStringAsFixed(2)}',
                            style: AppTextStyles.cardPrice.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: GestureDetector(
                    onTap: () {
                      // Pop back to the home shell — the checkout screen
                      // was pushed on top of it.
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomeShell()),
                        (route) => false,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Center(
                        child: Text(
                          'Back to Menu',
                          style: AppTextStyles.atcLabel.copyWith(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.cardDesc),
        Text(
          value,
          style: AppTextStyles.cardDesc.copyWith(color: AppColors.text1),
        ),
      ],
    );
  }
}
