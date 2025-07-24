part of '../_pages.dart';

/// ****************************************************************************
/// Friends birth list
/// ****************************************************************************

class ScreenFriendsBirth extends StatefulWidget {
  const ScreenFriendsBirth({super.key});

  @override
  State<ScreenFriendsBirth> createState() => _ScreenFriendsBirthState();
}

class _ScreenFriendsBirthState extends State<ScreenFriendsBirth> {
  final controller = Get.find<ControllerBirthDay>();
  bool _didRefresh = false;

  @override
  Widget build(BuildContext context) {
    if (!_didRefresh) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchFriendsBirthdays(); // force refresh
      });
      _didRefresh = true; // prevent repeated fetches
    }
    final isSearching = controller.searchController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: ChildPageAppBar(title: "Birthdate"),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: 12.verticalSpace),
              SliverToBoxAdapter(
                child: SearchBox(controller: controller.searchController),
              ),
              SliverToBoxAdapter(child: 8.verticalSpace),

              Obx(() {
                if (isSearching) {
                  if (controller.filteredFriends.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Center(
                          child: Text(
                            "No matching results found.",
                            style: goliathsTypography.screenText,
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      SectionHeader(sectionTitle: "Search Results"),
                      ...controller.filteredFriends
                          .map((item) => BirthdayItemWidget(item: item))
                          .toList(),
                      28.verticalSpace,
                    ]),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      if (controller.todays.isNotEmpty) ...[
                        SectionHeader(sectionTitle: "Birthdays Today"),
                        ...controller.todays
                            .map((item) => BirthdayItemWidget(item: item))
                            .toList(),
                        12.verticalSpace,
                      ],
                      if (controller.upcomings.isNotEmpty) ...[
                        SectionHeader(sectionTitle: "Upcoming Birthdays"),
                        ...controller.upcomings
                            .map((item) => BirthdayItemWidget(item: item))
                            .toList(),
                        12.verticalSpace,
                      ],
                      if (controller.filteredFriends.isNotEmpty) ...[
                        SectionHeader(sectionTitle: "All Friends"),
                        ...controller.filteredFriends
                            .map((item) => BirthdayItemWidget(item: item))
                            .toList(),
                        28.verticalSpace,
                      ],
                    ]),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final TextEditingController? controller;
  const SearchBox({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: SizedBox(
          height: 40.h,
          width: 40.h,
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/search.svg",
              colorFilter: ColorFilter.mode(
                goliathsTheme.text,
                BlendMode.srcIn,
              ),
              height: 20.h,
            ),
          ),
        ),
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
      textInputAction: TextInputAction.search,
      style: goliathsTypography.screenText,
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String sectionTitle;

  const SectionHeader({super.key, required this.sectionTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        sectionTitle,
        style: goliathsTypography.screenText.copyWith(
          color: goliathsTheme.accent,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class BirthdayItemWidget extends StatelessWidget {
  final BirthdayItem item;

  const BirthdayItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 26.r),
      decoration: BoxDecoration(
        border: Border.all(color: goliathsTheme.stroke, width: 2),
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: GestureDetector(
        onLongPress: () {
          Get.defaultDialog(
            title: "Delete",
            middleText: "Are you sure you want to delete ${item.name}'s birthday?",
            textConfirm: "Delete",
            textCancel: "Cancel",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.find<ControllerBirthDay>().deleteFriendBirthday(item.id);
              Get.back();
            },
          );
        },
        child: Row(
          children: [
            Image.network(item.image, height: 40.h, width: 40.h),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    item.name,
                    style: goliathsTypography.screenText.copyWith(
                      color: goliathsTheme.text,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "Birthday: ${item.birthday}",
                    style: goliathsTypography.screenText.copyWith(
                      color: goliathsTheme.text.withValues(alpha: 0.8),
                      fontSize: 13.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            16.horizontalSpace,
            GestureDetector(
              onTap: () {
                final message = "Hey ${item.name}, wishing you a very Happy Birthday! 🎉🎂";
                Share.share(message);
              },
              child: SvgPicture.asset(
                "assets/icons/whatsapp.svg",
                height: 20.h,
                width: 20.h,
              ),
            ),

          ],
        ),
      ),

    );
  }
}
