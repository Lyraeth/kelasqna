import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DashboardPaginationButton extends StatelessWidget {
  const DashboardPaginationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        return state.maybeWhen(
          hasData: (_, currentPage, totalPages) => _buildPagination(
            context,
            currentPage: currentPage,
            totalPages: totalPages,
          ),
          orElse: () => const SizedBox(),
        );
      },
    );
  }

  Widget _buildPagination(
    BuildContext context, {
    required int currentPage,
    required int totalPages,
  }) {
    // Hitung range nomor yang ditampilkan (max 5)
    final int start = (currentPage - 2).clamp(
      1,
      (totalPages - 4).clamp(1, totalPages),
    );
    final int end = (start + 4).clamp(1, totalPages);
    final pages = List.generate(end - start + 1, (i) => start + i);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Prev button
        NeoKelasButton(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          onPressed: currentPage > 1
              ? () => context.read<QuestionsBloc>().add(
                  QuestionsEvent.loadPage(currentPage - 1),
                )
              : null,
          child: Icon(LucideIcons.chevronLeft, color: context.colors.onSurface),
        ),

        // Page number buttons
        Row(
          children: pages.map((page) {
            final isActive = page == currentPage;
            return Padding(
              padding: 2.horizontal,
              child: NeoKelasButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                backgroundColor: isActive ? context.colors.primary : null,
                onPressed: isActive
                    ? null
                    : () => context.read<QuestionsBloc>().add(
                        QuestionsEvent.loadPage(page),
                      ),
                child: Text(
                  '$page',
                  style: context.text.bodyMedium?.copyWith(
                    color: isActive ? context.colors.onPrimary : null,
                    fontWeight: isActive ? FontWeight.bold : null,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        // Next button
        NeoKelasButton(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          onPressed: currentPage < totalPages
              ? () => context.read<QuestionsBloc>().add(
                  QuestionsEvent.loadPage(currentPage + 1),
                )
              : null,
          child: Icon(
            LucideIcons.chevronRight,
            color: context.colors.onSurface,
          ),
        ),
      ],
    );
  }
}
