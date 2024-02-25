import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/team.dart';

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

  static Widget teamLogo(Team team, {double size = 30}) {
    return SvgPicture.network(
      team.logo,
      height: 30,
      width: 30,
    );
  }

  static Widget networkImage(String? url, {double size = 40}) {
    if (url != null) {
      return Image.network(
        url,
        height: size,
        width: size,
        errorBuilder: (_, __, ___) => sizedBox(size),
      );
    }
    return sizedBox(size);
  }

  static Widget sizedBox(double size) => SizedBox(
        height: size,
        width: size,
      );
}
