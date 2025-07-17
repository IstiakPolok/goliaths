part of './_components.dart';

/// ****************************************************************************
/// Custom scaffold for gradient background
/// ****************************************************************************
class AuthScaffold extends StatefulWidget {
  final Widget body;
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;

  const AuthScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.resizeToAvoidBottomInset = false,
  });

  @override
  State<AuthScaffold> createState() => _AuthScaffoldState();
}

class _AuthScaffoldState extends State<AuthScaffold> {
  @override
  void initState() {
    super.initState();
    showLightStatusIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0B0B), Color(0xFF797676)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(child: widget.body),
      ),
    );
  }
}

/// ****************************************************************************
/// History List Item View
/// ****************************************************************************
class HistoryItem extends StatelessWidget {
  final String title;
  final SvgAssetLoader icon;
  final Function()? onClick;

  const HistoryItem({
    super.key,
    required this.title,
    required this.icon,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0).w,
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          padding: EdgeInsets.all(16).w,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0xFFF2F2F2)),
            borderRadius: BorderRadius.circular(60.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture(icon),
              const SizedBox(width: 12),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

/// ****************************************************************************
/// Chat Item View (Chat Bubble)
/// ****************************************************************************
enum ChatPosition { top, middle, bottom, single }

enum ChatRole { user, ai }

class ChatItemView extends StatelessWidget {
  final String text;
  final ChatRole role;
  final ChatPosition chatPosition;

  const ChatItemView({
    super.key,
    required this.text,
    required this.role,
    this.chatPosition = ChatPosition.middle,
  });

  @override
  Widget build(BuildContext context) {
    bool isUser = role == ChatRole.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isUser ? goliathsTheme.chatBubble1 : goliathsTheme.chatBubble2,
          borderRadius: isUser ? _getUserBorderRadius() : _getAiBorderRadius(),
        ),
        width: 0.8.sw,
        padding: EdgeInsets.all(16).w,
        child: Text(
          text,
          style: goliathsTypography.screenText.copyWith(
            color:
                isUser
                    ? goliathsTheme.onChatBubble1
                    : goliathsTheme.onChatBubble2,
          ),
        ),
      ),
    );
  }

  BorderRadiusGeometry _getUserBorderRadius() {
    double round = 14.r;
    double inner = 4.r;
    switch (chatPosition) {
      case ChatPosition.top:
        return BorderRadius.only(
          topLeft: Radius.circular(round),
          topRight: Radius.circular(round),
          bottomLeft: Radius.circular(round),
          bottomRight: Radius.circular(inner),
        );
      case ChatPosition.middle:
        return BorderRadius.only(
          topRight: Radius.circular(inner),
          bottomRight: Radius.circular(inner),
          topLeft: Radius.circular(round),
          bottomLeft: Radius.circular(round),
        );
      case ChatPosition.bottom:
        return BorderRadius.only(
          topRight: Radius.circular(inner),
          topLeft: Radius.circular(round),
          bottomLeft: Radius.circular(round),
          bottomRight: Radius.circular(round),
        );
      default:
        return BorderRadius.circular(round);
    }
  }

  BorderRadiusGeometry _getAiBorderRadius() {
    double round = 14.r;
    double inner = 4.r;
    switch (chatPosition) {
      case ChatPosition.top:
        return BorderRadius.only(
          topLeft: Radius.circular(round),
          topRight: Radius.circular(round),
          bottomRight: Radius.circular(round),
          bottomLeft: Radius.circular(inner),
        );
      case ChatPosition.middle:
        return BorderRadius.only(
          topRight: Radius.circular(round),
          bottomRight: Radius.circular(round),
          topLeft: Radius.circular(inner),
          bottomLeft: Radius.circular(inner),
        );
      case ChatPosition.bottom:
        return BorderRadius.only(
          topLeft: Radius.circular(inner),
          topRight: Radius.circular(round),
          bottomLeft: Radius.circular(round),
          bottomRight: Radius.circular(round),
        );
      default:
        return BorderRadius.circular(round);
    }
  }
}

/// ****************************************************************************
/// Chat Box Chat Page
/// ****************************************************************************
class ChatInputBox extends StatelessWidget {
  final Function(String) onSendMessage;
  final double gap;

  const ChatInputBox({super.key, required this.onSendMessage, this.gap = 8});

  Widget _iconButton({required SvgAssetLoader icon, required Color color}) {
    return Container(
      height: 36.h,
      width: 36.h,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(child: SvgPicture(icon, height: 20.h, width: 20.h)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(gap),
      child: Row(
        children: [
          // Input field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Ask me anything",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: goliathsTheme.stroke),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: goliathsTheme.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: goliathsTheme.stroke),
                ),
              ),
              textInputAction: TextInputAction.newline,
              style: goliathsTypography.screenText,
            ),
          ),
          SizedBox(width: gap),
          // Voice Button
          InkWell(
            splashColor: goliathsTheme.primary.withValues(alpha: 0.05),
            onTap: () {},
            child: _iconButton(
              icon: SvgAssetLoader("assets/icons/mic.svg"),
              color: goliathsTheme.primary,
            ),
          ),
          SizedBox(width: gap),
          // Send Button
          InkWell(
            splashColor: goliathsTheme.accent.withValues(alpha: 0.1),
            onTap: () {},
            child: _iconButton(
              icon: SvgAssetLoader("assets/icons/send.svg"),
              color: goliathsTheme.accent,
            ),
          ),
        ],
      ),
    );
  }
}

/// ****************************************************************************
/// Setting Tile
/// ****************************************************************************
class SettingTile extends StatelessWidget {
  final SvgAssetLoader icon;
  final String title;
  final VoidCallback? onTap;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: goliathsTheme.stroke.withValues(alpha: 0.2),
      highlightColor: goliathsTheme.stroke.withValues(alpha: 0.2),
      onTap: onTap,
      child: SizedBox(
        height: 42.h,
        child: Row(
          children: [
            SvgPicture(icon, width: 24.h, height: 24.h),
            12.horizontalSpace,
            Text(title, style: goliathsTypography.screenText),
          ],
        ),
      ),
    );
  }
}

/// ****************************************************************************
/// Three dot svg
/// ****************************************************************************
class ThreeDotSvg extends StatelessWidget {
  final bool isDark;

  const ThreeDotSvg({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          isDark
              ? "assets/images/three_dot_dark.svg"
              : "assets/images/three_dot.svg",
          height: 7.h,
        ),
      ],
    );
  }
}

/// ****************************************************************************
/// Avatar picker
/// ****************************************************************************
class AvatarUploader extends StatefulWidget {
  final String? initialImageUrl; // optional initial avatar
  final void Function(File pickedFile) onImagePicked;

  const AvatarUploader({
    super.key,
    this.initialImageUrl,
    required this.onImagePicked,
  });

  @override
  State<AvatarUploader> createState() => _AvatarUploaderState();
}

class _AvatarUploaderState extends State<AvatarUploader> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      setState(() {
        _selectedImage = file;
      });
      widget.onImagePicked(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60.r,
          backgroundColor: goliathsTheme.stroke,
          backgroundImage:
              _selectedImage != null
                  ? FileImage(_selectedImage!)
                  : (widget.initialImageUrl != null
                      ? NetworkImage(widget.initialImageUrl!) as ImageProvider
                      : null),
          child:
              (_selectedImage == null && widget.initialImageUrl == null)
                  ? const Icon(Icons.person, size: 50)
                  : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: goliathsTheme.primary,
                border: Border.all(color: Colors.white, width: 2),
              ),
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(
                "assets/icons/edit_pen.svg",
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: 18.r,
                height: 18.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ****************************************************************************
/// Close icon button
/// ****************************************************************************
class SvgCloseButton extends StatelessWidget {
  final SvgAssetLoader? icon;
  final VoidCallback onPressed;
  final double size;
  final Color? iconColor;

  const SvgCloseButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 24.0,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30), // tap effect shape
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            icon != null
                ? SvgPicture(
                  icon!,
                  height: size,
                  width: size,
                  colorFilter: ColorFilter.mode(
                    iconColor ?? Colors.grey,
                    BlendMode.srcIn,
                  ), // optional color
                )
                : Icon(Icons.close, size: size, color: iconColor),
      ),
    );
  }
}

/// ****************************************************************************
/// Custom Progress Bar
/// ****************************************************************************
// class CustomProgressCircle extends StatelessWidget {
//   final double progress; // progress between 0 and 1
//   final String daysCount; // Text for the day count
//
//   const CustomProgressCircle({
//     super.key,
//     required this.progress,
//     required this.daysCount,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(200, 200), // Define your widget size
//       painter: ProgressCirclePainter(progress, daysCount),
//     );
//   }
// }
//
// class ProgressCirclePainter extends CustomPainter {
//   final double progress;
//   final String daysCount;
//   ProgressCirclePainter(this.progress, this.daysCount);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint basePaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill;
//
//     final Paint accentPaint = Paint()
//       ..color = Colors.yellow
//       ..style = PaintingStyle.fill;
//
//     final Paint progressPaint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 8;
//
//     final Paint progressHeadPaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill;
//
//     final double radius = size.width / 2;
//     final double accentRadius = radius - 8; // Padding for accent circle
//
//     // Draw the base black circle
//     canvas.drawCircle(Offset(radius, radius), radius, basePaint);
//
//     // Draw the accent color circle
//     canvas.drawCircle(Offset(radius, radius), accentRadius, accentPaint);
//
//     // Draw the progress circle
//     double sweepAngle = 2 * 3.14159 * progress;
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(radius, radius), radius: radius),
//       -3.14159 / 2, // Starting angle
//       sweepAngle, // The angle of the progress
//       false,
//       progressPaint,
//     );
//
//     // Draw the little black circle for the head of the progress line
//     double progressHeadX = radius + (radius - 10) * (1 + cos(sweepAngle - 3.14159 / 2));
//     double progressHeadY = radius + (radius - 10) * (1 + sin(sweepAngle - 3.14159 / 2));
//
//     canvas.drawCircle(Offset(progressHeadX, progressHeadY), 10, progressHeadPaint);
//
//     // Draw the SVG icon inside the little circle
//     // final svgIcon = 'assets/your_svg_icon.svg'; // Path to your SVG asset
//     // final svgPicture = SvgPicture.asset(svgIcon, width: 20, height: 20);
//     // svgPicture.paint(canvas, Offset(progressHeadX - 10, progressHeadY - 10));
//
//     // Draw the days text in the center
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: daysCount,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 30,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();
//     textPainter.paint(
//       canvas,
//       Offset(radius - textPainter.width / 2, radius - textPainter.height / 2),
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
class ProgressCircle extends StatelessWidget {
  final int days;
  final double progress; // Progress percentage (0.0 to 1.0)

  const ProgressCircle({super.key, required this.days, required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(150.h, 150.h), // Size of the widget
      painter: ProgressCirclePainter(progress: progress),
      child: SizedBox(
        width: 150.h,
        height: 150.h,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                days.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: "Poly",
                ),
              ),
              Text(
                'days',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressCirclePainter extends CustomPainter {
  final double progress;

  ProgressCirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 10.0;
    final centerDeduct = 20.0;
    final accentColor = Color(0xFFF9BE2D); // Yellow color from the image
    final baseColor = Colors.black;

    // Draw the base black circle
    final basePaint =
        Paint()
          ..color = baseColor
          ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, basePaint);

    // Draw the progress arc (yellow)
    final progressPaint =
        Paint()
          ..color = accentColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;
    final sweepAngle = 2 * math.pi * progress; // Convert progress to radians
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from the top
      sweepAngle,
      false,
      progressPaint,
    );

    // Draw the accent (yellow) circle on top with padding
    final accentRadius = radius - centerDeduct;
    final accentPaint =
        Paint()
          ..color = accentColor
          ..style = PaintingStyle.fill;
    canvas.drawCircle(center, accentRadius, accentPaint);

    // Calculate the position of the small circle at the head of the progress
    final progressAngle =
        -math.pi / 2 + sweepAngle;
    final smallCircleRadius = 8.0;
    final smallCircleCenter = Offset(
      center.dx + radius * math.cos(progressAngle),
      center.dy + radius * math.sin(progressAngle),
    );

    // Draw the small black circle at the progress head
    final smallCirclePaint =
        Paint()
          ..color = baseColor
          ..style = PaintingStyle.fill;
    canvas.drawCircle(smallCircleCenter, smallCircleRadius, smallCirclePaint);

    // Draw the SVG icon inside the small circle
    // Since canvas doesn't directly support SVG, we'll overlay it in the widget tree
    // This part is handled in the widget tree by positioning the SvgPicture
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Wrapper widget to overlay the SVG icon
class ProgressCircleWithSvg extends StatelessWidget {
  final int days;
  final double progress;

  const ProgressCircleWithSvg({
    super.key,
    required this.days,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ProgressCircle(days: days, progress: progress),
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.maxWidth;
              final radius = size / 2;
              final progressAngle = -math.pi / 2 + 2 * math.pi * progress;
              final smallCircleRadius = 8.0;
              final x =
                  radius + radius * math.cos(progressAngle) - smallCircleRadius;
              final y =
                  radius + radius * math.sin(progressAngle) - smallCircleRadius;

              return Stack(
                children: [
                  Positioned(
                    left: x,
                    top: y,
                    child: SizedBox(
                      width: smallCircleRadius * 2,
                      height: smallCircleRadius * 2,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/clock.svg',
                          width: smallCircleRadius,
                          height: smallCircleRadius,
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ), // Tint the SVG to white
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

/// ****************************************************************************
/// Donation amount selector
/// ****************************************************************************
class AmountSelector extends StatelessWidget {
  final int selectedAmount;
  final List<int> amounts;
  final ValueChanged<int> onSelected;

  const AmountSelector({
    super.key,
    this.selectedAmount = 0,
    required this.amounts,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
          amounts.map((amount) {
            final isSelected = selectedAmount == amount;
            return GestureDetector(
              onTap: () {
                onSelected(amount);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border:
                      isSelected
                          ? Border.all(color: goliathsTheme.accent, width: 1.5)
                          : Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '\$$amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}

/// ****************************************************************************
/// Terms and condition text
/// ****************************************************************************
class TermsAndPrivacyText extends StatelessWidget {
  final Function()? termClick;
  final Function()? privacyClick;
  final TextStyle? style;

  const TermsAndPrivacyText({
    super.key,
    this.termClick,
    this.privacyClick,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle =
        (style ??
            TextStyle(fontWeight: FontWeight.normal, color: Colors.white));
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textStyle.copyWith(),
        children: [
          const TextSpan(text: 'By Signing Up You Accept The '),
          TextSpan(
            text: 'Terms of Service',
            style: textStyle.copyWith(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    termClick?.call();
                  },
          ),
          const TextSpan(text: '\nAnd our '),
          TextSpan(
            text: 'Privacy Policy',
            style: textStyle.copyWith(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    privacyClick?.call();
                  },
          ),
        ],
      ),
    );
  }
}
