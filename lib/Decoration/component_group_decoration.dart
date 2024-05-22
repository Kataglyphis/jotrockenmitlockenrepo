import 'package:flutter/material.dart';

class ComponentGroupDecoration extends StatelessWidget {
  const ComponentGroupDecoration(
      {super.key, required this.label, required this.children});

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    const colDivider = SizedBox(height: 10);
    // Fully traverse this component group before moving on
    return FocusTraversalGroup(
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.3),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(label, style: Theme.of(context).textTheme.headlineSmall),
            colDivider,
            ...children,
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
