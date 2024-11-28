import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes/features/notes/view/widgets/app_bar_buttons_widget.dart';
import 'package:notes/features/notes/view/widgets/app_bar_widget.dart';
import 'package:notes/features/notes/view/widgets/drawer_widget.dart';
import 'package:notes/features/notes/view/widgets/notes_grid_widget.dart';

class NotesPage extends HookWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final opacityOut = useState<double>(1);
    final opacityIn = useState<double>(0);

    final maxAppBarHeight = MediaQuery.sizeOf(context).height * 0.3;
    final maxDrawerWidth = MediaQuery.sizeOf(context).width * 0.8;

    final scrollController = useScrollController();
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );
    final scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>(), []);

    final drawerTranslateAnimation =
        Tween<double>(begin: -maxDrawerWidth, end: 0)
            .animate(animationController);
    final scaffolTranslateAnimation =
        Tween<double>(begin: 0, end: maxDrawerWidth)
            .animate(animationController);

    /// Get the percentage of app bar scroll
    double getAppBarScrollPercentage() {
      final currentScroll = scrollController.offset;
      final maxScroll = maxAppBarHeight;

      return min((currentScroll / maxScroll) * 100, 100);
    }

    void openDrawer() {
      animationController.forward();
    }

    useEffect(() {
      scrollController.addListener(() {
        final percentage = getAppBarScrollPercentage();

        /// Change the opacity of the text in appbar flexible space
        opacityOut.value = max(0, 1 - ((percentage / 100) * 2.5));

        final inPercentage = max(0, percentage - 30);
        opacityIn.value = min(1, (inPercentage / 60) * 3);
      });

      return null;
    }, []);

    return Container(
      color: Colors.white,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: AnimatedBuilder(
            animation: animationController,
            child: Scaffold(
              key: scaffoldKey,
              floatingActionButton: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                onPressed: () {},
                child: const Icon(Icons.edit),
              ),
              body: Listener(
                onPointerUp: (event) {
                  final percentage = getAppBarScrollPercentage();

                  if (percentage > 45) {
                    scrollController.animateTo(maxAppBarHeight,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear);
                  } else {
                    scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear);
                  }
                },
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    AppBarWidget(
                      titleOpacity: opacityOut.value,
                      maxAppBarHeight: maxAppBarHeight,
                    ),

                    /// App bar icons
                    AppBarButtonsWidgets(
                      titleOpacity: opacityIn.value,
                      onDrawerOpen: openDrawer,
                    ),
                    const NotesGridWidget()
                  ],
                ),
              ),
            ),
            builder: (context, child) {
              return Stack(
                children: [
                  Transform.translate(
                    offset: Offset(scaffolTranslateAnimation.value, 0),
                    child: child,
                  ),

                  /// Overlay
                  if (animationController.value > 0)
                    GestureDetector(
                      onTap: () {
                        animationController.reverse();
                      },
                      child: Opacity(
                        opacity: animationController.value,
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ),

                  /// Drawer
                  Transform.translate(
                    offset: Offset(drawerTranslateAnimation.value, 0),
                    child: const DrawerWidget(),
                  )
                ],
              );
            }),
      ),
    );
  }
}
