import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:kelasqna/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class MockSessionsBloc extends Mock implements SessionsBloc {}

class MockStackRouter extends Mock implements StackRouter {}

void main() {
  late MockSessionsBloc mockSessionsBloc;
  late MockStackRouter mockRouter;

  setUp(() {
    mockSessionsBloc = MockSessionsBloc();
    mockRouter = MockStackRouter();

    // Default mock behavior
    when(
      () => mockSessionsBloc.state,
    ).thenReturn(const SessionsState.initial());
    when(() => mockSessionsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockRouter.replaceAll(any())).thenAnswer((_) async => []);
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
      home: StackRouterScope(
        controller: mockRouter,
        stateHash: 0,
        child: BlocProvider<SessionsBloc>.value(
          value: mockSessionsBloc,
          child: const OnBoardingScreen(),
        ),
      ),
    );
  }

  group('OnBoardingScreen Widget Test', () {
    testWidgets('should render loading indicator and text', (
      WidgetTester tester,
    ) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Getting your data'), findsOneWidget);
    });

    testWidgets(
      'should navigate to HomeRoute when state becomes authenticated',
      (WidgetTester tester) async {
        // arrange
        // FIX: Use .broadcast() to allow multiple listeners
        final streamController = StreamController<SessionsState>.broadcast();
        when(
          () => mockSessionsBloc.stream,
        ).thenAnswer((_) => streamController.stream);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        // act
        final tUser = UserEntity(
          id: 1,
          name: 'Test',
          email: 'test@example.com',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        streamController.add(
          SessionsState.authenticated(user: tUser, accessToken: 'token'),
        );

        // Use pump() to trigger the BlocListener
        await tester.pump();

        // assert
        // FIX: Use verify() instead of verifyNever()
        verify(() => mockRouter.replaceAll([const HomeRoute()])).called(1);

        await streamController.close();
      },
    );
  });
}
