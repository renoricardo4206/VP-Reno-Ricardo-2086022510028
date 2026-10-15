# Responsive Matrix: Game Backlog

Aplikasi saat ini memiliki satu screen, yaitu `BacklogScreen`. Semua tes dijalankan dengan lab harness yang diadaptasi untuk Game Backlog (`lib/lab_harness.dart`), lalu dikonfirmasi dengan `flutter test`. Breakpoint layout ada di 600 dp.


| Screen | Test | Cara uji (harness) | Hasil | Perbaikan / catatan |
|---|---|---|---|---|
| BacklogScreen | Small phone | Screen: Small phone (320 dp) | Pass | Ringkasan memakai `Expanded` per kolom dan label `maxLines: 1`; chip filter memakai `Wrap` sehingga turun baris, bukan overflow ke samping. |
| BacklogScreen | Large phone | Screen: Large phone (430 dp) | Pass | Tidak ada perbaikan khusus. |
| BacklogScreen | Tablet | Screen: Tablet (800 dp), layout harus berubah | Pass | `LayoutBuilder` dengan breakpoint 600 dp: di bawahnya satu kolom, di atasnya panel kontrol di kiri dan daftar di kanan. |
| BacklogScreen | Landscape | Orientation: Landscape untuk ketiga ukuran | Pass | Lebar landscape ponsel melewati 600 dp sehingga memakai layout dua panel; panel kiri bisa digulir. |
| BacklogScreen | Long text | Data: 200-char name | Pass | Judul `maxLines: 2` + `ellipsis`, platform `maxLines: 1` + `ellipsis` dan dibungkus `Flexible`. |
| BacklogScreen | Empty state | Data: Zero items | Pass | `GameEmptyState` (`Key('empty-state')`) berisi ikon, pesan, dan aksi ("Muat data contoh" atau "Reset filter"). |
| BacklogScreen | Long list | Data: 500 items | Pass | `SliverList.builder` / `ListView.builder`, tanpa `shrinkWrap: true`. |
| BacklogScreen | Keyboard | Conditions: Keyboard open, lalu ketuk kolom pencarian (`Key('search-field')`) | | Layout satu kolom memakai `CustomScrollView`, jadi header ikut menggulir dan kolom pencarian tetap terjangkau. |
| BacklogScreen | Dark mode | Conditions: Dark mode | Pass | Teks sekunder memakai `onSurfaceVariant`; terang dan gelap sama-sama diuji. |
| BacklogScreen | Notch + gesture bar (bonus) | Conditions: Notch + gesture bar | Pass | Body dibungkus `SafeArea(top: false)` sehingga daftar tidak berada di bawah gesture bar. |