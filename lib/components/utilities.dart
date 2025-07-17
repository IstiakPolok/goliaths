part of '_components.dart';

/// ****************************************************************************
/// Start Gravity
/// ****************************************************************************
class Start extends Align {
  const Start({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
    super.alignment = Alignment.centerLeft,
  });
}

/// ****************************************************************************
/// End Gravity
/// ****************************************************************************
class End extends Align {
  const End({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
    super.alignment = Alignment.centerRight,
  });
}

/// ****************************************************************************
/// Divider with center text
/// ****************************************************************************
class CenteredDividerText extends StatelessWidget {
  final String text;
  final Color dividerColor;
  final Color textColor;
  final double thickness;
  final double spacing;
  final TextStyle? textStyle;

  const CenteredDividerText({
    super.key,
    required this.text,
    this.dividerColor = Colors.black12,
    this.textColor = Colors.black,
    this.thickness = 1,
    this.spacing = 16,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: thickness,
            endIndent: spacing / 2,
          ),
        ),
        Text(
          text,
          style:
              textStyle ??
              TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),

        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: thickness,
            indent: spacing / 2,
          ),
        ),
      ],
    );
  }
}

/// ****************************************************************************
/// Helper class for status icon
/// ****************************************************************************
void showDarkStatusIcon() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

void showLightStatusIcon() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
}
