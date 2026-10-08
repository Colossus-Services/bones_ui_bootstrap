import 'dart:js_interop_unsafe';

import 'package:amdjs/amdjs.dart';
import 'package:bones_ui/bones_ui.dart';
import 'package:dom_tools/dom_tools.dart';
import 'package:swiss_knife/swiss_knife.dart';
import 'package:web_utils/web_utils.dart';

// ignore: non_constant_identifier_names
final String BONES_UI_BOOTSTRAP_PACKAGE_PATH = 'packages/bones_ui_bootstrap';

// ignore: non_constant_identifier_names
final bool ENABLE_MINIFIED = true;

/// Bootstrap wrapper and loader.
class Bootstrap {
  // ignore: non_constant_identifier_names
  static final String VERSION = '5.3.8';

  // ignore: non_constant_identifier_names
  static final String PATH = 'bootstrap-$VERSION';

  // ignore: non_constant_identifier_names
  static final String PATH_CSS = '$PATH/css';

  // ignore: non_constant_identifier_names
  static final String PATH_JS = '$PATH/js';

  /// Path of the bundled Bootstrap SCSS sources (same [VERSION] as the bundled
  /// CSS and JS), for apps that compile their own Bootstrap theme:
  /// `@import "package:bones_ui_bootstrap/bootstrap-5/scss/bootstrap";`
  ///
  /// Only the major version is in the path, so a Bootstrap 5.x update doesn't
  /// change the app imports. (The CSS and JS paths keep the full version, as
  /// they are loaded by the browser and the version busts its cache.)
  // ignore: non_constant_identifier_names
  static final String PATH_SCSS = 'bootstrap-${VERSION.split('.').first}/scss';

  static final LoadController _load = LoadController('JSBootstrap');

  static bool? _cssLoaded;

  /// Returns `true` if the bundled Bootstrap CSS was loaded by [load],
  /// `false` if it wasn't (`loadCss: false` or a loading error), or `null` if
  /// [load] didn't finish loading the CSS yet.
  static bool? get isCssLoaded => _cssLoaded;

  /// The [load] `loadCss` when not passed, including the calls made by this
  /// package (e.g. [enableTooltip]). Set it to `false` at the app start (before
  /// any [load]) when the app compiles its own Bootstrap CSS: then no [load]
  /// call, whoever makes it first, loads the bundled CSS.
  static bool defaultLoadCss = true;

  /// [EventStream] for loading event.
  static EventStream<LoadController> get onLoad => _load.onLoad;

  /// Returns [true] if JS library is loaded.
  static bool get isLoaded => _load.isLoaded;

  /// Returns [true] if JS library is successfully loaded.
  static bool get isSuccessfullyLoaded =>
      _load.isLoaded && _load.loadSuccessful!;

  /// Loads Bootstrap JS library and CSS.
  ///
  /// Bootstrap 5 doesn't depend on JQuery, so JQuery is not loaded.
  /// Call [JQuery.load] if you need it.
  ///
  /// - [loadCss]: if `false`, the bundled Bootstrap CSS is not loaded (only
  ///   the JS). Use it when the app compiles its own Bootstrap CSS from the
  ///   bundled SCSS (see [PATH_SCSS]), to avoid loading Bootstrap twice.
  ///   Defaults to [defaultLoadCss].
  ///
  /// Only the first call loads: the options of later calls are ignored. As
  /// other calls (e.g. [enableTooltip]) may come first, prefer setting
  /// [defaultLoadCss].
  static Future<bool> load({bool? loadCss}) {
    final css = loadCss ?? defaultLoadCss;
    return _load.load(() async {
      AMDJS.verbose = true;

      var okCss = true;
      if (css) {
        var cssFile = ENABLE_MINIFIED ? 'bootstrap.min.css' : 'bootstrap.css';
        var cssFullPath = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_CSS/$cssFile';

        okCss = await addCssSource(cssFullPath, insertIndex: 0);
      }
      _cssLoaded = css && okCss;

      var jsFile = ENABLE_MINIFIED
          ? 'bootstrap.bundle.min.js'
          : 'bootstrap.bundle.js';
      var jsFullPath = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_JS/$jsFile';

      var okJS = await AMDJS.require(
        'bootstrap',
        jsFullPath: jsFullPath,
        addScriptTagInsideBody: true,
      );

      print(
        'LOADED[BS css: ${css ? okCss : 'skipped'} ; BS js: $okJS]> '
        'Bootstrap $VERSION',
      );

      return okCss && okJS;
    });
  }

  static bool _enableTooltip = false;

  /// Enables tooltip functionality for the elements with
  /// `data-bs-toggle="tooltip"` (Bootstrap 5 attribute).
  ///
  /// Returns `true` if any tooltip element was found.
  static Future<bool> enableTooltip({
    bool force = false,
    Duration? delay,
  }) async {
    if (_enableTooltip && !force) return true;
    _enableTooltip = true;

    if (!isLoaded) {
      await load();
    }

    try {
      delay ??= Duration(milliseconds: 100);
      if (delay.inMilliseconds > 0) {
        await Future.delayed(delay);
      }

      var tooltip =
          (globalContext['bootstrap'] as JSObject)['Tooltip'] as JSObject;

      var elements = document.querySelectorAll('[data-bs-toggle="tooltip"]');

      for (var i = 0; i < elements.length; ++i) {
        tooltip.callMethod<JSAny?>(
          'getOrCreateInstance'.toJS,
          elements.item(i),
        );
      }

      return elements.length > 0;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Enables tooltip functionality when [component] renders.
  static void enableTooltipOnRender(UIComponent component) {
    enableTooltip();

    component.onRender.listen((_) {
      Future.delayed(
        Duration(seconds: 1),
        () => Bootstrap.enableTooltip(force: true),
      );
    });
  }
}

/// JQuery wrapper and loader.
class JQuery {
  // ignore: non_constant_identifier_names
  static final String VERSION = '3.7.1';

  // ignore: non_constant_identifier_names
  static final String PATH = 'jquery-$VERSION';

  // ignore: non_constant_identifier_names
  static final String PATH_JS = '$PATH/js';

  static final LoadController _load = LoadController('JSJQuery');

  /// [EventStream] for loading event.
  static EventStream<LoadController> get onLoad => _load.onLoad;

  /// Returns [true] if JS library is loaded.
  static bool get isLoaded => _load.isLoaded;

  /// Returns [true] if JS library is successfully loaded.
  static bool get isSuccessfullyLoaded =>
      _load.isLoaded && _load.loadSuccessful!;

  /// Loads JQuery JS library.
  static Future<bool> load() {
    return _load.load(() async {
      var jsFile = ENABLE_MINIFIED ? 'jquery.min.js' : 'jquery.js';
      var jsFullPath = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_JS/$jsFile';

      AMDJS.verbose = true;

      var okJS = await AMDJS.require(
        'jquery',
        jsFullPath: jsFullPath,
        globalJSVariableName: 'jquery',
      );

      print('LOADED[js: $okJS]> JQuery $VERSION');

      return okJS;
    });
  }

  /// Does JQuery [query]
  static JQuery $(Object? query) {
    var o = globalContext.callMethod<JSObject?>(r'$'.toJS, query.toJSDeep);
    return JQuery(o);
  }

  final JSObject? _o;

  JQuery(this._o);

  /// Makes a JQuery call.
  ///
  /// [method] The method to call.
  /// [args] Arguments to the method.
  dynamic call(String method, [List? args]) {
    var arguments = args?.map((e) => (e as Object?).toJSDeep).toList();
    return _o!.callMethodVarArgs<JSAny?>(method.toJS, arguments).dartify();
  }

  /// Opens a new Window.
  ///
  /// - [name] of the Window.
  /// - [html] the Window HTML, set as the `body` `innerHTML`
  ///   (doesn't depend on JQuery).
  /// - [print] if `true` will print the window.
  static JSObject openWindow({String? name, String? html, bool print = false}) {
    var openParams = <dynamic>[];

    if (name != null) {
      if (openParams.isEmpty) {
        openParams.add(null);
      }
      openParams.add(name);
    }

    var w =
        globalContext.callMethodVarArgs<JSObject?>(
              'open'.toJS,
              openParams.map((e) => (e as Object?).toJSDeep).toList(),
            )
            as JSObject;

    if (html != null && html.isNotEmpty) {
      var doc = w['document'] as JSObject;
      var body = doc['body'] as JSObject;
      body['innerHTML'] = html.toJS;
    }

    if (print) {
      w.callMethod<JSAny?>('focus'.toJS);
      w.callMethod<JSAny?>('print'.toJS);
    }

    return w;
  }
}

/// Moment wrapper and loader.
class Moment {
  // ignore: non_constant_identifier_names
  static final String VERSION = '2.30.1';

  // ignore: non_constant_identifier_names
  static final String PATH = 'moment-$VERSION';

  // ignore: non_constant_identifier_names
  static final String PATH_JS = '$PATH/js';

  static final LoadController _load = LoadController('JSMoment');

  /// [EventStream] for loading event.
  static EventStream<LoadController> get onLoad => _load.onLoad;

  /// Returns [true] if JS library is loaded.
  static bool get isLoaded => _load.isLoaded;

  /// Returns [true] if JS library is successfully loaded.
  static bool get isSuccessfullyLoaded =>
      _load.isLoaded && _load.loadSuccessful!;

  static JSFunction? _moment;

  /// Loads Moment JS library.
  static Future<bool> load() {
    return _load.load(() async {
      var jsFile = ENABLE_MINIFIED
          ? 'moment-with-locales.min.js'
          : 'moment-with-locales.js';
      var jsFullPath = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/$PATH_JS/$jsFile';

      var okJS = await AMDJS.require(
        'moment',
        jsFullPath: jsFullPath,
        globalJSVariableName: 'moment',
      );

      _moment = globalContext['moment'] as JSFunction?;

      var okMoment = _moment != null;

      return okJS && okMoment;
    });
  }

  /// Sets the locale of [Moment].
  ///
  /// Returns `false` if [locale] is empty or if [Moment] is not loaded yet
  /// (it triggers [load]; `await Moment.load()` before calling it).
  static bool locale(String locale) {
    load();

    locale = locale.trim().toLowerCase();
    if (locale.isEmpty) return false;

    locale = locale.replaceFirst('_', '-');

    var moment = _moment;
    if (moment == null) return false;

    moment.callMethod<JSAny?>('locale'.toJS, locale.toJS);
    return true;
  }

  /// Parses a [DateTime] to a moment object.
  static JSObject moment(DateTime dateTime) {
    var dateStr = dateTime.toIso8601String();
    return _moment!.callAsConstructor<JSObject>(dateStr.toJS);
  }

  /// Formats [dateTime] to [format].
  static String? format(DateTime dateTime, Object format) {
    return moment(
      dateTime,
    ).callMethod<JSString?>('format'.toJS, format.toJSDeep)?.toDart;
  }

  static String? jsObjectFormat(JSObject moment, Object format) {
    return moment.callMethod<JSString>('format'.toJS, format.toJSDeep).toDart;
  }

  static int? jsObjectToMillisecondsSinceEpoch(JSObject moment) {
    return moment.callMethod<JSNumber?>('valueOf'.toJS)?.toDartInt;
  }

  static DateTime jsObjectToDateTime(JSObject moment) {
    var time = jsObjectToMillisecondsSinceEpoch(moment)!;
    return DateTime.fromMillisecondsSinceEpoch(time);
  }

  static int? toMomentWeekDay(DateTimeWeekDay? weekDay) {
    if (weekDay == null) return null;

    switch (weekDay) {
      case DateTimeWeekDay.sunday:
        return 0;
      case DateTimeWeekDay.monday:
        return 1;
      case DateTimeWeekDay.tuesday:
        return 2;
      case DateTimeWeekDay.wednesday:
        return 3;
      case DateTimeWeekDay.thursday:
        return 4;
      case DateTimeWeekDay.friday:
        return 5;
      case DateTimeWeekDay.saturday:
        return 6;
    }
  }

  static DateTimeWeekDay toDateTimeWeekDay(int momentWeekDay) {
    switch (momentWeekDay) {
      case 0:
        return DateTimeWeekDay.sunday;
      case 1:
        return DateTimeWeekDay.monday;
      case 2:
        return DateTimeWeekDay.tuesday;
      case 3:
        return DateTimeWeekDay.wednesday;
      case 4:
        return DateTimeWeekDay.thursday;
      case 5:
        return DateTimeWeekDay.friday;
      case 6:
        return DateTimeWeekDay.saturday;
      default:
        throw ArgumentError(
          'Invalid Moment weekDay index. Should be of range 0-6, where Sunday is 0 and Saturday is 6 (Sunday-to-Saturday week).',
        );
    }
  }
}
