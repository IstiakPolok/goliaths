part of '../_pages.dart';

/// ****************************************************************************
/// Birth day wish quotes screen
/// ****************************************************************************
class ScreenBirthdayWish extends StatelessWidget {
  const ScreenBirthdayWish({super.key});

  final wishes = const [
    "Wishing you a birthday filled with love, laughter, and all the happiness in the world.",
    "May your special day be surrounded with joy, cherished memories, and endless blessings.",
    "Happy Birthday! Here's to another year of amazing memories and incredible adventures.",
    "Wishing you all the love your heart can hold and all the happiness a day can bring.",
    "May today and every day be filled with sunshine, smiles, and laughter.",
    "Happy Birthday! May your dreams turn into reality and your efforts into great achievements.",
    "Sending you warm wishes for health, success, and happiness on your birthday and always.",
    "Hope your birthday is as sweet and wonderful as you are!",
    "Wishing you a bright year ahead filled with endless opportunities and beautiful moments.",
    "May your birthday be the beginning of a year filled with good luck, good health, and much happiness.",
    "Happy Birthday! May your heart always stay young and your dreams come true.",
    "Here’s to celebrating you and all the joy you bring to the world.",
    "Wishing you endless joy, laughter, and good company today and every day.",
    "May this new chapter of your life bring you new beginnings and countless blessings.",
    "Happy Birthday! May you find peace, love, and success in every corner of your life.",
    "On your special day, I hope you feel loved, appreciated, and truly celebrated.",
    "Wishing you a lifetime of love, laughter, and amazing moments.",
    "May today bring you all the smiles you deserve and the happiness you spread to others.",
    "Happy Birthday! You deserve a day that's as special as your heart.",
    "Cheers to you and the wonderful journey that lies ahead. Happy Birthday!",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "Birthday Wishes"),
      backgroundColor: Color(0xFFFEF9F5),
      body: SafeArea(
        top: false,
        child: ListView.separated(
          padding: EdgeInsets.all(16.r),
          itemBuilder: (context, index) {
            return _cardView(quote: wishes[index]);
          },
          separatorBuilder: (context, index) {
            return 8.verticalSpace;
          },
          itemCount: wishes.length,
        ),
      ),
    );
  }

  Widget _cardView({required String quote}) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: goliathsTheme.background,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/icons/quote.svg",
            colorFilter: ColorFilter.mode(goliathsTheme.text, BlendMode.srcIn),
            height: 20.h,
          ),
          12.horizontalSpace,
          Expanded(child: Text(quote, style: goliathsTypography.screenText)),
        ],
      ),
    );
  }
}
