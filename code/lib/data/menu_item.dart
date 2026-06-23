import 'package:flutter/material.dart';

/// One priced version of an item — e.g. Small £5.50, Large £10.50.
/// label is empty for single-price items (no size choice needed).
class PriceOption {
  final String label;
  final double price;
  const PriceOption({required this.label, required this.price});
}

class MenuItem {
  final int id;
  final String name;
  final String description;
  final String price; // display string — unchanged, still what the card shows
  final String emoji;

  const MenuItem({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    required this.emoji,
  });

  /// Parses [price] into structured, addable options.
  ///
  /// One value  → single option, empty label. Quick-add uses this directly.
  /// Two values → labelled Regular / Large.
  /// Three values → labelled Small / Medium / Large (the pizza shape).
  /// More than three (none currently in the menu) → numbered, so nothing
  /// silently breaks if a future item has an unusual price ladder.
  List<PriceOption> get priceOptions {
    final raw = price.replaceAll('£', '').trim();
    final parts = raw
        .split('–')
        .map((p) => double.tryParse(p.trim()))
        .whereType<double>()
        .toList();

    if (parts.isEmpty) return const [PriceOption(label: '', price: 0)];
    if (parts.length == 1) {
      return [PriceOption(label: '', price: parts.first)];
    }

    const twoLabels = ['Regular', 'Large'];
    const threeLabels = ['Small', 'Medium', 'Large'];
    final labels = switch (parts.length) {
      2 => twoLabels,
      3 => threeLabels,
      _ => List.generate(parts.length, (i) => 'Option ${i + 1}'),
    };

    return List.generate(
      parts.length,
      (i) => PriceOption(label: labels[i], price: parts[i]),
    );
  }

  /// True when the user needs to pick a size before this can be added —
  /// the trigger for routing quick-add to the detail sheet instead of
  /// adding directly.
  bool get hasSizeChoice => priceOptions.length > 1;
}

class MenuSection {
  final String title;
  final List<MenuItem> items;
  final List<Color> gradient;

  const MenuSection({
    required this.title,
    required this.items,
    required this.gradient,
  });
}

class MenuTab {
  final String id;
  final String label;
  final String icon;
  final List<MenuSection> sections;

  const MenuTab({
    required this.id,
    required this.label,
    required this.icon,
    required this.sections,
  });

  int get totalItems => sections.fold(0, (sum, s) => sum + s.items.length);
}
