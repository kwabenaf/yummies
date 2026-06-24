import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../data/menu_data.dart';
import '../data/menu_item.dart';
import '../models/cart_model.dart';
import 'item_detail_sheet.dart';

// ── Flat list entry types ──────────────────────────────────────
abstract class _Entry {}

class _SectionHeaderEntry extends _Entry {
  final String title;
  final int count;
  _SectionHeaderEntry(this.title, this.count);
}

class _DividerEntry extends _Entry {}

class _ItemEntry extends _Entry {
  final MenuItem item;
  final List<Color> gradient;
  _ItemEntry(this.item, this.gradient);
}

// ── Screen ────────────────────────────────────────────────────
class MenuScreen extends StatefulWidget {
  final VoidCallback onOpenBasket;
  const MenuScreen({super.key, required this.onOpenBasket});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _activeTab = 0;
  late List<_Entry> _entries;
  final _listController = ScrollController();
  final _tabController = ScrollController();

  @override
  void initState() {
    super.initState();
    _buildEntries();
  }

  @override
  void dispose() {
    _listController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _buildEntries() {
    final tab = MenuData.tabs[_activeTab];
    _entries = [];
    for (int i = 0; i < tab.sections.length; i++) {
      final s = tab.sections[i];
      if (i > 0) _entries.add(_DividerEntry());
      _entries.add(_SectionHeaderEntry(s.title, s.items.length));
      for (final item in s.items) {
        _entries.add(_ItemEntry(item, s.gradient));
      }
    }
  }

  void _switchTab(int index) {
    setState(() {
      _activeTab = index;
      _buildEntries();
    });
    _listController.animateTo(
      0,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.systemOverlay,
      child: Container(
        color: AppColors.bg,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(onBasketTap: widget.onOpenBasket),
              _CategoryStrip(
                activeIndex: _activeTab,
                controller: _tabController,
                onSelect: _switchTab,
              ),
              Expanded(
                child: ListView.builder(
                  controller: _listController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.only(
                    top: 6,
                    bottom: MediaQuery.of(context).padding.bottom + 80,
                  ),
                  itemCount: _entries.length,
                  itemBuilder: (context, index) {
                    final e = _entries[index];
                    if (e is _DividerEntry) return const _Divider();
                    if (e is _SectionHeaderEntry) {
                      return _SectionHeader(title: e.title, count: e.count);
                    }
                    if (e is _ItemEntry) {
                      return _MenuCard(item: e.item, gradient: e.gradient);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final VoidCallback onBasketTap;
  const _Header({required this.onBasketTap});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final itemCount = cart.itemCount;
    final isDelivery = cart.isDelivery;
    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
      child: Column(
        children: [
          SizedBox(
            height: 54,
            child: Row(
              children: [
                Text('YUMMIES', style: AppTextStyles.wordmark),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x1FFF3B30),
                    border: Border.all(
                      color: const Color(0x4DFF3B30),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Closed · Opens 16:00',
                    style: AppTextStyles.statusPill.copyWith(
                      color: const Color(0xFFFF3B30),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onBasketTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (itemCount > 0)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            '£${cart.subtotal.toStringAsFixed(2)}',
                            style: AppTextStyles.cardPrice.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.surface2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const Center(
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                size: 18,
                                color: AppColors.text1,
                              ),
                            ),
                            if (itemCount > 0)
                              Positioned(
                                top: -3,
                                right: -3,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 15,
                                  ),
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.bg,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$itemCount',
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
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
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                _ToggleBtn(
                  label: '🛵  Delivery',
                  active: isDelivery,
                  onTap: () => context.read<CartModel>().setDelivery(true),
                ),
                _ToggleBtn(
                  label: '🏃  Collection',
                  active: !isDelivery,
                  onTap: () => context.read<CartModel>().setDelivery(false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _ToggleBtn({
    required this.label,
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
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: active ? AppColors.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.orderToggle.copyWith(
                color: active ? Colors.white : AppColors.text2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Category strip ────────────────────────────────────────────
class _CategoryStrip extends StatelessWidget {
  final int activeIndex;
  final ScrollController controller;
  final ValueChanged<int> onSelect;
  const _CategoryStrip({
    required this.activeIndex,
    required this.controller,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: AppColors.surface,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: MenuData.tabs.length,
        itemBuilder: (context, index) {
          final tab = MenuData.tabs[index];
          final active = index == activeIndex;
          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: active ? AppColors.accent : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(tab.icon, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 5),
                  Text(
                    tab.label,
                    style: AppTextStyles.catPill.copyWith(
                      color: active ? AppColors.text1 : AppColors.text2,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Section header ────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(title, style: AppTextStyles.sectionTitle),
          const SizedBox(width: 8),
          Text('$count items', style: AppTextStyles.sectionCount),
        ],
      ),
    );
  }
}

// ── Section divider ───────────────────────────────────────────
class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.border,
    );
  }
}

// ── Menu card ─────────────────────────────────────────────────
class _MenuCard extends StatefulWidget {
  final MenuItem item;
  final List<Color> gradient;
  const _MenuCard({required this.item, required this.gradient});

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 180),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _ctrl.forward();
  void _onTapUp(_) {
    _ctrl.reverse();
    _openDetail();
  }

  void _onTapCancel() => _ctrl.reverse();

  void _openDetail() {
    showItemDetailSheet(context, item: widget.item, gradient: widget.gradient);
  }

  void _quickAdd() {
    HapticFeedback.lightImpact();
    if (widget.item.hasSizeChoice) {
      // Decision (Session 2): no direct add when sizing is ambiguous —
      // the sheet is the only path for multi-price items.
      _openDetail();
    } else {
      context.read<CartModel>().add(
        widget.item,
        widget.item.priceOptions.first,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 9),
      child: ScaleTransition(
        scale: _scale,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: Container(
            constraints: const BoxConstraints(minHeight: 90),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Gradient panel — stretches to full card height
                    Container(
                      width: 90,
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
                          style: const TextStyle(fontSize: 34),
                        ),
                      ),
                    ),
                    // Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(13, 10, 12, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.name,
                              style: AppTextStyles.cardName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (widget.item.description.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                widget.item.description,
                                style: AppTextStyles.cardDesc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                            const SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.item.price,
                                  style: AppTextStyles.cardPrice,
                                ),
                                _AddButton(onTap: _quickAdd),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Add button ────────────────────────────────────────────────
class _AddButton extends StatefulWidget {
  final VoidCallback onTap;
  const _AddButton({required this.onTap});
  @override
  State<_AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<_AddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 60),
      reverseDuration: const Duration(milliseconds: 160),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.82,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 17),
        ),
      ),
    );
  }
}
