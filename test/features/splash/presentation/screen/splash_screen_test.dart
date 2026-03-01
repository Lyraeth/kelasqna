import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:kelasqna/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class MockSessionsBloc extends Mock implements SessionsBloc {}

void main() {
  late MockSessionsBloc mockSessionsBloc;

  setUp(() {
    mockSessionsBloc = MockSessionsBloc();
    when(
      () => mockSessionsBloc.state,
    ).thenReturn(const SessionsState.initial());
    when(() => mockSessionsBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('id')],
      home: BlocProvider<SessionsBloc>.value(
        value: mockSessionsBloc,
        child: const SplashScreen(),
      ),
    );
  }

  group('SplashScreen Widget Test', () {
    testWidgets('should render app name and icon', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // assert
      expect(find.text('KelasQNA'), findsOneWidget);
      expect(find.byIcon(Icons.school), findsOneWidget);

      // FIX: Clean up the pending 2-second timer before the test ends
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('should add SessionsEvent.started() after delay', (
      WidgetTester tester,
    ) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Initial check: event should not have been called yet
      verifyNever(() => mockSessionsBloc.add(any()));

      // act
      // Fast forward time by 2 seconds to trigger the timer
      await tester.pump(const Duration(seconds: 2));

      // assert
      verify(
        () => mockSessionsBloc.add(const SessionsEvent.started()),
      ).called(1);
    });
  });

  setUpAll(() {
    registerFallbackValue(const SessionsEvent.started());
  });
}
