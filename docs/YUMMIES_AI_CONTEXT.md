# Yummies App — AI Context & Code Map
*Claude's working document. Not user-facing — co-created, not read independently.*
*Upload alongside yummies-master.md. Together they are sufficient to continue without reconstruction.*
*Last updated: end of Session 2, 22 Jun 2026.*

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

## FILE STRUCTURE (post Session 2)

```
lib/
├── main.dart                        — Entry point. Provider root, app config, orientation lock.
├── theme/
│   └── app_theme.dart               — ALL design tokens. Dark app + light sheet surfaces.
├── data/
│   ├── menu_item.dart               — MenuItem, PriceOption, MenuSection, MenuTab.
│   └── menu_data.dart               — All 171 items as static Dart data. Untouched by Session 2.
├── models/
│   └── cart_model.dart              — CartModel ChangeNotifier. CartLine. Single basket state.
└── screens/
    ├── home_shell.dart              — THE ONLY SCAFFOLD. Bottom nav, IndexedStack, tab routing.
    ├── menu_screen.dart             — Category strip, section headers, cards, quick-add logic.
    ├── item_detail_sheet.dart       — Modal bottom sheet. Size selection, qty, add to basket.
    └── basket_screen.dart           — Cart rows, sauce upsell, summary, place order stub.
```

**Line counts (Session 2 end):**
main.dart: 30 | app_theme.dart: 215 | menu_item.dart: 92 | menu_data.dart: ~930 |
cart_model.dart: 56 | home_shell.dart: 189 | menu_screen.dart: 594 |
item_detail_sheet.dart: 276 | basket_screen.dart: 384
**Total:** ~2,766 lines across 9 files.

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

**CRITICAL DATA ISSUE:** The price-string parser works correctly, but the underlying
data in `menu_data.dart` is wrong — 77 items have only 2 tiers where the menu doc
says 3. The parser labels 2-tier items as "Regular/Large" when they should be
"Small/Medium/Large" once the missing middle tier is restored. See FLAGGED in master doc.

### `lib/data/menu_data.dart` (~930 lines)
Static class `MenuData` with one field: `static final List<MenuTab> tabs`.
**Not touched by Session 2.** The 171 hand-authored items are unchanged.

6 tabs, 15 original categories collapsed into sections.
Gradient presets defined as private const lists at the top.
Item IDs are unique integers in ranges: Deals 1–25, Pizza 30–51, Kebabs 60–90,
Chicken 100–128, Sides 140–200, Drinks 210–231.

Intentional duplicates: Tub Of Coleslaw, Curry, Gravy, Beans in both Sides and
Sauces & Dips sections. Do not remove.

### `lib/models/cart_model.dart` (56 lines)
**`CartLine`** — one line in the basket.
- `item` (MenuItem), `size` (PriceOption), `qty` (int, mutable)
- `get lineTotal` → `size.price * qty`
- `get key` → `'${item.id}::${size.label}'` — same item + different size = different line

**`CartModel`** extends `ChangeNotifier`.
- `_lines` — the basket contents
- `get lines`, `get itemCount`, `get subtotal`
- `add(item, size, {qty})` — merges if same key exists, otherwise creates new line
- `setQty(line, qty)` — updates qty, removes if qty <= 0
- `removeLine(line)` — hard remove
- `clear()` — empties everything

No sauce-specific state. Sauce upsell chips add/remove real cart lines for sauce
MenuItems found via lookup in `MenuData.tabs`. This means sauces show up in the
cart row list, update subtotal, and survive any future cart persistence — they're
not a cosmetic parallel structure.

### `lib/screens/home_shell.dart` (189 lines)
**THE ONLY SCAFFOLD IN THE APP.** This is a locked architectural decision (Session 2).
Do not add Scaffold to any tab screen — it causes SnackBar lifecycle bugs under
IndexedStack because multiple ScaffoldMessengers compete for the same queue.

- `HomeShell` — StatefulWidget, manages `_index` for tab switching
- `_goToBasket()` callback passed to `MenuScreen` for header basket icon navigation
- `IndexedStack` with 4 children: MenuScreen, BasketScreen, 2 placeholders
- `_BottomNav` — custom nav bar with badge support on basket tab
- `_NavItem` — badge renders when `badgeCount > 0`, watches `CartModel.itemCount`
- `_PlaceholderScreen` — icon + label for Orders (Session 4) and Account (Session 4)

### `lib/screens/menu_screen.dart` (594 lines)
The main screen. Most complexity lives here.

**Architecture:** Flat `List<_Entry>` from active tab's sections. Three entry types:
`_SectionHeaderEntry`, `_DividerEntry`, `_ItemEntry`. Single `ListView.builder`.

**Key widgets:**
- `_MenuScreenState` — `_activeTab`, `_isDelivery`, `_entries`, two ScrollControllers
- `_Header` — wordmark, status pill (hardcoded), basket button with live badge, delivery/collection toggle
- `_ToggleBtn` — AnimatedContainer, 160ms
- `_CategoryStrip` — horizontal tab pills, 44px height, 2px red underline on active
- `_SectionHeader` — title + count
- `_Divider` — 1px border line
- `_MenuCard` — the card. ScaleTransition 0.97, IntrinsicHeight + minHeight: 90.
  **Card tap** → always opens detail sheet.
  **Quick-add (+)** → `hasSizeChoice` ? open detail sheet : add directly with haptic.
- `_AddButton` — tighter scale 0.82, independent animation

**No Scaffold here.** Uses `Container(color: AppColors.bg)` + `SafeArea` instead.

### `lib/screens/item_detail_sheet.dart` (276 lines)
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

### `lib/screens/basket_screen.dart` (384 lines)
Full basket tab, not a modal sheet.

- `BasketScreen` — reads `CartModel` via `context.watch`, shows empty state or list
- `_CartRow` — **wrapped in `Dismissible`** (swipe left to remove, red bg with bin icon).
  Qty pill with dimmed minus at qty 1 — minus does nothing when qty is already 1.
- `_QtyPill` — `atMin` flag controls whether minus is dimmed/disabled
- `_QtyIcon` — dimmed state via `AppColors.text3`
- `_SauceStrip` — "Anything to dip?" with 7 chips. Each chip looks up the real
  MenuItem from `MenuData.tabs`, adds/removes it as a real cart line (smallest size).
  `isOn` checks whether a matching line exists in the cart.
- `_Summary` — subtotal, delivery (hardcoded £2.00), total
- `_PlaceOrderButton` — stub, shows SnackBar "Checkout — Session 3"

**No Scaffold here.** Uses `Container(color: AppColors.bg)` + `SafeArea` instead.

**Delivery fee** is hardcoded £2.00, not wired to delivery/collection toggle. Session 3 fix.

---

## PATTERNS — LOCKED

**Single Scaffold per shell.** Only `HomeShell` has a Scaffold. Tab screens use
Container + SafeArea. This prevents SnackBar queue/lifecycle bugs under IndexedStack.
Discovered the hard way in Session 2 — three Scaffolds competing for one messenger
caused SnackBars to persist forever across tab switches.

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

**Swipe to dismiss for basket removal.** Minus stops at qty 1 (dims). Removal is a
deliberate horizontal swipe gesture only.

**Provider over setState for basket state.** CartModel is the single source of truth
for basket contents, read by menu screen (badge), basket screen, and eventually checkout.

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

---

## THINGS TRIED AND REJECTED

| What | Why rejected | Session |
|---|---|---|
| SnackBar with Undo on minus-to-remove | Timer never reliably auto-dismissed. Queue stacked stale removals. Close icon (×) added visual noise to a one-line toast. Three rounds of fixes, none clean. Root cause was wrong: the problem was accidental removal, not missing undo. Swipe-to-dismiss solved it without any SnackBar. | 2 |
| Separate `_sauces` Set in CartModel | Created a parallel structure that could drift from the real cart lines. Removed before ship — sauce chips now add/remove actual MenuItems as cart lines. | 2 |
| `const Padding` wrapping `Text` with AppTextStyles | GoogleFonts.dmSans() returns non-const TextStyle. Wrapping the parent widget in const causes compile error. Never const-wrap a widget tree that references AppTextStyles. | 2 |

---

## KNOWN GAPS AND OPEN WORK

**Data integrity (FLAGGED, blocking Session 3):**
77 of 171 items have only 2 price tiers in `menu_data.dart` where `yummies-menu.md`
lists 3. Every pizza, most kebabs, all sized sauces, many chicken/sides items.
The middle tier was systematically dropped during initial data entry in Session 1.
Must be audited and corrected before Session 3 builds checkout — cart math will be
wrong for every affected item otherwise.

**Delivery fee not wired to toggle:**
£2.00 hardcoded in `basket_screen.dart`. Collection should be £0. Wire to
`_isDelivery` state when checkout is built.

**Status pill hardcoded:**
"Closed · Opens 16:00" — should reflect actual hours dynamically.

**What's not built:**
Checkout, auth, orders, account, dynamic status, polish pass.
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

---

## NEXT SESSION STARTS HERE

Session 3: Place Order flow.

**Before writing any checkout code:** run the full price-string audit. 77 items
in `menu_data.dart` need their middle price tier restored from `yummies-menu.md`.
This is not optional — cart math will be wrong for every affected item until it's done.
The parser and size labels will work correctly once the data is right (3-tier items
automatically get "Small/Medium/Large" labels).

After the audit:
- Wire delivery fee to delivery/collection toggle (£2.00 / £0.00)
- Checkout form (address for delivery, notes)
- Place order confirmation screen
- Decide: does Session 3 also include auth, or does that stay in Session 4?

---

*melloWare Ltd. Session 2 closed 22 Jun 2026.*
*This file is Claude's working document. Update at the end of every session.*