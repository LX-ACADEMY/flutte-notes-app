import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.maxDrawerWidth,
  });

  final double maxDrawerWidth;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: maxDrawerWidth,
          margin: const EdgeInsets.symmetric(
            vertical: 24,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.settings)),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.note),
                      SizedBox(width: 8),
                      Expanded(child: Text('All notes')),
                      Text('2'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
