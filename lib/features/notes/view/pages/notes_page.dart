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

    final scrollController = useScrollController();

    final scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>(), []);

    /// Get the percentage of app bar scroll
    double getAppBarScrollPercentage() {
      final currentScroll = scrollController.offset;
      final maxScroll = maxAppBarHeight;

      return min((currentScroll / maxScroll) * 100, 100);
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

    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerWidget(),
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
              scaffoldKey: scaffoldKey,
            ),
            const NotesGridWidget()
          ],
        ),
      ),
    );
  }
}
