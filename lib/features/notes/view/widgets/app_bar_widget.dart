import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.titleOpacity,
    required this.maxAppBarHeight,
  });

  final double titleOpacity;
  final double maxAppBarHeight;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      toolbarHeight: 0,
      collapsedHeight: 0,
      excludeHeaderSemantics: false,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Center(
                  child: Opacity(
                    opacity: titleOpacity,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'All notes',
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                        Text('3 notes'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      pinned: true,
      expandedHeight: maxAppBarHeight,
    );
  }
}
