part of '_components.dart';

/// ****************************************************************************
/// Custom Button Rounded Accent
/// ****************************************************************************
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final bool isLoading; // ✅ New parameter
  final Color backgroundColor;
  final Color textColor;

  const CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.isLoading = false, // ✅ Default to false
    this.backgroundColor = const Color(0xFFF9BE2D),
    this.textColor = Colors.black,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // Disable while loading
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: !isFullWidth ? 32.w : 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: isLoading
            ? SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(textColor),
            strokeWidth: 2,
          ),
        )
            : Text(
          text,
          style: goliathsTypography.button.copyWith(color: textColor),
        ),
      ),
    );
  }
}


/// ****************************************************************************
/// Custom Button Rounded Accent
/// ****************************************************************************
class CustomButtonSmall extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final Color backgroundColor;
  final Color textColor;

  const CustomButtonSmall({
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.backgroundColor = const Color(0xFFF9BE2D),
    this.textColor = Colors.black, // Default text color
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: !isFullWidth ? 16.w : 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: goliathsTypography.button.copyWith(fontSize: 10.sp),
        ),
      ),
    );
  }
}
