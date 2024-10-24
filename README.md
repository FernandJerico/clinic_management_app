# Clinic Management App 🏥📋  
Clinic Management App adalah aplikasi manajemen klinik yang memungkinkan pengelolaan layanan klinis secara online, mulai dari reservasi hingga rekam medis elektronik. Aplikasi ini dibangun menggunakan Flutter dengan manajemen state menggunakan BLoC dan Freezed, serta backend API yang dikembangkan secara khusus.

## Fitur Utama 🔑
- **Reservasi Online**: Pasien dapat membuat janji temu dengan dokter secara online.
- **Jadwal Pasien & Dokter**: Penjadwalan yang mudah antara pasien dan dokter.
- **Rekam Medis Elektronik (EMR)**: Penyimpanan dan akses rekam medis pasien dalam format digital.
- **Master Data**: Manajemen data untuk pasien, dokter, layanan klinis, dan jadwal dokter.

## Teknologi yang Digunakan 🛠️
- **Flutter**: Framework lintas platform untuk pengembangan aplikasi mobile.
- **BLoC & Freezed**: State management yang memisahkan logika bisnis dari presentasi dengan BLoC, dan Freezed untuk pembuatan state immutable dan union classes.
- **Custom API**: Backend API dikembangkan sendiri dan tersedia di [repository ini](https://github.com/FernandJerico/be-clinic-management).

## Instalasi & Penggunaan 🚀
1. Clone repository ini:
   ```bash
   git clone https://github.com/FernandJerico/clinic-management-app.git
2. Masuk ke direktori proyek:
   ```bash
   cd clinic-management-app
3. Install dependencies:
    ```bash
    flutter pub get
4. Setup backend API sesuai dengan dokumentasi [disini ini](https://github.com/FernandJerico/be-clinic-management).
5. Jalankan aplikasi:
   ```bash
   flutter run

## Fitur Tambahan 📱
- **Manajemen Jadwal Dokter**: Pengguna dapat melihat dan mengatur jadwal dokter di klinik.
- **Manajemen Layanan**: Daftar layanan klinis yang tersedia dapat dikelola melalui aplikasi.
- **Push Notifikasi**: Pemberitahuan real-time untuk reservasi pasien.

## Arsitektur 🔧
Aplikasi ini dibangun dengan arsitektur Clean Architecture, dengan BLoC sebagai pengelola state dan Freezed untuk memastikan state tetap konsisten dan predictable. Backend API dikembangkan dengan RESTful service yang mendukung integrasi aplikasi mobile secara efisien.

## Contributing 🤝
Kami selalu terbuka untuk kontribusi! Jika tertarik, fork repository ini dan kirim pull request untuk review.
