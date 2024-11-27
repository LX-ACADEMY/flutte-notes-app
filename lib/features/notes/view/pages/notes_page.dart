import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes/features/notes/view/widgets/app_bar_buttons_widget.dart';
import 'package:notes/features/notes/view/widgets/app_bar_widget.dart';
import 'package:notes/features/notes/view/widgets/drawer_widget.dart';
import 'package:notes/features/notes/view/widgets/notes_grid_widget.dart';

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
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    /// Listen to scroll events to change the opacity of the text in appbar
    _scrollController.addListener(() {
      final percentage = getAppBarScrollPercentage();

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

  /// Get the percentage of app bar scroll
  double getAppBarScrollPercentage() {
    final currentScroll = _scrollController.offset;
    final maxScroll = maxAppBarHeight;

    return min((currentScroll / maxScroll) * 100, 100);
  }

  /// Open the drawer
  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    maxAppBarHeight = MediaQuery.sizeOf(context).height * 0.3;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      body: Listener(
        onPointerUp: (event) {
          final percentage = getAppBarScrollPercentage();

          if (percentage > 45) {
            _scrollController.animateTo(maxAppBarHeight,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
          } else {
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
          }
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            AppBarWidget(
              titleOpacity: opacityOut,
              maxAppBarHeight: maxAppBarHeight,
            ),

            /// App bar icons
            AppBarButtonsWidgets(titleOpacity: opacityIn),
            const NotesGridWidget()
          ],
        ),
      ),
    );
  }
}
