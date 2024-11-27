import 'package:flutter/material.dart';

class NotesGridWidget extends StatelessWidget {
  const NotesGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: const Center(
          child: Text('All Notes'),
        ),
      ),
    );
  }
}
