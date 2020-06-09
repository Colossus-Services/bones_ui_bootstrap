import 'dart:html';
import 'dart:svg' as dart_svg;

import 'package:bones_ui/bones_ui.dart';
import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:swiss_knife/swiss_knife.dart';

/// Bootstrap icons support.
class BootstrapIcons {
  static final String ICONS_LS = '''
alarm-fill.svg                   box-arrow-up.svg                 collection-play.svg              folder-check.svg                 lock-fill.svg                    skip-start.svg
alarm.svg                        braces.svg                       collection.svg                   folder-fill.svg                  lock.svg                         slash-circle-fill.svg
alt.svg                          briefcase-fill.svg               columns-gap.svg                  folder-minus.svg                 map.svg                          slash-circle.svg
app-indicator.svg                briefcase.svg                    columns.svg                      folder-plus.svg                  mic-fill.svg                     slash-square-fill.svg
app.svg                          brightness-alt-high-fill.svg     command.svg                      folder-symlink-fill.svg          mic-mute-fill.svg                slash-square.svg
archive-fill.svg                 brightness-alt-high.svg          compass.svg                      folder-symlink.svg               mic-mute.svg                     slash.svg
archive.svg                      brightness-alt-low-fill.svg      cone-striped.svg                 folder.svg                       mic.svg                          sliders.svg
arrow-90deg-down.svg             brightness-alt-low.svg           cone.svg                         fonts.svg                        moon.svg                         soundwave.svg
arrow-90deg-left.svg             brightness-high-fill.svg         controller.svg                   forward-fill.svg                 music-note-beamed.svg            speaker.svg
arrow-90deg-right.svg            brightness-high.svg              credit-card.svg                  forward.svg                      music-note-list.svg              square-fill.svg
arrow-90deg-up.svg               brightness-low-fill.svg          crop.svg                         fullscreen-exit.svg              music-note.svg                   square-half.svg
arrow-bar-down.svg               brightness-low.svg               cursor-fill.svg                  fullscreen.svg                   music-player-fill.svg            square.svg
arrow-bar-left.svg               brush.svg                        cursor-text.svg                  funnel-fill.svg                  music-player.svg                 star-fill.svg
arrow-bar-right.svg              bucket-fill.svg                  cursor.svg                       funnel.svg                       newspaper.svg                    star-half.svg
arrow-bar-up.svg                 bucket.svg                       dash-circle-fill.svg             gear-fill.svg                    octagon-fill.svg                 star.svg
arrow-clockwise.svg              building.svg                     dash-circle.svg                  gear-wide-connected.svg          octagon-half.svg                 stop-fill.svg
arrow-counterclockwise.svg       bullseye.svg                     dash-square-fill.svg             gear-wide.svg                    octagon.svg                      stop.svg
arrow-down-left.svg              calendar-fill.svg                dash-square.svg                  gear.svg                         option.svg                       stopwatch-fill.svg
arrow-down-right.svg             calendar.svg                     dash.svg                         gem.svg                          outlet.svg                       stopwatch.svg
arrow-down-short.svg             camera-video-fill.svg            diamond-fill.svg                 geo-alt.svg                      paperclip.svg                    subtract.svg
arrow-down.svg                   camera-video.svg                 diamond-half.svg                 geo.svg                          pause-fill.svg                   sun.svg
arrow-left-right.svg             camera.svg                       diamond.svg                      gift-fill.svg                    pause.svg                        table.svg
arrow-left-short.svg             capslock-fill.svg                display-fill.svg                 gift.svg                         pen.svg                          tablet-landscape.svg
arrow-left.svg                   capslock.svg                     display.svg                      graph-down.svg                   pencil-square.svg                tablet.svg
arrow-repeat.svg                 card-checklist.svg               dot.svg                          graph-up.svg                     pencil.svg                       tag-fill.svg
arrow-return-left.svg            card-heading.svg                 download.svg                     grid-1x2-fill.svg                pentagon-fill.svg                tag.svg
arrow-return-right.svg           card-image.svg                   droplet-fill.svg                 grid-1x2.svg                     pentagon-half.svg                terminal-fill.svg
arrow-right-short.svg            card-list.svg                    droplet-half.svg                 grid-3x2-gap-fill.svg            pentagon.svg                     terminal.svg
arrow-right.svg                  card-text.svg                    droplet.svg                      grid-3x2-gap.svg                 people-circle.svg                text-center.svg
arrow-up-down.svg                caret-down-fill.svg              egg-fill.svg                     grid-3x2.svg                     people-fill.svg                  text-indent-left.svg
arrow-up-left.svg                caret-down.svg                   egg-fried.svg                    grid-3x3-gap-fill.svg            people.svg                       text-indent-right.svg
arrow-up-right.svg               caret-left-fill.svg              egg.svg                          grid-3x3-gap.svg                 person-bounding-box.svg          text-left.svg
arrow-up-short.svg               caret-left.svg                   eject-fill.svg                   grid-3x3.svg                     person-check-fill.svg            text-right.svg
arrow-up.svg                     caret-right-fill.svg             eject.svg                        grid-fill.svg                    person-check.svg                 textarea-t.svg
arrows-angle-contract.svg        caret-right.svg                  envelope-fill.svg                grid.svg                         person-dash-fill.svg             textarea.svg
arrows-angle-expand.svg          caret-up-fill.svg                envelope-open-fill.svg           hammer.svg                       person-dash.svg                  three-dots-vertical.svg
arrows-collapse.svg              caret-up.svg                     envelope-open.svg                hash.svg                         person-fill.svg                  three-dots.svg
arrows-expand.svg                chat-dots-fill.svg               envelope.svg                     heart-fill.svg                   person-lines-fill.svg            toggle-off.svg
arrows-fullscreen.svg            chat-dots.svg                    exclamation-circle-fill.svg      heart-half.svg                   person-plus-fill.svg             toggle-on.svg
arrows-move.svg                  chat-fill.svg                    exclamation-circle.svg           heart.svg                        person-plus.svg                  toggles.svg
aspect-ratio-fill.svg            chat-quote-fill.svg              exclamation-diamond-fill.svg     house-door-fill.svg              person-square.svg                tools.svg
aspect-ratio.svg                 chat-quote.svg                   exclamation-diamond.svg          house-door.svg                   person.svg                       trash-fill.svg
at.svg                           chat-square-dots-fill.svg        exclamation-octagon-fill.svg     house-fill.svg                   phone-landscape.svg              trash.svg
award-fill.svg                   chat-square-dots.svg             exclamation-octagon.svg          house.svg                        phone.svg                        trash2-fill.svg
award.svg                        chat-square-fill.svg             exclamation-square-fill.svg      hr.svg                           pie-chart-fill.svg               trash2.svg
backspace-fill.svg               chat-square-quote-fill.svg       exclamation-square.svg           image-alt.svg                    pie-chart.svg                    triangle-fill.svg
backspace-reverse-fill.svg       chat-square-quote.svg            exclamation-triangle-fill.svg    image-fill.svg                   pip-fill.svg                     triangle-half.svg
backspace-reverse.svg            chat-square.svg                  exclamation-triangle.svg         image.svg                        pip.svg                          triangle.svg
backspace.svg                    chat.svg                         exclamation.svg                  images.svg                       play-fill.svg                    trophy.svg
bag-fill.svg                     check-all.svg                    exclude.svg                      inbox-fill.svg                   play.svg                         tv-fill.svg
bag.svg                          check-box.svg                    eye-fill.svg                     inbox.svg                        plug.svg                         tv.svg
bar-chart-fill.svg               check-circle.svg                 eye-slash-fill.svg               inboxes-fill.svg                 plus-circle-fill.svg             type-bold.svg
bar-chart.svg                    check.svg                        eye-slash.svg                    inboxes.svg                      plus-circle.svg                  type-h1.svg
battery-charging.svg             chevron-bar-contract.svg         eye.svg                          info-circle-fill.svg             plus-square-fill.svg             type-h2.svg
battery-full.svg                 chevron-bar-down.svg             file-arrow-down.svg              info-circle.svg                  plus-square.svg                  type-h3.svg
battery-half.svg                 chevron-bar-expand.svg           file-arrow-up.svg                info-square-fill.svg             plus.svg                         type-italic.svg
battery.svg                      chevron-bar-left.svg             file-break.svg                   info-square.svg                  power.svg                        type-strikethrough.svg
bell-fill.svg                    chevron-bar-right.svg            file-check.svg                   info.svg                         puzzle-fill.svg                  type-underline.svg
bell.svg                         chevron-bar-up.svg               file-code.svg                    intersect.svg                    puzzle.svg                       type.svg
blockquote-left.svg              chevron-compact-down.svg         file-diff.svg                    justify-left.svg                 question-circle-fill.svg         union.svg
blockquote-right.svg             chevron-compact-left.svg         file-earmark-arrow-down.svg      justify-right.svg                question-circle.svg              unlock-fill.svg
book-half.svg                    chevron-compact-right.svg        file-earmark-arrow-up.svg        justify.svg                      question-diamond-fill.svg        unlock.svg
book.svg                         chevron-compact-up.svg           file-earmark-break.svg           kanban-fill.svg                  question-diamond.svg             upload.svg
bookmark-check.svg               chevron-contract.svg             file-earmark-check.svg           kanban.svg                       question-octagon-fill.svg        view-list.svg
bookmark-dash.svg                chevron-double-down.svg          file-earmark-code.svg            laptop.svg                       question-octagon.svg             view-stacked.svg
bookmark-fill.svg                chevron-double-left.svg          file-earmark-diff.svg            layers-fill.svg                  question-square-fill.svg         volume-down-fill.svg
bookmark-plus.svg                chevron-double-right.svg         file-earmark-minus.svg           layers-half.svg                  question-square.svg              volume-down.svg
bookmark.svg                     chevron-double-up.svg            file-earmark-plus.svg            layers.svg                       question.svg                     volume-mute-fill.svg
bookmarks-fill.svg               chevron-down.svg                 file-earmark-ruled.svg           layout-sidebar-inset-reverse.svg reply-all-fill.svg               volume-mute.svg
bookmarks.svg                    chevron-expand.svg               file-earmark-spreadsheet.svg     layout-sidebar-inset.svg         reply-all.svg                    volume-up-fill.svg
bootstrap-fill.svg               chevron-left.svg                 file-earmark-text.svg            layout-sidebar-reverse.svg       reply-fill.svg                   volume-up.svg
bootstrap-reboot.svg             chevron-right.svg                file-earmark-zip.svg             layout-sidebar.svg               reply.svg                        vr.svg
bootstrap.svg                    chevron-up.svg                   file-earmark.svg                 layout-split.svg                 screwdriver.svg                  wallet.svg
bounding-box-circles.svg         circle-fill.svg                  file-minus.svg                   layout-text-sidebar-reverse.svg  search.svg                       watch.svg
bounding-box.svg                 circle-half.svg                  file-plus.svg                    layout-text-sidebar.svg          server.svg                       wifi.svg
box-arrow-down-left.svg          circle-square.svg                file-post.svg                    layout-text-window-reverse.svg   shield-fill.svg                  window.svg
box-arrow-down-right.svg         circle.svg                       file-richtext.svg                layout-text-window.svg           shield-lock-fill.svg             wrench.svg
box-arrow-down.svg               clipboard-data.svg               file-ruled.svg                   layout-three-columns.svg         shield-lock.svg                  x-circle-fill.svg
box-arrow-in-down-left.svg       clipboard.svg                    file-spreadsheet.svg             layout-wtf.svg                   shield-shaded.svg                x-circle.svg
box-arrow-in-down-right.svg      clock-fill.svg                   file-text.svg                    life-preserver.svg               shield.svg                       x-diamond-fill.svg
box-arrow-in-down.svg            clock-history.svg                file-zip.svg                     lightning-fill.svg               shift-fill.svg                   x-diamond.svg
box-arrow-in-left.svg            clock.svg                        file.svg                         lightning.svg                    shift.svg                        x-octagon-fill.svg
box-arrow-in-right.svg           cloud-download.svg               files-alt.svg                    link-45deg.svg                   shuffle.svg                      x-octagon.svg
box-arrow-in-up-left.svg         cloud-fill.svg                   files.svg                        link.svg                         skip-backward-fill.svg           x-square-fill.svg
box-arrow-in-up-right.svg        cloud-upload.svg                 film.svg                         list-check.svg                   skip-backward.svg                x-square.svg
box-arrow-in-up.svg              cloud.svg                        filter-left.svg                  list-nested.svg                  skip-end-fill.svg                x.svg
box-arrow-left.svg               code-slash.svg                   filter-right.svg                 list-ol.svg                      skip-end.svg
box-arrow-right.svg              code.svg                         filter.svg                       list-task.svg                    skip-forward-fill.svg
box-arrow-up-left.svg            collection-fill.svg              flag-fill.svg                    list-ul.svg                      skip-forward.svg
box-arrow-up-right.svg           collection-play-fill.svg         flag.svg                         list.svg                         skip-start-fill.svg
''';

  static final List<String> _icons = ICONS_LS
      .split(RegExp(r'\s+'))
      .where((s) => s.isNotEmpty)
      .map((s) => s.replaceFirst('.svg', ''))
      .toList();

  static final Set<String> _iconsSet = Set.from(_icons);

  static final String ICONS_PATH = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/icons';

  static List<String> get allIcons => List.from(_icons);

  /// Returns the path of a icon with [name].
  static String getIconPath(String name) {
    if (name == null) return null;
    name = name.toLowerCase().trim();
    if (name.isEmpty) return null;

    if (name.endsWith('.svg')) {
      name = name.substring(0, name.length - 4);
    }

    if (!_iconsSet.contains(name)) return null;

    var path = '$ICONS_PATH/$name.svg';
    return path;
  }

  /// Returns the HTML of a SVG icon with [name].
  static String svgIconHTML(String name,
      {String title, int width, int height, String classes, String style}) {
    var path = getIconPath(name);
    if (path == null) return null;

    var html = '<img src="$path"';

    if (width != null) {
      html += ' width=$width';
    }

    if (height != null) {
      html += ' height=$height';
    }

    if (title != null && title.isNotEmpty) {
      html += ' title="$title"';
    }

    if (classes != null && classes.isNotEmpty) {
      html += ' class="$classes"';
    }

    if (style != null && style.isNotEmpty) {
      html += ' style="$style"';
    }

    html += '>';

    return html;
  }

  /// Returns an [Element] of a SVG icon with [name].
  static Element svgIconElement(String name,
      {String title, int width, int height, String classes, String style}) {
    var iconHTML = svgIconHTML(name,
        title: title,
        width: width,
        height: height,
        classes: classes,
        style: style);
    return createHTML(iconHTML);
  }

  static final ResourceContentCache _resourceContentCache =
      ResourceContentCache();

  /// Returns a [ResourceContent] for the icon with [name].
  static ResourceContent svgResourceContent(String name) {
    var path = getIconPath(name);
    if (path == null) return null;
    return _resourceContentCache.get(path);
  }
}

/// Component to show a SVG.
class UISVG extends UIComponent {
  static final ResourceContentCache _resourceContentCache =
      ResourceContentCache();

  /// Source for the SVG.
  final String src;

  /// Width of the SVG.
  final String width;

  /// Height of the SVG.
  final String height;

  /// Title of the SVG.
  final String title;

  /// Color to render the SVG.
  final String color;

  UISVG(Element parent, this.src,
      {this.width, this.height, this.title, this.color, String classes})
      : super(parent, classes: classes);

  Element _renderedElement;

  /// Returns the [Element] rendered.
  Element get renderedElement => _renderedElement;

  /// Returns [true] if it was rendered as an [ImageElement].
  bool get isRenderedAsImage => _renderedElement is ImageElement;

  /// Returns [true] if it was rendered as an [SvgElement].
  bool get isRenderedAsSVG => _renderedElement is dart_svg.SvgElement;

  @override
  dynamic render() {
    if (src == null || src.isEmpty) return null;

    var resourceContent = _resourceContentCache.get(src);

    Element element;

    if (resourceContent.isLoaded) {
      var content = resourceContent.getContentIfLoaded();
      var svg = _buildSVG(content);
      element = svg;
    } else {
      resourceContent.onLoad.listen((_) => refresh());
      resourceContent.getContent();
      element = _buildImg();
    }

    _renderedElement = element;

    return element;
  }

  dart_svg.SvgElement _buildSVG(String content) {
    var svg = createHTML(content) as dart_svg.SvgElement;

    _applyDimension(svg);

    if (color != null && color.isNotEmpty) {
      svg.style.cssText += 'fill: $color';
    }

    if (title != null && title.isNotEmpty) {
      svg.setAttribute('data-toggle', 'tooltip');
      svg.setAttribute('title', title);
    }

    return svg;
  }

  ImageElement _buildImg() {
    var img = ImageElement(src: src);

    _applyDimension(img);

    if (title != null && title.isNotEmpty) img.title = title;

    return img;
  }

  void _applyDimension(Element elem) {
    elem.removeAttribute('width');
    elem.removeAttribute('height');

    if (width != null && width.isNotEmpty) {
      elem.style.width = _parseDimension(width);
    }
    if (height != null && height.isNotEmpty) {
      elem.style.height = _parseDimension(height);
    }
  }

  String _parseDimension(String s) {
    if (isInt(s)) return '${s}px';
    return s;
  }
}
