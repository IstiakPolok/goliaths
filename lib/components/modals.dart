part of './_components.dart';

/// ****************************************************************************
/// Closeable container of modal
/// ****************************************************************************
class CloseAbleDialog extends StatelessWidget {
  final Widget child;
  final bool isChildScrollable;

  const CloseAbleDialog({
    super.key,
    required this.child,
    this.isChildScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: goliathsTheme.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 0.9.sh, maxWidth: 0.9.sw),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgCloseButton(
                  icon: SvgAssetLoader("assets/icons/close.svg"),
                  onPressed: () => Get.close(1),
                  iconColor: goliathsTheme.accent,
                ),
              ],
            ),
            12.verticalSpace,
            isChildScrollable ? Expanded(child: child) : child,
          ],
        ),
      ),
    );
  }
}

/// ****************************************************************************
/// Profile update modal widget from settings route
/// ****************************************************************************
class ModalEditProfile extends StatefulWidget {
  const ModalEditProfile({super.key});

  @override
  State<ModalEditProfile> createState() => _ModalEditProfileState();
}

class _ModalEditProfileState extends State<ModalEditProfile> {
  final _nameController = TextEditingController();
  String _gender = 'Female';
  DateTime? _dob;

  InputDecoration _inputDecorTop({required String hint}) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: goliathsTheme.stroke),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: goliathsTheme.primary),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
    );
  }

  InputDecoration _inputDecorBottom({required String hint}) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
    );
  }

  InputDecoration _inputDecorMiddle({required String hint}) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(left: 0, top: 16, bottom: 16, right: 8),
      hintText: hint,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CloseAbleDialog(
      //isChildScrollable: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Edit Profile', style: goliathsTypography.screenTitle),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: _inputDecorTop(hint: "Name"),
              style: goliathsTypography.screenText,
            ),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: goliathsTheme.stroke),
                  right: BorderSide(color: goliathsTheme.stroke),
                ),
              ),
              child: DropdownButtonFormField2<String>(
                decoration: _inputDecorMiddle(hint: "Gender"),
                isExpanded: true,
                value: _gender,
                style: goliathsTypography.screenText,
                items:
                    ['Male', 'Female', 'Other']
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _gender = value);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: goliathsTheme.stroke, width: 1.r),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              child: Column(
                children: [
                  TextField(
                    readOnly: true,
                    onTap: _selectDate,
                    controller: TextEditingController(
                      text:
                          _dob != null
                              ? "${_dob!.year}-${_dob!.month.toString().padLeft(2, '0')}-${_dob!.day.toString().padLeft(2, '0')}"
                              : '',
                    ),
                    decoration: _inputDecorBottom(hint: "Date Of Birth"),
                    style: goliathsTypography.screenText,
                  ),

                  // AwesomeCalenDart(
                  //   elevation: 0,
                  //   theme: AwesomeTheme(
                  //     selectedDateBackgroundColor: goliathsTheme.accent,
                  //     yearAndMonthHeaderTextStyle:
                  //         goliathsTypography.screenTitle,
                  //     unselectedDayTextStyle: goliathsTypography.screenText,
                  //   ),
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            CustomElevatedButton(
              onPressed: _updateProfile,
              text: 'Update',
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dob = picked);
    }
  }

  void _updateProfile() async {
    final fullName = _nameController.text.trim();
    if (fullName.isEmpty || _dob == null) {
      Get.snackbar("Missing Fields", "Please fill all fields before updating.");
      return;
    }

    // Split name into first and last name
    final nameParts = fullName.split(" ");
    final firstName = nameParts.first;
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";

    final dobFormatted =
        _dob!.toIso8601String().split("T").first; // "yyyy-MM-dd"

    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.patch(
        Uri.parse("${Urls.baseUrl}/auth/profile/"),
        headers: {
          "Authorization": "JWT $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          "date_of_birth": dobFormatted,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Profile updated successfully");
        Get.find<ProfileController>().fetchProfile(); // Refresh profile
        Navigator.pop(context);
      } else {
        print("❌ ${response.statusCode}: ${response.body}");
        Get.snackbar("Error", "Failed to update profile");
      }
    } catch (e) {
      print("🔥 Exception: $e");
      Get.snackbar("Error", "Something went wrong");
    }
  }
}

/// ****************************************************************************
/// Add friend birth date
/// ****************************************************************************
class ModalFriendBirthDate extends StatefulWidget {
  const ModalFriendBirthDate({super.key});

  @override
  State<ModalFriendBirthDate> createState() => _ModalFriendBirthDateState();
}

class _ModalFriendBirthDateState extends State<ModalFriendBirthDate> {
  final _nameController = TextEditingController();
  String? _relation;
  DateTime? _dob;

  InputDecoration _inputDecorTop({required String hint}) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: goliathsTheme.stroke),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: goliathsTheme.primary),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
    );
  }

  InputDecoration _inputDecorBottom({required String hint}) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
    );
  }

  InputDecoration _inputDecorMiddle({required String hint}) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(left: 0, top: 16, bottom: 16, right: 8),
      hintText: hint,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CloseAbleDialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Add Friend Birthdate', style: goliathsTypography.screenTitle),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: _inputDecorTop(hint: "Name"),
              style: goliathsTypography.screenText,
            ),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: goliathsTheme.stroke),
                  right: BorderSide(color: goliathsTheme.stroke),
                ),
              ),
              child: DropdownButtonFormField2<String>(
                decoration: _inputDecorMiddle(hint: "Relation"),
                isExpanded: true,
                value: _relation,
                style: goliathsTypography.screenText,
                items:
                    ['Friend', 'Family', 'Colleague', 'Partner', 'Other']
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _relation = value);
                },
                hint: Text("Select Relation", style: goliathsTypography.screenText),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: goliathsTheme.stroke, width: 1.r),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              child: Column(
                children: [
                  TextField(
                    readOnly: true,
                    onTap: _selectDate,
                    controller: TextEditingController(
                      text:
                          _dob != null
                              ? "${_dob!.year}-${_dob!.month.toString().padLeft(2, '0')}-${_dob!.day.toString().padLeft(2, '0')}"
                              : '',
                    ),
                    decoration: _inputDecorBottom(hint: "Date Of Birth"),
                    style: goliathsTypography.screenText,
                  ),

                  // AwesomeCalenDart(
                  //   elevation: 0,
                  //   theme: AwesomeTheme(
                  //     selectedDateBackgroundColor: goliathsTheme.accent,
                  //     yearAndMonthHeaderTextStyle:
                  //         goliathsTypography.screenTitle,
                  //     unselectedDayTextStyle: goliathsTypography.screenText,
                  //   ),
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            CustomElevatedButton(
              onPressed: _updateProfile,
              text: 'Submit',
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dob = picked);
    }
  }

  void _updateProfile() async {
    final name = _nameController.text.trim();
    final birthday = _dob;
    final relation = _relation;

    if (name.isEmpty || birthday == null) {
      Get.snackbar("Missing Fields", "Please fill in all fields.");
      return;
    }

    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/friends/"),
        headers: {
          "Authorization": "JWT $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "relation": relation,
          "birthday": birthday.toIso8601String().split("T").first, // yyyy-MM-dd
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Birthday added successfully");
        Navigator.pop(context); // Close modal
      } else {
        Get.snackbar("Error", "Failed to save birthday");
        print("❌ Response: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print("🔥 Exception: $e");
    }
  }
}
