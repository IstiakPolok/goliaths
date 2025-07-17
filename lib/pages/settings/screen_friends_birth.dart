part of '../_pages.dart';

/// ****************************************************************************
/// Friends birth list
/// ****************************************************************************
class ScreenFriendsBirth extends GetView<ControllerBirthDay> {
  const ScreenFriendsBirth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "Birthdate"),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: 12.verticalSpace),
              SliverToBoxAdapter(child: SearchBox()),
              SliverToBoxAdapter(child: 8.verticalSpace),
              if (controller.todays.isNotEmpty)
                SliverToBoxAdapter(
                  child: SectionHeader(sectionTitle: "Birthdays Today"),
                ),
              SliverList.separated(
                itemCount: controller.todays.length,
                itemBuilder: (context, index) {
                  return BirthdayItemWidget(item: controller.todays[index]);
                },
                separatorBuilder: (context, index) {
                  return 12.verticalSpace;
                },
              ),
              if (controller.upcomings.isNotEmpty)
                SliverToBoxAdapter(
                  child: SectionHeader(sectionTitle: "Upcoming Birthdays"),
                ),
              SliverList.separated(
                itemCount: controller.upcomings.length,
                itemBuilder: (context, index) {
                  return BirthdayItemWidget(item: controller.upcomings[index]);
                },
                separatorBuilder: (context, index) {
                  return 12.verticalSpace;
                },
              ),
              SliverToBoxAdapter(child: 28.verticalSpace),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final TextEditingController? controller;
  const SearchBox({super.key,this.controller});

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
      textInputAction: TextInputAction.newline,
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
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 26.r),
      decoration: BoxDecoration(
        border: Border.all(color: goliathsTheme.stroke, width: 2),
        borderRadius: BorderRadius.circular(26.r),
      ),
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
          SvgPicture.asset(
            "assets/icons/whatsapp.svg",
            height: 20.h,
            width: 20.h,
          ),
        ],
      ),
    );
  }
}
