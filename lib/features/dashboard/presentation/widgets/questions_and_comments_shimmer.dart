import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:shimmer/shimmer.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Helper internal
// ─────────────────────────────────────────────────────────────────────────────

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({required this.height, this.width});

  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0),
        borderRadius: 16.circular,
      ),
    );
  }
}

Widget _shimmerWrap({required BuildContext context, required Widget child}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Shimmer.fromColors(
    baseColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0),
    highlightColor: isDark ? const Color(0xFF3D3D3D) : const Color(0xFFF5F5F5),
    child: child,
  );
}

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      sliver: SliverList.separated(
        itemCount: 5,
        separatorBuilder: (_, _) => 16.h,
        itemBuilder: (context, index) {
          if (index == 0) return _FilterSortShimmer();
          return _QuestionCardShimmer();
        },
      ),
    );
  }
}

class _FilterSortShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0);

    return _shimmerWrap(
      context: context,
      child: Row(
        children: [
          Container(
            width: 110,
            height: 40,
            decoration: BoxDecoration(color: color, borderRadius: 16.circular),
          ),
          const Spacer(),
          Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(color: color, borderRadius: 16.circular),
          ),
        ],
      ),
    );
  }
}

class _QuestionCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final blockColor = isDark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFE0E0E0);

    return _shimmerWrap(
      context: context,
      child: Container(
        padding: 16.all,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: 16.circular,
          border: Border.all(color: blockColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: blockColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ShimmerBox(width: 140, height: 13),
                    _ShimmerBox(width: 80, height: 10),
                  ].separatedBy(8.h),
                ),
              ].separatedBy(16.w),
            ),
            16.h,
            _ShimmerBox(width: double.infinity, height: 14),
            8.h,
            _ShimmerBox(width: 220, height: 14),
            8.h,
            _ShimmerBox(width: double.infinity, height: 11),
            8.h,
            _ShimmerBox(width: 180, height: 11),
            16.h,
            Row(
              children: [
                _ShimmerBox(width: 48, height: 11),
                16.w,
                _ShimmerBox(width: 48, height: 11),
                16.w,
                _ShimmerBox(width: 36, height: 11),
                const Spacer(),
                _ShimmerBox(width: 72, height: 11),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommentListShimmer extends StatelessWidget {
  const CommentListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      itemCount: 4,
      separatorBuilder: (_, _) => 8.h,
      itemBuilder: (_, _) => _CommentItemShimmer(),
    );
  }
}

class _CommentItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final blockColor = isDark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFE0E0E0);

    return _shimmerWrap(
      context: context,
      child: Container(
        padding: 16.all,
        decoration: BoxDecoration(color: cardColor, borderRadius: 16.circular),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: blockColor,
                shape: BoxShape.circle,
              ),
            ),
            10.w,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _ShimmerBox(width: 120, height: 12),
                      const Spacer(),
                      _ShimmerBox(width: 64, height: 11),
                    ],
                  ),
                  8.w,
                  Container(
                    width: double.infinity,
                    padding: 8.all,
                    decoration: BoxDecoration(
                      color: blockColor,
                      borderRadius: 8.circular,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(width: double.infinity, height: 12),
                        _ShimmerBox(width: 160, height: 12),
                      ].separatedBy(8.h),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
