part of '../_pages.dart';

/// ****************************************************************************
/// User profile screen
/// ****************************************************************************
class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final String name = "Susan Jannat";
    final String email = "raihansusan1@gmail.com";
    final String gender = "Female";
    final String dateOfBirth = "30 March, 2000";
    return Scaffold(
      appBar: ChildPageAppBar(title: "Profile Information"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            ThreeDotSvg(isDark: true),
            24.verticalSpace,
            // profile image section ===========================================
            AvatarUploader(
              initialImageUrl: 'https://example.com/avatar.jpg',
              onImagePicked: (file) {
                // Upload file to server here
                print('Picked image path: ${file.path}');
              },
            ),
            36.verticalSpace,
            // personal information ============================================
            GestureDetector(
              onTap: () => _openEditModal(context),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: goliathsTheme.stroke),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('Name', name),
                    _divider(),
                    _infoRow('Email', email),
                    _divider(),
                    _infoRow('Gender', gender),
                    _divider(),
                    // date of birth field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoRow('Date of birth', dateOfBirth),
                        Padding(
                          padding: EdgeInsets.only(right: 16.r),
                          child: SvgPicture.asset(
                            "assets/icons/calendar.svg",
                            height: 24.h,
                            width: 24.h,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Text('$title: $value', style: goliathsTypography.screenText),
    );
  }

  Widget _divider() {
    return Container(height: 1, color: goliathsTheme.stroke);
  }

  void _openEditModal(BuildContext context) {
    Get.dialog(const ModalEditProfile());
  }
}
