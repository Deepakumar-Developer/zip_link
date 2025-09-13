# 🚀 ZipLink - URL Shortening Mobile Application

![ZipLink Logo](./assets/logo.png)

**ZipLink** is a URL-shortening mobile application that provides a clean, intuitive, and efficient way for users to convert long, cumbersome URLs into short, shareable links.

---

## ✨ Core Functionality

### 🔗 URL Shortening
- **Input**: Users paste a long URL into a dedicated input field within the mobile app.
- **Processing**: Upon tapping the **"Zip It!"** button, the app sends this long URL to its backend API.
- **Output**: The app receives a unique, short URL (e.g., `https://ziplink.com/Abc123`) which is displayed to the user.

---

### 📋 Shortened URL Management & Sharing
- ✅ **Copy to Clipboard**  
  Once a short URL is generated, users can copy it to their clipboard with a single tap, ready to paste into messages, social media, emails, etc.

- 🌐 **Redirection**  
  When someone clicks a generated short URL (e.g., `https://ziplink.com/Abc123`), the backend redirects them to the original long URL.

---

### 📱 Clipboard Integration (Paste)
- The app includes a **Paste Button** (📋 icon) allowing users to paste any URL or text currently in their clipboard directly into the input field, streamlining the shortening process.

---

## 🏗 Architecture (3-Tier)

### 1️⃣ Mobile Application (Flutter/Dart)
- Built with **Flutter**, offering a modern, responsive UI with gradient text & interactive buttons.
- Handles user input, displays results, and manages clipboard interactions.

---

### 2️⃣ API Backend (Dart Frog)
- High-performance Dart API built using the **Dart Frog** framework.

#### 📚 Endpoints:
- `POST /zip`:  
  Receives the long URL from the app, generates a unique short code, stores it in the database, and returns the short URL.
  
- `GET /[short_code]`:  
  Retrieves the long URL from the database and performs an HTTP 302 redirect to that original URL.

#### 🔒 Environment Variables:
- Manages sensitive data (e.g., database credentials) securely using `.env` files locally and environment variables during deployment.

---

### 3️⃣ Database (Supabase / PostgreSQL)
- Persistent storage for all shortened URLs.
- Uses **Supabase** powered by PostgreSQL.

#### 📋 Schema:
- Fields:  
  - `long_url`: Original link  
  - `short_code`: Unique identifier for the short link

#### 🔐 Security:
- Row-Level Security (RLS) to ensure data integrity.

---

## ☁️ Deployment
- Dart Frog API is deployable to cloud platforms like **Globe.dev**, **Google Cloud Run**, or **AWS App Runner** using **Docker**.
- Supports **Continuous Deployment (CD)** via GitHub integration:  
  Code pushed to a branch triggers automatic API build & deployment.

---

## 🎯 Conclusion
ZipLink is designed to be a user-friendly, reliable tool for URL shortening, backed by a modern cloud-native architecture.

---

Made with ❤️ in India 🇮🇳
