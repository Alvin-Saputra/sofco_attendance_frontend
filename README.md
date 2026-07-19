# Sofco Attendance Frontend

Aplikasi frontend (mobile) berbasis Flutter untuk sistem presensi (Attendance). Aplikasi ini dibangun dengan mengimplementasikan State Management Riverpod dan integrasi REST API menggunakan HTTP.

## 🚀 Fitur Utama

- Autentikasi (Login/Logout)
- Pengambilan Presensi (Check-in/Check-out) dengan foto (image)
- Riwayat Presensi
- Environment Configuration (membaca Base URL) menggunakan `.env`

## 🛠 Prasyarat (Prerequisites)
Sebelum menjalankan project ini, pastikan Anda telah menginstal beberapa perangkat lunak berikut di sistem Anda:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi `dart: ">=3.11.1 <4.0.0" dan flutter: ">=3.38.0"` atau direkomendasikan versi stabil terbaru)
- Editor pilihan Anda (misalnya: [Android Studio](https://developer.android.com/studio), [Visual Studio Code](https://code.visualstudio.com/), atau IntelliJ IDEA)
- Emulator Android / Simulator iOS, atau perangkat HP fisik yang terhubung (USB Debugging diaktifkan)

## 📥 Panduan Instalasi (Cloning & Setup)

1. **Clone repositori**  
   Buka terminal/Command Prompt Anda, lalu jalankan perintah berikut untuk meng-clone repositori ini ke dalam komputer Anda:
   ```bash
   git clone https://github.com/Alvin-Saputra/sofco_attendance_frontend
   cd attendance_frontend
   ```

2. **Unduh seluruh package/dependensi**  
   Untuk mengunduh library pendukung aplikasi yang tercatat di `pubspec.yaml` (seperti `flutter_riverpod`, `http`, `flutter_dotenv`, dsb), jalankan perintah berikut di dalam folder project:
   ```bash
   flutter pub get
   ```

## ⚙️ Konfigurasi Environment (Setup File `.env`)

Aplikasi ini menggunakan file `.env` untuk menyimpan dan membaca alamat URL API (Base URL). 

1. Buat sebuah file baru dan beri nama persis **`.env`** di dalam folder paling luar project (sejajar dengan file `pubspec.yaml`).
2. Buka file `.env` tersebut dan tambahkan baris konfigurasi berikut:
   ```env
   BASE_URL=http://10.0.2.2:3000
   ```
   *Catatan penting untuk Base URL:*
   - `http://10.0.2.2:3000` adalah IP alias localhost default jika Anda menjalankan API server lokal (localhost:3000) di komputer yang sama dan Anda melakukan testing menggunakan **Android Emulator**.
   - Jika Anda melakukan testing menggunakan **perangkat HP fisik (via kabel USB)**, ganti IP tersebut dengan IP Address lokal komputer Anda yang terhubung pada jaringan WiFi yang sama (contoh: `http://192.168.1.15:3000`).

## ▶️ Menjalankan Project (Run)

Setelah proses instalasi dan setup file `.env` di atas selesai, Anda siap untuk menjalankan aplikasi.

1. Pastikan Emulator/Simulator sudah menyala, atau HP fisik sudah terhubung ke komputer. (Anda bisa mengeceknya dengan mengetikkan `flutter devices` di terminal).
2. Jalankan perintah berikut di terminal:
   ```bash
   flutter run
   ```
   Atau jika Anda menggunakan VS Code atau Android Studio, Anda cukup menekan tombol **Run** atau **Debug** (biasanya shortcut F5 atau icon Play berwarna hijau).
