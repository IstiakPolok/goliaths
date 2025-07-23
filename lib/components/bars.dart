part of '_components.dart';

/// ****************************************************************************
/// Onboard Bars
/// ****************************************************************************
class OnboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const OnboardAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ThreeDotSvg(isDark: true),
            Text(
              title,
              style: goliathsTypography.screenHeading,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}

/// ****************************************************************************
/// Home Bar
/// ****************************************************************************
class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isButton;

  const HomeAppBar({
    super.key,
    this.title = "Breaking Goliaths",
    this.isButton = true,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(88.h);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
    super.initState();
    showDarkStatusIcon();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: widget.preferredSize.height,
        color: goliathsTheme.background,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ThreeDotSvg(isDark: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    "Breaking Goliaths",
                    style: goliathsTypography.screenText,
                  ),
                ),
                if (widget.isButton)
                  CustomButtonSmall(
                    text: "Donate",
                    onPressed: () {
                      Get.toNamed(AppRoutes.donationHome);
                    },
                  ),
              ],
            ),
            Text(
              widget.title,
              style: goliathsTypography.screenHeading,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

/// ****************************************************************************
/// Other Bar
/// ****************************************************************************
class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NormalAppBar({super.key, this.title = "Breaking Goliaths"});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(title, style: goliathsTypography.screenText),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

/// ****************************************************************************
/// ChildPage Bar Back Button
/// ****************************************************************************
class ChildPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? background;
  final Color? color;

  const ChildPageAppBar({
    super.key,
    this.title = "",
    this.color,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: background ?? goliathsTheme.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: color),
            onPressed: () => Get.close(1),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: goliathsTypography.screenText.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// ****************************************************************************
/// Bottom App Bar
/// ****************************************************************************
class BottomBar extends StatelessWidget {
  final int selectedIndex;

  BottomBar({super.key, required this.selectedIndex});
  final controllerHome = Get.put(ControllerHome());

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        width: 1.0.sw,
        height: 60.h, // fixed height
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomBarItem(
              icon: SvgAssetLoader("assets/icons/bar_chat.svg"),
              label: 'Home',
              selected: selectedIndex == 0,
              onClick: () {
                if (selectedIndex == 0) return;
                Get.toNamed(AppRoutes.home);
              },
            ),
            _BottomBarItem(
              icon: SvgAssetLoader("assets/icons/bar_voice.svg"),
              label: 'My Coach',
              selected: selectedIndex == 1,
              onClick: () {
                if (selectedIndex == 1) return;
                // Get.toNamed(AppRoutes.chat);
                controllerHome.selectModeAndStartChat("friend");
              },
            ),
            _BottomBarItem(
              icon: SvgAssetLoader("assets/icons/bar_settings.svg"),
              label: 'Settings',
              selected: selectedIndex == 2,
              onClick: () {
                if (selectedIndex == 2) return;
                Get.toNamed(AppRoutes.settings);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final SvgAssetLoader icon;
  final String label;
  final bool selected;
  final Function() onClick;

  const _BottomBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 0.3.sw),
      child: GestureDetector(
        onTap: onClick,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture(
              icon,
              height: 20.h,
              width: 20.h,
              colorFilter: ColorFilter.mode(
                selected ? goliathsTheme.accent : goliathsTheme.barIcon,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: "Poppins",
                color: selected ? goliathsTheme.accent : goliathsTheme.barIcon,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
