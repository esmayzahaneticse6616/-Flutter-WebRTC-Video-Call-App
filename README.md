# 📞 Flutter WebRTC Video Call App  

A simple and effective **video calling app** built with **Flutter** and **WebRTC**. This app allows users to make **real-time video calls** using Firebase for signaling and WebRTC for peer-to-peer connection.  

---

## 🚀 Features  

✅ **Live Video Calling** – Peer-to-peer WebRTC-based video calls  
✅ **End-to-End Encryption** – Secure communication  
✅ **Mute/Unmute Audio** – Control microphone during the call  
✅ **Firebase Signaling** – Real-time signaling using Firebase Realtime Database  
✅ **Cross-Platform Support** – Works on Android, iOS, and Web  

---

## 📌 Technologies Used  

- **Flutter** – UI framework for building cross-platform apps  
- **WebRTC** – Real-time video communication technology  
- **Firebase** – Used for signaling (Firebase Realtime Database)  
- **Flutter WebRTC Plugin** – Handles camera, microphone, and WebRTC features  

---

## 🔧 Installation & Setup  

### 1️⃣ **Clone the Repository**  

```sh  
git clone https://github.com/esmayzahaneticse6616/-Flutter-WebRTC-Video-Call-App.git
cd flutter-webrtc-video-call  
```  

### 2️⃣ **Install Dependencies**  

```sh  
flutter pub get  
```  

### 3️⃣ **Setup Firebase**  

1. Go to [Firebase Console](https://console.firebase.google.com/)  
2. Create a new project  
3. Add an Android/iOS app and download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS)  
4. Place `google-services.json` inside `android/app/` and `GoogleService-Info.plist` inside `ios/Runner/`  
5. Enable Firebase Realtime Database and set rules to:  

```json  
{  
  "rules": {  
    ".read": true,  
    ".write": true  
  }  
}  
```  

### 4️⃣ **Run the App**  

```sh  
flutter run  
```  

---

## 📲 How It Works  

1. **User 1** starts a call → Creates an **offer** and sends it to Firebase.  
2. **User 2** joins → Retrieves the offer and generates an **answer**.  
3. Both users exchange **ICE candidates** for direct connection.  
4. **WebRTC** establishes a peer-to-peer connection and streams video/audio.  

---

## 🛠 Configuration  

### **Android Permissions** (AndroidManifest.xml)  

```xml  
<uses-permission android:name="android.permission.CAMERA"/>  
<uses-permission android:name="android.permission.RECORD_AUDIO"/>  
<uses-permission android:name="android.permission.INTERNET"/>  
```  

### **iOS Permissions** (Info.plist)  

```xml  
<key>NSCameraUsageDescription</key>  
<string>We need access to your camera for video calling</string>  
<key>NSMicrophoneUsageDescription</key>  
<string>We need access to your microphone for audio</string>  
```  

---

## 🎥 Video Call UI  

- **Local Video** – Displays the user's own camera feed  
- **Remote Video** – Displays the peer's video stream  
- **Mute Button** – Enables/Disables microphone  
- **End Call Button** – Disconnects the call  

---

## 📌 Troubleshooting  

❌ **getUserMedia() NotAllowedError** → Ensure camera & microphone permissions are granted.  
❌ **Failed to Load FirebaseOptions** → Check if `google-services.json` is correctly placed.  
❌ **ICE Connection Failed** → Verify that Firebase Realtime Database rules allow read/write.  

---

## 💡 Future Enhancements  

🔹 **Group Calling Support**  
🔹 **Call Notifications**  
🔹 **Screen Sharing**  
🔹 **Better UI with Animations**  

---

## 💖 Contributing  

Feel free to contribute! Submit a pull request or report issues in the repository.  

---

## 📞 Contact  

For any queries or support, reach out to [**alamincse6615@gmail.com**](mailto:alamincse6615@gmail.com).  

---

**Happy coding! 🚀🎥**  
