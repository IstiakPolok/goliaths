part of '../_pages.dart';

/// ****************************************************************************
/// User profile screen
/// ****************************************************************************
class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: ChildPageAppBar(title: "Profile Information"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profile.value;
        if (profile == null) {
          return const Center(child: Text('Failed to load profile'));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              ThreeDotSvg(isDark: true),
              24.verticalSpace,

              // profile image
              AvatarUploader(
                initialImageUrl: profile.avatarUrl,
                onImagePicked: (file) {
                  print('Picked image path: ${file.path}');
                  // Add image upload logic
                },
              ),
              36.verticalSpace,

              // personal info
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
                      _infoRow('Name', profile.name),
                      _divider(),
                      _infoRow('Email', profile.email),
                      _divider(),
                      _infoRow('Gender', profile.lastName),
                      _divider(),

                      // date of birth
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _infoRow('Date of birth', profile.dateOfBirth),
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
        );
      }),
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
