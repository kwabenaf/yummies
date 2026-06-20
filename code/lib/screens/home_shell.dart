import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'menu_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _screens = [
    MenuScreen(),
    _PlaceholderScreen(
        icon: Icons.shopping_bag_outlined, label: 'Your basket is empty'),
    _PlaceholderScreen(
        icon: Icons.receipt_long_outlined, label: 'No orders yet'),
    _PlaceholderScreen(icon: Icons.person_outline_rounded, label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: _BottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

// ── Bottom nav bar ────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _NavItem(
                  icon: Icons.grid_view_rounded,
                  label: 'Menu',
                  index: 0,
                  current: currentIndex,
                  onTap: onTap),
              _NavItem(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Basket',
                  index: 1,
                  current: currentIndex,
                  onTap: onTap),
              _NavItem(
                  icon: Icons.receipt_long_outlined,
                  label: 'Orders',
                  index: 2,
                  current: currentIndex,
                  onTap: onTap),
              _NavItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Account',
                  index: 3,
                  current: currentIndex,
                  onTap: onTap),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int current;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = index == current;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 22, color: active ? AppColors.accent : AppColors.text2),
            const SizedBox(height: 3),
            Text(
              label,
              style: AppTextStyles.navLabel.copyWith(
                color: active ? AppColors.accent : AppColors.text2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Placeholder screen ────────────────────────────────────────
class _PlaceholderScreen extends StatelessWidget {
  final IconData icon;
  final String label;
  const _PlaceholderScreen({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 44, color: AppColors.text3),
          const SizedBox(height: 12),
          Text(label,
              style: const TextStyle(color: AppColors.text2, fontSize: 14)),
        ],
      ),
    );
  }
}
