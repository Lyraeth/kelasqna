import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfilePagesList extends StatelessWidget {
  const ProfilePagesList({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final int itemCount;
  final Widget Function(int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        8.h,
        Expanded(
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            itemCount: itemCount,
            separatorBuilder: (_, _) => 16.h,
            itemBuilder: (_, index) => itemBuilder(index),
          ),
        ),
        if (totalPages > 1)
          _PaginationBar(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: onPageChanged,
          ),
      ],
    );
  }
}

class _PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const _PaginationBar({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: NeoKelasContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NeoKelasContainer(
              width: 36,
              height: 36,
              padding: EdgeInsets.zero,
              child: IconButton(
                onPressed: currentPage > 1
                    ? () => onPageChanged(currentPage - 1)
                    : null,
                icon: Icon(
                  LucideIcons.chevronLeft,
                  size: 18,
                  color: currentPage > 1
                      ? context.colors.onSurface
                      : context.colors.onSurfaceVariant,
                ),
              ),
            ),
            Text(
              '$currentPage / $totalPages',
              style: context.text.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            NeoKelasContainer(
              width: 36,
              height: 36,
              padding: EdgeInsets.zero,
              child: IconButton(
                onPressed: currentPage < totalPages
                    ? () => onPageChanged(currentPage + 1)
                    : null,
                icon: Icon(
                  LucideIcons.chevronRight,
                  size: 18,
                  color: currentPage < totalPages
                      ? context.colors.onSurface
                      : context.colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
