import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lottie/lottie.dart';

class NeoKelasBottomSheet extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final CrossAxisAlignment? contentCrossAxisAlignment;
  final String lottieAsset;
  final String title;
  final String? desc;
  final void Function() onPressed;
  final Color? buttonColor;
  final String buttonText;
  final bool useIcon;
  final IconData? icon;

  const NeoKelasBottomSheet({
    super.key,
    this.width,
    this.height,
    this.contentPadding,
    this.contentCrossAxisAlignment,
    required this.lottieAsset,
    required this.title,
    this.desc,
    required this.onPressed,
    this.buttonColor,
    required this.buttonText,
    this.useIcon = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding:
            contentPadding ??
            const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment:
              contentCrossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            SizedBox(width: 150, height: 150, child: Lottie.asset(lottieAsset)),

            const SizedBox(height: 16),

            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),

            if (desc != null && desc!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                (desc!),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            const Spacer(),

            NeoKelasButton(
              padding: const EdgeInsets.symmetric(vertical: 8),
              onPressed: onPressed,
              backgroundColor: buttonColor ?? secondaryBlue,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: useIcon
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            buttonText,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Icon(icon),
                        ],
                      )
                    : Text(
                        buttonText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
