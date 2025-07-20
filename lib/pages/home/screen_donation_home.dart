part of '../_pages.dart';

/// ****************************************************************************
/// Donation and organization list
/// ****************************************************************************
class ScreenDonationHome extends GetView<ControllerDonation> {
  const ScreenDonationHome({super.key});

  Widget SliverPaddingBoxAdapter({
    required EdgeInsetsGeometry padding,
    required Widget child,
  }) {
    return SliverPadding(
      padding: padding,
      sliver: SliverToBoxAdapter(child: child),
    );
  }

  Widget SliverPaddingListView({
    Key? key,
    required EdgeInsetsGeometry padding,
    required Widget? Function(BuildContext, int) itemBuilder,
    int? Function(Key)? findChildIndexCallback,
    required Widget? Function(BuildContext, int) separatorBuilder,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList.separated(
        itemBuilder: itemBuilder,
        separatorBuilder: separatorBuilder,
        findChildIndexCallback: findChildIndexCallback,
        itemCount: itemCount,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        key: key,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _padding = EdgeInsets.symmetric(horizontal: 16.sp);
    return Scaffold(
      appBar: ChildPageAppBar(title: "Fundraising"),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverPaddingBoxAdapter(
              padding: _padding,
              child: _totalFundRaiseCard(),
            ),
            SliverPaddingBoxAdapter(
              padding: _padding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  12.verticalSpace,
                  Text(
                    "Tap Donate",
                    textAlign: TextAlign.center,
                    style: goliathsTypography.screenTitle.copyWith(
                      fontSize: 28.sp,
                      color: goliathsTheme.accent,
                    ),
                  ),
                  Text(
                    "Donate any chairity of your choice By useing our app you can done now! ",
                    textAlign: TextAlign.center,
                    style: goliathsTypography.screenText.copyWith(),
                  ),
                  12.verticalSpace,
                ],
              ),
            ),
            Obx(() {
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final donation = controller.donations[index];
                  return ListTile(
                    leading: Icon(Icons.card_giftcard),
                    title: Text(donation.donorName ?? 'Anonymous'),
                    subtitle: Text(
                      "${donation.amount} ${donation.currency} - ${donation.status}",
                    ),
                    trailing: Text(donation.donatedAt.split('T').first),
                  );
                }, childCount: controller.donations.length),
              );
            }),

            Obx(
              () => SliverPaddingListView(
                padding: _padding,
                itemCount: controller.donations.length,
                itemBuilder: (context, index) {
                  return _fundRaiseCard(
                    image: controller.donationSummaries[index].image,
                    name: controller.donations[index].message,
                    fundRaised: controller.donations[index].amount,
                    onClick: () {
                      final id = controller.donations[index].id;
                      print('Donation ID: $id');
                      Get.toNamed(
                        AppRoutes.donationDetail,
                        arguments: {'donationId': id},
                      );
                    },
                    onClickDonateButton: () {
                      final id = controller.donations[index].id;
                      print('campaign_id: $id');
                      Get.toNamed(
                        AppRoutes.donationAmount,
                        arguments: {'campaign_id': id},
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return 12.verticalSpace;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalFundRaiseCard() {
    return Container(
      height: 0.22.sh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/total_fund_bd.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Total Fundraised",
              textAlign: TextAlign.start,
              style: goliathsTypography.screenTitle.copyWith(
                color: goliathsTheme.textOnPrimary,
              ),
            ),
            Text(
              "\$ ${controller.totalDonated.value}",
              textAlign: TextAlign.start,
              style: goliathsTypography.screenHeading.copyWith(
                color: goliathsTheme.accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fundRaiseCard({
    required String image,
    required String name,
    required String fundRaised,
    Function()? onClick,
    Function()? onClickDonateButton,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: goliathsTheme.background,
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(color: goliathsTheme.stroke),
        ),
        child: Column(
          children: [
            Container(
              height: 0.22.sh,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/total_fund_bd.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.h,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.r),
                          color: goliathsTheme.background.withValues(
                            alpha: 0.3,
                          ),
                        ),
                        child: Text(
                          "Raised: $fundRaised",
                          style: goliathsTypography.screenText.copyWith(
                            color: goliathsTheme.accent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                children: [
                  Expanded(
                    child: Text(name, style: goliathsTypography.screenText),
                  ),
                  CustomButtonSmall(
                    text: "Donate",
                    onPressed: () => onClickDonateButton?.call(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
