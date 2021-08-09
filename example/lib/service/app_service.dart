import 'package:flutter/material.dart';
import 'package:flutter_package/service.dart';
import 'package:logging/logging.dart';
import 'package:table_calendar_example/app/style.dart';

class AppService extends AppServiceBase {
  //
  static final log = Logger('AppService');

  late double textScaleFactor;
  ThemeData? themeData;
  ThemeData? themeDataInverse;

  AppService({bool product = false}) : super(product: product) {
    this.fontSizeByRatio = GeneratedFontSizeByRatio(body: 20);
  }

  // BEGIN override

  @override
  appHandleError(dynamic error, StackTrace? stackTrace) async {}

  // BEGIN theme

  initTheme(BuildContext context) {
    //
    final MediaQueryData data = MediaQuery.of(context);
    log.finest('data: ', data);
    log.finest('data.devicePixelRatio: ', data.devicePixelRatio);
    log.finest('data.textScaleFactor: ', data.textScaleFactor);
    textScaleFactor = data.textScaleFactor;
    //
    themeData = newNewThemeData(data);
    themeDataInverse = newNewThemeData(data, inverse: true);
  }

  /// IMPORTANT cant overload so "new new"
  ThemeData newNewThemeData(MediaQueryData? data, {bool inverse = false}) {
    //
    final fontSizeByRatioBase = GeneratedFontSizeByRatio(body: 14);
    //
    return newThemeData(
      data,
      inverse: inverse,
      primarySwatch: Colors.grey,
      colorPrimary: Style.colorPrimary,
      colorBg: Style.colorBg,
      colorFg: Style.colorAccent,
      colorFg1: Style.colorAccent1,
      colorFgInverse: Style.colorPrimary,
      fontSizeByRatioBase: fontSizeByRatioBase,
    );
  }
}
