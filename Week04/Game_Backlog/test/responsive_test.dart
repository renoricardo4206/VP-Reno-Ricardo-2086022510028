// =============================================================================
// responsive_test.dart — sembilan tes Week 4 untuk Game Backlog
//
// Diadaptasi dari lab04_test.dart (dosen): 16 kasus untuk sembilan tes, ditambah
// satu bonus. Setiap tes mengatur ukuran layar (kadang keyboard, notch, atau
// data), menampilkan aplikasi, dan GAGAL kalau Flutter melaporkan error layout
// apa pun ("A RenderFlex overflowed…", "unbounded height", dan sebagainya).
//
//   flutter test test/responsive_test.dart
//
// CATATAN: flutter test memakai font uji di mana setiap huruf berupa persegi
// penuh, jadi teks jauh lebih lebar daripada di ponsel. Kalau tes gagal tetapi
// harness terlihat normal, berarti teks itu belum punya strategi overflow
// (maxLines + ellipsis, atau ruang untuk membungkus). Perbaiki strateginya,
// bukan fontnya.
//
// Kalau proyekmu tidak bernama flutter_application_2, ganti nama package di
// import di bawah dengan nilai `name:` di pubspec.yaml.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/data/sample_data.dart';
import 'package:flutter_application_2/features/models/game.dart';
import 'package:flutter_application_2/features/widgets/game_card.dart';
import 'package:flutter_application_2/lab_harness.dart';
import 'package:flutter_test/flutter_test.dart';

const Size small = Size(320, 568);
const Size large = Size(430, 932);
const Size tablet = Size(800, 1280);

const List<(String, Size)> screens = [
  ('small phone', small),
  ('large phone', large),
  ('tablet', tablet),
];

/// Mengatur layar palsu, menampilkan aplikasi, dan menunggu semua animasi selesai.
Future<void> pumpLab(
  WidgetTester tester,
  Size size, {
  List<Game>? games,
  double keyboard = 0,
  double topInset = 0,
  double bottomInset = 0,
  ThemeMode theme = ThemeMode.light,
}) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  tester.view.viewInsets = FakeViewPadding(bottom: keyboard);
  tester.view.padding = FakeViewPadding(top: topInset, bottom: bottomInset);
  tester.view.viewPadding = FakeViewPadding(top: topInset, bottom: bottomInset);
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    GameBacklogHarnessApp(games: games ?? kDefaultGames, themeMode: theme),
  );
  await tester.pumpAndSettle();
}

/// Gagal dengan pesan asli Flutter, supaya widget, sumbu, dan pikselnya terbaca.
/// Kalau ada beberapa error sekaligus, alasannya hanya "Multiple exceptions":
/// gulir ke atas di output tes untuk membaca satu per satu.
void expectNoLayoutErrors(WidgetTester tester) {
  final Object? error = tester.takeException();
  expect(error, isNull, reason: 'Layout error:\n$error');
}

/// Scroll view vertikal utama (bukan kolom pencarian, bukan chip).
Finder get mainScrollable => find
    .byWidgetPredicate(
      (widget) => widget is Scrollable && widget.axisDirection == AxisDirection.down,
    )
    .first;

void main() {
  final List<Game> bigList = gamesForScenario('long_list');
  final List<Game> longNameList = gamesForScenario('long_text');

  group('Game Backlog — the unbreakable screen', () {
    testWidgets('1 · small phone, 320 dp', (tester) async {
      await pumpLab(tester, small);
      expectNoLayoutErrors(tester);
      expect(find.byType(VerticalDivider), findsNothing, reason: 'Ponsel tetap satu kolom.');
    });

    testWidgets('2 · large phone, 430 dp', (tester) async {
      await pumpLab(tester, large);
      expectNoLayoutErrors(tester);
      expect(find.byType(VerticalDivider), findsNothing, reason: 'Ponsel tetap satu kolom.');
    });

    testWidgets('3 · tablet, 800 dp — the layout changes, it does not stretch', (tester) async {
      await pumpLab(tester, tablet);
      expectNoLayoutErrors(tester);
      expect(
        find.byType(VerticalDivider),
        findsOneWidget,
        reason: 'At 800 dp the single column should become two panes.',
      );
      final searchRight = tester.getRect(find.byKey(const Key('search-field'))).right;
      final firstCardLeft = tester.getRect(find.byType(GameCard).first).left;
      expect(
        searchRight,
        lessThanOrEqualTo(firstCardLeft),
        reason: 'The controls should sit in a side panel, to the left of the list.',
      );
    });

    for (final (name, size) in screens) {
      testWidgets('4 · landscape — $name', (tester) async {
        await pumpLab(tester, size.flipped);
        expectNoLayoutErrors(tester);
      });
    }

    for (final (name, size) in screens) {
      testWidgets('5 · a 200-character game title — $name', (tester) async {
        await pumpLab(tester, size, games: longNameList);
        expectNoLayoutErrors(tester);
      });
    }

    testWidgets('6 · zero items shows an empty state', (tester) async {
      await pumpLab(tester, small, games: const <Game>[]);
      expectNoLayoutErrors(tester);
      expect(
        find.byKey(const Key('empty-state')),
        findsOneWidget,
        reason: "Zero items needs an empty state with key: const Key('empty-state').",
      );
      expect(find.byIcon(Icons.videogame_asset_off_outlined), findsOneWidget);
      expect(find.text('Muat data contoh'), findsOneWidget);

      // Dengan font uji yang lebar, tombol bisa berada di bawah tepi layar:
      // gulir dulu sampai terlihat, seperti yang dilakukan pengguna.
      await tester.ensureVisible(find.text('Muat data contoh'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Muat data contoh'));
      await tester.pumpAndSettle();
      expectNoLayoutErrors(tester);
      expect(find.byType(GameCard), findsWidgets);
    });

    testWidgets('7 · 500 items — built lazily, scrolled hard', (tester) async {
      await pumpLab(tester, small, games: bigList);
      expectNoLayoutErrors(tester);
      expect(
        find.byType(GameCard).evaluate().length,
        lessThan(100),
        reason: 'Only the visible cards should be built. Is a long list shrink-wrapped?',
      );

      for (var i = 0; i < 5; i++) {
        await tester.fling(mainScrollable, const Offset(0, -2000), 3000);
        await tester.pumpAndSettle();
      }
      expectNoLayoutErrors(tester);
    });

    testWidgets('8 · keyboard open on a short screen — content stays reachable', (tester) async {
      await pumpLab(tester, small, keyboard: 260);
      expectNoLayoutErrors(tester);
      final field = tester.getRect(find.byKey(const Key('search-field')));
      expect(
        field.bottom,
        lessThanOrEqualTo(small.height - 260),
        reason: 'The search field is hidden behind the keyboard.',
      );
      expect(
        tester.getRect(mainScrollable).bottom,
        lessThanOrEqualTo(small.height - 260),
        reason:
            'The scrollable content should end above the keyboard so everything can be scrolled into view.',
      );
    });

    testWidgets('8 · keyboard open in landscape', (tester) async {
      await pumpLab(tester, small.flipped, keyboard: 180);
      expectNoLayoutErrors(tester);
    });

    for (final (name, size) in screens) {
      testWidgets('9 · dark mode — $name', (tester) async {
        await pumpLab(tester, size, theme: ThemeMode.dark);
        expectNoLayoutErrors(tester);
        // Keterbacaan dicek dengan mata di harness: nyalakan "Dark mode".
      });
    }

    testWidgets('Bonus · notch and gesture bar', (tester) async {
      await pumpLab(tester, small, topInset: 32, bottomInset: 20);
      expectNoLayoutErrors(tester);
      expect(
        tester.getRect(mainScrollable).bottom,
        lessThanOrEqualTo(small.height - 20),
        reason: 'The list runs under the gesture bar. Which widget keeps content out of it?',
      );
    });
  });
}