import 'dart:async';
import 'dart:js';

import 'package:amdjs/amdjs.dart';
import 'package:bones_ui/bones_ui.dart';
import 'package:swiss_knife/swiss_knife.dart';

////////////////////////////////////////////////////////////////////////////////

final String BONES_UI_BOOTSTRAP_PACKAGE_PATH = 'packages/bones_ui_bootstrap';

final bool ENABLE_MINIFIED = false;

class JSBootstrap {
  static final String VERSION = '4.4.1';

  static final String PATH = 'bootstrap-$VERSION';

  static final String PATH_CSS = '$PATH/css';

  static final String PATH_JS = '$PATH/js';

  static final LoadController _load = LoadController('JSBootstrap');

  static Future<bool> load() {
    return _load.load(() async {
      var okCss = await addCssSource(
          '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_CSS/bootstrap.css',
          insertIndex: 0);

      var jsFile =
          ENABLE_MINIFIED ? 'bootstrap.bundle.min.js' : 'bootstrap.bundle.js';
      var jsFullPath = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_JS/$jsFile';

      AMDJS.verbose = true;

      var okJS = await AMDJS.require('bootstrap', jsFullPath,
          addScriptTagInsideBody: true);

      print('LOADED[css: $okCss ; js: $okJS]> Bootstrap $VERSION');

      return okCss && okJS;
    });
  }

  static Future<bool> loadWithJQuery() async {
    var ok1 = await JSJQuery.load();
    var ok2 = await load();
    return ok1 && ok2;
  }

  static bool _enableTooltip = false;

  static Future<bool> enableTooltip([bool force]) async {
    force ??= false;

    if (_enableTooltip && !force) return true;
    _enableTooltip = true;

    await JSJQuery.load();

    var ret = JSJQuery.$('[data-toggle="tooltip"]').call('tooltip');

    return ret != null;
  }

  static void enableTooltipOnRender(UIComponent component) {
    enableTooltip();

    component.onRender.listen((_) {
      Future.delayed(
          Duration(seconds: 1), () => JSBootstrap.enableTooltip(true));
    });
  }
}

class JSJQuery {
  static final String VERSION = '3.5.1';

  static final String PATH = 'jquery-$VERSION';

  static final String PATH_JS = '$PATH/js';

  static final LoadController _load = LoadController('JSJQuery');

  static Future<bool> load() {
    return _load.load(() async {
      var jsFile = ENABLE_MINIFIED ? 'jquery.min.js' : 'jquery.js';
      var jsFullPath = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_JS/$jsFile';

      AMDJS.verbose = true;

      var okJS = await AMDJS.require('jquery', jsFullPath,
          globalJSVariableName: 'jquery');

      print('LOADED[js: $okJS]> JQuery $VERSION');

      return okJS;
    });
  }

  static JSJQuery $(dynamic query) {
    var o = context.callMethod(r'$', [query]);
    return JSJQuery(o);
  }

  final JsObject _o;

  JSJQuery(this._o);

  dynamic call(String method, [List args]) {
    return _o.callMethod(method, args);
  }
}

class JSMoment {
  static final String VERSION = '2.25.2';

  static final String PATH = 'moment-$VERSION';

  static final String PATH_JS = '$PATH/js';

  static final LoadController _load = LoadController('JSMoment');

  static JsFunction _moment;

  static Future<bool> load() {
    return _load.load(() async {
      var jsFile = ENABLE_MINIFIED
          ? 'moment-with-locales.min.js'
          : 'moment-with-locales.js';
      var jsFullPath = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_JS/$jsFile';

      var okJS = await AMDJS.require('moment', jsFullPath,
          globalJSVariableName: 'moment');

      _moment = context['moment'] as JsFunction;

      var okMoment = _moment != null;

      return okJS && okMoment;
    });
  }

  static bool locale(String locale) {
    load();
    if (locale == null) return false;

    locale = locale.trim().toLowerCase();
    if (locale.isEmpty) return false;

    locale = locale.replaceFirst('_', '-');

    _moment.callMethod('locale', [locale]);
    return true;
  }

  static JsObject moment(DateTime dateTime) {
    return JsObject(_moment, [dateTime]);
  }

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
