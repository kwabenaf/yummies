import 'package:flutter/material.dart';

class MenuItem {
  final int id;
  final String name;
  final String description;
  final String price;
  final String emoji;

  const MenuItem({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    required this.emoji,
  });
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
