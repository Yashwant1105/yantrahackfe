# ♻️ GreenLink – A Flutter-Based Waste Management App

GreenLink is a mobile application built using Flutter that enables users and factories to engage in effective waste management and recycling contributions. It features seamless login/signup systems, contribution tracking, and integration with Supabase for secure backend communication.

---

## 📱 Screens & Features

### ✅ User-Facing Screens
- **Login & Signup for Users**
- **User Dashboard (UserMain)**
- **Recycle Contribution Screen**
- **Contributions Summary**
- **Camera Integration (future scope)**

### 🏭 Factory-Facing Screens
- **Login & Signup for Factory**
- **Factory Dashboard (FactoryMain)**

### 🌟 Additional Features
- **Splash Screen** with authentication check
- Shared navigation using `go_router`
- Theme customization and Google Fonts
- JWT token handling for secure access

---

## 🧠 DBMS Concepts Implemented

### 1. **Authentication & Authorization (Supabase)**
- Email-password login system
- Secure token-based authentication
- Authorization checks using stored access tokens

### 2. **Persistent Storage (SharedPreferences)**
- Stores login credentials (`accessToken`, `refreshToken`, `lastEmail`)
- Used to determine login state and auto-login

### 3. **Backend Integration with Supabase (PostgreSQL)**
- Integration with Supabase for backend storage and user auth
- Abstracted DB operations (login queries, session storage)
- Accessing data stored in relational tables (abstracted)

### 4. **Token-Based Session Management**
- JWT tokens decoded to fetch `userId`
- Stateless authentication using token-based architecture

---

## 🧰 Tech Stack

- **Flutter** – UI development
- **Dart** – Programming Language
- **Supabase** – Backend service (authentication + PostgreSQL)
- **SharedPreferences** – Local key-value storage
- **GoRouter** – Navigation management
- **JWT** – Token decoding

---


---

## 🚀 How to Run

```bash
git clone https://github.com/Yashwant1105/your-repo-name.git
cd your-repo-name
flutter pub get
flutter run


