part of '../_pages.dart';

/// ****************************************************************************
/// Onboard Country Pick Screen
/// ****************************************************************************
class ScreenCountry extends GetView<ControllerOnboard> {
  const ScreenCountry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OnboardAppBar(title: "Choose Your Country"),
      body: CountryListView(
        onSelect: (country) {
          Get.toNamed(AppRoutes.dob);
        },
        searchBuilder: (controller) {
          return Padding(
            padding: EdgeInsets.all(8.r),
            child: SearchBox(controller: controller),
          );
        },
        itemBuilder: (country) {
          return CountryListItem(name: country.name, flag: country.flag);
        },
      ),
    );
  }

  Widget CountryListItem({required String name, required AssetImage flag}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: goliathsTheme.stroke),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: flag, width: 26),
            const SizedBox(width: 12),
            Text(name),
          ],
        ),
      ),
    );
  }
}
