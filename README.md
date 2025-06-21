# AviCare

**AviCare** is a physiotherapy application designed to help users perform guided exercises remotely. The platform includes a mobile app for end-users, an admin panel for managing users and exercises, and a FastAPI backend to serve both.

## 🧠 Features

- Guided physiotherapy exercises
- Admin portal to manage exercise plans and users
- User-facing Flutter mobile application
- FastAPI backend for API and web serving
- Single-deployment architecture with all components bundled

---

## 🏗️ Project Structure

```
avicare/
├── server/             # FastAPI backend server
│   ├── static/         # Built admin panel (web) is placed here
│   └── artifacts/      # Contains built mobile app APK
├── avicare_web/        # Admin panel (Flutter Web)
├── user_app/           # Main Flutter mobile app for users
└── requirements.txt    # Python dependencies for backend
```

---

## 🚀 Getting Started

### Prerequisites

- Python 3.10+
- pip
- Flutter (for development)
- Uvicorn (for running the server)

---

### Installation & Deployment

1. **Clone the repository**

   ```bash
   git clone https://github.com/yvvivek9/avicare.git
   cd avicare
   ```

2. **Install backend dependencies**

   ```bash
   pip install -r requirements.txt
   ```

3. **Run the server**

   ```bash
   uvicorn server.main:app --host 0.0.0.0 --port 5000
   ```

> ✅ The admin panel (Flutter web) is already built and located in `server/static`. The mobile app APK is in `server/artifacts`.

---

## 📦 Deployment Notes

- **Only the FastAPI server needs to be deployed.**
- Ensure port `5000` is open and accessible.
- The server will serve:
  - API endpoints
  - Admin panel at `/`
  - Mobile app can be distributed via the APK in `artifacts/`.

---

## 📁 Artifacts

- **APK (Android)**: `server/artifacts/`
- **Admin Panel Build**: `server/static/`

---

## 📬 Contact

For questions or collaboration, feel free to [open an issue](https://github.com/yvvivek9/avicare/issues).

---

## 📄 License

This project is currently not licensed. Please contact the repository owner for usage rights.
