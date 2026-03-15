# KelasQNA 🎓

KelasQNA adalah platform tanya jawab inovatif yang dirancang khusus untuk siswa dan siswi guna memfasilitasi diskusi akademik secara cepat, terstruktur, dan kolaboratif. Aplikasi ini bertujuan untuk meruntuhkan batasan ruang kelas konvensional, memungkinkan proses belajar mengajar tetap berlangsung secara digital melalui interaksi antar pengguna.

Dengan KelasQNA, siswa dapat bertanya tanpa rasa sungkan dan mendapatkan berbagai perspektif jawaban dari komunitas belajar yang suportif.

---

## ✨ Fitur Utama

### 📝 Posting Pertanyaan
Buat dan bagikan pertanyaan terkait materi pelajaran dengan mudah. Sertakan detail yang diperlukan agar teman-teman lain dapat membantu memberikan jawaban yang tepat.

### 📱 Timeline Pertanyaan
Pantau diskusi terbaru melalui feed yang dinamis. Lihat apa yang sedang dipelajari oleh rekan-rekanmu dan ikut berkontribusi dalam diskusi.

### 💬 Interaksi Pengguna
Bangun pemahaman yang lebih dalam melalui diskusi. Pengguna dapat memberikan jawaban, memberikan komentar, atau sekadar berdiskusi pada setiap topik pertanyaan.

### 🔐 Manajemen Akun & Sesi
Sistem autentikasi yang aman dengan pengelolaan sesi login (Session Management) untuk memastikan data dan riwayat diskusi tetap terjaga.

### 🤝 Kolaborasi Belajar
Ciptakan lingkungan belajar yang terbuka di mana siswa saling membantu menjawab tantangan akademik dan memperdalam pemahaman materi secara bersama-sama.

---

## 🚀 Tujuan Pengembangan

Tujuan utama dari KelasQNA adalah menciptakan sebuah platform diskusi pendidikan yang:
- **Sederhana & Mudah Digunakan**: Antarmuka yang intuitif untuk semua jenjang siswa.
- **Meningkatkan Interaksi**: Mendorong siswa untuk lebih aktif berdiskusi di luar jam pelajaran sekolah.
- **Demokratisasi Pengetahuan**: Memberikan akses jawaban dari berbagai perspektif komunitas.

---

## 🛠️ Detail Teknis (Tech Stack)

Aplikasi ini dibangun menggunakan teknologi modern untuk memastikan performa dan skalabilitas yang baik:

- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **State Management**: [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- **Routing**: [AutoRoute](https://pub.dev/packages/auto_route)
- **Networking**: [Dio](https://pub.dev/packages/dio) with [Pretty Dio Logger](https://pub.dev/packages/pretty_dio_logger)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
- **Local Database**: [Hive](https://pub.dev/packages/hive) & [Shared Preferences](https://pub.dev/packages/shared_preferences)
- **UI & Animations**: [Lucide Icons](https://pub.dev/packages/lucide_icons_flutter), [Lottie](https://pub.dev/packages/lottie), [Flutter Animate](https://pub.dev/packages/flutter_animate)
- **Security**: [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) & [Local Auth](https://pub.dev/packages/local_auth)

---

## ⚙️ Persiapan Proyek

1. **Clone Repository**
   ```bash
   git clone https://github.com/username/kelasqna.git
   cd kelasqna
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Files** (untuk AutoRoute, Freezed, & JSON Serializable)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Konfigurasi Environment**
   Pastikan file `.env` sudah tersedia di root folder (sesuaikan dengan `.env.example` jika ada).

5. **Run Application**
   ```bash
   flutter run --flavor staging / production
   ```

---

## 📄 Lisensi

Copyright © 2026 KelasQNA Team.
