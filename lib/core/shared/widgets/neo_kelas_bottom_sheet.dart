import 'package:flutter/material.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/core/shared/widgets/neo_kelas_button.dart';
import 'package:kelasqna/utils/utils.dart';
import 'package:lottie/lottie.dart';

class NeoKelasBottomSheet extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final CrossAxisAlignment? contentCrossAxisAlignment;
  final String lottieAsset;
  final String title;
  final String desc;
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
    required this.desc,
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
      height: height ?? MediaQuery.of(context).size.height * (0.5),
      child: Padding(
        padding:
            contentPadding ??
            const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment:
              contentCrossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            SizedBox(width: 200, height: 200, child: Lottie.asset(lottieAsset)),

            Text(
              Utils.getTranslatedLabel(title),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24),

            Text(
              Utils.getTranslatedLabel(desc),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 56),

            Expanded(
              child: NeoKelasButton(
                padding: const EdgeInsets.symmetric(vertical: 8),
                onPressed: onPressed,
                buttonColor: buttonColor ?? secondaryBlue,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: useIcon
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Utils.getTranslatedLabel(buttonText),
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                            ),

                            Icon(icon),
                          ],
                        )
                      : Text(
                          Utils.getTranslatedLabel(buttonText),
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                ),
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
