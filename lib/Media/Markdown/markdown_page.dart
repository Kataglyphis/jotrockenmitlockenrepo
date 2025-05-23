import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:markdown_widget/markdown_widget.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

class MarkdownFilePage extends StatefulWidget {
  const MarkdownFilePage({
    Key? key,
    required this.currentLocale,
    required this.filePathDe,
    required this.filePathEn,
    this.imageDirectory = 'assets/images/',
    required this.useLightMode,
  }) : super(key: key);

  final Locale currentLocale;
  final String filePathDe;
  final String filePathEn;
  final String imageDirectory;
  final bool useLightMode;

  @override
  MarkdownFilePageState createState() => MarkdownFilePageState();
}

class MarkdownFilePageState extends State<MarkdownFilePage> {
  late Future<String> _markupFileContent;

  @override
  void initState() {
    super.initState();
    _markupFileContent = _readMarkupFile();
  }

  Future<String> _readMarkupFile() async {
    // Read the corresponding file depending on the current locale
    try {
      if (widget.currentLocale == const Locale('de') &&
          widget.filePathDe.isNotEmpty) {
        return await rootBundle.loadString(widget.filePathDe);
      } else if (widget.currentLocale == const Locale('de') &&
          widget.filePathEn.isNotEmpty) {
        return await rootBundle.loadString(widget.filePathEn);
      } else if (widget.currentLocale == const Locale('en') &&
          widget.filePathEn.isNotEmpty) {
        return await rootBundle.loadString(widget.filePathEn);
      } else if (widget.currentLocale == const Locale('en') &&
          widget.filePathDe.isNotEmpty) {
        return await rootBundle.loadString(widget.filePathDe);
      } else if (widget.filePathDe.isNotEmpty) {
        return await rootBundle.loadString(widget.filePathDe);
      } else {
        return await rootBundle.loadString(widget.filePathEn);
      }
    } catch (e) {
      developer.log("Error reading file: $e");
      return '';
    }
  }

  double getMarkdownPageWidth() {
    final currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return currentWidth * 0.9;
    } else if (currentWidth <= mediumWidthBreakpoint) {
      return currentWidth * 0.9;
    } else {
      return currentWidth * 0.7;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final config = isDark
        ? MarkdownConfig.darkConfig
        : MarkdownConfig.defaultConfig;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        rowDivider,
        FutureBuilder<String>(
          future: _markupFileContent,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: getMarkdownPageWidth(),
                child: Center(
                  child: MarkdownWidget(
                    shrinkWrap: true,
                    data: snapshot.data!,

                    config: config.copy(
                      configs: [
                        isDark
                            ? PreConfig.darkConfig.copy()
                            : PreConfig().copy(),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
