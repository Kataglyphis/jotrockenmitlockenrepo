import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlockenrepo/Media/Image/openable_image.dart';
import 'package:markdown/markdown.dart' as md;

class CenteredImageBuilder extends MarkdownElementBuilder {
  CenteredImageBuilder({
    required this.colorSelected,
    required this.imageDir,
  });
  Color colorSelected;
  String imageDir;

  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    String placeholderImage = "assets/images/cats/Summy&Thundy_compressed.png";
    String displayedImage = placeholderImage;

    String? imageCaption;
    if (element.attributes['src'] != null) {
      displayedImage = "$imageDir/${element.attributes['src']!}";
    }

    if (element.attributes['alt'] != null) {
      imageCaption = element.attributes['alt']!;
    }

    return SelectionArea(
        child: Center(
      child: OpenableImage(
        placeholderImage: placeholderImage,
        displayedImage: displayedImage,
        imageCaptioning: imageCaption,
        captioningStyle: preferredStyle,
      ),
    ));
  }
}
