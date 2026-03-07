import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class QnaDetailScreen extends StatelessWidget {
  const QnaDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QnaCardHeader(
          userName: "Mahsa Nurfarhan Hidayat",
          userRole: "Flutter Developer",
          showTrailing: false,
        ),
        Divider(thickness: 3, color: context.colors.onSurface),
        Container(
          padding: 8.all,
          child: QnaCardBody(
            backgroundTransparent: false,
            rounded: true,
            title:
                "Perbedaan StatelessWidget dan StatefulWidget di Flutter apa?",
            body:
                "Gua baru belajar Flutter dan masih agak bingung soal StatelessWidget dan StatefulWidget. Kapan kita harus pakai yang stateless dan kapan yang stateful?",
          ),
        ),

        24.h,

        QnaCommentContainer(
          userName: "Muhammad Ghozy",
          userComment:
              "StatelessWidget itu UI yang tidak berubah setelah di-build.",
        ),
        QnaCommentContainer(
          userName: "Fazril Arief Nugraha",
          userComment:
              "Kalau UI bisa berubah karena user interaction atau data update, pakai StatefulWidget.",
        ),
        QnaCommentContainer(
          userName: "Muhammad Akbar",
          userComment: "Setuju tuh",
        ),
      ],
    );
  }
}
