import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarButtonsWidgets extends StatelessWidget {
  const AppBarButtonsWidgets({
    super.key,
    required this.titleOpacity,
    required this.scaffoldKey,
  });

  final double titleOpacity;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: AppBarButtonsDelegate(
        scaffoldKey: scaffoldKey,
        titleOpacity: titleOpacity,
      ),
      pinned: true,
    );
  }
}

class AppBarButtonsDelegate extends SliverPersistentHeaderDelegate {
  final GlobalKey<ScaffoldState> scaffoldKey;
  double titleOpacity;

  AppBarButtonsDelegate(
      {required this.scaffoldKey, required this.titleOpacity});

  /// Open the drawer
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/drawer.svg',
              height: 20,
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            onPressed: openDrawer,
          ),
          Expanded(
            child: Opacity(
              opacity: titleOpacity,
              child: const Text(
                'All notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(AppBarButtonsDelegate oldDelegate) {
    return titleOpacity != oldDelegate.titleOpacity ||
        scaffoldKey != oldDelegate.scaffoldKey;
  }
}
