# CardLink (SwiftUI)

CardLink is an original SwiftUI iPhone app concept for creating and sharing digital business cards.

## Legal / design disclaimer
This project intentionally uses original naming, copy, flows, visual styling, and iconography.
It does not copy protected branding, copyrighted assets, trade dress, or exact UX from any existing app.

## Included scope
- Quick onboarding to create your first card
- Profile fields: name, photo, job title, email, phone, website, social
- QR code generation for each profile
- Public profile page (clean card layout)
- Freemium model with StoreKit 2 hooks
  - Free: 1 profile + basic themes
  - Premium: multiple profiles + extra themes/customization hooks
- Local persistence with `UserDefaults` (easy to replace with backend later)
- MVVM architecture

## Architecture
- `Models/`: data models (`CardProfile`)
- `Services/`: persistence, QR generation, purchase manager
- `ViewModels/`: profile state and business logic
- `Views/`: onboarding, card list, sharing, profile display, premium screen
