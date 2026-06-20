# Yummies App — AI Context & Code Map
*For use at the start of any new session working on this project.*
*Upload alongside yummies-master.md. Together they are sufficient to continue without reconstruction.*

---

## WHAT THIS PROJECT IS

A bespoke Flutter mobile ordering app redesign for Yummies — a kebab, pizza and fried
chicken shop in Cardiff. Built speculatively under melloWare Ltd. The existing app is a
WebView wrapper with broken navigation, no design system, and 15 tabs for 171 items.
This replaces it with a native-feeling Flutter app.

**Stack:** Flutter (Dart), google_fonts package, no state management library yet.
**Device tested on:** Motorola Razr 50
**Project path:** `C:\melloWare\apps\yummies_app`
**Flutter version:** 3.41.7

---

## FILE STRUCTURE

```
lib/
├── main.dart                    — Entry point. App config, theme, orientation lock.
├── theme/
│   └── app_theme.dart           — ALL design tokens. Colors, text styles, system chrome.
├── data/
│   ├── menu_item.dart           — Data models: MenuItem, MenuSection, MenuTab.
│   └── menu_data.dart           — All 171 items as static Dart data. Single source of truth.
└── screens/
    ├── home_shell.dart          — Bottom nav (4 tabs). IndexedStack routing.
    └── menu_screen.dart         — Main menu screen. Category strip + scrollable item cards.
```

---

## FILE BY FILE

### `lib/main.dart`
- Locks orientation to portrait
- Sets system UI overlay (transparent status bar, light icons)
- Runs `YummiesApp` → `MaterialApp` → `HomeShell`
- Uses `AppTheme.dark` for the theme

### `lib/theme/app_theme.dart`
The design system. Everything visual references this file. Never use raw hex or raw sizes
anywhere else in the app.

**AppColors** — static const Color values:
- `bg` = `#0C0C0D` — near black, main background
- `surface` = `#181819` — bottom nav, header backgrounds
- `surface2` = `#222224` — toggle backgrounds, basket button
- `surface3` = `#2A2A2C` — unused currently, available for deeper nesting
- `cardBg` = `#1E1E20` — menu item cards
- `accent` = `#C8200A` — red. Used sparingly: CTA buttons, active states, price text ONLY
- `yellow` = `#F5C400` — wordmark colour only
- `text1` = `#FFFFFF` — primary text
- `text2` = `rgba(255,255,255,0.44)` — secondary text, inactive nav items
- `text3` = `rgba(255,255,255,0.24)` — tertiary, item counts
- `border` = `rgba(255,255,255,0.06)` — subtle borders throughout

**AppTextStyles** — static TextStyle values using DM Sans (google_fonts):
- `wordmark` — italic bold 24px, yellow with red shadow offset
- `sectionTitle` — 17px bold, text1
- `sectionCount` — 12px, text3
- `cardName` — 13.5px bold, text1
- `cardDesc` — 11.5px regular, text2
- `cardPrice` — 13px bold, yellow
- `catPill` — 13px, used in category strip
- `statusPill` — 11px bold, used for open/closed chip
- `orderToggle` — 13px bold, delivery/collection toggle
- `navLabel` — 10px, bottom nav labels

**AppTheme**:
- `systemOverlay` — SystemUiOverlayStyle for transparent status bar
- `dark` — ThemeData with no splash, dark colour scheme, DM Sans text theme

### `lib/data/menu_item.dart`
Three model classes:

```dart
class MenuItem {
  final int id;
  final String name;
  final String description; // optional, defaults to ''
  final String price;       // stored as String e.g. '£9.20' or '£9.50–£14.00'
  final String emoji;
}

class MenuSection {
  final String title;       // original category name e.g. 'Meal Deals', 'Kebabs'
  final List<MenuItem> items;
  final List<Color> gradient; // 2-colour list for the card image panel
}

class MenuTab {
  final String id;          // e.g. 'deals', 'pizza', 'kebabs'
  final String label;       // displayed in category strip
  final String icon;        // emoji prefix
  final List<MenuSection> sections;
  int get totalItems        // computed from sections
}
```

Note: prices are strings because many items have range prices (small/medium/large).
No price parsing is done in the app yet — prices are display-only at this stage.

### `lib/data/menu_data.dart`
Static class `MenuData` with one field: `static final List<MenuTab> tabs`.

**6 tabs, 15 original categories collapsed into sections:**

| Tab id | Label | Sections inside | Item count |
|---|---|---|---|
| deals | Deals | Meal Deals, Mega Deals, Pizza Offers | 25 |
| pizza | Pizza | Pizzas | 22 |
| kebabs | Kebabs & Wraps | Kebabs, Combinations, Wraps | 31 |
| chicken | Chicken & Burgers | Fried Chicken, Burgers | 21 |
| sides | Sides & More | Sides, Extra Dishes, Kids Corner, Sauces & Dips | 53 |
| drinks | Drinks & Desserts | Drinks, Desserts | 15 |

**Gradient presets** are defined as private const lists at the top of the file:
`_dealGrad`, `_megaGrad`, `_pizzaGrad`, `_kebabGrad`, `_comboGrad`, `_wrapGrad`,
`_chickenGrad`, `_burgerGrad`, `_sidesGrad`, `_extraGrad`, `_kidsGrad`,
`_saucesGrad`, `_drinksGrad`, `_dessertsGrad`

Each is a 2-colour warm gradient used as the left panel background on menu cards.

**Important note on duplicates:** Tub Of Coleslaw, Tub Of Curry, Tub Of Gravy,
Tub Of Beans appear in BOTH the Sides section and the Sauces & Dips section.
This is intentional — discoverability. Do not remove the duplicates.

Item IDs are unique integers. ID ranges by tab:
- Deals: 1–25
- Pizza: 30–51
- Kebabs/Wraps: 60–90
- Chicken/Burgers: 100–128
- Sides: 140–200
- Drinks: 210–231

### `lib/screens/home_shell.dart`
Bottom navigation shell using `IndexedStack` (keeps all screens alive).

4 tabs:
- index 0 → `MenuScreen()`
- index 1 → placeholder (Basket — Session 2)
- index 2 → placeholder (Orders — Session 4)
- index 3 → placeholder (Account — Session 4)

**`_BottomNav`** — custom nav bar, `AppColors.surface` background, 1px border top.
**`_NavItem`** — each tab button. Active colour: `AppColors.accent`. Inactive: `AppColors.text2`.
**`_PlaceholderScreen`** — centered icon + label for unbuilt screens.

### `lib/screens/menu_screen.dart`
The main screen. Most of the current complexity lives here.

**Architecture:** Builds a flat `List<_Entry>` from the active tab's sections. Three
entry types: `_SectionHeaderEntry`, `_DividerEntry`, `_ItemEntry`. This is rendered
by a single `ListView.builder` — efficient, no nested scrolling issues.

**Key widgets:**

`_MenuScreenState` — manages `_activeTab` (int), `_isDelivery` (bool), `_entries` list.
Has two ScrollControllers: `_listController` (main list), `_tabController` (category strip).
`_switchTab()` rebuilds entries and resets list scroll to top with animation.

`_Header` — contains wordmark, status pill, basket button, delivery/collection toggle.
Status pill is hardcoded as "Closed · Opens 16:00" — will be dynamic in a later session.
Basket button currently has empty onTap — wired up in Session 2.

`_ToggleBtn` — `AnimatedContainer` for the delivery/collection switch.
Animation duration: 160ms.

`_CategoryStrip` — horizontal `ListView.builder` of tab pills. Fixed height 44px.
Active tab has 2px red underline via `Border(bottom:...)` on the container.

`_SectionHeader` — title + item count, `EdgeInsets.fromLTRB(16, 18, 16, 10)`.

`_Divider` — 1px `AppColors.border` line between sections, 16px horizontal margin.

`_MenuCard` — the item card. Key details:
- `constraints: BoxConstraints(minHeight: 90)` — NOT a fixed height. Allows cards to
  expand for long descriptions. This was a bug fix — do not change back to fixed height.
- Wrapped in `IntrinsicHeight` with `CrossAxisAlignment.stretch` so the gradient panel
  always fills the full card height regardless of content.
- `ScaleTransition` on the whole card: 1.0 → 0.97 on press, 80ms forward / 180ms reverse.
- Left panel: 90px wide, gradient background, emoji centred.
- Right panel: name (1 line, ellipsis), description (2 lines, ellipsis, only if non-empty),
  8px spacer, then price + add button row.
- `_openDetail()` is stubbed — item detail sheet built in Session 2.
- `_quickAdd()` calls `HapticFeedback.lightImpact()` — cart logic added Session 2.

`_AddButton` — separate stateful widget for the + button. Tighter animation: 1.0 → 0.82,
60ms forward / 160ms reverse. Independent from card scale animation.

---

## WHAT IS NOT BUILT YET

Everything below this line is pending. Do not assume it exists.

**State management** — no Provider, Riverpod, or Bloc yet. Currently simple `setState`.
For Session 2 a decision is needed: Provider is the likely choice for cart state given
it needs to be accessible from menu screen, basket sheet, and eventually checkout.

**Item detail sheet** — bottom sheet triggered by tapping a card. Needs:
image/emoji hero, name, description, price, quantity selector, add to basket CTA.

**Basket** — cart state, basket sheet (triggered from nav or header button), sauce upsell
strip ("Anything to dip?"), order summary, place order button.

**Sauce upsell** — 7 quick-add chips at the top of the basket: Chilli Sauce, Garlic Sauce,
Mint Sauce, BBQ Sauce, Ketchup, Tub Of Curry, Tub Of Gravy. Skippable, not a modal.

**Checkout** — delivery/collection confirmation, address input, order notes, place order.

**Auth** — login, registration (guest checkout first, account optional), password change.
Registration should NOT require address upfront — collect at first checkout.

**Orders screen** — order history list, order detail, tracking status.

**Account screen** — profile edit, password change, log out.
DELETE ACCOUNT must be at the bottom in a danger zone, NOT at the top.

**Dynamic status** — open/closed pill should reflect actual opening hours:
Tue–Thu + Sun 16:00–22:30, Fri–Sat 15:00–22:30, Mon Closed.

**Polish pass** — transitions, empty states, error states, splash screen, app icon.

---

## DESIGN RULES — DO NOT VIOLATE

These are locked decisions. Do not suggest changing them.

1. `AppColors.accent` (red) is used ONLY for: active states, CTA buttons, price text.
   Not for decorative purposes. Not for section headers. Not for icons.
2. Card height is `minHeight: 90` with `IntrinsicHeight`. Never revert to fixed height.
3. The wordmark "YUMMIES" uses italic DM Sans with yellow fill and red shadow offset.
   It is not a logo image — it is a Text widget styled via `AppTextStyles.wordmark`.
4. No flattery. No reflexive agreement. If something is wrong or could be better, say so.
5. Sauces & Dips intentionally duplicates 4 items from Sides. This is correct.
6. The Combinations section (4 items) belongs in Kebabs & Wraps, not Deals.

---

## PATTERNS IN USE

**Tap animations:** All interactive elements use `AnimationController` +
`ScaleTransition`. Cards: 0.97 scale. Add button: 0.82 scale. Pattern:
- `onTapDown` → `_ctrl.forward()`
- `onTapUp` → `_ctrl.reverse()` then action
- `onTapCancel` → `_ctrl.reverse()`

**Flat list rendering:** Menu sections are flattened into a typed `List<_Entry>`
before building. This avoids nested scrolling and keeps `ListView.builder` efficient
across 171 items. Same pattern should be used if orders list or similar is built.

**No raw values in widgets:** All colours via `AppColors`, all text styles via
`AppTextStyles`. If a new style is needed, add it to `app_theme.dart` first.

**BouncingScrollPhysics:** Used on the main menu list for iOS-style feel on Android.
`BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())` — the parent wrapper
ensures pull-to-refresh works if added later.

---

## SESSION HISTORY

| Session | What was built | Bugs fixed |
|---|---|---|
| 1 | Project setup, theme, all data models, menu screen, home shell | CategoryStrip color+decoration conflict; card fixed height overflow (replaced with IntrinsicHeight + minHeight) |

---

## NEXT SESSION STARTS HERE

Session 2: Item detail sheet + basket + cart state.

Before writing code, confirm:
- State management approach (Provider recommended — cart needs to be shared across screens)
- Whether item detail sheet needs size selection for pizza/kebabs (prices are ranges)
- Whether quick-add from card skips the detail sheet or opens it

The HTML prototype (yummies-v2.html in project outputs) shows the intended feel
for the item detail sheet and basket if visual reference is needed.

---

*melloWare Ltd. April 2026.*
*This file should be updated at the end of every session.*
