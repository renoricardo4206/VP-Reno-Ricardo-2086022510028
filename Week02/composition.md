# Composition: Video Game Backlog Manager

## State yang di-hoist di `BacklogScreen`

`BacklogScreen` (StatefulWidget) memegang seluruh state yang dibutuhkan lebih dari satu widget: `_games`, `_selectedStatus`, dan `_query`. Daftar yang tampil (`_visibleGames`) dihitung dari ketiganya, sehingga filter, pencarian, dan ringkasan selalu konsisten.

## Widget hasil ekstraksi

### 1. `GameCard`
- **Trigger:** Reuse. Dipakai berulang di dalam `ListView.builder`, satu instance untuk setiap game (data awal berisi 5 game, jadi dibuat 5 kali).
- **Owns:** Tidak memiliki state (stateless). Hanya menerima satu objek `Game` untuk ditampilkan.
- **Reports upward:** Memanggil `onStatusChanged(GameStatus)` saat user memilih status baru lewat menu di kartu.

### 2. `StatusBadge`
- **Trigger:** Reuse. Label berwarna untuk status ini dipakai di setiap `GameCard`, sehingga tampilannya seragam dan tidak ditulis ulang di tiap kartu.
- **Owns:** Tidak memiliki state (stateless). Hanya menerima `status` untuk menentukan teks dan warna.
- **Reports upward:** Tidak ada, karena hanya menampilkan data.

### 3. `StatusFilterChips`
- **Trigger:** Readability. Memisahkan UI filter (chip "All" dan chip tiap status) dari `build()` screen agar tidak terlalu panjang.
- **Owns:** Tidak memiliki state (stateless). Hanya menerima `selected` dari parent untuk menentukan chip yang sedang aktif.
- **Reports upward:** Memanggil `onSelected(GameStatus?)` saat user memilih chip. Nilai `null` berarti semua status.

### 4. `GameSearchBar`
- **Trigger:** Readability. Memisahkan `TextField` beserta dekorasinya dari `build()` screen.
- **Owns:** Tidak memiliki state sendiri. Teks yang sedang diketik dikelola oleh `TextField` bawaan Flutter, sedangkan kata kunci yang dipakai untuk menyaring tetap disimpan di screen.
- **Reports upward:** Memanggil `onChanged(String)` setiap kali teks berubah.

### 5. `BacklogSummary`
- **Trigger:** Readability. Memisahkan perhitungan dan tampilan jumlah game per status dari `build()` screen.
- **Owns:** Tidak memiliki state (stateless). Hanya menerima daftar `games` dari parent.
- **Reports upward:** Tidak ada, karena hanya menampilkan ringkasan.

## Alasan struktur

Semua widget hasil ekstraksi bersifat stateless: data masuk lewat constructor dan interaksi user dilaporkan lewat callback. Dengan begitu state (daftar game, filter, dan pencarian) hanya disimpan di satu tempat, yaitu `BacklogScreen`. Widget lain hanya menampilkan data itu dan melapor kalau ada perubahan, sehingga tampilan antar bagian selalu sinkron.
