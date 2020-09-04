import 'dart:html';

import 'package:bones_ui/bones_ui.dart';
import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:swiss_knife/swiss_knife.dart';

/// Bootstrap icons support.
class BootstrapIcons {
  static final String ICONS_LS = '''
alarm-fill.svg calendar-week-fill.svg dice-2-fill.svg grid-fill.svg question-octagon.svg alarm.svg calendar-week.svg
dice-2.svg grid.svg question-square-fill.svg align-bottom.svg calendar-x-fill.svg dice-3-fill.svg grip-horizontal.svg
question-square.svg align-center.svg calendar-x.svg dice-3.svg grip-vertical.svg question.svg align-end.svg
calendar.svg dice-4-fill.svg hammer.svg receipt-cutoff.svg align-middle.svg calendar2-check-fill.svg dice-4.svg
hand-index-thumb.svg receipt.svg align-start.svg calendar2-check.svg dice-5-fill.svg hand-index.svg reception-0.svg
align-top.svg calendar2-date-fill.svg dice-5.svg hand-thumbs-down.svg reception-1.svg alt.svg calendar2-date.svg
dice-6-fill.svg hand-thumbs-up.svg reception-2.svg app-indicator.svg calendar2-day-fill.svg dice-6.svg handbag-fill.svg
reception-3.svg app.svg calendar2-day.svg display-fill.svg handbag.svg reception-4.svg archive-fill.svg
calendar2-event-fill.svg display.svg hash.svg reply-all-fill.svg archive.svg calendar2-event.svg
distribute-horizontal.svg hdd-fill.svg reply-all.svg arrow-90deg-down.svg calendar2-fill.svg distribute-vertical.svg
hdd-network-fill.svg reply-fill.svg arrow-90deg-left.svg calendar2-minus-fill.svg door-closed-fill.svg hdd-network.svg
reply.svg arrow-90deg-right.svg calendar2-minus.svg door-closed.svg hdd-rack-fill.svg rss-fill.svg arrow-90deg-up.svg
calendar2-month-fill.svg door-open-fill.svg hdd-rack.svg rss.svg arrow-bar-down.svg calendar2-month.svg door-open.svg
hdd-stack-fill.svg scissors.svg arrow-bar-left.svg calendar2-plus-fill.svg dot.svg hdd-stack.svg screwdriver.svg
arrow-bar-right.svg calendar2-plus.svg download.svg hdd.svg search.svg arrow-bar-up.svg calendar2-range-fill.svg
droplet-fill.svg headphones.svg segmented-nav.svg arrow-clockwise.svg calendar2-range.svg droplet-half.svg headset.svg
server.svg arrow-counterclockwise.svg calendar2-week-fill.svg droplet.svg heart-fill.svg share-fill.svg
arrow-down-circle-fill.svg calendar2-week.svg earbuds.svg heart-half.svg share.svg arrow-down-circle.svg
calendar2-x-fill.svg easel-fill.svg heart.svg shield-check.svg arrow-down-left-circle-fill.svg calendar2-x.svg
easel.svg heptagon-fill.svg shield-exclamation.svg arrow-down-left-circle.svg calendar2.svg egg-fill.svg
heptagon-half.svg shield-fill-check.svg arrow-down-left-square-fill.svg calendar3-event-fill.svg egg-fried.svg
heptagon.svg shield-fill-exclamation.svg arrow-down-left-square.svg calendar3-event.svg egg.svg hexagon-fill.svg
shield-fill-minus.svg arrow-down-left.svg calendar3-fill.svg eject-fill.svg hexagon-half.svg shield-fill-plus.svg
arrow-down-right-circle-fill.svg calendar3-range-fill.svg eject.svg hexagon.svg shield-fill-x.svg
arrow-down-right-circle.svg calendar3-range.svg emoji-angry.svg hourglass-bottom.svg shield-fill.svg
arrow-down-right-square-fill.svg calendar3-week-fill.svg emoji-dizzy.svg hourglass-split.svg shield-lock-fill.svg
arrow-down-right-square.svg calendar3-week.svg emoji-expressionless.svg hourglass-top.svg shield-lock.svg
arrow-down-right.svg calendar3.svg emoji-frown.svg hourglass.svg shield-minus.svg arrow-down-short.svg
calendar4-event.svg emoji-laughing.svg house-door-fill.svg shield-plus.svg arrow-down-square-fill.svg
calendar4-range.svg emoji-neutral.svg house-door.svg shield-shaded.svg arrow-down-square.svg calendar4-week.svg
emoji-smile-upside-down.svg house-fill.svg shield-slash-fill.svg arrow-down-up.svg calendar4.svg emoji-smile.svg
house.svg shield-slash.svg arrow-down.svg camera-fill.svg emoji-sunglasses.svg hr.svg shield-x.svg
arrow-left-circle-fill.svg camera-reels-fill.svg envelope-fill.svg image-alt.svg shield.svg arrow-left-circle.svg
camera-reels.svg envelope-open-fill.svg image-fill.svg shift-fill.svg arrow-left-right.svg camera-video-fill.svg
envelope-open.svg image.svg shift.svg arrow-left-short.svg camera-video-off-fill.svg envelope.svg images.svg
shop-window.svg arrow-left-square-fill.svg camera-video-off.svg exclamation-circle-fill.svg inbox-fill.svg shop.svg
arrow-left-square.svg camera-video.svg exclamation-circle.svg inbox.svg shuffle.svg arrow-left.svg camera.svg
exclamation-diamond-fill.svg inboxes-fill.svg signpost-2-fill.svg arrow-repeat.svg camera2.svg exclamation-diamond.svg
inboxes.svg signpost-2.svg arrow-return-left.svg capslock-fill.svg exclamation-octagon-fill.svg info-circle-fill.svg
signpost-fill.svg arrow-return-right.svg capslock.svg exclamation-octagon.svg info-circle.svg signpost-split-fill.svg
arrow-right-circle-fill.svg card-checklist.svg exclamation-square-fill.svg info-square-fill.svg signpost-split.svg
arrow-right-circle.svg card-heading.svg exclamation-square.svg info-square.svg signpost.svg arrow-right-short.svg
card-image.svg exclamation-triangle-fill.svg info.svg sim-fill.svg arrow-right-square-fill.svg card-list.svg
exclamation-triangle.svg input-cursor-text.svg sim.svg arrow-right-square.svg card-text.svg exclamation.svg
input-cursor.svg skip-backward-fill.svg arrow-right.svg caret-down-fill.svg exclude.svg intersect.svg skip-backward.svg
arrow-up-circle-fill.svg caret-down-square-fill.svg eye-fill.svg journal-album.svg skip-end-fill.svg
arrow-up-circle.svg caret-down-square.svg eye-slash-fill.svg journal-arrow-down.svg skip-end.svg arrow-up-down.svg
caret-down.svg eye-slash.svg journal-arrow-up.svg skip-forward-fill.svg arrow-up-left-circle-fill.svg
caret-left-fill.svg eye.svg journal-check.svg skip-forward.svg arrow-up-left-circle.svg caret-left-square-fill.svg
eyeglasses.svg journal-code.svg skip-start-fill.svg arrow-up-left-square-fill.svg caret-left-square.svg
file-arrow-down-fill.svg journal-medical.svg skip-start.svg arrow-up-left-square.svg caret-left.svg file-arrow-down.svg
journal-minus.svg slash-circle-fill.svg arrow-up-left.svg caret-right-fill.svg file-arrow-up-fill.svg journal-plus.svg
slash-circle.svg arrow-up-right-circle-fill.svg caret-right-square-fill.svg file-arrow-up.svg journal-richtext.svg
slash-square-fill.svg arrow-up-right-circle.svg caret-right-square.svg file-binary-fill.svg journal-text.svg
slash-square.svg arrow-up-right-square-fill.svg caret-right.svg file-binary.svg journal-x.svg slash.svg
arrow-up-right-square.svg caret-up-fill.svg file-break-fill.svg journal.svg sliders.svg arrow-up-right.svg
caret-up-square-fill.svg file-break.svg journals.svg smartwatch.svg arrow-up-short.svg caret-up-square.svg
file-check-fill.svg joystick.svg sort-alpha-down-alt.svg arrow-up-square-fill.svg caret-up.svg file-check.svg
justify-left.svg sort-alpha-down.svg arrow-up-square.svg cart-check-fill.svg file-code-fill.svg justify-right.svg
sort-alpha-up-alt.svg arrow-up.svg cart-check.svg file-code.svg justify.svg sort-alpha-up.svg arrows-angle-contract.svg
cart-dash-fill.svg file-diff-fill.svg kanban-fill.svg sort-down-alt.svg arrows-angle-expand.svg cart-dash.svg
file-diff.svg kanban.svg sort-down.svg arrows-collapse.svg cart-fill.svg file-earmark-arrow-down-fill.svg key-fill.svg
sort-numeric-down-alt.svg arrows-expand.svg cart-plus-fill.svg file-earmark-arrow-down.svg key.svg
sort-numeric-down.svg arrows-fullscreen.svg cart-plus.svg file-earmark-arrow-up-fill.svg keyboard-fill.svg
sort-numeric-up-alt.svg arrows-move.svg cart-x-fill.svg file-earmark-arrow-up.svg keyboard.svg sort-numeric-up.svg
aspect-ratio-fill.svg cart-x.svg file-earmark-binary-fill.svg ladder.svg sort-up-alt.svg aspect-ratio.svg cart.svg
file-earmark-binary.svg lamp-fill.svg sort-up.svg asterisk.svg cart2.svg file-earmark-break-fill.svg lamp.svg
soundwave.svg at.svg cart3.svg file-earmark-break.svg laptop-fill.svg speaker-fill.svg award-fill.svg cart4.svg
file-earmark-check-fill.svg laptop.svg speaker.svg award.svg cash-stack.svg file-earmark-check.svg layers-fill.svg
spellcheck.svg back.svg cash.svg file-earmark-code-fill.svg layers-half.svg square-fill.svg backspace-fill.svg cast.svg
file-earmark-code.svg layers.svg square-half.svg backspace-reverse-fill.svg chat-dots-fill.svg
file-earmark-diff-fill.svg layout-sidebar-inset-reverse.svg square.svg backspace-reverse.svg chat-dots.svg
file-earmark-diff.svg layout-sidebar-inset.svg star-fill.svg backspace.svg chat-fill.svg file-earmark-easel-fill.svg
layout-sidebar-reverse.svg star-half.svg badge-4k-fill.svg chat-left-dots-fill.svg file-earmark-easel.svg
layout-sidebar.svg star.svg badge-4k.svg chat-left-dots.svg file-earmark-fill.svg layout-split.svg stickies-fill.svg
badge-8k-fill.svg chat-left-fill.svg file-earmark-font-fill.svg layout-text-sidebar-reverse.svg stickies.svg
badge-8k.svg chat-left-quote-fill.svg file-earmark-font.svg layout-text-sidebar.svg sticky-fill.svg badge-ad-fill.svg
chat-left-quote.svg file-earmark-image-fill.svg layout-text-window-reverse.svg sticky.svg badge-ad.svg
chat-left-text-fill.svg file-earmark-image.svg layout-text-window.svg stop-fill.svg badge-cc-fill.svg
chat-left-text.svg file-earmark-lock-fill.svg layout-three-columns.svg stop.svg badge-cc.svg chat-left.svg
file-earmark-lock.svg layout-wtf.svg stoplights-fill.svg badge-hd-fill.svg chat-quote-fill.svg
file-earmark-lock2-fill.svg life-preserver.svg stoplights.svg badge-hd.svg chat-quote.svg file-earmark-lock2.svg
lightning-fill.svg stopwatch-fill.svg badge-tm-fill.svg chat-right-dots-fill.svg file-earmark-medical-fill.svg
lightning.svg stopwatch.svg badge-tm.svg chat-right-dots.svg file-earmark-medical.svg link-45deg.svg subtract.svg
badge-vo-fill.svg chat-right-fill.svg file-earmark-minus-fill.svg link.svg suit-club-fill.svg badge-vo.svg
chat-right-quote-fill.svg file-earmark-minus.svg list-check.svg suit-club.svg bag-check-fill.svg chat-right-quote.svg
file-earmark-music-fill.svg list-nested.svg suit-diamond-fill.svg bag-check.svg chat-right-text-fill.svg
file-earmark-music.svg list-ol.svg suit-diamond.svg bag-dash-fill.svg chat-right-text.svg file-earmark-person-fill.svg
list-stars.svg suit-heart-fill.svg bag-dash.svg chat-right.svg file-earmark-person.svg list-task.svg suit-heart.svg
bag-fill.svg chat-square-dots-fill.svg file-earmark-play-fill.svg list-ul.svg suit-spade-fill.svg bag-plus-fill.svg
chat-square-dots.svg file-earmark-play.svg list.svg suit-spade.svg bag-plus.svg chat-square-fill.svg
file-earmark-plus-fill.svg lock-fill.svg sun.svg bag-x-fill.svg chat-square-quote-fill.svg file-earmark-plus.svg
lock.svg sunglasses.svg bag-x.svg chat-square-quote.svg file-earmark-post-fill.svg mailbox.svg table.svg bag.svg
chat-square-text-fill.svg file-earmark-post.svg mailbox2.svg tablet-fill.svg bar-chart-fill.svg chat-square-text.svg
file-earmark-richtext-fill.svg map-fill.svg tablet-landscape-fill.svg bar-chart-line-fill.svg chat-square.svg
file-earmark-richtext.svg map.svg tablet-landscape.svg bar-chart-line.svg chat-text-fill.svg
file-earmark-ruled-fill.svg markdown-fill.svg tablet.svg bar-chart-steps.svg chat-text.svg file-earmark-ruled.svg
markdown.svg tag-fill.svg bar-chart.svg chat.svg file-earmark-slides-fill.svg menu-app-fill.svg tag.svg basket-fill.svg
check-all.svg file-earmark-slides.svg menu-app.svg tags-fill.svg basket.svg check-box.svg
file-earmark-spreadsheet-fill.svg menu-button-fill.svg tags.svg basket2-fill.svg check-circle-fill.svg
file-earmark-spreadsheet.svg menu-button-wide-fill.svg telephone-fill.svg basket2.svg check-circle.svg
file-earmark-text-fill.svg menu-button-wide.svg telephone-forward-fill.svg basket3-fill.svg check-square-fill.svg
file-earmark-text.svg menu-button.svg telephone-forward.svg basket3.svg check-square.svg file-earmark-x-fill.svg
menu-down.svg telephone-inbound-fill.svg battery-charging.svg check.svg file-earmark-x.svg menu-up.svg
telephone-inbound.svg battery-full.svg check2-all.svg file-earmark-zip-fill.svg mic-fill.svg telephone-minus-fill.svg
battery-half.svg check2-circle.svg file-earmark-zip.svg mic-mute-fill.svg telephone-minus.svg battery.svg
check2-square.svg file-earmark.svg mic-mute.svg telephone-outbound-fill.svg bell-fill.svg check2.svg
file-easel-fill.svg mic.svg telephone-outbound.svg bell.svg chevron-bar-contract.svg file-easel.svg minecart-loaded.svg
telephone-plus-fill.svg bezier.svg chevron-bar-down.svg file-fill.svg minecart.svg telephone-plus.svg bezier2.svg
chevron-bar-expand.svg file-font-fill.svg moon.svg telephone-x-fill.svg bicycle.svg chevron-bar-left.svg file-font.svg
mouse.svg telephone-x.svg binoculars-fill.svg chevron-bar-right.svg file-image-fill.svg mouse2.svg telephone.svg
binoculars.svg chevron-bar-up.svg file-image.svg mouse3.svg terminal-fill.svg blockquote-left.svg
chevron-compact-down.svg file-lock-fill.svg music-note-beamed.svg terminal.svg blockquote-right.svg
chevron-compact-left.svg file-lock.svg music-note-list.svg text-center.svg book-fill.svg chevron-compact-right.svg
file-lock2-fill.svg music-note.svg text-indent-left.svg book-half.svg chevron-compact-up.svg file-lock2.svg
music-player-fill.svg text-indent-right.svg book.svg chevron-contract.svg file-medical-fill.svg music-player.svg
text-left.svg bookmark-check-fill.svg chevron-double-down.svg file-medical.svg newspaper.svg text-paragraph.svg
bookmark-check.svg chevron-double-left.svg file-minus-fill.svg node-minus-fill.svg text-right.svg
bookmark-dash-fill.svg chevron-double-right.svg file-minus.svg node-minus.svg textarea-resize.svg bookmark-dash.svg
chevron-double-up.svg file-music-fill.svg node-plus-fill.svg textarea-t.svg bookmark-fill.svg chevron-down.svg
file-music.svg node-plus.svg textarea.svg bookmark-heart-fill.svg chevron-expand.svg file-person-fill.svg nut-fill.svg
thermometer-half.svg bookmark-heart.svg chevron-left.svg file-person.svg nut.svg thermometer.svg bookmark-plus-fill.svg
chevron-right.svg file-play-fill.svg octagon-fill.svg three-dots-vertical.svg bookmark-plus.svg chevron-up.svg
file-play.svg octagon-half.svg three-dots.svg bookmark-star-fill.svg circle-fill.svg file-plus-fill.svg octagon.svg
toggle-off.svg bookmark-star.svg circle-half.svg file-plus.svg option.svg toggle-on.svg bookmark-x-fill.svg
circle-square.svg file-post-fill.svg outlet.svg toggle2-off.svg bookmark-x.svg circle.svg file-post.svg paperclip.svg
toggle2-on.svg bookmark.svg clipboard-check.svg file-richtext-fill.svg paragraph.svg toggles.svg bookmarks-fill.svg
clipboard-data.svg file-richtext.svg patch-check-fll.svg toggles2.svg bookmarks.svg clipboard-minus.svg
file-ruled-fill.svg patch-check.svg tools.svg bookshelf.svg clipboard-plus.svg file-ruled.svg patch-exclamation-fll.svg
trash-fill.svg bootstrap-fill.svg clipboard-x.svg file-slides-fill.svg patch-exclamation.svg trash.svg
bootstrap-icons.svg clipboard.svg file-slides.svg patch-minus-fll.svg trash2-fill.svg bootstrap-reboot.svg
clock-fill.svg file-spreadsheet-fill.svg patch-minus.svg trash2.svg bootstrap.svg clock-history.svg
file-spreadsheet.svg patch-plus-fll.svg tree-fill.svg border-style.svg clock.svg file-text-fill.svg patch-plus.svg
tree.svg border-width.svg cloud-arrow-down-fill.svg file-text.svg patch-question-fll.svg triangle-fill.svg
bounding-box-circles.svg cloud-arrow-down.svg file-x-fill.svg patch-question.svg triangle-half.svg bounding-box.svg
cloud-arrow-up-fill.svg file-x.svg pause-fill.svg triangle.svg box-arrow-down-left.svg cloud-arrow-up.svg
file-zip-fill.svg pause.svg trophy-fill.svg box-arrow-down-right.svg cloud-check-fill.svg file-zip.svg peace-fill.svg
trophy.svg box-arrow-down.svg cloud-check.svg file.svg peace.svg truck-flatbed.svg box-arrow-in-down-left.svg
cloud-download-fill.svg files-alt.svg pen-fill.svg truck.svg box-arrow-in-down-right.svg cloud-download.svg files.svg
pen.svg tv-fill.svg box-arrow-in-down.svg cloud-fill.svg film.svg pencil-fill.svg tv.svg box-arrow-in-left.svg
cloud-minus-fill.svg filter-circle-fill.svg pencil-square.svg type-bold.svg box-arrow-in-right.svg cloud-minus.svg
filter-circle.svg pencil.svg type-h1.svg box-arrow-in-up-left.svg cloud-plus-fill.svg filter-left.svg pentagon-fill.svg
type-h2.svg box-arrow-in-up-right.svg cloud-plus.svg filter-right.svg pentagon-half.svg type-h3.svg box-arrow-in-up.svg
cloud-slash-fill.svg filter-square-fill.svg pentagon.svg type-italic.svg box-arrow-left.svg cloud-slash.svg
filter-square.svg people-circle.svg type-strikethrough.svg box-arrow-right.svg cloud-upload-fill.svg filter.svg
people-fill.svg type-underline.svg box-arrow-up-left.svg cloud-upload.svg flag-fill.svg people.svg type.svg
box-arrow-up-right.svg cloud.svg flag.svg percent.svg ui-checks-grid.svg box-arrow-up.svg code-slash.svg flower1.svg
person-badge-fill.svg ui-checks.svg box-seam.svg code-square.svg flower2.svg person-badge.svg ui-radios-grid.svg
box.svg code.svg flower3.svg person-bounding-box.svg ui-radios.svg braces.svg collection-fill.svg folder-check.svg
person-check-fill.svg union.svg bricks.svg collection-play-fill.svg folder-fill.svg person-check.svg unlock-fill.svg
briefcase-fill.svg collection-play.svg folder-minus.svg person-circle.svg unlock.svg briefcase.svg collection.svg
folder-plus.svg person-dash-fill.svg upc-scan.svg brightness-alt-high-fill.svg columns-gap.svg folder-symlink-fill.svg
person-dash.svg upc.svg brightness-alt-high.svg columns.svg folder-symlink.svg person-fill.svg upload.svg
brightness-alt-low-fill.svg command.svg folder-x.svg person-lines-fill.svg vector-pen.svg brightness-alt-low.svg
compass-fill.svg folder.svg person-plus-fill.svg view-list.svg brightness-high-fill.svg compass.svg folder2-open.svg
person-plus.svg view-stacked.svg brightness-high.svg cone-striped.svg folder2.svg person-square.svg voicemail.svg
brightness-low-fill.svg cone.svg fonts.svg person-x-fill.svg volume-down-fill.svg brightness-low.svg controller.svg
forward-fill.svg person-x.svg volume-down.svg broadcast-pin.svg cpu-fill.svg forward.svg person.svg
volume-mute-fill.svg broadcast.svg cpu.svg front.svg phone-fill.svg volume-mute.svg brush-fill.svg
credit-card-2-back-fill.svg fullscreen-exit.svg phone-landscape-fill.svg volume-off-fill.svg brush.svg
credit-card-2-back.svg fullscreen.svg phone-landscape.svg volume-off.svg bucket-fill.svg credit-card-2-front-fill.svg
funnel-fill.svg phone-vibrate.svg volume-up-fill.svg bucket.svg credit-card-2-front.svg funnel.svg phone.svg
volume-up.svg bug-fill.svg credit-card-fill.svg gear-fill.svg pie-chart-fill.svg vr.svg bug.svg credit-card.svg
gear-wide-connected.svg pie-chart.svg wallet-fill.svg building.svg crop.svg gear-wide.svg pip-fill.svg wallet.svg
bullseye.svg cup-fill.svg gear.svg pip.svg wallet2.svg calculator-fill.svg cup-straw.svg gem.svg play-fill.svg
watch.svg calculator.svg cup.svg geo-alt-fill.svg play.svg wifi-1.svg calendar-check-fill.svg cursor-fill.svg
geo-alt.svg plug-fill.svg wifi-2.svg calendar-check.svg cursor-text.svg geo-fill.svg plug.svg wifi-off.svg
calendar-date-fill.svg cursor.svg geo.svg plus-circle-fill.svg wifi.svg calendar-date.svg dash-circle-fill.svg
gift-fill.svg plus-circle.svg window.svg calendar-day-fill.svg dash-circle.svg gift.svg plus-square-fill.svg wrench.svg
calendar-day.svg dash-square-fill.svg globe.svg plus-square.svg x-circle-fill.svg calendar-event-fill.svg
dash-square.svg globe2.svg plus.svg x-circle.svg calendar-event.svg dash.svg graph-down.svg power.svg
x-diamond-fill.svg calendar-fill.svg diagram-2-fill.svg graph-up.svg printer-fill.svg x-diamond.svg
calendar-minus-fill.svg diagram-2.svg grid-1x2-fill.svg printer.svg x-octagon-fill.svg calendar-minus.svg
diagram-3-fill.svg grid-1x2.svg puzzle-fill.svg x-octagon.svg calendar-month-fill.svg diagram-3.svg
grid-3x2-gap-fill.svg puzzle.svg x-square-fill.svg calendar-month.svg diamond-fill.svg grid-3x2-gap.svg
question-circle-fill.svg x-square.svg calendar-plus-fill.svg diamond-half.svg grid-3x2.svg question-circle.svg x.svg
calendar-plus.svg diamond.svg grid-3x3-gap-fill.svg question-diamond-fill.svg zoom-in.svg calendar-range-fill.svg
dice-1-fill.svg grid-3x3-gap.svg question-diamond.svg zoom-out.svg calendar-range.svg dice-1.svg grid-3x3.svg
question-octagon-fill.svg 
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
