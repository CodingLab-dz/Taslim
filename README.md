# Taslim
📝 Project Description Template
Smart Parcel Locker System
A real-time delivery management system designed to secure online purchases. This project uses a Tablet-based Android application for user/delivery interaction and a Python-powered Microcontroller to manage physical locker hardware, all synchronized via Firebase Realtime Database.

🚀 Key Features
Time-Limited Access: Delivery personnel and users receive restricted time windows to access specific lockers.

Real-Time Monitoring: Uses Firebase to track locker states (Open, Closed, Occupied, Vacant) instantly.

Dual-Interface System: * Frontend: Android Tablet App for UI/UX and access control.

Hardware: Microcontroller (Python/MicroPython) for electronic lock management and sensor feedback.

Secure Handoff: Ensures packages are only accessible to the intended recipient through unique access tokens.

🏗️ Project Structure
To keep the repository organized, the code is split into two main directories:

/android-tablet-app: The frontend interface (Java/Kotlin/Flutter) used by customers and delivery drivers.

/locker-controller: Python scripts for the microcontroller (Raspberry Pi/ESP32) to control GPIO pins and locks.

🛠️ Tech Stack
Mobile: Android (Tablet Optimized)

Language: Python (Backend/Hardware Logic)

Database: Firebase Realtime Database

Hardware: Microcontroller (e.g., Raspberry Pi, ESP32, or similar)

⚙️ Setup & Installation
Firebase: Create a project in the Firebase Console and download the google-services.json for the app and the serviceAccountKey.json for the Python controller.

Hardware: Connect your electronic locks to the specified GPIO pins defined in /locker-controller/config.py.

App: Build and install the APK on your Android tablet.
