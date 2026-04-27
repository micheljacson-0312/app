GHL CRM Mobile App

Structure
- backend/: Node.js Express backend that proxies GHL API
- flutter_app/: Flutter frontend using Riverpod

Run locally
1. Backend
   - cd backend
   - cp .env.example .env and set GHL_PRIVATE_TOKEN
   - npm install
   - npm run dev

2. Flutter
   - cd flutter_app
   - flutter pub get
   - run on emulator. Android emulator reach backend at http://10.0.2.2:4000
