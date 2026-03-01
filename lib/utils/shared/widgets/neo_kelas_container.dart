import 'package:flutter/material.dart';

class NeoKelasContainer extends StatefulWidget {
  final Offset offset;
  final Color containerColor;
  final Color? shadowsColor;
  final Color? borderColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;

  const NeoKelasContainer({
    super.key,
    required this.containerColor,
    required this.child,
    this.offset = const Offset(4, 4),
    this.shadowsColor,
    this.borderColor = Colors.black,
    this.padding,
    this.margin,
    this.borderRadius = const BorderRadiusGeometry.all(Radius.circular(8)),
  });

  @override
  State<NeoKelasContainer> createState() => _NeoKelasContainerState();
}

class _NeoKelasContainerState extends State<NeoKelasContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border: Border.all(color: widget.borderColor ?? Colors.black, width: 3),
        color: widget.containerColor,
        boxShadow: [
          BoxShadow(
            color: widget.shadowsColor ?? Theme.of(context).colorScheme.shadow,
            blurRadius: 0,
            offset: widget.offset,
            blurStyle: BlurStyle.solid,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Center(child: widget.child),
    );
  }
}
