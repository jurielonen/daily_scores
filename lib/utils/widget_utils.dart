import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetUtils {
  static AppBar emptyAppBar({
    Color? backgroundColor,
    SystemUiOverlayStyle? systemUiOverlayStyle,
  }) =>
      AppBar(
        backgroundColor: backgroundColor,
        systemOverlayStyle: systemUiOverlayStyle,
        toolbarHeight: 0,
        elevation: 0,
      );
}
