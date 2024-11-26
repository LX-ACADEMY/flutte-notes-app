import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  double opacityOut = 1;
  double opacityIn = 0;

  double maxAppBarHeight = 0;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    /// Listen to scroll events
    _scrollController.addListener(() {
      final currentScroll = _scrollController.offset;
      final maxScroll = maxAppBarHeight;

      final percentage = min((currentScroll / maxScroll) * 100, 100);

      /// Change the opacity of the text in appbar flexible space
      setState(() {
        opacityOut = max(0, 1 - ((percentage / 100) * 2.5));

        final inPercentage = max(0, percentage - 30);
        opacityIn = min(1, (inPercentage / 60) * 3);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    maxAppBarHeight = MediaQuery.sizeOf(context).height * 0.3;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            centerTitle: true,
            toolbarHeight: 0,
            collapsedHeight: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Center(
                        child: Opacity(
                          opacity: opacityOut,
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
          ),

          /// App bar icons
          SliverToBoxAdapter(
            child: Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/drawer.svg',
                    height: 20,
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: Opacity(
                    opacity: opacityIn,
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
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: const Center(
                child: Text('All Notes'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
