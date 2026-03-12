import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasEngagementButton extends StatelessWidget {
  const NeoKelasEngagementButton({
    super.key,
    required this.questionEntity,
    required this.onLikeTap,
    required this.onBookmarkTap,
  });

  final QuestionEntity questionEntity;
  final VoidCallback onLikeTap;
  final VoidCallback onBookmarkTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _EngagementItem(
          icon: questionEntity.engagementReact.isLiked
              ? Icons.thumb_up_rounded
              : Icons.thumb_up_outlined,
          isFilled: questionEntity.engagementReact.isLiked,
          activeColor: Colors.blue,
          count: questionEntity.engagementTotal.totalLikes,
          onTap: onLikeTap,
        ),

        _EngagementItem(
          icon: Icons.mode_comment_outlined,
          isFilled: false,
          activeColor: Colors.grey,
          count: questionEntity.engagementTotal.totalComments,
          onTap: null,
        ),

        _EngagementItem(
          icon: questionEntity.engagementReact.isBookmarked
              ? Icons.bookmark_rounded
              : Icons.bookmark_outline_rounded,
          isFilled: questionEntity.engagementReact.isBookmarked,
          activeColor: Colors.amber,
          count: questionEntity.engagementTotal.totalBookmarks,
          onTap: onBookmarkTap,
        ),
      ].separatedBy(16.w),
    );
  }
}

class _EngagementItem extends StatefulWidget {
  const _EngagementItem({
    required this.icon,
    required this.isFilled,
    required this.activeColor,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final bool isFilled;
  final Color activeColor;
  final int count;
  final VoidCallback? onTap;

  @override
  State<_EngagementItem> createState() => _EngagementItemState();
}

class _EngagementItemState extends State<_EngagementItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.75,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onTap == null) return;
    _controller.forward().then((_) => _controller.reverse());
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isFilled
        ? widget.activeColor
        : context.colors.onSurfaceVariant;

    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          ScaleTransition(
            scale: _scaleAnim,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                widget.icon,
                key: ValueKey(widget.isFilled),
                size: 18,
                color: color,
              ),
            ),
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: (context.text.labelMedium ?? const TextStyle()).copyWith(
              color: color,
              fontWeight: widget.isFilled ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(widget.count.toString()),
          ),
        ].separatedBy(4.w),
      ),
    );
  }
}
