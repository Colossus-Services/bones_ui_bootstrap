import 'dart:collection';
import 'dart:html';
import 'dart:js';

import 'package:bones_ui/bones_ui.dart';
import 'package:dom_tools/dom_tools.dart';
import 'package:intl_messages/intl_messages.dart';
import 'package:swiss_knife/swiss_knife.dart';

import '../bones_ui_bootstrap_base.dart';
import '../bones_ui_bootstrap_icons.dart';

/// Format of time picker for [BSDateRangePicker].
enum TimePicker {
  none,
  hoursMinutes,
  hoursMinutesBy5,
  hoursMinutesBy10,
  hoursMinutesBy15,
  hoursMinutesBy30,
}

/// Bootstrap Date Range Picker component.
class BSDateRangePicker extends UIComponent implements UIField<Pair<DateTime>> {
  static final LoadController _load = LoadController('BSDateRangePicker');

  /// Loads [BSDateRangePicker] component and related JS libraries and CSS.
  static void load() {
    _load.load(() async {
      var ok1 = await JQuery.load();
      var ok2 = await Moment.load();
      var ok3 = await Bootstrap.load();

      var ok5 = await addCssSource(
          'packages/bones_ui_bootstrap/components/daterangepicker/daterangepicker.css');
      var ok4 = await addJavaScriptSource(
          'packages/bones_ui_bootstrap/components/daterangepicker/daterangepicker.js');

      var allOk = ok1 && ok2 && ok3 && ok4 && ok5;
      return allOk;
    });
  }

  static DateTime _resolveDateTime(
      DateTime? time, DateRangeType? rangeType, bool start) {
    if (rangeType != null) {
      var now = time ?? DateTime.now();
      var dateTimeRange = getDateTimeRange(rangeType, now);
      return start ? dateTimeRange.a : dateTimeRange.b;
    } else if (time == null) {
      var now = time ?? DateTime.now();
      return start ? getDateTimeDayStart(now) : getDateTimeDayEnd(now);
    } else {
      return time;
    }
  }

  @override
  final String fieldName;

  /// The time picker format. Default: [TimePicker.none]
  final TimePicker timePicker;

  /// If [true shows a summaru of selected date range in input text. Default: [true]
  final bool showDateTextTitle;

  final List<DateRangeType> _rangesTypes;

  DateTime _startTime;

  DateTime _endTime;

  HashMap<String, List<int>>? _dateRanges;

  final DateRangeType? initialRangeType;

  BSDateRangePicker(super.parent,
      {this.fieldName = 'date-range-picker',
      TimePicker? timePicker,
      this.showDateTextTitle = true,
      List<DateRangeType>? rangesTypes,
      this.initialRangeType,
      DateTime? startTime,
      DateTime? endTime,
      super.classes,
      super.style})
      : timePicker = timePicker ?? TimePicker.none,
        _rangesTypes = LinkedHashSet.from(rangesTypes ?? []).toList().cast(),
        _startTime = _resolveDateTime(startTime, initialRangeType, true),
        _endTime = _resolveDateTime(endTime, initialRangeType, false),
        super(classes2: 'ui-bs-date-range-picker');

  /// Returns [true] if time picker is present.
  bool get hasTimePicker => timePicker != TimePicker.none;

  /// Returns the start time of selected date range.
  DateTime get startTime => _startTime;

  /// Returns the end time of selected date range.
  DateTime get endTime => _endTime;

  /// Returns a [Pair<DateTime>] of selected date range.
  Pair<DateTime> get dateTimeRange => Pair(_startTime, _endTime);

  @override
  Pair<DateTime> getFieldValue() => dateTimeRange;

  @override
  void setFieldValue(Pair<DateTime>? value) {
    value ??= Pair(
      _resolveDateTime(null, initialRangeType, true),
      _resolveDateTime(null, initialRangeType, false),
    );

    _startTime = value.a;
    _endTime = value.b;
  }

  @override
  void configure() {
    load();
    _load.onLoad.listen((_) => refresh());
  }

  Element? _icon;

  Element? _textElement;

  @override
  dynamic render() {
    if (_load.isNotLoaded) return '...';

    if (_icon != null) {
      _icon!.remove();
    }

    if (_textElement != null) {
      _textElement!.remove();
    }

    _icon = BootstrapIcons.svgIconElement('calendar');

    _textElement = createHTML('''
      <div class="form-control" style="max-width: 80vw; white-space: nowrap; text-overflow: ellipsis;"></div>
    ''');

    _textElement!.children.add(_icon!);

    _configureLocale();
    _buildDateRanges();
    _configureDatePicker();

    return _textElement;
  }

  int? _getTimePickerMinutesInterval() {
    switch (timePicker) {
      case TimePicker.hoursMinutes:
        return 1;
      case TimePicker.hoursMinutesBy5:
        return 5;
      case TimePicker.hoursMinutesBy10:
        return 10;
      case TimePicker.hoursMinutesBy15:
        return 15;
      case TimePicker.hoursMinutesBy30:
        return 30;
      default:
        return null;
    }
  }

  /// Returns the 1st day of the week for the defined [_locale].
  DateTimeWeekDay? get weekFirstDay => forceWeekFirstDay ?? _localeWeekFirstDay;

  /// The 1st day of week to use (forced).
  DateTimeWeekDay? forceWeekFirstDay;

  /// Defined locale for the component and [Moment].
  IntlLocale? _locale;

  DateTimeWeekDay? _localeWeekFirstDay;

  late bool _localeUsesAMPM;

  void _configureLocale() {
    _locale = IntlLocale.getDefaultIntlLocale();
    Moment.locale(_locale!.code);

    _localeWeekFirstDay = getFirstDayOfWeek(_locale);
    _localeUsesAMPM = getTimeFormatUsesAMPM(_locale);
  }

  Map<DateRangeType, Pair<DateTime>>? _rangesTypesDateTimeRange;

  void _buildDateRanges() {
    var now = DateTime.now();

    var rangesTypesDateTimeRange = HashMap<DateRangeType, Pair<DateTime>>();
    var dateRanges = HashMap<String, List<int>>();

    for (var dateRangeType in _rangesTypes) {
      var dateTimeRange = getDateTimeRange(dateRangeType, now, weekFirstDay);
      rangesTypesDateTimeRange[dateRangeType] = dateTimeRange;

      var dateRangeTypeTitle =
          toUpperCaseInitials(getDateRangeTypeTitle(dateRangeType)!);
      dateRanges[dateRangeTypeTitle] = [
        dateTimeRange.a.millisecondsSinceEpoch,
        dateTimeRange.b.millisecondsSinceEpoch
      ];
    }

    _rangesTypesDateTimeRange = rangesTypesDateTimeRange;
    _dateRanges = dateRanges;
  }

  void _configureDatePicker() {
    var momentWeekDay = Moment.toMomentWeekDay(weekFirstDay);

    var configLocale = <String, dynamic>{
      'applyLabel': IntlBasicDictionary.msgUpperCaseInitials('apply'),
      'cancelLabel': IntlBasicDictionary.msgUpperCaseInitials('cancel'),
      'customRangeLabel': IntlBasicDictionary.msgUpperCaseInitials('custom'),
      'firstDay': momentWeekDay
    };

    var jsStartTime = Moment.moment(_startTime);
    var jsEndTime = Moment.moment(_endTime);

    var config = <String, dynamic>{
      'startDate': jsStartTime,
      'endDate': jsEndTime,
      'timePicker': hasTimePicker,
      if (hasTimePicker) 'timePicker24Hour': !_localeUsesAMPM,
      if (hasTimePicker) 'timePickerIncrement': _getTimePickerMinutesInterval(),
      if (_dateRanges!.isNotEmpty) 'ranges': _dateRanges,
      if (configLocale.isNotEmpty) 'locale': configLocale
    };

    print(config);

    JQuery.$(_textElement).call('daterangepicker',
        [JsObject.jsify(config), ([a, b, c]) => _setDateRange(a, b)]);

    _updateTextElement();
  }

  void _setDateRange(JsObject jsStartTime, JsObject jsEndTime) {
    setDateRange(Moment.jsObjectToDateTime(jsStartTime),
        Moment.jsObjectToDateTime(jsEndTime));
  }

  /// Sets the selected date range by [dateRangeType].
  void setDateRangeByType(DateRangeType dateRangeType) {
    var range = _rangesTypesDateTimeRange != null
        ? _rangesTypesDateTimeRange![dateRangeType]
        : null;
    range ??= getDateTimeRange(dateRangeType, DateTime.now(), weekFirstDay);

    setDateRange(range.a, range.b);
  }

  /// Sets the selected date range.
  ///
  /// [startTime] The start date of selected range.
  /// [endTime] The end date of selected range.
  void setDateRange(DateTime startTime, DateTime endTime) {
    startTime = _ensureSeconds(startTime, 0, 0);
    endTime = _ensureSeconds(endTime, 59, 999);

    _startTime = startTime;
    _endTime = endTime;

    print('Selected Date Range:  $startTime  >>  $endTime');

    _updateTextElement();

    onChange.add(this);
  }

  DateTime _ensureSeconds(DateTime d, int seconds, int millisecond) => DateTime(
      d.year, d.month, d.day, d.hour, d.minute, seconds, millisecond, 0);

  void _updateTextElement() {
    if (_textElement == null) return;

    var text = dateText;

    _textElement!.children.clear();

    _textElement!.children.add(createSpan(text));

    _icon!.style.paddingLeft = '10px';
    _textElement!.children.add(_icon!);
  }

  String get dateText => _getDateText(_startTime, _endTime);

  String _getDateText(DateTime startTime, DateTime endTime) {
    var dateText = _buildDateText(startTime, endTime);

    var dateRangeTitle =
        showDateTextTitle ? _buildDateTextTitle(startTime, endTime) : null;

    if (dateRangeTitle != null && dateRangeTitle.isNotEmpty) {
      dateText = '$dateRangeTitle ($dateText)';
    }

    return dateText;
  }

  String _buildDateText(DateTime startTime, DateTime endTime) {
    return formatDateRangeText(startTime, endTime, hasTimePicker, _locale);
  }

  String? _buildDateTextTitle(DateTime startTime, DateTime endTime) {
    if (_dateRanges == null) return null;

    var startMillis = startTime.millisecondsSinceEpoch;
    var endMillis = endTime.millisecondsSinceEpoch;

    for (var entry in _dateRanges!.entries) {
      var rangeInit = entry.value[0];
      var rangeEnd = entry.value[1];

      if (startMillis == rangeInit && endMillis == rangeEnd) {
        return entry.key;
      }
    }

    return null;
  }
}
