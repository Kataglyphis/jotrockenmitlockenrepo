import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  final String text;
  const CopyButton({
    super.key,
    required this.text,
  });

  void _onPressed() async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      child: Text(
        (Localizations.localeOf(context) == const Locale('de'))
            ? "Kopieren"
            : "Copy",
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
