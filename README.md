# DineDash - Sistem Point of Sale (POS) Restoran Modern

Selamat datang di repositori **DineDash**, sebuah aplikasi Point of Sale (POS) berbasis Flutter yang dirancang untuk restoran modern. Aplikasi ini menawarkan antarmuka pengguna (UI) yang premium dengan gaya *glassmorphism* dan fitur manajemen pesanan yang efisien.

## 📱 Fitur Utama

Aplikasi ini mencakup fitur-fitur berikut untuk membantu operasional restoran:

*   **Dashboard Pesanan**:
    *   Melihat semua pesanan aktif secara real-time.
    *   Indikator status pesanan (Menunggu Pembayaran, Disiapkan, Siap Disajikan).
    *   Fitur hapus pesanan (Server-side deletion).
    *   Sinkronisasi jumlah pesanan dengan Sidebar.

*   **Manajemen Dapur (Kitchen Display)**:
    *   Tampilan khusus untuk staf dapur.
    *   Memproses pesanan masuk ("Terima" untuk mulai memasak).
    *   Update status pesanan: *Preparing* -> *Ready* -> *Completed*.
    *   Membatalkan pesanan jika stok habis.

*   **Buat Pesanan Baru**:
    *   Pilih produk dari menu.
    *   Keranjang belanja (Cart) interaktif.
    *   Pilihan tipe pesanan: *Makan di Tempat* (Dine In) atau *Bawa Pulang* (Take Away).
    *   Input nomor meja (untuk Dine In).
    *   Metode pembayaran: Cash atau QRIS.

*   **Pengaturan (Settings)**:
    *   Profil pengguna.
    *   Pengaturan tampilan (Mode Gelap/Terang - *Coming Soon*).
    *   Manajemen perangkat (Printer Kasir, Customer Display).

*   **Desain Premium**:
    *   Antarmuka modern dengan efek *Glassmorphism*.
    *   Responsif untuk Tablet dan Desktop.
    *   Navigasi Sidebar yang intuitif dengan indikator notifikasi.

## 🛠️ Teknologi yang Digunakan

*   **Frontend**: Flutter (Dart)
*   **State Management**: `setState` & Callback-based state lifting (untuk sinkronisasi sederhana).
*   **Networking**: `http` package untuk komunikasi dengan REST API.
*   **Backend API**: Terintegrasi dengan `pos-app-backend-production.up.railway.app`.

## 📂 Struktur Proyek

```
lib/
├── main.dart               # Entry point aplikasi
├── models/                 # Model data (Transaction, Product, User)
├── screens/                # Halaman-halaman aplikasi
│   ├── dashboard/          # Dashboard utama
│   ├── delivery/           # Layar integrasi dapur/delivery
│   ├── login_screen.dart   # Layar login
│   ├── home_screen.dart    # Wrapper utama setelah login
│   ├── order/              # Layar buat pesanan baru
│   └── settings/           # Layar pengaturan
├── services/               # Logika bisnis dan API (ApiService)
├── theme/                  # Konfigurasi warna dan tema (AppColors)
└── widgets/                # Widget reusable (Sidebar, OrderCard, GlassCard)
```

## 🔑 Akun Demo

*   **Email**: `1`
*   **Password**: `1`

---

