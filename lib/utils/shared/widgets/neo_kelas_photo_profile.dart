import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NeoKelasPhotoProfile extends StatelessWidget {
  const NeoKelasPhotoProfile({super.key, required this.questionEntity});

  final QuestionEntity questionEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Block show profile sheet if user try to tap on their own photo profile on their question
        if (questionEntity.author.id ==
            context.read<SessionsBloc>().getUserId) {
          return;
        }

        showCupertinoSheet(
          context: context,
          builder: (context) {
            return Material(
              child: SafeArea(
                child: ProfileSheet(userId: questionEntity.author.id),
              ),
            );
          },
        );
      },
      child: CircleAvatar(
        backgroundColor: context.colors.onSurface,
        foregroundColor: context.colors.surface,
        child: (questionEntity.author.avatar != null)
            ? CachedNetworkImage(imageUrl: questionEntity.author.avatar!)
            : Icon(LucideIcons.user),
      ),
    );
  }
}
