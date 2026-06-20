import 'package:flutter/material.dart';
import 'menu_item.dart';

class MenuData {
  MenuData._();

  // ── Gradient presets ──────────────────────────────────────────
  static const _dealGrad = [Color(0xFFC0392B), Color(0xFFE74C3C)];
  static const _megaGrad = [Color(0xFF922B21), Color(0xFFC0392B)];
  static const _pizzaGrad = [Color(0xFF922B21), Color(0xFFC0392B)];
  static const _kebabGrad = [Color(0xFF7B3F00), Color(0xFFA04000)];
  static const _comboGrad = [Color(0xFF7B3F00), Color(0xFFA04000)];
  static const _wrapGrad = [Color(0xFF7B3F00), Color(0xFFA04000)];
  static const _chickenGrad = [Color(0xFFD35400), Color(0xFFE67E22)];
  static const _burgerGrad = [Color(0xFF7B3F00), Color(0xFFA04000)];
  static const _sidesGrad = [Color(0xFFB7950B), Color(0xFFD4AC0D)];
  static const _extraGrad = [Color(0xFF7B3F00), Color(0xFFA04000)];
  static const _kidsGrad = [Color(0xFF1A5276), Color(0xFF2471A3)];
  static const _saucesGrad = [Color(0xFFC0392B), Color(0xFFE74C3C)];
  static const _drinksGrad = [Color(0xFF1F3A93), Color(0xFF2E4482)];
  static const _dessertsGrad = [Color(0xFF4A235A), Color(0xFF7D3C98)];

  static final List<MenuTab> tabs = [
    // ── DEALS ─────────────────────────────────────────────────
    const MenuTab(
      id: 'deals',
      label: 'Deals',
      icon: '🔥',
      sections: [
        MenuSection(
          title: 'Meal Deals',
          gradient: _dealGrad,
          items: [
            MenuItem(
                id: 1,
                name: 'Meal Deal 1',
                description: '¼ Pounder Burger With Cheese, Chips, Drink',
                price: '£9.20',
                emoji: '🍔'),
            MenuItem(
                id: 2,
                name: 'Meal Deal 2',
                description: '½ Pounder Burger With Cheese, Chips, Drink',
                price: '£10.50',
                emoji: '🍔'),
            MenuItem(
                id: 3,
                name: 'Meal Deal 3',
                description: '5 Pcs Hot Wings, Chips, Drink',
                price: '£7.00',
                emoji: '🍗'),
            MenuItem(
                id: 4,
                name: 'Meal Deal 4',
                description: '2 Pcs Chicken, Chips, Drink',
                price: '£7.70',
                emoji: '🍗'),
            MenuItem(
                id: 5,
                name: 'Meal Deal 5',
                description: '3 Pcs Chicken, Chips, Drink',
                price: '£9.00',
                emoji: '🍗'),
            MenuItem(
                id: 6,
                name: 'Meal Deal 6',
                description: 'Chicken Burger, Chips, Drink',
                price: '£9.50',
                emoji: '🍔'),
            MenuItem(
                id: 7,
                name: 'Meal Deal 7',
                description: 'Double Chicken Burger, Chips, Drink',
                price: '£10.70',
                emoji: '🍔'),
            MenuItem(
                id: 8,
                name: 'Meal Deal 8',
                description: 'Mixed Burger Chicken & Beef, Chips, Drink',
                price: '£10.60',
                emoji: '🍔'),
            MenuItem(
                id: 9,
                name: 'Meal Deal 9',
                description: '10 Pcs Chicken Nuggets, Chips, Drink',
                price: '£9.70',
                emoji: '🍗'),
            MenuItem(
                id: 10,
                name: 'Meal Deal 10',
                description: '4 Pcs Chicken Strips, Chips, Drink',
                price: '£9.50',
                emoji: '🍗'),
            MenuItem(
                id: 11, name: 'Meat Bun Meal', price: '£11.00', emoji: '🍔'),
            MenuItem(
                id: 12,
                name: 'Kebab Meal',
                price: '£13.00–£15.00',
                emoji: '🥙'),
            MenuItem(
                id: 13,
                name: 'Chicken Doner Meal',
                price: '£12.90–£14.50',
                emoji: '🥙'),
            MenuItem(
                id: 14,
                name: 'Mixed Doner Meal',
                price: '£13.00–£15.00',
                emoji: '🥙'),
            MenuItem(
                id: 15,
                name: 'Pizza Deal 1',
                description:
                    '10" Pizza, 4 Toppings, Wedges or Onion Rings, Can',
                price: '£14.00',
                emoji: '🍕'),
          ],
        ),
        MenuSection(
          title: 'Mega Deals',
          gradient: _megaGrad,
          items: [
            MenuItem(
                id: 16,
                name: 'Mega Pack 1',
                description:
                    '8 Pcs Fried Chicken, 3x Chips, Beans, Coleslaw, Bottle',
                price: '£26.50',
                emoji: '🎉'),
            MenuItem(
                id: 17,
                name: 'Mega Pack 2',
                description:
                    '2x Large Kebab, 2x ¼ Burgers, 2x Chips, 3 Pcs Chicken, Coleslaw, Bottle',
                price: '£46.00',
                emoji: '🎉'),
            MenuItem(
                id: 18,
                name: 'Mega Pack 3',
                description:
                    '6 Pcs Chicken, 2x ¼ Burgers, 8 Hot Wings, 2x Chips, Beans, Coleslaw, Bottle',
                price: '£37.00',
                emoji: '🎉'),
            MenuItem(
                id: 19,
                name: 'Mega Pack 4',
                description:
                    '2x Medium Kebabs, 2x Chips, 2 Pcs Chicken, Bottle',
                price: '£29.50',
                emoji: '🎉'),
            MenuItem(
                id: 20,
                name: 'Mega Pack 5',
                description:
                    'Any 10" Pizza, 4 Toppings, Garlic Bread, Chips, Coleslaw, Bottle',
                price: '£21.90',
                emoji: '🎉'),
            MenuItem(
                id: 21,
                name: 'Mega Pack 6',
                description: 'Any 10" Pizza, 2x Chips, 2x ¼ Burgers, Bottle',
                price: '£28.50',
                emoji: '🎉'),
            MenuItem(
                id: 22,
                name: 'Mega Pack 7',
                description:
                    '10" Pizza, Any Medium Doner, ¼ Burger, 2x Chips, Garlic Bread, Bottle',
                price: '£48.00',
                emoji: '🎉'),
            MenuItem(
                id: 23,
                name: 'Mega Pack 8',
                description:
                    '2x 10" Pizzas, Garlic Bread with Cheese, 2x Chips, 1.5L Drink',
                price: '£30.00',
                emoji: '🎉'),
          ],
        ),
        MenuSection(
          title: 'Pizza Offers',
          gradient: _pizzaGrad,
          items: [
            MenuItem(
                id: 24,
                name: 'Any 2x 10"',
                description: 'Any 2x 10" Pizzas',
                price: '£18.00',
                emoji: '🍕'),
            MenuItem(
                id: 25,
                name: 'Any 2x 12"',
                description: 'Any 2x 12" Pizzas',
                price: '£24.00',
                emoji: '🍕'),
          ],
        ),
      ],
    ),

    // ── PIZZA ──────────────────────────────────────────────────
    const MenuTab(
      id: 'pizza',
      label: 'Pizza',
      icon: '🍕',
      sections: [
        MenuSection(
          title: 'Pizzas',
          gradient: _pizzaGrad,
          items: [
            MenuItem(
                id: 30,
                name: 'Margherita',
                description: 'Tomato Sauce, Cheese',
                price: '£5.50–£10.50',
                emoji: '🍕'),
            MenuItem(
                id: 31,
                name: 'BBQ Pizza',
                description: 'Cheese, BBQ Sauce',
                price: '£5.50–£10.50',
                emoji: '🍕'),
            MenuItem(
                id: 32,
                name: 'Garlic Pizza',
                description: 'Cheese, Special Garlic Sauce',
                price: '£5.50–£10.50',
                emoji: '🍕'),
            MenuItem(
                id: 33,
                name: 'Chicken & Mushroom',
                description: 'Tomato Sauce, Cheese, Chicken, Mushrooms',
                price: '£6.70–£12.50',
                emoji: '🍕'),
            MenuItem(
                id: 34,
                name: 'Chicken & Bacon',
                description: 'Tomato Sauce, Cheese, Chicken, Bacon',
                price: '£6.70–£12.50',
                emoji: '🍕'),
            MenuItem(
                id: 35,
                name: 'Hot One Hot',
                description:
                    'Tomato Sauce, Spicy Beef, Spicy Chicken, Pepperoni, Jalapeños',
                price: '£7.50–£14.50',
                emoji: '🍕'),
            MenuItem(
                id: 36,
                name: 'Chicken & Sweetcorn',
                description: 'Tomato Sauce, Cheese, Chicken, Sweetcorn',
                price: '£6.70–£12.50',
                emoji: '🍕'),
            MenuItem(
                id: 37,
                name: 'Ham & Bacon',
                description: 'Ham, Bacon, Cheese',
                price: '£6.70–£12.50',
                emoji: '🍕'),
            MenuItem(
                id: 38,
                name: 'Hawaiian',
                description: 'Ham, Pineapple, Cheese',
                price: '£6.70–£12.50',
                emoji: '🍕'),
            MenuItem(
                id: 39,
                name: 'Farmhouse',
                description: 'Ham, Mushroom, Cheese',
                price: '£6.70–£12.50',
                emoji: '🍕'),
            MenuItem(
                id: 40,
                name: 'Pepperoni Supreme',
                description: 'Pepperoni, Pepperoni, Pepperoni, Cheese',
                price: '£7.00–£13.70',
                emoji: '🍕'),
            MenuItem(
                id: 41,
                name: 'Classic Pizza',
                description: 'Ham, Mushroom, Pineapple, Cheese',
                price: '£7.00–£13.70',
                emoji: '🍕'),
            MenuItem(
                id: 42,
                name: 'BBQ Original Experience',
                description: 'BBQ Sauce, Spicy Chicken, Onions, Peppers',
                price: '£7.50–£14.50',
                emoji: '🍕'),
            MenuItem(
                id: 43,
                name: 'New York City Hot',
                description: 'Ham, Bacon, Mushroom, Jalapeños, Tomato, Cheese',
                price: '£7.90–£15.00',
                emoji: '🍕'),
            MenuItem(
                id: 44,
                name: 'Meat Feast',
                description: 'Ham, Pepperoni, Spicy Chicken, Spicy Beef, Bacon',
                price: '£7.90–£15.00',
                emoji: '🍕'),
            MenuItem(
                id: 45,
                name: 'The Best Of Seven',
                description: 'Ham, Pepperoni, Bacon, Mushroom, Onions, Peppers',
                price: '£7.90–£15.00',
                emoji: '🍕'),
            MenuItem(
                id: 46,
                name: 'Mighty Meaty',
                description:
                    'Pepperoni, Spicy Chicken, Spicy Beef, Sweetcorn, Onions, Peppers',
                price: '£7.90–£15.00',
                emoji: '🍕'),
            MenuItem(
                id: 47,
                name: 'The Sizzler Hot',
                description:
                    'Pepperoni, Spicy Chicken, Onions, Jalapeños, Peppers',
                price: '£7.90–£15.00',
                emoji: '🍕'),
            MenuItem(
                id: 48,
                name: 'Mixed Doner Pizza',
                description:
                    'Chicken Doner, Lamb Doner, Mushroom, Onions, Jalapeños',
                price: '£7.90–£15.00',
                emoji: '🍕'),
            MenuItem(
                id: 49,
                name: 'Sweet Herbie',
                description:
                    'Mushroom, Pineapple, Sweetcorn, Onions, Tomato, Peppers',
                price: '£7.90–£15.00',
                emoji: '🍕'),
            MenuItem(
                id: 50,
                name: 'House Special',
                description:
                    'Ham, Pepperoni, Spicy Beef, Bacon, Mushroom, Onions',
                price: '£7.90–£15.00',
                emoji: '🍕'),
            MenuItem(
                id: 51,
                name: 'Veggie',
                description:
                    'Mushroom, Sweetcorn, Onions, Tomato, Peppers, Cheese',
                price: '£7.90–£15.00',
                emoji: '🍕'),
          ],
        ),
      ],
    ),

    // ── KEBABS & WRAPS ─────────────────────────────────────────
    const MenuTab(
      id: 'kebabs',
      label: 'Kebabs & Wraps',
      icon: '🥙',
      sections: [
        MenuSection(
          title: 'Kebabs',
          gradient: _kebabGrad,
          items: [
            MenuItem(
                id: 60,
                name: 'Doner Kebab',
                description: 'Served with Fresh Salad & Pitta',
                price: '£9.50–£14.00',
                emoji: '🥙'),
            MenuItem(
                id: 61,
                name: 'Chicken Doner Kebab',
                description: 'Served with Fresh Salad & Pitta',
                price: '£9.40–£13.80',
                emoji: '🥙'),
            MenuItem(
                id: 62,
                name: 'Mix Doner Kebab',
                description: 'Served with Fresh Salad & Pitta',
                price: '£9.50–£14.00',
                emoji: '🥙'),
            MenuItem(
                id: 63,
                name: 'Chicken Shish Kebab',
                description:
                    'Cubed breasted chicken, skewered, marinated & charcoal grilled. Fresh Salad & Pitta',
                price: '£10.50–£16.90',
                emoji: '🥙'),
            MenuItem(
                id: 64,
                name: 'Lamb Shish Kebab',
                description:
                    'Cubed lamb, skewered, marinated & charcoal grilled. Fresh Salad & Pitta',
                price: '£12.00–£19.00',
                emoji: '🥙'),
            MenuItem(
                id: 65,
                name: 'Lamb Kofte Kebab',
                description:
                    'Minced meat, skewered, spiced, marinated & charcoal grilled. Fresh Salad & Pitta',
                price: '£11.30–£17.50',
                emoji: '🥙'),
            MenuItem(
                id: 66,
                name: 'Special Chicken Shish',
                description:
                    'Chicken shish, fried vegetables. Fresh Salad & Pitta',
                price: '£11.90–£17.80',
                emoji: '🥙'),
            MenuItem(
                id: 67,
                name: 'Mixed Shish Kebab',
                description: 'Served with Fresh Salad & Pitta',
                price: '£11.40–£17.90',
                emoji: '🥙'),
            MenuItem(
                id: 68,
                name: 'Mix Grill Kebabs',
                description:
                    'Lamb shish, kofte shish, chicken shish. Fresh Salad & Pitta',
                price: '£22.50',
                emoji: '🥙'),
            MenuItem(
                id: 69,
                name: 'Kings Special',
                description:
                    'Lamb shish, chicken shish, kofte shish & lamb doner. Fresh Salad & Pitta',
                price: '£24.00',
                emoji: '🥙'),
            MenuItem(
                id: 70,
                name: 'Yummies Special Kebab',
                description:
                    '1 Skewer (Lamb shish, kofte, chicken shish), lamb & chicken doner, 2 pitta with rice or fried veg. Salad & 4 sauce pots',
                price: '£34.50',
                emoji: '🥙'),
          ],
        ),
        MenuSection(
          title: 'Combinations',
          gradient: _comboGrad,
          items: [
            MenuItem(
                id: 71,
                name: 'Lamb Shish & Doner',
                price: '£15.50',
                emoji: '🥙'),
            MenuItem(
                id: 72,
                name: 'Chicken Shish & Chicken Doner',
                price: '£15.20',
                emoji: '🥙'),
            MenuItem(
                id: 73,
                name: 'Chicken Shish & Doner',
                price: '£15.30',
                emoji: '🥙'),
            MenuItem(
                id: 74,
                name: 'Lamb Shish & Chicken Doner',
                price: '£15.40',
                emoji: '🥙'),
          ],
        ),
        MenuSection(
          title: 'Wraps',
          gradient: _wrapGrad,
          items: [
            MenuItem(id: 75, name: 'Doner Wrap', price: '£9.50', emoji: '🌯'),
            MenuItem(
                id: 76, name: 'Doner Wrap Meal', price: '£13.50', emoji: '🌯'),
            MenuItem(
                id: 77, name: 'Mix Doner Wrap', price: '£9.50', emoji: '🌯'),
            MenuItem(
                id: 78,
                name: 'Mix Doner Wrap Meal',
                price: '£13.50',
                emoji: '🌯'),
            MenuItem(
                id: 79,
                name: 'Chicken Shish Wrap',
                price: '£11.50',
                emoji: '🌯'),
            MenuItem(
                id: 80, name: 'Lamb Shish Wrap', price: '£11.50', emoji: '🌯'),
            MenuItem(
                id: 81,
                name: 'Lamb Shish Wrap Meal',
                price: '£15.50',
                emoji: '🌯'),
            MenuItem(
                id: 82,
                name: 'Chicken Shish Wrap Meal',
                price: '£15.50',
                emoji: '🌯'),
            MenuItem(
                id: 83,
                name: 'Chicken Strip Wrap',
                price: '£9.50',
                emoji: '🌯'),
            MenuItem(
                id: 84,
                name: 'Chicken Strip Wrap Meal',
                price: '£13.50',
                emoji: '🌯'),
            MenuItem(id: 85, name: 'Vegi Wrap', price: '£6.00', emoji: '🌯'),
            MenuItem(
                id: 86, name: 'Vegi Wrap Meal', price: '£10.00', emoji: '🌯'),
            MenuItem(
                id: 87,
                name: 'Chicken Doner Wrap',
                price: '£9.50',
                emoji: '🌯'),
            MenuItem(
                id: 88,
                name: 'Chicken Doner Wrap Meal',
                price: '£13.50',
                emoji: '🌯'),
            MenuItem(
                id: 89, name: 'Kofte Shish Wrap', price: '£11.50', emoji: '🌯'),
            MenuItem(
                id: 90,
                name: 'Kofte Shish Wrap Meal',
                price: '£15.50',
                emoji: '🌯'),
          ],
        ),
      ],
    ),

    // ── CHICKEN & BURGERS ──────────────────────────────────────
    const MenuTab(
      id: 'chicken',
      label: 'Chicken & Burgers',
      icon: '🍗',
      sections: [
        MenuSection(
          title: 'Fried Chicken',
          gradient: _chickenGrad,
          items: [
            MenuItem(
                id: 100,
                name: '1 Pc Fried Chicken',
                price: '£2.50–£5.00',
                emoji: '🍗'),
            MenuItem(
                id: 101,
                name: '2 Pc Fried Chicken',
                price: '£4.50–£6.70',
                emoji: '🍗'),
            MenuItem(
                id: 102,
                name: '3 Pc Fried Chicken',
                price: '£6.30–£8.50',
                emoji: '🍗'),
            MenuItem(
                id: 103,
                name: '4 Pc Fried Chicken',
                price: '£8.00–£10.00',
                emoji: '🍗'),
            MenuItem(
                id: 104,
                name: '6 Pc Fried Chicken',
                price: '£11.50',
                emoji: '🍗'),
            MenuItem(
                id: 105,
                name: '8 Pc Fried Chicken',
                price: '£15.00',
                emoji: '🍗'),
            MenuItem(
                id: 106,
                name: '10 Pc Fried Chicken',
                price: '£18.40',
                emoji: '🍗'),
            MenuItem(
                id: 107,
                name: '5 Pc Hot Wings',
                price: '£3.50–£6.00',
                emoji: '🍗'),
            MenuItem(
                id: 108,
                name: '8 Pc Hot Wings',
                price: '£5.50–£7.50',
                emoji: '🍗'),
            MenuItem(
                id: 109,
                name: '10 Pc Hot Wings',
                price: '£6.90–£9.20',
                emoji: '🍗'),
            MenuItem(
                id: 110,
                name: '4 Pc Chicken Strips',
                price: '£5.50–£8.50',
                emoji: '🍗'),
            MenuItem(
                id: 111,
                name: '10 Pc Chicken Nuggets',
                price: '£5.80–£8.60',
                emoji: '🍗'),
          ],
        ),
        MenuSection(
          title: 'Burgers',
          gradient: _burgerGrad,
          items: [
            MenuItem(
                id: 120,
                name: '¼ Cheese Burger',
                price: '£5.50–£8.50',
                emoji: '🍔'),
            MenuItem(
                id: 121,
                name: '½ Cheese Burger',
                price: '£7.50–£10.00',
                emoji: '🍔'),
            MenuItem(
                id: 122,
                name: 'Chicken Burger',
                price: '£6.00–£9.00',
                emoji: '🍔'),
            MenuItem(
                id: 123,
                name: 'Double Chicken Burger',
                price: '£8.00–£10.50',
                emoji: '🍔'),
            MenuItem(
                id: 124,
                name: 'Mixed Burger',
                description: 'Chicken & Beef Burger',
                price: '£7.70–£10.30',
                emoji: '🍔'),
            MenuItem(
                id: 125,
                name: 'Burger With Doner Meat',
                price: '£7.50–£10.00',
                emoji: '🍔'),
            MenuItem(
                id: 126,
                name: 'Veggie Burger',
                price: '£5.50–£8.50',
                emoji: '🍔'),
            MenuItem(
                id: 127,
                name: 'Chicken Meat In Bun',
                price: '£8.20–£10.70',
                emoji: '🍔'),
            MenuItem(
                id: 128,
                name: 'Donner Meat In Bun',
                price: '£8.20–£10.70',
                emoji: '🍔'),
          ],
        ),
      ],
    ),

    // ── SIDES & MORE ───────────────────────────────────────────
    const MenuTab(
      id: 'sides',
      label: 'Sides & More',
      icon: '🍟',
      sections: [
        MenuSection(
          title: 'Sides',
          gradient: _sidesGrad,
          items: [
            MenuItem(id: 140, name: 'Chips', price: '£3.30–£3.90', emoji: '🍟'),
            MenuItem(
                id: 141,
                name: 'Chips & Cheese',
                price: '£5.70–£7.00',
                emoji: '🍟'),
            MenuItem(
                id: 142,
                name: 'Chips & Any Sauce',
                price: '£4.00–£6.50',
                emoji: '🍟'),
            MenuItem(
                id: 143,
                name: 'Chips, Cheese, Any Sauce',
                price: '£6.60–£7.50',
                emoji: '🍟'),
            MenuItem(
                id: 144, name: 'Potato Wedges', price: '£4.50', emoji: '🍟'),
            MenuItem(
                id: 145, name: 'Tub Of Coleslaw', price: '£2.20', emoji: '🥗'),
            MenuItem(
                id: 146, name: 'Tub Of Curry', price: '£2.20', emoji: '🍛'),
            MenuItem(
                id: 147, name: 'Tub Of Gravy', price: '£2.20', emoji: '🍜'),
            MenuItem(
                id: 148, name: 'Tub Of Beans', price: '£2.20', emoji: '🫘'),
            MenuItem(id: 149, name: 'Rice', price: '£3.30', emoji: '🍚'),
            MenuItem(
                id: 150, name: 'Portion Salad', price: '£3.70', emoji: '🥗'),
            MenuItem(id: 151, name: 'Onion Rings', price: '£3.60', emoji: '🧅'),
            MenuItem(
                id: 152, name: 'Garlic Baguette', price: '£2.70', emoji: '🥖'),
            MenuItem(
                id: 153,
                name: 'Garlic Baguette With Cheese',
                price: '£3.80',
                emoji: '🥖'),
            MenuItem(
                id: 154,
                name: 'Jalapeno Cream',
                price: '£4.80–£7.80',
                emoji: '🌶️'),
            MenuItem(
                id: 155,
                name: 'Mozzarella Sticks',
                price: '£4.40–£7.80',
                emoji: '🧀'),
            MenuItem(
                id: 156,
                name: 'Garlic Mushrooms (12pc)',
                price: '£5.40',
                emoji: '🍄'),
            MenuItem(
                id: 157,
                name: 'Chicken Popcorn',
                price: '£6.90–£8.00',
                emoji: '🍗'),
            MenuItem(
                id: 158, name: 'Tortilla Wrap', price: '£1.20', emoji: '🫓'),
            MenuItem(id: 159, name: 'Pitta', price: '£0.70', emoji: '🫓'),
          ],
        ),
        MenuSection(
          title: 'Extra Dishes',
          gradient: _extraGrad,
          items: [
            MenuItem(
                id: 160,
                name: 'Doner Meat & Chips',
                price: '£10.50–£13.20',
                emoji: '🍽️'),
            MenuItem(
                id: 161,
                name: 'Chicken Meat & Chips',
                price: '£10.30–£13.00',
                emoji: '🍽️'),
            MenuItem(
                id: 162,
                name: 'Mix Meat & Chips',
                price: '£10.50–£13.20',
                emoji: '🍽️'),
            MenuItem(
                id: 163,
                name: 'Doner On Rice',
                description: 'Separate salad & pitta, 2 small dips',
                price: '£11.50–£14.00',
                emoji: '🍽️'),
            MenuItem(
                id: 164,
                name: 'Chicken Doner On Rice',
                description: 'Separate salad & pitta, 2 small dips',
                price: '£11.30–£13.80',
                emoji: '🍽️'),
            MenuItem(
                id: 165,
                name: 'Mix Doner On Rice',
                description: 'Separate salad & pitta, 2 small dips',
                price: '£11.50–£14.00',
                emoji: '🍽️'),
            MenuItem(
                id: 166,
                name: 'Chicken Shish On Chips',
                description: 'Separate salad & pitta, 2 small dips',
                price: '£12.50–£15.00',
                emoji: '🍽️'),
            MenuItem(
                id: 167,
                name: 'Lamb Shish On Chips',
                description: 'Separate salad & pitta, 2 small dips',
                price: '£13.50–£17.00',
                emoji: '🍽️'),
            MenuItem(
                id: 168,
                name: 'Kofte Shish On Chips',
                description: 'Separate salad & pitta, 2 small dips',
                price: '£12.70–£15.50',
                emoji: '🍽️'),
            MenuItem(
                id: 169, name: 'Chip In Pitta', price: '£4.50', emoji: '🍽️'),
            MenuItem(
                id: 170,
                name: 'Chip In Pitta With Salad',
                price: '£5.50',
                emoji: '🍽️'),
            MenuItem(
                id: 171,
                name: 'Platter 10',
                description:
                    'Garlic pizza bread, doner, chicken doner, 2 hot wings, chips, 2 mozzarella sticks, 2 onion rings & 2 jalapeño creams',
                price: '£21.00',
                emoji: '🍽️'),
            MenuItem(
                id: 172,
                name: 'Platter 12',
                description:
                    'Garlic pizza bread, doner, chicken doner, 5 hot wings, chips, 3 mozzarella sticks, 3 onion rings & 3 jalapeño creams',
                price: '£24.00',
                emoji: '🍽️'),
            MenuItem(
                id: 173,
                name: 'Chicken Shish On Rice',
                description: 'Separate salad & pitta, 2 small dips',
                price: '£12.50–£15.00',
                emoji: '🍽️'),
            MenuItem(
                id: 174,
                name: 'Lamb Shish On Rice',
                description: 'Separate salad & pitta, 2 small dips',
                price: '£13.50–£17.00',
                emoji: '🍽️'),
            MenuItem(
                id: 175,
                name: 'Lamb Kofte On Rice',
                description: 'Separate salad & pitta, 2 small dips',
                price: '£12.70–£15.50',
                emoji: '🍽️'),
            MenuItem(
                id: 176, name: 'Salad In Pitta', price: '£4.50', emoji: '🥗'),
          ],
        ),
        MenuSection(
          title: 'Kids Corner',
          gradient: _kidsGrad,
          items: [
            MenuItem(
                id: 180,
                name: 'Kids Fish Fingers (4pc) Meal',
                description: 'Served with Chips and Drink',
                price: '£6.90',
                emoji: '🐟'),
            MenuItem(
                id: 181,
                name: 'Kids Nuggets (5pc) Meal',
                description: 'Served with Chips and Drink',
                price: '£6.90',
                emoji: '🍗'),
            MenuItem(
                id: 182,
                name: 'Kids Sausage (2pc) Meal',
                description: 'Served with Chips and Drink',
                price: '£6.90',
                emoji: '🌭'),
            MenuItem(
                id: 183,
                name: 'Kids Strips (2pc) Meal',
                description: 'Served with Chips and Drink',
                price: '£6.90',
                emoji: '🍗'),
            MenuItem(
                id: 184,
                name: 'Kids Chicken (1pc) Meal',
                description: 'Served with Chips and Drink',
                price: '£6.90',
                emoji: '🍗'),
            MenuItem(
                id: 185,
                name: 'Kids Pizza Meal',
                description:
                    '7" Cheese & Tomato Pizza. Served with Chips and Drink',
                price: '£8.50',
                emoji: '🍕'),
            MenuItem(
                id: 186,
                name: 'Kids Kebab Meal',
                description: 'Plain Only. Served with Chips and Drink',
                price: '£8.00',
                emoji: '🥙'),
            MenuItem(
                id: 187,
                name: 'Kids Popcorn Meal',
                description: 'Served with Chips and Drink',
                price: '£6.90',
                emoji: '🍿'),
            MenuItem(
                id: 188,
                name: 'Kids Cheese Burger Meal',
                description: 'Served with Chips and Drink',
                price: '£6.90',
                emoji: '🍔'),
          ],
        ),
        MenuSection(
          title: 'Sauces & Dips',
          gradient: _saucesGrad,
          items: [
            // 7 true sauces + 4 tubs (intentionally duplicated from Sides for discoverability)
            MenuItem(
                id: 190,
                name: 'Chilli Sauce',
                price: '£0.90–£2.20',
                emoji: '🌶️'),
            MenuItem(
                id: 191,
                name: 'Garlic Sauce',
                price: '£0.90–£2.20',
                emoji: '🧄'),
            MenuItem(
                id: 192, name: 'Mint Sauce', price: '£0.90–£2.20', emoji: '🌿'),
            MenuItem(
                id: 193, name: 'BBQ Sauce', price: '£0.90–£2.20', emoji: '🍖'),
            MenuItem(
                id: 194, name: 'Ketchup', price: '£0.90–£2.20', emoji: '🍅'),
            MenuItem(
                id: 195,
                name: 'Burger Sauce',
                price: '£0.90–£2.20',
                emoji: '🍔'),
            MenuItem(
                id: 196, name: 'Mayonnaise', price: '£0.90–£2.20', emoji: '🥣'),
            MenuItem(
                id: 197, name: 'Tub Of Coleslaw', price: '£2.20', emoji: '🥗'),
            MenuItem(
                id: 198, name: 'Tub Of Curry', price: '£2.20', emoji: '🍛'),
            MenuItem(
                id: 199, name: 'Tub Of Gravy', price: '£2.20', emoji: '🍜'),
            MenuItem(
                id: 200, name: 'Tub Of Beans', price: '£2.20', emoji: '🫘'),
          ],
        ),
      ],
    ),

    // ── DRINKS & DESSERTS ──────────────────────────────────────
    const MenuTab(
      id: 'drinks',
      label: 'Drinks & Desserts',
      icon: '🥤',
      sections: [
        MenuSection(
          title: 'Drinks',
          gradient: _drinksGrad,
          items: [
            MenuItem(
                id: 210,
                name: 'Pepsi',
                description: 'Can',
                price: '£1.30',
                emoji: '🥤'),
            MenuItem(
                id: 211,
                name: '7Up',
                description: 'Can',
                price: '£1.30',
                emoji: '🥤'),
            MenuItem(
                id: 212,
                name: 'Dr. Pepper',
                description: 'Can',
                price: '£1.30',
                emoji: '🥤'),
            MenuItem(
                id: 213,
                name: 'Apple Tango',
                description: 'Can',
                price: '£1.30',
                emoji: '🥤'),
            MenuItem(
                id: 214,
                name: 'Tango Orange',
                description: 'Can',
                price: '£1.30',
                emoji: '🥤'),
            MenuItem(
                id: 215,
                name: 'Pepsi Max',
                description: 'Can',
                price: '£1.30',
                emoji: '🥤'),
            MenuItem(
                id: 216,
                name: 'Diet Pepsi',
                description: 'Can',
                price: '£1.30',
                emoji: '🥤'),
            MenuItem(
                id: 217,
                name: 'Rio Tropical',
                description: 'Can',
                price: '£1.30',
                emoji: '🥤'),
            MenuItem(
                id: 218,
                name: 'Pepsi 1.5L',
                description: 'Bottle',
                price: '£3.00',
                emoji: '🍶'),
            MenuItem(
                id: 219,
                name: '7Up 1.5L',
                description: 'Bottle',
                price: '£3.00',
                emoji: '🍶'),
            MenuItem(
                id: 220,
                name: 'Orange Tango 1.5L',
                description: 'Bottle',
                price: '£3.00',
                emoji: '🍶'),
            MenuItem(
                id: 221,
                name: 'Diet Pepsi 1.5L',
                description: 'Bottle',
                price: '£3.00',
                emoji: '🍶'),
            MenuItem(
                id: 222, name: 'Yazoo Milkshake', price: '£1.50', emoji: '🥛'),
          ],
        ),
        MenuSection(
          title: 'Desserts',
          gradient: _dessertsGrad,
          items: [
            MenuItem(id: 230, name: 'Cheese Cake', price: '£3.00', emoji: '🍰'),
            MenuItem(
                id: 231, name: 'Chocolate Cake', price: '£3.00', emoji: '🍫'),
          ],
        ),
      ],
    ),
  ];
}
