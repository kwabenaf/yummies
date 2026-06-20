# Yummies — Project Master
*A melloWare Ltd studio project.*
*Started April 2026. Shelf until melloWare is ready to pitch.*

---

## STATUS

| Phase | Status |
|---|---|
| Discovery & audit | ✅ Complete |
| Design decisions (HTML prototype) | ✅ Complete |
| Menu architecture | ✅ Complete |
| Flutter foundation | ✅ Complete |
| Item detail + basket | Pending |
| Checkout + delivery/collection | Pending |
| Sauce upsell (checkout) | Pending |
| Login / registration | Pending |
| Order history + tracking | Pending |
| Polish pass | Pending |
| Shelf for pitch | Pending |

---

## THE PITCH

A bespoke mobile ordering app redesign for Yummies — a kebab, pizza and fried chicken
shop in Cardiff. The existing app is a WebView wrapper with poor navigation, no design
system, repeated error modals, and a 15-tab menu structure that buries 171 items.

The redesign solves every identified problem and delivers something that feels like
a real native app. If the shop accepts: melloWare charges for the work. If not:
the build goes in the portfolio and the skills compound.

Contact: 02920 568 812
Hours: Tue–Thu + Sun 16:00–22:30, Fri–Sat 15:00–22:30, Mon Closed

---

## COMMERCIAL

### Price range
**£1,500 – £3,500** for the front-end redesign as scoped.

This covers: Flutter app (iOS + Android), full menu with 171 items restructured into
6 tabs, item detail, basket with sauce upsell, checkout flow, login/registration,
order history, account management, polish pass, and handover.

It does not cover: backend integration, payment processing, App Store submission
fees, or ongoing maintenance.

### Ongoing support
To be decided and quoted separately at pitch stage. Options worth considering:
- Flat monthly retainer (menu updates, bug fixes)
- Per-change hourly rate
- No support — handover only

Do not go in without a position on this. The owner will ask.

### Why this range
The lower band reflects that this is front-end only — the existing backend handles
orders and payments. No new infrastructure means significantly less risk and time.

The upper band reflects the full scope: 5 build sessions, a complete design system,
171 real items, and a polished demo that required genuine research and audit work
before a line of code was written. That work has value even if the client doesn't
see it.

The strongest position at pitch is a working demo of their own app looking better
than what they currently have. That is not a quote for hypothetical work. It is a
price for something that already exists.

---

## WHAT WAS WRONG WITH THE ORIGINAL APP

1. **Navigation labels lie** — "Home" was account management. "Orders" was profile + password.
2. **Out-of-hours modal fires on every Menu tap** — should appear once per session, then allow browsing.
3. **15 category tabs** for 171 items — overwhelming. No hierarchy.
4. **DELETE MY ACCOUNT** was the first element in the profile form, in orange, above the fields.
5. **Email field in registration labelled "NAME"** — a bug in production.
6. **No design system** — 5+ button colours in use with no logic. Blue, teal, green, orange, red.
7. **Registration requires address and postcode upfront** — unnecessary friction.
8. **The app is a WebView** — behaves like a website, has cookie consent banners, no native feel.
9. **Hero image throughout is stock pizza** — this is a kebab shop.
10. **Massive empty space** on the home screen — a card floating in black.

---

## DESIGN DECISIONS (LOCKED)

### Palette
- Background: `#0C0C0D` (near black)
- Surface: `#181819`
- Surface 2: `#222224`
- Accent: `#C8200A` (red — respects their existing branding)
- Yellow: `#F5C400` (wordmark — respects their existing branding)
- Text primary: `#FFFFFF`
- Text secondary: `rgba(255,255,255,0.44)`

### Navigation — 4 bottom tabs
- **Menu** — food browsing. Entry point. What 90% of users open the app for.
- **Basket** — live cart. Replaces the misleading "Checkout" tab.
- **Orders** — order history and tracking only.
- **Account** — profile, password, contact, log out.

### Menu — 6 category tabs (horizontal scroll strip)
| Tab | Contains | Items |
|---|---|---|
| 🔥 Deals | Meal Deals · Mega Deals · Pizza Offers | 25 |
| 🍕 Pizza | Pizzas | 22 |
| 🥙 Kebabs & Wraps | Kebabs · Combinations · Wraps | 31 |
| 🍗 Chicken & Burgers | Fried Chicken · Burgers | 21 |
| 🍟 Sides & More | Sides · Extra Dishes · Kids Corner · Sauces & Dips | 53 |
| 🥤 Drinks & Desserts | Drinks · Desserts | 15 |

Each tab is a scrollable list of section-separated cards.
Original category names preserved as section headers — the shop owner sees their labels.

### Sauce / duplicate resolution
Tub Of Coleslaw, Tub Of Curry, Tub Of Gravy, Tub Of Beans appear in **both**
Sides section and Sauces & Dips section within the Sides & More tab. Intentional duplication
for discoverability — users find them wherever they look.

### Sauce upsell at basket
A quiet "Anything to dip?" strip appears in the basket above the order total.
7 quick-add chips (Chilli Sauce, Garlic Sauce, Mint Sauce, BBQ Sauce, Ketchup,
Tub Of Curry, Tub Of Gravy). Skippable. Not a screen. Not a modal.
Mirrors how a good counter person operates.

### Status indicator
A small pill in the header shows open/closed status and next opening time.
Non-blocking. Does not prevent menu browsing when closed.

### Cards
- Dark background cards with gradient colour image placeholder (for emoji / food photo)
- Name, short description, price, quick-add + button
- Tap card → item detail bottom sheet

### Design sensibility (melloWare)
This is a food app. Users are focused on getting food, not the app.
The goal is to make them feel blissful, pleasant, graceful — and as a
by-product of those feelings, excited for their food. Unconscious quality.
The kind of app that feels good without the user being able to explain why.

Techniques employed in Flutter:
- Smooth, physics-based scroll (Flutter default — already better than WebView)
- Bottom sheet transitions: slow ease, slight spring on open
- Card press feedback: subtle scale + opacity
- Typography: generous line height, careful weight hierarchy
- Colour: red used sparingly — CTA buttons and price only. Everything else is surface.
- Spacing: breathing room. Nothing crowded. Let the food be the thing.
- Haptic feedback on add-to-basket
- Status bar colour matched to app background

---

## BUILD PLAN

### Session 1 — Foundation ✅
- Flutter project created: `yummies_app` at `C:\melloWare\apps\yummies_app`
- Flutter upgraded from 3.10.3 → 3.41.7 during setup
- `lib/theme/app_theme.dart` — colour tokens, text styles, system chrome
- `lib/data/menu_item.dart` — data models
- `lib/data/menu_data.dart` — all 171 items as structured Dart data
- `lib/screens/home_shell.dart` — bottom nav, screen routing
- `lib/screens/menu_screen.dart` — category strip, section headers, cards
- Bugs fixed: color+decoration conflict in CategoryStrip, card overflow with IntrinsicHeight
- Running on device: Motorola Razr 50

### Session 2 — Item detail + basket
- Item detail bottom sheet (image, name, desc, price, qty, add to basket)
- Basket sheet (cart rows, sauce upsell strip, order summary, place order button)
- State management — Provider or simple setState, decide at session start

### Session 3 — Checkout + auth
- Delivery / collection selection
- Checkout form (address, notes)
- Login + registration screens
- Guest checkout option (reduces friction — collect account details after first order)

### Session 4 — Orders + account
- Order history list
- Order detail / tracking status
- Account screen (profile edit, password change, log out)

### Session 5 — Polish
- Transitions reviewed
- Empty states designed
- Error states (closed shop, network error)
- App icon (melloWare to produce or placeholder)
- Splash screen
- Final device test

---

## MELLOWARE CONTEXT

- Standalone bespoke project under melloWare Ltd
- Shelf after completion — pitch when melloWare is ready for business
- Goes into the studio portfolio regardless of outcome
- If accepted: charge for the work
- If declined: skills compounded, portfolio strengthened

---

## REVISION LOG

| Version | Date | Change |
|---|---|---|
| 0.1 | Apr-2026 | Initial build. Discovery, audit, HTML prototype, design decisions all locked. |
| 0.2 | Apr-2026 | Flutter session 1 complete. Foundation, theme, all menu data, menu screen running on device. Commercial section added with pricing range and rationale. |
