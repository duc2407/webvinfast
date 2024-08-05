import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonNormalIcon extends StatelessWidget {
  const ButtonNormalIcon(
    this.name, {
    super.key,
    this.size = 32,
    this.padding = 4,
    this.backgroundColor = Colors.black26,
    this.backgroundRadius,
  });

  final String name;
  final double size;
  final double padding;
  final Color? backgroundColor;
  final double? backgroundRadius;

  static const double tapTargetSize = kMinInteractiveDimension;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset('assets/svgs/$name',
          width: 24, height: 24, color: const Color(0xff395241)),
      padding: EdgeInsets.all(padding),
      constraints: BoxConstraints(maxWidth: size, maxHeight: size),
      style: IconButton.styleFrom(
        // Expands the minimum tap target size to 48px by 48px.
        tapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: backgroundColor ?? Colors.black26,
        shape: backgroundRadius == null
            ? null
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(backgroundRadius!),
              ),
      ),
      onPressed: () {},
    );
  }
}
