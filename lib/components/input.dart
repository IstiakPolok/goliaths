part of '_components.dart';

/// ****************************************************************************
/// Custom input field
/// ****************************************************************************
class CustomInputField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final Color backgroundColor;
  final TextEditingController? controller;
  final TextInputAction action;

  const CustomInputField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.backgroundColor = const Color(0xFFDADADA), // Light grey by default
    this.controller,
    this.action = TextInputAction.next,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          textInputAction: widget.action,
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          style: goliathsTypography.screenText,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontSize: 16, color: Colors.black87),
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: widget.isPassword ? 12 : 18, // Adjust vertical padding
            ),
            border: InputBorder.none,
            // no border
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                    : null,
          ),
        ),
      ),
    );
  }
}

/// ****************************************************************************
/// Otp field
/// ****************************************************************************
class InputOtpFields extends StatelessWidget {
  final Function(String)? onOtpChange;

  const InputOtpFields({super.key, this.onOtpChange});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      contentPadding: EdgeInsets.symmetric(vertical: 20.h),
      fieldWidth: 0.15.sw,
      showFieldAsBox: true,
      numberOfFields: 4,
      filled: true,
      fillColor: goliathsTheme.inputBackground,
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      textStyle: goliathsTypography.screenTitle,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: goliathsTheme.text, width: 2.0),
        ),
        hintStyle: TextStyle(
          color: goliathsTheme.inputBackground.withValues(alpha: 0.5),
          fontFamily: 'Poly',
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
      ),
      borderColor: goliathsTheme.inputBackground,
      focusedBorderColor: goliathsTheme.inputBackground,
      enabledBorderColor: Colors.grey.withValues(alpha: 0.2),
      //runs when a code is typed in
      onCodeChanged: (String code) {},
      //runs when every text field is filled
      onSubmit: (String verificationCode) {
        onOtpChange?.call(verificationCode);
      }, // end onSubmit
    );
  }
}
