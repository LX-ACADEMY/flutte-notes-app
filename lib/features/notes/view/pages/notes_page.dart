import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            toolbarHeight: 40,
            collapsedHeight: 40,
            flexibleSpace: const FlexibleSpaceBar(
              background: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
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
                  ],
                ),
              ),
            ),
            pinned: true,
            expandedHeight: MediaQuery.sizeOf(context).height * 0.3,
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
                const Expanded(
                  child: Text(
                    'All notes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
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
