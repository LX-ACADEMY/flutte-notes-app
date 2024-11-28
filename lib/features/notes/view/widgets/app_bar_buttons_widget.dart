import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarButtonsWidgets extends StatelessWidget {
  const AppBarButtonsWidgets({
    super.key,
    required this.titleOpacity,
    required this.onDrawerOpen,
  });

  final double titleOpacity;
  final void Function() onDrawerOpen;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: AppBarButtonsDelegate(
        titleOpacity: titleOpacity,
        onDrawerOpen: onDrawerOpen,
      ),
      pinned: true,
    );
  }
}

class AppBarButtonsDelegate extends SliverPersistentHeaderDelegate {
  final double titleOpacity;
  final VoidCallback onDrawerOpen;

  const AppBarButtonsDelegate(
      {required this.titleOpacity, required this.onDrawerOpen});

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
            onPressed: onDrawerOpen,
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
    return titleOpacity != oldDelegate.titleOpacity;
  }
}
