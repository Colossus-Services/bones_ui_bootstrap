import 'dart:html';

import 'package:dom_tools/dom_tools.dart';
import 'package:swiss_knife/swiss_knife.dart';

import 'bones_ui_bootstrap_base.dart';

/// Bootstrap icons support.
class BootstrapIcons {
  // ignore: non_constant_identifier_names
  static final String VERSION = '1.8.1';

  static final String iconsList = '''
123.svg caret-left-fill.svg envelope-slash-fill.svg images.svg search-heart.svg activity.svg caret-left-square-fill.svg
envelope-slash.svg inbox-fill.svg search.svg alarm-fill.svg caret-left-square.svg envelope-x-fill.svg inbox.svg
segmented-nav.svg alarm.svg caret-left.svg envelope-x.svg inboxes-fill.svg send-check-fill.svg align-bottom.svg
caret-right-fill.svg envelope.svg inboxes.svg send-check.svg align-center.svg caret-right-square-fill.svg
eraser-fill.svg incognito.svg send-dash-fill.svg align-end.svg caret-right-square.svg eraser.svg infinity.svg
send-dash.svg align-middle.svg caret-right.svg ethernet.svg info-circle-fill.svg send-exclamation-fill.svg
align-start.svg caret-up-fill.svg exclamation-circle-fill.svg info-circle.svg send-exclamation.svg align-top.svg
caret-up-square-fill.svg exclamation-circle.svg info-lg.svg send-fill.svg alt.svg caret-up-square.svg
exclamation-diamond-fill.svg info-square-fill.svg send-plus-fill.svg app-indicator.svg caret-up.svg
exclamation-diamond.svg info-square.svg send-plus.svg app.svg cart-check-fill.svg exclamation-lg.svg info.svg
send-slash-fill.svg apple.svg cart-check.svg exclamation-octagon-fill.svg input-cursor-text.svg send-slash.svg
archive-fill.svg cart-dash-fill.svg exclamation-octagon.svg input-cursor.svg send-x-fill.svg archive.svg cart-dash.svg
exclamation-square-fill.svg instagram.svg send-x.svg arrow-90deg-down.svg cart-fill.svg exclamation-square.svg
intersect.svg send.svg arrow-90deg-left.svg cart-plus-fill.svg exclamation-triangle-fill.svg journal-album.svg
server.svg arrow-90deg-right.svg cart-plus.svg exclamation-triangle.svg journal-arrow-down.svg share-fill.svg
arrow-90deg-up.svg cart-x-fill.svg exclamation.svg journal-arrow-up.svg share.svg arrow-bar-down.svg cart-x.svg
exclude.svg journal-bookmark-fill.svg shield-check.svg arrow-bar-left.svg cart.svg explicit-fill.svg
journal-bookmark.svg shield-exclamation.svg arrow-bar-right.svg cart2.svg explicit.svg journal-check.svg
shield-fill-check.svg arrow-bar-up.svg cart3.svg eye-fill.svg journal-code.svg shield-fill-exclamation.svg
arrow-clockwise.svg cart4.svg eye-slash-fill.svg journal-medical.svg shield-fill-minus.svg arrow-counterclockwise.svg
cash-coin.svg eye-slash.svg journal-minus.svg shield-fill-plus.svg arrow-down-circle-fill.svg cash-stack.svg eye.svg
journal-plus.svg shield-fill-x.svg arrow-down-circle.svg cash.svg eyedropper.svg journal-richtext.svg shield-fill.svg
arrow-down-left-circle-fill.svg cast.svg eyeglasses.svg journal-text.svg shield-lock-fill.svg
arrow-down-left-circle.svg chat-dots-fill.svg facebook.svg journal-x.svg shield-lock.svg
arrow-down-left-square-fill.svg chat-dots.svg fan.svg journal.svg shield-minus.svg arrow-down-left-square.svg
chat-fill.svg file-arrow-down-fill.svg journals.svg shield-plus.svg arrow-down-left.svg chat-heart-fill.svg
file-arrow-down.svg joystick.svg shield-shaded.svg arrow-down-right-circle-fill.svg chat-heart.svg
file-arrow-up-fill.svg justify-left.svg shield-slash-fill.svg arrow-down-right-circle.svg chat-left-dots-fill.svg
file-arrow-up.svg justify-right.svg shield-slash.svg arrow-down-right-square-fill.svg chat-left-dots.svg
file-bar-graph-fill.svg justify.svg shield-x.svg arrow-down-right-square.svg chat-left-fill.svg file-bar-graph.svg
kanban-fill.svg shield.svg arrow-down-right.svg chat-left-heart-fill.svg file-binary-fill.svg kanban.svg shift-fill.svg
arrow-down-short.svg chat-left-heart.svg file-binary.svg key-fill.svg shift.svg arrow-down-square-fill.svg
chat-left-quote-fill.svg file-break-fill.svg key.svg shop-window.svg arrow-down-square.svg chat-left-quote.svg
file-break.svg keyboard-fill.svg shop.svg arrow-down-up.svg chat-left-text-fill.svg file-check-fill.svg keyboard.svg
shuffle.svg arrow-down.svg chat-left-text.svg file-check.svg ladder.svg signal.svg arrow-left-circle-fill.svg
chat-left.svg file-code-fill.svg lamp-fill.svg signpost-2-fill.svg arrow-left-circle.svg chat-quote-fill.svg
file-code.svg lamp.svg signpost-2.svg arrow-left-right.svg chat-quote.svg file-diff-fill.svg laptop-fill.svg
signpost-fill.svg arrow-left-short.svg chat-right-dots-fill.svg file-diff.svg laptop.svg signpost-split-fill.svg
arrow-left-square-fill.svg chat-right-dots.svg file-earmark-arrow-down-fill.svg layer-backward.svg signpost-split.svg
arrow-left-square.svg chat-right-fill.svg file-earmark-arrow-down.svg layer-forward.svg signpost.svg arrow-left.svg
chat-right-heart-fill.svg file-earmark-arrow-up-fill.svg layers-fill.svg sim-fill.svg arrow-repeat.svg
chat-right-heart.svg file-earmark-arrow-up.svg layers-half.svg sim.svg arrow-return-left.svg chat-right-quote-fill.svg
file-earmark-bar-graph-fill.svg layers.svg skip-backward-btn-fill.svg arrow-return-right.svg chat-right-quote.svg
file-earmark-bar-graph.svg layout-sidebar-inset-reverse.svg skip-backward-btn.svg arrow-right-circle-fill.svg
chat-right-text-fill.svg file-earmark-binary-fill.svg layout-sidebar-inset.svg skip-backward-circle-fill.svg
arrow-right-circle.svg chat-right-text.svg file-earmark-binary.svg layout-sidebar-reverse.svg skip-backward-circle.svg
arrow-right-short.svg chat-right.svg file-earmark-break-fill.svg layout-sidebar.svg skip-backward-fill.svg
arrow-right-square-fill.svg chat-square-dots-fill.svg file-earmark-break.svg layout-split.svg skip-backward.svg
arrow-right-square.svg chat-square-dots.svg file-earmark-check-fill.svg layout-text-sidebar-reverse.svg
skip-end-btn-fill.svg arrow-right.svg chat-square-fill.svg file-earmark-check.svg layout-text-sidebar.svg
skip-end-btn.svg arrow-through-heart-fill.svg chat-square-heart-fill.svg file-earmark-code-fill.svg
layout-text-window-reverse.svg skip-end-circle-fill.svg arrow-through-heart.svg chat-square-heart.svg
file-earmark-code.svg layout-text-window.svg skip-end-circle.svg arrow-up-circle-fill.svg chat-square-quote-fill.svg
file-earmark-diff-fill.svg layout-three-columns.svg skip-end-fill.svg arrow-up-circle.svg chat-square-quote.svg
file-earmark-diff.svg layout-wtf.svg skip-end.svg arrow-up-down.svg chat-square-text-fill.svg
file-earmark-easel-fill.svg life-preserver.svg skip-forward-btn-fill.svg arrow-up-left-circle-fill.svg
chat-square-text.svg file-earmark-easel.svg lightbulb-fill.svg skip-forward-btn.svg arrow-up-left-circle.svg
chat-square.svg file-earmark-excel-fill.svg lightbulb-off-fill.svg skip-forward-circle-fill.svg
arrow-up-left-square-fill.svg chat-text-fill.svg file-earmark-excel.svg lightbulb-off.svg skip-forward-circle.svg
arrow-up-left-square.svg chat-text.svg file-earmark-fill.svg lightbulb.svg skip-forward-fill.svg arrow-up-left.svg
chat.svg file-earmark-font-fill.svg lightning-charge-fill.svg skip-forward.svg arrow-up-right-circle-fill.svg
check-all.svg file-earmark-font.svg lightning-charge.svg skip-start-btn-fill.svg arrow-up-right-circle.svg
check-box.svg file-earmark-image-fill.svg lightning-fill.svg skip-start-btn.svg arrow-up-right-square-fill.svg
check-circle-fill.svg file-earmark-image.svg lightning.svg skip-start-circle-fill.svg arrow-up-right-square.svg
check-circle.svg file-earmark-lock-fill.svg line.svg skip-start-circle.svg arrow-up-right.svg check-lg.svg
file-earmark-lock.svg link-45deg.svg skip-start-fill.svg arrow-up-short.svg check-square-fill.svg
file-earmark-lock2-fill.svg link.svg skip-start.svg arrow-up-square-fill.svg check-square.svg file-earmark-lock2.svg
linkedin.svg skype.svg arrow-up-square.svg check.svg file-earmark-medical-fill.svg list-check.svg slack.svg
arrow-up.svg check2-all.svg file-earmark-medical.svg list-columns-reverse.svg slash-circle-fill.svg
arrows-angle-contract.svg check2-circle.svg file-earmark-minus-fill.svg list-columns.svg slash-circle.svg
arrows-angle-expand.svg check2-square.svg file-earmark-minus.svg list-nested.svg slash-lg.svg arrows-collapse.svg
check2.svg file-earmark-music-fill.svg list-ol.svg slash-square-fill.svg arrows-expand.svg chevron-bar-contract.svg
file-earmark-music.svg list-stars.svg slash-square.svg arrows-fullscreen.svg chevron-bar-down.svg
file-earmark-pdf-fill.svg list-task.svg slash.svg arrows-move.svg chevron-bar-expand.svg file-earmark-pdf.svg
list-ul.svg sliders.svg aspect-ratio-fill.svg chevron-bar-left.svg file-earmark-person-fill.svg list.svg
sliders2-vertical.svg aspect-ratio.svg chevron-bar-right.svg file-earmark-person.svg lock-fill.svg sliders2.svg
asterisk.svg chevron-bar-up.svg file-earmark-play-fill.svg lock.svg smartwatch.svg at.svg chevron-compact-down.svg
file-earmark-play.svg magic.svg snapchat.svg award-fill.svg chevron-compact-left.svg file-earmark-plus-fill.svg
magnet-fill.svg snow.svg award.svg chevron-compact-right.svg file-earmark-plus.svg magnet.svg snow2.svg back.svg
chevron-compact-up.svg file-earmark-post-fill.svg mailbox.svg snow3.svg backspace-fill.svg chevron-contract.svg
file-earmark-post.svg mailbox2.svg sort-alpha-down-alt.svg backspace-reverse-fill.svg chevron-double-down.svg
file-earmark-ppt-fill.svg map-fill.svg sort-alpha-down.svg backspace-reverse.svg chevron-double-left.svg
file-earmark-ppt.svg map.svg sort-alpha-up-alt.svg backspace.svg chevron-double-right.svg
file-earmark-richtext-fill.svg markdown-fill.svg sort-alpha-up.svg badge-3d-fill.svg chevron-double-up.svg
file-earmark-richtext.svg markdown.svg sort-down-alt.svg badge-3d.svg chevron-down.svg file-earmark-ruled-fill.svg
mask.svg sort-down.svg badge-4k-fill.svg chevron-expand.svg file-earmark-ruled.svg mastodon.svg
sort-numeric-down-alt.svg badge-4k.svg chevron-left.svg file-earmark-slides-fill.svg medium.svg sort-numeric-down.svg
badge-8k-fill.svg chevron-right.svg file-earmark-slides.svg megaphone-fill.svg sort-numeric-up-alt.svg badge-8k.svg
chevron-up.svg file-earmark-spreadsheet-fill.svg megaphone.svg sort-numeric-up.svg badge-ad-fill.svg circle-fill.svg
file-earmark-spreadsheet.svg memory.svg sort-up-alt.svg badge-ad.svg circle-half.svg file-earmark-text-fill.svg
menu-app-fill.svg sort-up.svg badge-ar-fill.svg circle-square.svg file-earmark-text.svg menu-app.svg soundwave.svg
badge-ar.svg circle.svg file-earmark-word-fill.svg menu-button-fill.svg speaker-fill.svg badge-cc-fill.svg
clipboard-check-fill.svg file-earmark-word.svg menu-button-wide-fill.svg speaker.svg badge-cc.svg clipboard-check.svg
file-earmark-x-fill.svg menu-button-wide.svg speedometer.svg badge-hd-fill.svg clipboard-data-fill.svg
file-earmark-x.svg menu-button.svg speedometer2.svg badge-hd.svg clipboard-data.svg file-earmark-zip-fill.svg
menu-down.svg spellcheck.svg badge-sd-fill.svg clipboard-fill.svg file-earmark-zip.svg menu-up.svg spotify.svg
badge-sd.svg clipboard-heart-fill.svg file-earmark.svg messenger.svg square-fill.svg badge-tm-fill.svg
clipboard-heart.svg file-easel-fill.svg meta.svg square-half.svg badge-tm.svg clipboard-minus-fill.svg file-easel.svg
mic-fill.svg square.svg badge-vo-fill.svg clipboard-minus.svg file-excel-fill.svg mic-mute-fill.svg stack-overflow.svg
badge-vo.svg clipboard-plus-fill.svg file-excel.svg mic-mute.svg stack.svg badge-vr-fill.svg clipboard-plus.svg
file-fill.svg mic.svg star-fill.svg badge-vr.svg clipboard-pulse.svg file-font-fill.svg microsoft.svg star-half.svg
badge-wc-fill.svg clipboard-x-fill.svg file-font.svg minecart-loaded.svg star.svg badge-wc.svg clipboard-x.svg
file-image-fill.svg minecart.svg stars.svg bag-check-fill.svg clipboard.svg file-image.svg modem-fill.svg steam.svg
bag-check.svg clipboard2-check-fill.svg file-lock-fill.svg modem.svg stickies-fill.svg bag-dash-fill.svg
clipboard2-check.svg file-lock.svg moisture.svg stickies.svg bag-dash.svg clipboard2-data-fill.svg file-lock2-fill.svg
moon-fill.svg sticky-fill.svg bag-fill.svg clipboard2-data.svg file-lock2.svg moon-stars-fill.svg sticky.svg
bag-heart-fill.svg clipboard2-fill.svg file-medical-fill.svg moon-stars.svg stop-btn-fill.svg bag-heart.svg
clipboard2-heart-fill.svg file-medical.svg moon.svg stop-btn.svg bag-plus-fill.svg clipboard2-heart.svg
file-minus-fill.svg mortarboard-fill.svg stop-circle-fill.svg bag-plus.svg clipboard2-minus-fill.svg file-minus.svg
mortarboard.svg stop-circle.svg bag-x-fill.svg clipboard2-minus.svg file-music-fill.svg motherboard-fill.svg
stop-fill.svg bag-x.svg clipboard2-plus-fill.svg file-music.svg motherboard.svg stop.svg bag.svg clipboard2-plus.svg
file-pdf-fill.svg mouse-fill.svg stoplights-fill.svg balloon-fill.svg clipboard2-pulse-fill.svg file-pdf.svg mouse.svg
stoplights.svg balloon-heart-fill.svg clipboard2-pulse.svg file-person-fill.svg mouse2-fill.svg stopwatch-fill.svg
balloon-heart.svg clipboard2-x-fill.svg file-person.svg mouse2.svg stopwatch.svg balloon.svg clipboard2-x.svg
file-play-fill.svg mouse3-fill.svg strava.svg bandaid-fill.svg clipboard2.svg file-play.svg mouse3.svg subtract.svg
bandaid.svg clock-fill.svg file-plus-fill.svg music-note-beamed.svg suit-club-fill.svg bank.svg clock-history.svg
file-plus.svg music-note-list.svg suit-club.svg bank2.svg clock.svg file-post-fill.svg music-note.svg
suit-diamond-fill.svg bar-chart-fill.svg cloud-arrow-down-fill.svg file-post.svg music-player-fill.svg suit-diamond.svg
bar-chart-line-fill.svg cloud-arrow-down.svg file-ppt-fill.svg music-player.svg suit-heart-fill.svg bar-chart-line.svg
cloud-arrow-up-fill.svg file-ppt.svg newspaper.svg suit-heart.svg bar-chart-steps.svg cloud-arrow-up.svg
file-richtext-fill.svg nintendo-switch.svg suit-spade-fill.svg bar-chart.svg cloud-check-fill.svg file-richtext.svg
node-minus-fill.svg suit-spade.svg basket-fill.svg cloud-check.svg file-ruled-fill.svg node-minus.svg sun-fill.svg
basket.svg cloud-download-fill.svg file-ruled.svg node-plus-fill.svg sun.svg basket2-fill.svg cloud-download.svg
file-slides-fill.svg node-plus.svg sunglasses.svg basket2.svg cloud-drizzle-fill.svg file-slides.svg nut-fill.svg
sunrise-fill.svg basket3-fill.svg cloud-drizzle.svg file-spreadsheet-fill.svg nut.svg sunrise.svg basket3.svg
cloud-fill.svg file-spreadsheet.svg octagon-fill.svg sunset-fill.svg battery-charging.svg cloud-fog-fill.svg
file-text-fill.svg octagon-half.svg sunset.svg battery-full.svg cloud-fog.svg file-text.svg octagon.svg
symmetry-horizontal.svg battery-half.svg cloud-fog2-fill.svg file-word-fill.svg optical-audio-fill.svg
symmetry-vertical.svg battery.svg cloud-fog2.svg file-word.svg optical-audio.svg table.svg behance.svg
cloud-hail-fill.svg file-x-fill.svg option.svg tablet-fill.svg bell-fill.svg cloud-hail.svg file-x.svg outlet.svg
tablet-landscape-fill.svg bell-slash-fill.svg cloud-haze-1.svg file-zip-fill.svg paint-bucket.svg tablet-landscape.svg
bell-slash.svg cloud-haze-fill.svg file-zip.svg palette-fill.svg tablet.svg bell.svg cloud-haze.svg file.svg
palette.svg tag-fill.svg bezier.svg cloud-haze2-fill.svg files-alt.svg palette2.svg tag.svg bezier2.svg cloud-haze2.svg
files.svg paperclip.svg tags-fill.svg bicycle.svg cloud-lightning-fill.svg filetype-aac.svg paragraph.svg tags.svg
binoculars-fill.svg cloud-lightning-rain-fill.svg filetype-ai.svg patch-check-fill.svg telegram.svg binoculars.svg
cloud-lightning-rain.svg filetype-bmp.svg patch-check-fll.svg telephone-fill.svg blockquote-left.svg
cloud-lightning.svg filetype-cs.svg patch-check.svg telephone-forward-fill.svg blockquote-right.svg
cloud-minus-fill.svg filetype-css.svg patch-exclamation-fill.svg telephone-forward.svg bluetooth.svg cloud-minus.svg
filetype-csv.svg patch-exclamation-fll.svg telephone-inbound-fill.svg body-text.svg cloud-moon-fill.svg
filetype-doc.svg patch-exclamation.svg telephone-inbound.svg book-fill.svg cloud-moon.svg filetype-docx.svg
patch-minus-fill.svg telephone-minus-fill.svg book-half.svg cloud-plus-fill.svg filetype-exe.svg patch-minus-fll.svg
telephone-minus.svg book.svg cloud-plus.svg filetype-gif.svg patch-minus.svg telephone-outbound-fill.svg
bookmark-check-fill.svg cloud-rain-fill.svg filetype-heic.svg patch-plus-fill.svg telephone-outbound.svg
bookmark-check.svg cloud-rain-heavy-fill.svg filetype-html.svg patch-plus-fll.svg telephone-plus-fill.svg
bookmark-dash-fill.svg cloud-rain-heavy.svg filetype-java.svg patch-plus.svg telephone-plus.svg bookmark-dash.svg
cloud-rain.svg filetype-jpg.svg patch-question-fill.svg telephone-x-fill.svg bookmark-fill.svg cloud-slash-fill.svg
filetype-js.svg patch-question-fll.svg telephone-x.svg bookmark-heart-fill.svg cloud-slash.svg filetype-json.svg
patch-question.svg telephone.svg bookmark-heart.svg cloud-sleet-fill.svg filetype-jsx.svg pause-btn-fill.svg
terminal-dash.svg bookmark-plus-fill.svg cloud-sleet.svg filetype-key.svg pause-btn.svg terminal-fill.svg
bookmark-plus.svg cloud-snow-fill.svg filetype-m4p.svg pause-circle-fill.svg terminal-plus.svg bookmark-star-fill.svg
cloud-snow.svg filetype-md.svg pause-circle.svg terminal-split.svg bookmark-star.svg cloud-sun-fill.svg
filetype-mdx.svg pause-fill.svg terminal-x.svg bookmark-x-fill.svg cloud-sun.svg filetype-mov.svg pause.svg
terminal.svg bookmark-x.svg cloud-upload-fill.svg filetype-mp3.svg paypal.svg text-center.svg bookmark.svg
cloud-upload.svg filetype-mp4.svg pc-display-horizontal.svg text-indent-left.svg bookmarks-fill.svg cloud.svg
filetype-otf.svg pc-display.svg text-indent-right.svg bookmarks.svg clouds-fill.svg filetype-pdf.svg pc-horizontal.svg
text-left.svg bookshelf.svg clouds.svg filetype-php.svg pc.svg text-paragraph.svg boombox-fill.svg cloudy-fill.svg
filetype-png.svg pci-card.svg text-right.svg boombox.svg cloudy.svg filetype-ppt.svg peace-fill.svg textarea-resize.svg
bootstrap-fill.svg code-slash.svg filetype-pptx.svg peace.svg textarea-t.svg bootstrap-icons.svg code-square.svg
filetype-psd.svg pen-fill.svg textarea.svg bootstrap-reboot.svg code.svg filetype-py.svg pen.svg thermometer-half.svg
bootstrap.svg coin.svg filetype-raw.svg pencil-fill.svg thermometer-high.svg border-all.svg collection-fill.svg
filetype-rb.svg pencil-square.svg thermometer-low.svg border-bottom.svg collection-play-fill.svg filetype-sass.svg
pencil.svg thermometer-snow.svg border-center.svg collection-play.svg filetype-scss.svg pentagon-fill.svg
thermometer-sun.svg border-inner.svg collection.svg filetype-sh.svg pentagon-half.svg thermometer.svg border-left.svg
columns-gap.svg filetype-svg.svg pentagon.svg three-dots-vertical.svg border-middle.svg columns.svg filetype-tiff.svg
people-circle.svg three-dots.svg border-outer.svg command.svg filetype-tsx.svg people-fill.svg thunderbolt-fill.svg
border-right.svg compass-fill.svg filetype-ttf.svg people.svg thunderbolt.svg border-style.svg compass.svg
filetype-txt.svg percent.svg ticket-detailed-fill.svg border-top.svg cone-striped.svg filetype-wav.svg
person-badge-fill.svg ticket-detailed.svg border-width.svg cone.svg filetype-woff.svg person-badge.svg ticket-fill.svg
border.svg controller.svg filetype-xls.svg person-bounding-box.svg ticket-perforated-fill.svg bounding-box-circles.svg
cpu-fill.svg filetype-xlsx.svg person-check-fill.svg ticket-perforated.svg bounding-box.svg cpu.svg filetype-xml.svg
person-check.svg ticket.svg box-arrow-down-left.svg credit-card-2-back-fill.svg filetype-yml.svg person-circle.svg
tiktok.svg box-arrow-down-right.svg credit-card-2-back.svg film.svg person-dash-fill.svg toggle-off.svg
box-arrow-down.svg credit-card-2-front-fill.svg filter-circle-fill.svg person-dash.svg toggle-on.svg
box-arrow-in-down-left.svg credit-card-2-front.svg filter-circle.svg person-fill.svg toggle2-off.svg
box-arrow-in-down-right.svg credit-card-fill.svg filter-left.svg person-heart.svg toggle2-on.svg box-arrow-in-down.svg
credit-card.svg filter-right.svg person-hearts.svg toggles.svg box-arrow-in-left.svg crop.svg filter-square-fill.svg
person-lines-fill.svg toggles2.svg box-arrow-in-right.svg cup-fill.svg filter-square.svg person-plus-fill.svg tools.svg
box-arrow-in-up-left.svg cup-straw.svg filter.svg person-plus.svg tornado.svg box-arrow-in-up-right.svg cup.svg
fingerprint.svg person-rolodex.svg translate.svg box-arrow-in-up.svg currency-bitcoin.svg flag-fill.svg
person-square.svg trash-fill.svg box-arrow-left.svg currency-dollar.svg flag.svg person-video.svg trash.svg
box-arrow-right.svg currency-euro.svg flower1.svg person-video2.svg trash2-fill.svg box-arrow-up-left.svg
currency-exchange.svg flower2.svg person-video3.svg trash2.svg box-arrow-up-right.svg currency-pound.svg flower3.svg
person-workspace.svg trash3-fill.svg box-arrow-up.svg currency-yen.svg folder-check.svg person-x-fill.svg trash3.svg
box-seam.svg cursor-fill.svg folder-fill.svg person-x.svg tree-fill.svg box.svg cursor-text.svg folder-minus.svg
person.svg tree.svg box2-fill.svg cursor.svg folder-plus.svg phone-fill.svg triangle-fill.svg box2-heart-fill.svg
dash-circle-dotted.svg folder-symlink-fill.svg phone-flip.svg triangle-half.svg box2-heart.svg dash-circle-fill.svg
folder-symlink.svg phone-landscape-fill.svg triangle.svg box2.svg dash-circle.svg folder-x.svg phone-landscape.svg
trophy-fill.svg boxes.svg dash-lg.svg folder.svg phone-vibrate-fill.svg trophy.svg braces-asterisk.svg
dash-square-dotted.svg folder2-open.svg phone-vibrate.svg tropical-storm.svg braces.svg dash-square-fill.svg
folder2.svg phone.svg truck-flatbed.svg bricks.svg dash-square.svg fonts.svg pie-chart-fill.svg truck.svg
briefcase-fill.svg dash.svg forward-fill.svg pie-chart.svg tsunami.svg briefcase.svg device-hdd-fill.svg forward.svg
piggy-bank-fill.svg tv-fill.svg brightness-alt-high-fill.svg device-hdd.svg front.svg piggy-bank.svg tv.svg
brightness-alt-high.svg device-ssd-fill.svg fullscreen-exit.svg pin-angle-fill.svg twitch.svg
brightness-alt-low-fill.svg device-ssd.svg fullscreen.svg pin-angle.svg twitter.svg brightness-alt-low.svg
diagram-2-fill.svg funnel-fill.svg pin-fill.svg type-bold.svg brightness-high-fill.svg diagram-2.svg funnel.svg
pin-map-fill.svg type-h1.svg brightness-high.svg diagram-3-fill.svg gear-fill.svg pin-map.svg type-h2.svg
brightness-low-fill.svg diagram-3.svg gear-wide-connected.svg pin.svg type-h3.svg brightness-low.svg diamond-fill.svg
gear-wide.svg pinterest.svg type-italic.svg broadcast-pin.svg diamond-half.svg gear.svg pip-fill.svg
type-strikethrough.svg broadcast.svg diamond.svg gem.svg pip.svg type-underline.svg brush-fill.svg dice-1-fill.svg
gender-ambiguous.svg play-btn-fill.svg type.svg brush.svg dice-1.svg gender-female.svg play-btn.svg ui-checks-grid.svg
bucket-fill.svg dice-2-fill.svg gender-male.svg play-circle-fill.svg ui-checks.svg bucket.svg dice-2.svg
gender-trans.svg play-circle.svg ui-radios-grid.svg bug-fill.svg dice-3-fill.svg geo-alt-fill.svg play-fill.svg
ui-radios.svg bug.svg dice-3.svg geo-alt.svg play.svg umbrella-fill.svg building.svg dice-4-fill.svg geo-fill.svg
playstation.svg umbrella.svg bullseye.svg dice-4.svg geo.svg plug-fill.svg union.svg calculator-fill.svg
dice-5-fill.svg gift-fill.svg plug.svg unlock-fill.svg calculator.svg dice-5.svg gift.svg plugin.svg unlock.svg
calendar-check-fill.svg dice-6-fill.svg git.svg plus-circle-dotted.svg upc-scan.svg calendar-check.svg dice-6.svg
github.svg plus-circle-fill.svg upc.svg calendar-date-fill.svg disc-fill.svg globe.svg plus-circle.svg upload.svg
calendar-date.svg disc.svg globe2.svg plus-lg.svg usb-c-fill.svg calendar-day-fill.svg discord.svg google.svg
plus-slash-minus.svg usb-c.svg calendar-day.svg display-fill.svg gpu-card.svg plus-square-dotted.svg usb-drive-fill.svg
calendar-event-fill.svg display.svg graph-down-arrow.svg plus-square-fill.svg usb-drive.svg calendar-event.svg
displayport-fill.svg graph-down.svg plus-square.svg usb-fill.svg calendar-fill.svg displayport.svg graph-up-arrow.svg
plus.svg usb-micro-fill.svg calendar-heart-fill.svg distribute-horizontal.svg graph-up.svg postage-fill.svg
usb-micro.svg calendar-heart.svg distribute-vertical.svg grid-1x2-fill.svg postage-heart-fill.svg usb-mini-fill.svg
calendar-minus-fill.svg door-closed-fill.svg grid-1x2.svg postage-heart.svg usb-mini.svg calendar-minus.svg
door-closed.svg grid-3x2-gap-fill.svg postage.svg usb-plug-fill.svg calendar-month-fill.svg door-open-fill.svg
grid-3x2-gap.svg postcard-fill.svg usb-plug.svg calendar-month.svg door-open.svg grid-3x2.svg postcard-heart-fill.svg
usb-symbol.svg calendar-plus-fill.svg dot.svg grid-3x3-gap-fill.svg postcard-heart.svg usb.svg calendar-plus.svg
download.svg grid-3x3-gap.svg postcard.svg valentine.svg calendar-range-fill.svg dpad-fill.svg grid-3x3.svg power.svg
valentine2.svg calendar-range.svg dpad.svg grid-fill.svg printer-fill.svg vector-pen.svg calendar-week-fill.svg
dribbble.svg grid.svg printer.svg view-list.svg calendar-week.svg droplet-fill.svg grip-horizontal.svg
projector-fill.svg view-stacked.svg calendar-x-fill.svg droplet-half.svg grip-vertical.svg projector.svg vimeo.svg
calendar-x.svg droplet.svg hammer.svg puzzle-fill.svg vinyl-fill.svg calendar.svg ear-fill.svg hand-index-fill.svg
puzzle.svg vinyl.svg calendar2-check-fill.svg ear.svg hand-index-thumb-fill.svg qr-code-scan.svg voicemail.svg
calendar2-check.svg earbuds.svg hand-index-thumb.svg qr-code.svg volume-down-fill.svg calendar2-date-fill.svg
easel-fill.svg hand-index.svg question-circle-fill.svg volume-down.svg calendar2-date.svg easel.svg
hand-thumbs-down-fill.svg question-circle.svg volume-mute-fill.svg calendar2-day-fill.svg easel2-fill.svg
hand-thumbs-down.svg question-diamond-fill.svg volume-mute.svg calendar2-day.svg easel2.svg hand-thumbs-up-fill.svg
question-diamond.svg volume-off-fill.svg calendar2-event-fill.svg easel3-fill.svg hand-thumbs-up.svg question-lg.svg
volume-off.svg calendar2-event.svg easel3.svg handbag-fill.svg question-octagon-fill.svg volume-up-fill.svg
calendar2-fill.svg egg-fill.svg handbag.svg question-octagon.svg volume-up.svg calendar2-heart-fill.svg egg-fried.svg
hash.svg question-square-fill.svg vr.svg calendar2-heart.svg egg.svg hdd-fill.svg question-square.svg wallet-fill.svg
calendar2-minus-fill.svg eject-fill.svg hdd-network-fill.svg question.svg wallet.svg calendar2-minus.svg eject.svg
hdd-network.svg quora.svg wallet2.svg calendar2-month-fill.svg emoji-angry-fill.svg hdd-rack-fill.svg quote.svg
watch.svg calendar2-month.svg emoji-angry.svg hdd-rack.svg radioactive.svg water.svg calendar2-plus-fill.svg
emoji-dizzy-fill.svg hdd-stack-fill.svg rainbow.svg webcam-fill.svg calendar2-plus.svg emoji-dizzy.svg hdd-stack.svg
receipt-cutoff.svg webcam.svg calendar2-range-fill.svg emoji-expressionless-fill.svg hdd.svg receipt.svg whatsapp.svg
calendar2-range.svg emoji-expressionless.svg hdmi-fill.svg reception-0.svg wifi-1.svg calendar2-week-fill.svg
emoji-frown-fill.svg hdmi.svg reception-1.svg wifi-2.svg calendar2-week.svg emoji-frown.svg headphones.svg
reception-2.svg wifi-off.svg calendar2-x-fill.svg emoji-heart-eyes-fill.svg headset-vr.svg reception-3.svg wifi.svg
calendar2-x.svg emoji-heart-eyes.svg headset.svg reception-4.svg wind.svg calendar2.svg emoji-kiss-fill.svg
heart-arrow.svg record-btn-fill.svg window-dash.svg calendar3-event-fill.svg emoji-kiss.svg heart-fill.svg
record-btn.svg window-desktop.svg calendar3-event.svg emoji-laughing-fill.svg heart-half.svg record-circle-fill.svg
window-dock.svg calendar3-fill.svg emoji-laughing.svg heart-pulse-fill.svg record-circle.svg window-fullscreen.svg
calendar3-range-fill.svg emoji-neutral-fill.svg heart-pulse.svg record-fill.svg window-plus.svg calendar3-range.svg
emoji-neutral.svg heart.svg record.svg window-sidebar.svg calendar3-week-fill.svg emoji-smile-fill.svg
heartbreak-fill.svg record2-fill.svg window-split.svg calendar3-week.svg emoji-smile-upside-down-fill.svg
heartbreak.svg record2.svg window-stack.svg calendar3.svg emoji-smile-upside-down.svg hearts.svg recycle.svg
window-x.svg calendar4-event.svg emoji-smile.svg heptagon-fill.svg reddit.svg window.svg calendar4-range.svg
emoji-sunglasses-fill.svg heptagon-half.svg reply-all-fill.svg windows.svg calendar4-week.svg emoji-sunglasses.svg
heptagon.svg reply-all.svg wordpress.svg calendar4.svg emoji-wink-fill.svg hexagon-fill.svg reply-fill.svg
wrench-adjustable-circle-fill.svg camera-fill.svg emoji-wink.svg hexagon-half.svg reply.svg
wrench-adjustable-circle.svg camera-reels-fill.svg envelope-check-fill.svg hexagon.svg robot.svg wrench-adjustable.svg
camera-reels.svg envelope-check.svg hospital-fill.svg router-fill.svg wrench.svg camera-video-fill.svg
envelope-dash-fill.svg hospital.svg router.svg x-circle-fill.svg camera-video-off-fill.svg envelope-dash.svg
hourglass-bottom.svg rss-fill.svg x-circle.svg camera-video-off.svg envelope-exclamation-fill.svg hourglass-split.svg
rss.svg x-diamond-fill.svg camera-video.svg envelope-exclamation.svg hourglass-top.svg rulers.svg x-diamond.svg
camera.svg envelope-fill.svg hourglass.svg safe-fill.svg x-lg.svg camera2.svg envelope-heart-fill.svg
house-door-fill.svg safe.svg x-octagon-fill.svg capslock-fill.svg envelope-heart.svg house-door.svg safe2-fill.svg
x-octagon.svg capslock.svg envelope-open-fill.svg house-fill.svg safe2.svg x-square-fill.svg card-checklist.svg
envelope-open-heart-fill.svg house-heart-fill.svg save-fill.svg x-square.svg card-heading.svg envelope-open-heart.svg
house-heart.svg save.svg x.svg card-image.svg envelope-open.svg house.svg save2-fill.svg xbox.svg card-list.svg
envelope-paper-fill.svg hr.svg save2.svg yin-yang.svg card-text.svg envelope-paper-heart-fill.svg hurricane.svg
scissors.svg youtube.svg caret-down-fill.svg envelope-paper-heart.svg hypnotize.svg screwdriver.svg zoom-in.svg
caret-down-square-fill.svg envelope-paper.svg image-alt.svg sd-card-fill.svg zoom-out.svg caret-down-square.svg
envelope-plus-fill.svg image-fill.svg sd-card.svg caret-down.svg envelope-plus.svg image.svg search-heart-fill.svg
''';

  static final List<String> _icons = iconsList
      .split(RegExp(r'\s+'))
      .where((s) => s.isNotEmpty)
      .map((s) => s.replaceFirst('.svg', ''))
      .toList();

  static final Set<String> _iconsSet = Set.from(_icons);

  // ignore: non_constant_identifier_names
  static final String ICONS_PATH = '$BONES_UI_BOOTSTRAP_PACKAGE_PATH/icons';

  static List<String> get allIcons => List.from(_icons);

  /// Returns the path of a icon with [name].
  static String? getIconPath(String name) {
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
  static String? svgIconHTML(String name,
      {String? title,
      int? width,
      int? height,
      String? classes,
      String? style}) {
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
      {String? title,
      int? width,
      int? height,
      String? classes,
      String? style}) {
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
  static ResourceContent? svgResourceContent(String name) {
    var path = getIconPath(name);
    if (path == null) return null;
    return _resourceContentCache.get(path);
  }
}
