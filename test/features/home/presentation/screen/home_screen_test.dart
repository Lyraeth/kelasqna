import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:kelasqna/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class MockSessionsBloc extends Mock implements SessionsBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;
  late MockSessionsBloc mockSessionsBloc;

  final tUser = UserEntity(
    id: 1,
    name: 'John Doe',
    email: 'john@example.com',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    mockSessionsBloc = MockSessionsBloc();

    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

    when(() => mockSessionsBloc.state).thenReturn(
      SessionsState.authenticated(user: tUser, accessToken: 'fake_token'),
    );
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: mockAuthBloc),
          BlocProvider<SessionsBloc>.value(value: mockSessionsBloc),
        ],
        child: const HomeScreen(),
      ),
    );
  }

  group('HomeScreen Widget Test', () {
    testWidgets('should display user information when authenticated', (
      WidgetTester tester,
    ) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // assert
      expect(find.textContaining('John Doe'), findsOneWidget);
      expect(find.textContaining('john@example.com'), findsOneWidget);
      expect(find.textContaining('fake_token'), findsOneWidget);
    });

    testWidgets(
      'should add AuthEvent.logoutRequested() when logout button is pressed',
      (WidgetTester tester) async {
        // arrange
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        // act
        final logoutButton = find.byType(NeoKelasButton);
        await tester.tap(logoutButton);

        // FIX: Use pumpAndSettle because NeoKelasButton has a 100ms animation
        // before calling widget.onPressed?.call()
        await tester.pumpAndSettle();

        // assert
        // Use a type matcher to ensure we catch the event correctly
        verify(
          () => mockAuthBloc.add(
            any(
              that: isA<AuthEvent>().having(
                (e) => e.maybeWhen(
                  logoutRequested: () => true,
                  orElse: () => false,
                ),
                'logoutRequested event',
                true,
              ),
            ),
          ),
        ).called(1);
      },
    );

    testWidgets(
      'should add SessionsEvent.loggedOut() to SessionsBloc when AuthBloc emits successLogout',
      (WidgetTester tester) async {
        // arrange
        final authStreamController = StreamController<AuthState>.broadcast();
        when(
          () => mockAuthBloc.stream,
        ).thenAnswer((_) => authStreamController.stream);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        // act
        authStreamController.add(const AuthState.successLogout());
        await tester.pump();

        // assert
        verify(
          () => mockSessionsBloc.add(
            any(
              that: isA<SessionsEvent>().having(
                (e) => e.maybeWhen(loggedOut: () => true, orElse: () => false),
                'loggedOut event',
                true,
              ),
            ),
          ),
        ).called(1);

        await authStreamController.close();
      },
    );
  });

  setUpAll(() {
    registerFallbackValue(const AuthEvent.logoutRequested());
    registerFallbackValue(const SessionsEvent.loggedOut());
  });
}
