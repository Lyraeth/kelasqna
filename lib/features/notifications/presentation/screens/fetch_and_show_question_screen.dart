import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FetchAndShowQuestionScreen extends StatefulWidget {
  const FetchAndShowQuestionScreen({super.key, required this.questionId});

  final int questionId;

  @override
  State<FetchAndShowQuestionScreen> createState() =>
      _FetchAndShowQuestionScreenState();
}

class _FetchAndShowQuestionScreenState
    extends State<FetchAndShowQuestionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionBloc>().add(
        QuestionEvent.fetchQuestion(widget.questionId, forceRefresh: true),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      builder: (context, state) {
        return state.maybeWhen(
          success: (question) =>
              QnaDetailScreen(questionEntity: question, shouldFetch: false),
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          orElse: () => Scaffold(
            appBar: AppBar(),
            body: NeoKelasEmptyScreen(
              icon: LucideIcons.circleAlert,
              message: context.l10n.questionNotFound,
            ),
          ),
        );
      },
    );
  }
}
