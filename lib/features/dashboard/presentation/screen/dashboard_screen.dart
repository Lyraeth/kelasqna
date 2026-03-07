import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceContainer,
      appBar: AppBar(
        backgroundColor: context.colors.surfaceContainer,
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${context.l10n.welcomeTo} KelasQNA",
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            BlocSelector<SessionsBloc, SessionsState, String>(
              selector: (state) => state.maybeWhen(
                authenticated: (user, _, _) => user.name,
                orElse: () => "",
              ),
              builder: (context, userName) {
                return Text(
                  userName,
                  style: context.text.titleMedium?.copyWith(
                    color: context.colors.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ].separatedBy(4.h),
        ),
        actions: [
          NeoKelasContainer(
            width: 40,
            height: 40,
            margin: 16.onlyRight,
            padding: EdgeInsets.zero,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                LucideIcons.bell,
                color: context.colors.onSurface,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: 16.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.h,
            DashboardFilterSortButton(),
            24.h,
            DashboardQnaCard(
              userName: "Mahsa Nurfarhan Hidayat",
              userRole: "Flutter Developer",
              title:
                  "Perbedaan StatelessWidget dan StatefulWidget di Flutter apa?",
              body:
                  "Gua baru belajar Flutter dan masih agak bingung soal StatelessWidget dan StatefulWidget. Kapan kita harus pakai yang stateless dan kapan yang stateful?",
              totalLike: 23,
              totalComment: 4,
              totalBookmark: 8,
              createdAt: DateTime.now().subtract(15.minutes),
              onTap: () {
                showCupertinoSheet(
                  context: context,
                  builder: (context) {
                    return Material(child: SafeArea(child: QnaDetailScreen()));
                  },
                );
              },
            ),
            16.h,
            DashboardQnaCard(
              userName: "Muhammad Ghozy",
              userRole: "QA Engineer",
              title: "Cara manage state di Flutter yang bagus apa?",
              body:
                  "Sekarang Flutter punya banyak state management seperti Provider, Riverpod, Bloc, dll. Kalau untuk aplikasi menengah ke besar sebaiknya pakai apa?",
              totalLike: 72,
              totalComment: 51,
              totalBookmark: 90,
              createdAt: DateTime.now().subtract(54.minutes),
              onTap: () {
                showCupertinoSheet(
                  context: context,
                  builder: (context) {
                    return Material(child: SafeArea(child: QnaDetailScreen()));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
