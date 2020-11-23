import 'dart:async';
import 'dart:js';

import 'package:amdjs/amdjs.dart';
import 'package:bones_ui/bones_ui_kit.dart';
import 'package:swiss_knife/swiss_knife.dart';

final String BONES_UI_BOOTSTRAP_PACKAGE_PATH = 'packages/bones_ui_bootstrap';

final bool ENABLE_MINIFIED = false;

/// Bootstrap wrapper and loader.
class Bootstrap {
  static final String VERSION = '4.5.3';

  static final String PATH = 'bootstrap-$VERSION';

  static final String PATH_CSS = '$PATH/css';

  static final String PATH_JS = '$PATH/js';

  static final LoadController _load = LoadController('JSBootstrap');

  /// [EventStream] for loading event.
  static EventStream<LoadController> get onLoad => _load.onLoad;

  /// Returns [true] if JS library is loaded.
  static bool get isLoaded => _load.isLoaded && _load.loadSuccessful;

  /// Returns [true] if JS library is successfully loaded.
  static bool get isSuccessfullyLoaded =>
      _load.isLoaded && _load.loadSuccessful;

  /// Loads Bootstrap and JQuery JS library and CSS.
  static Future<bool> load() {
    return _load.load(() async {
      var okJQuery = await JQuery.load();

      var okCss = await addCssSource(
          '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_CSS/bootstrap.css',
          insertIndex: 0);

      var jsFile =
          ENABLE_MINIFIED ? 'bootstrap.bundle.min.js' : 'bootstrap.bundle.js';
      var jsFullPath = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_JS/$jsFile';

      AMDJS.verbose = true;

      var okJS = await AMDJS.require('bootstrap',
          jsFullPath: jsFullPath, addScriptTagInsideBody: true);

      print(
          'LOADED[jquery: $okJQuery ; BS css: $okCss ; BS js: $okJS]> Bootstrap $VERSION');

      return okJQuery && okCss && okJS;
    });
  }

  static bool _enableTooltip = false;

  /// Enables tooltip functionality.
  static Future<bool> enableTooltip([bool force]) async {
    force ??= false;

    if (_enableTooltip && !force) return true;
    _enableTooltip = true;

    await JQuery.load();

    var ret = JQuery.$('[data-toggle="tooltip"]').call('tooltip');

    return ret != null;
  }

  /// Enables tooltip functionality when [component] renders.
  static void enableTooltipOnRender(UIComponent component) {
    enableTooltip();

    component.onRender.listen((_) {
      Future.delayed(Duration(seconds: 1), () => Bootstrap.enableTooltip(true));
    });
  }
}

/// JQuery wrapper and loader.
class JQuery {
  static final String VERSION = '3.5.1';

  static final String PATH = 'jquery-$VERSION';

  static final String PATH_JS = '$PATH/js';

  static final LoadController _load = LoadController('JSJQuery');

  /// [EventStream] for loading event.
  static EventStream<LoadController> get onLoad => _load.onLoad;

  /// Returns [true] if JS library is loaded.
  static bool get isLoaded => _load.isLoaded && _load.loadSuccessful;

  /// Returns [true] if JS library is successfully loaded.
  static bool get isSuccessfullyLoaded =>
      _load.isLoaded && _load.loadSuccessful;

  /// Loads JQuery JS library.
  static Future<bool> load() {
    return _load.load(() async {
      var jsFile = ENABLE_MINIFIED ? 'jquery.min.js' : 'jquery.js';
      var jsFullPath = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_JS/$jsFile';

      AMDJS.verbose = true;

      var okJS = await AMDJS.require('jquery',
          jsFullPath: jsFullPath, globalJSVariableName: 'jquery');

      print('LOADED[js: $okJS]> JQuery $VERSION');

      return okJS;
    });
  }

  /// Does JQuery [query]
  static JQuery $(dynamic query) {
    var o = context.callMethod(r'$', [query]);
    return JQuery(o);
  }

  final JsObject _o;

  JQuery(this._o);

  /// Makes a JQuery call.
  ///
  /// [method] The method to call.
  /// [args] Arguments to the method.
  dynamic call(String method, [List args]) {
    return _o.callMethod(method, args);
  }
}

/// Moment wrapper and loader.
class Moment {
  static final String VERSION = '2.25.2';

  static final String PATH = 'moment-$VERSION';

  static final String PATH_JS = '$PATH/js';

  static final LoadController _load = LoadController('JSMoment');

  /// [EventStream] for loading event.
  static EventStream<LoadController> get onLoad => _load.onLoad;

  /// Returns [true] if JS library is loaded.
  static bool get isLoaded => _load.isLoaded && _load.loadSuccessful;

  /// Returns [true] if JS library is successfully loaded.
  static bool get isSuccessfullyLoaded =>
      _load.isLoaded && _load.loadSuccessful;

  static JsFunction _moment;

  /// Loads Moment JS library.
  static Future<bool> load() {
    return _load.load(() async {
      var jsFile = ENABLE_MINIFIED
          ? 'moment-with-locales.min.js'
          : 'moment-with-locales.js';
      var jsFullPath = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_JS/$jsFile';

      var okJS = await AMDJS.require('moment',
          jsFullPath: jsFullPath, globalJSVariableName: 'moment');

      _moment = context['moment'] as JsFunction;

      var okMoment = _moment != null;

      return okJS && okMoment;
    });
  }

  /// Sets the locale of [Moment].
  static bool locale(String locale) {
    load();
    if (locale == null) return false;

    locale = locale.trim().toLowerCase();
    if (locale.isEmpty) return false;

    locale = locale.replaceFirst('_', '-');

    _moment.callMethod('locale', [locale]);
    return true;
  }

  /// Parses a [DateTime] to a moment object.
  static JsObject moment(DateTime dateTime) {
    return JsObject(_moment, [dateTime]);
  }

  /// Formats [dateTime] to [format].
  static String format(DateTime dateTime, format) {
    return moment(dateTime).callMethod('format', format);
  }

  static String jsObject_format(JsObject moment, format) {
    return moment.callMethod('format', [format]);
  }

  static int jsObject_toMillisecondsSinceEpoch(JsObject moment) {
    return moment.callMethod('valueOf');
  }

  static DateTime jsObject_toDateTime(JsObject moment) {
    var time = jsObject_toMillisecondsSinceEpoch(moment);
    return DateTime.fromMillisecondsSinceEpoch(time);
  }

  static int toMomentWeekDay(DateTimeWeekDay weekDay) {
    if (weekDay == null) return null;

    switch (weekDay) {
      case DateTimeWeekDay.Sunday:
        return 0;
      case DateTimeWeekDay.Monday:
        return 1;
      case DateTimeWeekDay.Tuesday:
        return 2;
      case DateTimeWeekDay.Wednesday:
        return 3;
      case DateTimeWeekDay.Thursday:
        return 4;
      case DateTimeWeekDay.Friday:
        return 5;
      case DateTimeWeekDay.Saturday:
        return 6;
      default:
        return null;
    }
  }

  static DateTimeWeekDay toDateTimeWeekDay(int momentWeekDay) {
    if (momentWeekDay == null) return null;

    switch (momentWeekDay) {
      case 0:
        return DateTimeWeekDay.Sunday;
      case 1:
        return DateTimeWeekDay.Monday;
      case 2:
        return DateTimeWeekDay.Tuesday;
      case 3:
        return DateTimeWeekDay.Wednesday;
      case 4:
        return DateTimeWeekDay.Thursday;
      case 5:
        return DateTimeWeekDay.Friday;
      case 6:
        return DateTimeWeekDay.Saturday;
      default:
        throw ArgumentError(
            'Invalid Moment weekDay index. Should be of range 0-6, where Sunday is 0 and Saturday is 6 (Sunday-to-Saturday week).');
    }
  }
}
