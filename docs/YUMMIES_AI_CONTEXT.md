# Yummies App — AI Context & Code Map
*Claude's working document. Not user-facing — co-created, not read independently.*
*Upload alongside yummies-master.md. Together they are sufficient to continue without reconstruction.*
*Last updated: end of Session 3, 24 Jun 2026.*

---

## WHAT THIS PROJECT IS

A bespoke Flutter mobile ordering app redesign for Yummies — a kebab, pizza and fried
chicken shop in Cardiff. Built speculatively under melloWare Ltd. The existing app is a
WebView wrapper with broken navigation, no design system, and 15 tabs for 171 items.
This replaces it with a native-feeling Flutter app.

**Stack:** Flutter (Dart), google_fonts, provider
**Device tested on:** Motorola Razr 50
**Project name:** `yummies_app_new`
**Project path:** `C:\melloWare\yummies\code`
**GitHub:** https://github.com/kwabenaf/yummies (public)
**Flutter version:** 3.41.7
**Archive:** `C:\melloWare\_archive\yummies-old\` — confirmed pre-bug-fix source-only backup, no Android platform folder, safe to ignore.

---

## FILE STRUCTURE (post Session 3)

```
lib/
├── main.dart                        — Entry point. Provider root, app config, orientation lock.
├── theme/
│   └── app_theme.dart               — ALL design tokens. Dark app + light sheet surfaces.
├── data/
│   ├── menu_item.dart               — MenuItem, PriceOption, MenuSection, MenuTab.
│   └── menu_data.dart               — All 171 items as static Dart data. 40 prices fixed Session 3.
├── models/
│   └── cart_model.dart              — CartModel ChangeNotifier. CartLine. Delivery state. Single basket state.
└── screens/
    ├── home_shell.dart              — THE ONLY SCAFFOLD (tabs). Bottom nav, IndexedStack, tab routing.
    ├── menu_screen.dart             — Category strip, section headers, cards, quick-add, header with running total.
    ├── item_detail_sheet.dart       — Modal bottom sheet. Size selection, qty, add to basket.
    ├── basket_screen.dart           — Cart rows, sauce upsell, summary, delete icon, navigation to checkout.
    ├── checkout_screen.dart         — Pushed route. Order type toggle, address/notes form, order summary.
    └── confirmation_screen.dart     — Pushed route. Order placed, summary, navigate to fresh HomeShell.
```

**Line counts (Session 3 end):**
main.dart: 30 | app_theme.dart: 215 | menu_item.dart: 92 | menu_data.dart: 1030 |
cart_model.dart: 69 | home_shell.dart: 204 | menu_screen.dart: 613 |
item_detail_sheet.dart: 286 | basket_screen.dart: 421 |
checkout_screen.dart: 466 | confirmation_screen.dart: 154
**Total:** 3,580 lines across 11 files.

---

## FILE BY FILE

### `lib/main.dart` (30 lines)
- Locks orientation to portrait
- Sets system UI overlay (transparent status bar, light icons)
- **`ChangeNotifierProvider<CartModel>`** wraps the entire `MaterialApp`
- Runs `YummiesApp` → `MaterialApp` → `HomeShell`
- Uses `AppTheme.dark` for the theme

### `lib/theme/app_theme.dart` (215 lines)
The design system. Everything visual references this file. Never use raw hex or raw sizes
anywhere else in the app.

**AppColors** — static const Color values:
- `bg` = `#0C0C0D` — near black, main background
- `surface` = `#181819` — bottom nav, header backgrounds
- `surface2` = `#222224` — toggle backgrounds, basket button, qty pill
- `surface3` = `#2A2A2C` — unused currently, available for deeper nesting
- `cardBg` = `#1E1E20` — menu item cards, basket cart rows
- `accent` = `#C8200A` — red. CTA buttons, active states, price text, swipe-dismiss bg ONLY
- `yellow` = `#F5C400` — wordmark and card price text only
- `text1` = `#FFFFFF` — primary text
- `text2` = `Color(0x70FFFFFF)` (44%) — secondary text, inactive nav items
- `text3` = `Color(0x3DFFFFFF)` (24%) — tertiary, item counts, dimmed minus button
- `border` = `Color(0x0FFFFFFF)` (6%) — subtle borders throughout
- `sheetBg` = `#FFFFFF` — item detail sheet background (light, not dark)
- `sheetSurface` = `#F4F4F6` — basket sheet background (unused currently, available)
- `sheetText` = `#111111` — sheet primary text
- `sheetText2` = `#888888` — sheet secondary text
- `sheetText3` = `#AAAAAA` — sheet tertiary text
- `sheetDivider` = `#F0F0F0` — sheet separator lines
- `chipBg` = `#FAFAFA` — qty stepper background in sheet
- `chipBorder` = `#EBEBEB` — unused currently
- `handle` = `#DDDDDD` — sheet drag handle, radio button inactive border
- `success` = `#34C759` — unused currently, reserved

**AppTextStyles** — static TextStyle values using DM Sans (google_fonts).
All are non-const (GoogleFonts returns runtime values). Never wrap in `const` widgets.

Dark app styles:
`wordmark`, `sectionTitle`, `sectionCount`, `cardName`, `cardDesc`, `cardPrice`,
`catPill`, `statusPill`, `orderToggle`, `navLabel`

Light sheet styles (added Session 2):
`sheetName`, `sheetDesc`, `sheetPrice`, `sizeLabel`, `sizePrice`, `qtyNumber`,
`atcLabel`, `sauceChip`, `cartTitle`, `rowName`, `rowSub`, `rowPrice`,
`summaryRow`, `summaryTotal`

**AppTheme**:
- `systemOverlay` — SystemUiOverlayStyle for transparent status bar
- `dark` — ThemeData with no splash, dark colour scheme, DM Sans text theme

### `lib/data/menu_item.dart` (92 lines)
Four model types:

**`PriceOption`** — one priced version of an item (e.g. Small £5.50).
- `label` (String) — empty for single-price items
- `price` (double)

**`MenuItem`** — the core item.
- `id`, `name`, `description`, `price` (display string), `emoji`
- `get priceOptions` — parses the `price` string into a `List<PriceOption>`.
  1 value → single option, empty label.
  2 values → "Regular" / "Large".
  3 values → "Small" / "Medium" / "Large".
- `get hasSizeChoice` → `priceOptions.length > 1`. Used by `_quickAdd()` to decide
  whether to open the detail sheet or add directly.

**`MenuSection`** — a group with title, items, and gradient colours.
**`MenuTab`** — a top-level tab with id, label, icon, sections, and computed `totalItems`.

### `lib/data/menu_data.dart` (1030 lines)
Static class `MenuData` with one field: `static final List<MenuTab> tabs`.
**Session 3:** 40 items had middle price tier restored (all pizzas, 8 kebabs,
3 sides, 7 sauces). Verified to zero mismatches against `yummies-menu.md`.
Tier distribution: 94 single-price, 37 two-tier (correct), 40 three-tier.

6 tabs, 15 original categories collapsed into sections.
Gradient presets defined as private const lists at the top.
Item IDs are unique integers in ranges: Deals 1–25, Pizza 30–51, Kebabs 60–90,
Chicken 100–128, Sides 140–200, Drinks 210–231.

Intentional duplicates: Tub Of Coleslaw, Curry, Gravy, Beans in both Sides and
Sauces & Dips sections. Do not remove.

### `lib/models/cart_model.dart` (69 lines)
**`CartLine`** — one line in the basket.
- `item` (MenuItem), `size` (PriceOption), `qty` (int, mutable)
- `get lineTotal` → `size.price * qty`
- `get key` → `'${item.id}::${size.label}'` — same item + different size = different line

**`CartModel`** extends `ChangeNotifier`.
- `_lines` — the basket contents
- `_isDelivery` — delivery/collection state (Session 3)
- `get lines`, `get itemCount`, `get subtotal`
- `get isDelivery`, `get deliveryFee` (£2.00 / £0.00), `get total` (subtotal + fee)
- `setDelivery(bool)` — updates toggle, notifies listeners
- `add(item, size, {qty})` — merges if same key exists, otherwise creates new line
- `setQty(line, qty)` — updates qty, removes if qty <= 0
- `removeLine(line)` — hard remove
- `clear()` — empties everything

No sauce-specific state. Sauce upsell chips add/remove real cart lines for sauce
MenuItems found via lookup in `MenuData.tabs`. This means sauces show up in the
cart row list, update subtotal, and survive any future cart persistence — they're
not a cosmetic parallel structure.

### `lib/screens/home_shell.dart` (204 lines)
**THE ONLY SCAFFOLD FOR TAB SCREENS.** This is a locked architectural decision (Session 2).
Do not add Scaffold to any tab screen — it causes SnackBar lifecycle bugs under
IndexedStack because multiple ScaffoldMessengers compete for the same queue.
Pushed routes (checkout, confirmation) have their own Scaffolds — this is fine
because they're separate routes on the Navigator, not children of IndexedStack.

- `HomeShell` — StatefulWidget, manages `_index` for tab switching
- `_goToBasket()` callback passed to `MenuScreen` for header basket icon navigation
- `IndexedStack` with 4 children: MenuScreen, BasketScreen, 2 placeholders
- `_BottomNav` — custom nav bar with badge support on basket tab
- `_NavItem` — badge renders when `badgeCount > 0`, watches `CartModel.itemCount`
- `_PlaceholderScreen` — icon + label for Orders (Session 4) and Account (Session 4)

### `lib/screens/menu_screen.dart` (613 lines)
The main screen. Most complexity lives here.

**Architecture:** Flat `List<_Entry>` from active tab's sections. Three entry types:
`_SectionHeaderEntry`, `_DividerEntry`, `_ItemEntry`. Single `ListView.builder`.

**Key widgets:**
- `_MenuScreenState` — `_activeTab`, `_entries`, two ScrollControllers
- `_Header` — wordmark, status pill (hardcoded), basket button with live badge and
  running total (yellow price text, visible when cart has items), delivery/collection
  toggle. Reads `isDelivery` and `itemCount` from `CartModel` directly (Session 3 —
  no longer receives toggle state as parameter).
- `_ToggleBtn` — AnimatedContainer, 160ms
- `_CategoryStrip` — horizontal tab pills, 44px height, 2px red underline on active
- `_SectionHeader` — title + count
- `_Divider` — 1px border line
- `_MenuCard` — the card. ScaleTransition 0.97, IntrinsicHeight + minHeight: 90.
  **Card tap** → always opens detail sheet.
  **Quick-add (+)** → `hasSizeChoice` ? open detail sheet : add directly with haptic.
- `_AddButton` — tighter scale 0.82, independent animation

**No Scaffold here.** Uses `Container(color: AppColors.bg)` + `SafeArea` instead.

### `lib/screens/item_detail_sheet.dart` (286 lines)
Modal bottom sheet opened via `showItemDetailSheet()`.

- Hero gradient panel (180px) with emoji
- Name, description, live price display
- **Size selection** (only shown when `priceOptions.length > 1`): radio buttons,
  "choose a size" label, tapping updates the displayed price and the Add to Basket total
- Qty stepper (min 1, no max)
- Sticky footer: qty pill + "Add to Basket · £X.XX" button
- Haptic on add, pops the sheet on completion

**const TextStyle trap:** AppTextStyles values are non-const (GoogleFonts runtime).
Do not wrap any widget containing an AppTextStyles reference in `const`. This was
a compilation error caught and fixed in Session 2 — it will recur if const is
applied carelessly to parent widgets.

### `lib/screens/basket_screen.dart` (421 lines)
Full basket tab, not a modal sheet.

- `BasketScreen` — reads `CartModel` via `context.watch`, shows empty state or list
- `_CartRow` — **wrapped in `Dismissible`** (swipe left to remove, red bg with bin icon).
  Qty pill with dimmed minus at qty 1 — minus does nothing when qty is already 1.
  **Visible × icon** (Session 3) — dimmed `close_rounded` icon right of price, taps
  to remove line. Provides discoverable removal alongside swipe.
- `_QtyPill` — `atMin` flag controls whether minus is dimmed/disabled
- `_QtyIcon` — dimmed state via `AppColors.text3`
- `_SauceStrip` — "Anything to dip?" with 7 chips. Each chip looks up the real
  MenuItem from `MenuData.tabs`, adds/removes it as a real cart line (smallest size).
  `isOn` checks whether a matching line exists in the cart.
- `_Summary` — receives `CartModel`, shows subtotal, delivery/collection fee from
  model, total. Label dynamically reads "Delivery" or "Collection".
- `_PlaceOrderButton` — navigates to `CheckoutScreen` via `Navigator.push`

**No Scaffold here.** Uses `Container(color: AppColors.bg)` + `SafeArea` instead.

### `lib/screens/checkout_screen.dart` (466 lines)
Pushed route from basket. Has its own Scaffold.

- `CheckoutScreen` — StatefulWidget with text controllers for address, postcode,
  phone, notes. Form key for delivery validation.
- `_placeOrder()` — captures `isDelivery`, `total`, `itemCount` as locals BEFORE
  `cart.clear()`, then `pushReplacement` to `ConfirmationScreen`. The builder
  closure captures the locals, not the cart — prevents stale-data bug.
- `_TopBar` — back arrow + "Checkout" title
- `_OrderTypeBanner` — **tappable** delivery/collection toggle (not read-only).
  Switching dynamically shows/hides address fields and updates order summary.
  Uses `context.read<CartModel>().setDelivery()`.
- `_TypeOption` — AnimatedContainer, 160ms, shows emoji + label + subtitle (price/Free)
- `_SectionLabel` — uppercase section dividers
- `_Field` — TextFormField with dark styling, accent focus border, validation
- `_OrderSummary` — full item list + subtotal + fee + total
- `_CheckoutButton` — "Place Order · £X.XX"

**Validation:** Only address fields (line 1, postcode, phone) validate, and only
when `cart.isDelivery` is true. Notes field never validates. Collection orders
skip validation entirely.

### `lib/screens/confirmation_screen.dart` (154 lines)
Pushed route (replaces checkout). Has its own Scaffold.

- `ConfirmationScreen` — StatelessWidget with `isDelivery`, `total`, `itemCount`
  as final constructor parameters (values, not live cart references).
- Green check icon, "Order placed" message, contextual subtitle
- Summary card: items, type, total paid
- "Back to Menu" button — uses `pushAndRemoveUntil` with a fresh `HomeShell()`,
  removing all routes. This resets the tab index to 0 (menu) and avoids the
  stale-basket-tab-index bug.

---

## PATTERNS — LOCKED

**Single Scaffold for tab screens.** Only `HomeShell` has a Scaffold for tab screens.
Tab screens use Container + SafeArea. Pushed routes (checkout, confirmation) get their
own Scaffolds — they're separate Navigator routes, not IndexedStack children.
Discovered the hard way in Session 2 — three Scaffolds under IndexedStack caused
SnackBars to persist forever across tab switches.

**Tap animations:** `AnimationController` + `ScaleTransition`. Cards: 0.97 scale.
Add button: 0.82 scale. Pattern: onTapDown → forward, onTapUp → reverse then action,
onTapCancel → reverse.

**Flat list rendering:** Sections flattened into typed `List<_Entry>` before building.
Single `ListView.builder`, no nested scrolling.

**No raw values in widgets:** All colours via `AppColors`, all text styles via
`AppTextStyles`. New values go in `app_theme.dart` first.

**BouncingScrollPhysics:** Main menu list uses
`BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())`.

**Detail sheet only for size selection.** Multi-price items cannot be quick-added.
The + button routes to the detail sheet instead.

**Swipe to dismiss + visible × for basket removal.** Minus stops at qty 1 (dims).
Removal is swipe-to-dismiss or tapping the dimmed × icon on the right edge.
Both call `cart.removeLine()`.

**Provider over setState for shared state.** CartModel is the single source of truth
for basket contents AND delivery/collection toggle, read by menu screen (badge + total),
basket screen, checkout, and confirmation.

**Capture values before async navigation.** Route builder closures capture variables by
reference. If the underlying object changes (e.g. `cart.clear()`) before the builder
runs, the closure sees stale data. Capture computed values as locals first.

---

## DECISIONS MADE AND WHY

| Decision | Why | Session |
|---|---|---|
| Provider, not setState | 3+ consumers (menu badge, basket, checkout) — callback threading gets ugly at this count | 2 |
| Detail sheet only for sizing | Quick-add with ambiguous pricing silently picks the wrong price — the sheet is the only honest path | 2 |
| Swipe-to-dismiss, not minus-to-remove | Minus sits next to plus — accidental removal is too easy. Swipe is a different motor action, can't happen by accident while adjusting qty | 2 |
| Sauces as real cart lines, not parallel state | Keeps one source of truth. Sauces show in cart, affect totals, survive future persistence — no drift between a Set<String> and the actual basket | 2 |
| Single Scaffold in HomeShell | Multiple Scaffolds under IndexedStack cause SnackBar lifecycle bugs — messenger doesn't cleanly hand off between competing Scaffolds on tab switch | 2 |
| Light sheet surfaces | Item detail and basket sheets are deliberately light (#FFFFFF bg), contrasting against the dark app — validated against the yummies-v2.html prototype | 2 |
| Delivery state in CartModel, not local | Toggle affects total (basket, checkout, confirmation all need it) — same argument as Provider over setState, applied to this specific field | 3 |
| Dark checkout/confirmation screens | Pushed routes match the app's dark theme. Only modal bottom sheets use light surfaces. Avoids jarring transition from dark basket tab. | 3 |
| Tappable toggle on checkout | Users who reach checkout and want to switch delivery/collection shouldn't need to navigate back. Address fields show/hide dynamically. | 3 |
| Visible × icon on cart rows | Swipe-to-dismiss is undiscoverable for many users. Dimmed × on far right provides visible affordance without the accidental-removal risk of minus-to-zero (different position, different icon, different action). | 3 |
| pushAndRemoveUntil for post-order nav | popUntil returns to HomeShell with stale tab index. Pushing a fresh HomeShell resets to menu tab cleanly. Provider survives because it wraps MaterialApp. | 3 |
| Capture values before clear + navigate | Route builder closures evaluate lazily. cart.clear() runs before the builder. Capturing values as locals before navigation prevents the stale-data bug. | 3 |

---

## THINGS TRIED AND REJECTED

| What | Why rejected | Session |
|---|---|---|
| SnackBar with Undo on minus-to-remove | Timer never reliably auto-dismissed. Queue stacked stale removals. Close icon (×) added visual noise to a one-line toast. Three rounds of fixes, none clean. Root cause was wrong: the problem was accidental removal, not missing undo. Swipe-to-dismiss solved it without any SnackBar. | 2 |
| Separate `_sauces` Set in CartModel | Created a parallel structure that could drift from the real cart lines. Removed before ship — sauce chips now add/remove actual MenuItems as cart lines. | 2 |
| `const Padding` wrapping `Text` with AppTextStyles | GoogleFonts.dmSans() returns non-const TextStyle. Wrapping the parent widget in const causes compile error. Never const-wrap a widget tree that references AppTextStyles. | 2 |
| Read-only order type banner on checkout | User feedback: if you reach checkout and want to switch delivery/collection, you'd have to go back multiple screens. Made it a tappable toggle instead. | 3 |
| popUntil for post-order return to menu | Returns to HomeShell with stale _index (basket tab), not menu tab. No clean way to communicate the tab change back. Replaced with pushAndRemoveUntil to fresh HomeShell. | 3 |
| Text-only swipe hint below cart rows | "Swipe to remove" text was too small and easily missed (mello feedback). Replaced with visible × icon on each row — always present, always discoverable. | 3 |

---

## KNOWN GAPS AND OPEN WORK

**Status pill hardcoded:**
"Closed · Opens 16:00" — should reflect actual hours dynamically.

**Minimum delivery spend:**
Live Yummies app enforces £15 minimum for delivery. Not implemented. Needs
investigation: do thresholds vary by area? Should be a configurable value.

**Item customisation beyond size:**
Some items in the live app have sub-options (e.g. Chips & Any Sauce has proportions,
sauce dropdown, salt/vinegar tick boxes). Current model only supports size tiers.
Per-item option modelling needed — but scope is large. See FLAGGED in master doc.

**Cart persistence:**
Cart is wiped on app restart. Needs SharedPreferences or similar local storage.

**Size labels for 2-tier items:**
"Regular/Large" assigned by count, not confirmed against shop's actual terminology.

**What's not built:**
Auth, orders, account, dynamic status, cart persistence, polish pass.
See master doc BUILD PLAN for session-by-session breakdown.

---

## WORKFLOW NOTES FOR FUTURE SESSIONS

**GitHub pull, not paste.** Repo is public. Clone at session start:
`git clone https://github.com/kwabenaf/yummies.git` — then read `code/lib/` directly.
Eliminates the need for user to paste files and avoids stale-context risk.

**git status after file handover.** When handing over multiple files, user should run
`git status` immediately after copying them in, before running the app. Catches files
that silently didn't overwrite (browser saving duplicates like `main (1).dart`).

**melloCaravan standard mode.** When user signals low energy: pull code directly, lead with
concrete actions not questions, front-load verification before reporting done.
Speed reduces user effort, never reduces correctness. 

**Shell context matters.** User switches between PowerShell and Git Bash (MINGW64).
Commands that work in one may not work in the other (`rm -rf` is Bash, `Remove-Item
-Recurse -Force` is PowerShell). Always check which shell the user is in before
giving filesystem commands.

**The prototype is for feel, not architecture.** `yummies-v2.html` validates design
and interaction feel. Its JS logic (e.g. `price.split('–')[0]`) is a shortcut,
not a decision. Don't read prototype code as architectural commitments.

---

## SESSION HISTORY

| Session | What was built | Bugs fixed |
|---|---|---|
| 1 | Project setup, theme, all data models, menu screen, home shell | CategoryStrip color+decoration conflict; card fixed height overflow (replaced with IntrinsicHeight + minHeight) |
| 2 | PriceOption model, CartModel + Provider, item detail sheet with size selection, BasketScreen with sauce upsell and swipe-to-dismiss, basket badge on nav + header | const/non-const TextStyle; deprecated .withOpacity; multiple-Scaffold-under-IndexedStack persistent SnackBars; minus button accidental removal (→ swipe-to-dismiss) |
| 3 | Price audit (40 items fixed), delivery/collection in CartModel, checkout screen with toggle + address + validation, confirmation screen, running basket total in header, visible × delete on cart rows | Confirmation 0 items/wrong total (closure captured cart by ref, evaluated after clear); "Back to Menu" returning to basket tab (popUntil → pushAndRemoveUntil) |

---

## NEXT SESSION STARTS HERE

Session 4: Auth + orders + account.

- Login + registration screens
- Guest checkout option (reduces friction — collect account details after first order)
- Order history list
- Order detail / tracking status
- Account screen (profile edit, password change, log out)
- Auto-fill checkout from account details
- Saved notes on checkout
- Cart persistence across app close (SharedPreferences or similar)

Auth is the biggest open question: is this token-based against the existing backend,
or a local-only prototype? Depends on the backend investigation (is the shop's system
white-label with an API, or closed?). For a demo-quality v1 that gets pitched, local
mock auth may be sufficient — the pitch is the front-end, not the integration.

---

*melloWare Ltd. Session 3 closed 24 Jun 2026.*
*This file is Claude's working document. Update at the end of every session.*