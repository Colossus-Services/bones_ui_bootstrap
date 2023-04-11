import 'dart:html';

import 'package:dom_tools/dom_tools.dart';
import 'package:swiss_knife/swiss_knife.dart';

import 'bones_ui_bootstrap_base.dart';

/// Bootstrap icons support.
class BootstrapIcons {
  // ignore: non_constant_identifier_names
  static final String VERSION = '1.10.4';

  static final String iconsList = '''
0-circle-fill.svg                 building.svg                      currency-yen.svg                  filetype-m4p.svg                  motherboard.svg                   sign-turn-slight-left.svg
0-circle.svg                      buildings-fill.svg                cursor-fill.svg                   filetype-md.svg                   mouse-fill.svg                    sign-turn-slight-right-fill.svg
0-square-fill.svg                 buildings.svg                     cursor-text.svg                   filetype-mdx.svg                  mouse.svg                         sign-turn-slight-right.svg
0-square.svg                      bullseye.svg                      cursor.svg                        filetype-mov.svg                  mouse2-fill.svg                   sign-yield-fill.svg
1-circle-fill.svg                 bus-front-fill.svg                dash-circle-dotted.svg            filetype-mp3.svg                  mouse2.svg                        sign-yield.svg
1-circle.svg                      bus-front.svg                     dash-circle-fill.svg              filetype-mp4.svg                  mouse3-fill.svg                   signal.svg
1-square-fill.svg                 c-circle-fill.svg                 dash-circle.svg                   filetype-otf.svg                  mouse3.svg                        signpost-2-fill.svg
1-square.svg                      c-circle.svg                      dash-lg.svg                       filetype-pdf.svg                  music-note-beamed.svg             signpost-2.svg
123.svg                           c-square-fill.svg                 dash-square-dotted.svg            filetype-php.svg                  music-note-list.svg               signpost-fill.svg
2-circle-fill.svg                 c-square.svg                      dash-square-fill.svg              filetype-png.svg                  music-note.svg                    signpost-split-fill.svg
2-circle.svg                      calculator-fill.svg               dash-square.svg                   filetype-ppt.svg                  music-player-fill.svg             signpost-split.svg
2-square-fill.svg                 calculator.svg                    dash.svg                          filetype-pptx.svg                 music-player.svg                  signpost.svg
2-square.svg                      calendar-check-fill.svg           database-add.svg                  filetype-psd.svg                  newspaper.svg                     sim-fill.svg
3-circle-fill.svg                 calendar-check.svg                database-check.svg                filetype-py.svg                   nintendo-switch.svg               sim.svg
3-circle.svg                      calendar-date-fill.svg            database-dash.svg                 filetype-raw.svg                  node-minus-fill.svg               sina-weibo.svg
3-square-fill.svg                 calendar-date.svg                 database-down.svg                 filetype-rb.svg                   node-minus.svg                    skip-backward-btn-fill.svg
3-square.svg                      calendar-day-fill.svg             database-exclamation.svg          filetype-sass.svg                 node-plus-fill.svg                skip-backward-btn.svg
4-circle-fill.svg                 calendar-day.svg                  database-fill-add.svg             filetype-scss.svg                 node-plus.svg                     skip-backward-circle-fill.svg
4-circle.svg                      calendar-event-fill.svg           database-fill-check.svg           filetype-sh.svg                   nut-fill.svg                      skip-backward-circle.svg
4-square-fill.svg                 calendar-event.svg                database-fill-dash.svg            filetype-sql.svg                  nut.svg                           skip-backward-fill.svg
4-square.svg                      calendar-fill.svg                 database-fill-down.svg            filetype-svg.svg                  nvidia.svg                        skip-backward.svg
5-circle-fill.svg                 calendar-heart-fill.svg           database-fill-exclamation.svg     filetype-tiff.svg                 octagon-fill.svg                  skip-end-btn-fill.svg
5-circle.svg                      calendar-heart.svg                database-fill-gear.svg            filetype-tsx.svg                  octagon-half.svg                  skip-end-btn.svg
5-square-fill.svg                 calendar-minus-fill.svg           database-fill-lock.svg            filetype-ttf.svg                  octagon.svg                       skip-end-circle-fill.svg
5-square.svg                      calendar-minus.svg                database-fill-slash.svg           filetype-txt.svg                  optical-audio-fill.svg            skip-end-circle.svg
6-circle-fill.svg                 calendar-month-fill.svg           database-fill-up.svg              filetype-wav.svg                  optical-audio.svg                 skip-end-fill.svg
6-circle.svg                      calendar-month.svg                database-fill-x.svg               filetype-woff.svg                 option.svg                        skip-end.svg
6-square-fill.svg                 calendar-plus-fill.svg            database-fill.svg                 filetype-xls.svg                  outlet.svg                        skip-forward-btn-fill.svg
6-square.svg                      calendar-plus.svg                 database-gear.svg                 filetype-xlsx.svg                 p-circle-fill.svg                 skip-forward-btn.svg
7-circle-fill.svg                 calendar-range-fill.svg           database-lock.svg                 filetype-xml.svg                  p-circle.svg                      skip-forward-circle-fill.svg
7-circle.svg                      calendar-range.svg                database-slash.svg                filetype-yml.svg                  p-square-fill.svg                 skip-forward-circle.svg
7-square-fill.svg                 calendar-week-fill.svg            database-up.svg                   film.svg                          p-square.svg                      skip-forward-fill.svg
7-square.svg                      calendar-week.svg                 database-x.svg                    filter-circle-fill.svg            paint-bucket.svg                  skip-forward.svg
8-circle-fill.svg                 calendar-x-fill.svg               database.svg                      filter-circle.svg                 palette-fill.svg                  skip-start-btn-fill.svg
8-circle.svg                      calendar-x.svg                    device-hdd-fill.svg               filter-left.svg                   palette.svg                       skip-start-btn.svg
8-square-fill.svg                 calendar.svg                      device-hdd.svg                    filter-right.svg                  palette2.svg                      skip-start-circle-fill.svg
8-square.svg                      calendar2-check-fill.svg          device-ssd-fill.svg               filter-square-fill.svg            paperclip.svg                     skip-start-circle.svg
9-circle-fill.svg                 calendar2-check.svg               device-ssd.svg                    filter-square.svg                 paragraph.svg                     skip-start-fill.svg
9-circle.svg                      calendar2-date-fill.svg           diagram-2-fill.svg                filter.svg                        pass-fill.svg                     skip-start.svg
9-square-fill.svg                 calendar2-date.svg                diagram-2.svg                     fingerprint.svg                   pass.svg                          skype.svg
9-square.svg                      calendar2-day-fill.svg            diagram-3-fill.svg                fire.svg                          patch-check-fill.svg              slack.svg
activity.svg                      calendar2-day.svg                 diagram-3.svg                     flag-fill.svg                     patch-check-fll.svg               slash-circle-fill.svg
airplane-engines-fill.svg         calendar2-event-fill.svg          diamond-fill.svg                  flag.svg                          patch-check.svg                   slash-circle.svg
airplane-engines.svg              calendar2-event.svg               diamond-half.svg                  flower1.svg                       patch-exclamation-fill.svg        slash-lg.svg
airplane-fill.svg                 calendar2-fill.svg                diamond.svg                       flower2.svg                       patch-exclamation-fll.svg         slash-square-fill.svg
airplane.svg                      calendar2-heart-fill.svg          dice-1-fill.svg                   flower3.svg                       patch-exclamation.svg             slash-square.svg
alarm-fill.svg                    calendar2-heart.svg               dice-1.svg                        folder-check.svg                  patch-minus-fill.svg              slash.svg
alarm.svg                         calendar2-minus-fill.svg          dice-2-fill.svg                   folder-fill.svg                   patch-minus-fll.svg               sliders.svg
alexa.svg                         calendar2-minus.svg               dice-2.svg                        folder-minus.svg                  patch-minus.svg                   sliders2-vertical.svg
align-bottom.svg                  calendar2-month-fill.svg          dice-3-fill.svg                   folder-plus.svg                   patch-plus-fill.svg               sliders2.svg
align-center.svg                  calendar2-month.svg               dice-3.svg                        folder-symlink-fill.svg           patch-plus-fll.svg                smartwatch.svg
align-end.svg                     calendar2-plus-fill.svg           dice-4-fill.svg                   folder-symlink.svg                patch-plus.svg                    snapchat.svg
align-middle.svg                  calendar2-plus.svg                dice-4.svg                        folder-x.svg                      patch-question-fill.svg           snow.svg
align-start.svg                   calendar2-range-fill.svg          dice-5-fill.svg                   folder.svg                        patch-question-fll.svg            snow2.svg
align-top.svg                     calendar2-range.svg               dice-5.svg                        folder2-open.svg                  patch-question.svg                snow3.svg
alipay.svg                        calendar2-week-fill.svg           dice-6-fill.svg                   folder2.svg                       pause-btn-fill.svg                sort-alpha-down-alt.svg
alt.svg                           calendar2-week.svg                dice-6.svg                        font                              pause-btn.svg                     sort-alpha-down.svg
amd.svg                           calendar2-x-fill.svg              disc-fill.svg                     fonts.svg                         pause-circle-fill.svg             sort-alpha-up-alt.svg
android.svg                       calendar2-x.svg                   disc.svg                          forward-fill.svg                  pause-circle.svg                  sort-alpha-up.svg
android2.svg                      calendar2.svg                     discord.svg                       forward.svg                       pause-fill.svg                    sort-down-alt.svg
app-indicator.svg                 calendar3-event-fill.svg          display-fill.svg                  front.svg                         pause.svg                         sort-down.svg
app.svg                           calendar3-event.svg               display.svg                       fuel-pump-diesel-fill.svg         paypal.svg                        sort-numeric-down-alt.svg
apple.svg                         calendar3-fill.svg                displayport-fill.svg              fuel-pump-diesel.svg              pc-display-horizontal.svg         sort-numeric-down.svg
archive-fill.svg                  calendar3-range-fill.svg          displayport.svg                   fuel-pump-fill.svg                pc-display.svg                    sort-numeric-up-alt.svg
archive.svg                       calendar3-range.svg               distribute-horizontal.svg         fuel-pump.svg                     pc-horizontal.svg                 sort-numeric-up.svg
arrow-90deg-down.svg              calendar3-week-fill.svg           distribute-vertical.svg           fullscreen-exit.svg               pc.svg                            sort-up-alt.svg
arrow-90deg-left.svg              calendar3-week.svg                door-closed-fill.svg              fullscreen.svg                    pci-card.svg                      sort-up.svg
arrow-90deg-right.svg             calendar3.svg                     door-closed.svg                   funnel-fill.svg                   peace-fill.svg                    soundwave.svg
arrow-90deg-up.svg                calendar4-event.svg               door-open-fill.svg                funnel.svg                        peace.svg                         speaker-fill.svg
arrow-bar-down.svg                calendar4-range.svg               door-open.svg                     gear-fill.svg                     pen-fill.svg                      speaker.svg
arrow-bar-left.svg                calendar4-week.svg                dot.svg                           gear-wide-connected.svg           pen.svg                           speedometer.svg
arrow-bar-right.svg               calendar4.svg                     download.svg                      gear-wide.svg                     pencil-fill.svg                   speedometer2.svg
arrow-bar-up.svg                  camera-fill.svg                   dpad-fill.svg                     gear.svg                          pencil-square.svg                 spellcheck.svg
arrow-clockwise.svg               camera-reels-fill.svg             dpad.svg                          gem.svg                           pencil.svg                        spotify.svg
arrow-counterclockwise.svg        camera-reels.svg                  dribbble.svg                      gender-ambiguous.svg              pentagon-fill.svg                 square-fill.svg
arrow-down-circle-fill.svg        camera-video-fill.svg             dropbox.svg                       gender-female.svg                 pentagon-half.svg                 square-half.svg
arrow-down-circle.svg             camera-video-off-fill.svg         droplet-fill.svg                  gender-male.svg                   pentagon.svg                      square.svg
arrow-down-left-circle-fill.svg   camera-video-off.svg              droplet-half.svg                  gender-trans.svg                  people-circle.svg                 stack-overflow.svg
arrow-down-left-circle.svg        camera-video.svg                  droplet.svg                       geo-alt-fill.svg                  people-fill.svg                   stack.svg
arrow-down-left-square-fill.svg   camera.svg                        ear-fill.svg                      geo-alt.svg                       people.svg                        star-fill.svg
arrow-down-left-square.svg        camera2.svg                       ear.svg                           geo-fill.svg                      percent.svg                       star-half.svg
arrow-down-left.svg               capslock-fill.svg                 earbuds.svg                       geo.svg                           person-add.svg                    star.svg
arrow-down-right-circle-fill.svg  capslock.svg                      easel-fill.svg                    gift-fill.svg                     person-badge-fill.svg             stars.svg
arrow-down-right-circle.svg       capsule-pill.svg                  easel.svg                         gift.svg                          person-badge.svg                  steam.svg
arrow-down-right-square-fill.svg  capsule.svg                       easel2-fill.svg                   git.svg                           person-bounding-box.svg           stickies-fill.svg
arrow-down-right-square.svg       car-front-fill.svg                easel2.svg                        github.svg                        person-check-fill.svg             stickies.svg
arrow-down-right.svg              car-front.svg                     easel3-fill.svg                   globe-americas.svg                person-check.svg                  sticky-fill.svg
arrow-down-short.svg              card-checklist.svg                easel3.svg                        globe-asia-australia.svg          person-circle.svg                 sticky.svg
arrow-down-square-fill.svg        card-heading.svg                  egg-fill.svg                      globe-central-south-asia.svg      person-dash-fill.svg              stop-btn-fill.svg
arrow-down-square.svg             card-image.svg                    egg-fried.svg                     globe-europe-africa.svg           person-dash.svg                   stop-btn.svg
arrow-down-up.svg                 card-list.svg                     egg.svg                           globe.svg                         person-down.svg                   stop-circle-fill.svg
arrow-down.svg                    card-text.svg                     eject-fill.svg                    globe2.svg                        person-exclamation.svg            stop-circle.svg
arrow-left-circle-fill.svg        caret-down-fill.svg               eject.svg                         google-play.svg                   person-fill-add.svg               stop-fill.svg
arrow-left-circle.svg             caret-down-square-fill.svg        emoji-angry-fill.svg              google.svg                        person-fill-check.svg             stop.svg
arrow-left-right.svg              caret-down-square.svg             emoji-angry.svg                   gpu-card.svg                      person-fill-dash.svg              stoplights-fill.svg
arrow-left-short.svg              caret-down.svg                    emoji-dizzy-fill.svg              graph-down-arrow.svg              person-fill-down.svg              stoplights.svg
arrow-left-square-fill.svg        caret-left-fill.svg               emoji-dizzy.svg                   graph-down.svg                    person-fill-exclamation.svg       stopwatch-fill.svg
arrow-left-square.svg             caret-left-square-fill.svg        emoji-expressionless-fill.svg     graph-up-arrow.svg                person-fill-gear.svg              stopwatch.svg
arrow-left.svg                    caret-left-square.svg             emoji-expressionless.svg          graph-up.svg                      person-fill-lock.svg              strava.svg
arrow-repeat.svg                  caret-left.svg                    emoji-frown-fill.svg              grid-1x2-fill.svg                 person-fill-slash.svg             stripe.svg
arrow-return-left.svg             caret-right-fill.svg              emoji-frown.svg                   grid-1x2.svg                      person-fill-up.svg                subscript.svg
arrow-return-right.svg            caret-right-square-fill.svg       emoji-heart-eyes-fill.svg         grid-3x2-gap-fill.svg             person-fill-x.svg                 subtract.svg
arrow-right-circle-fill.svg       caret-right-square.svg            emoji-heart-eyes.svg              grid-3x2-gap.svg                  person-fill.svg                   suit-club-fill.svg
arrow-right-circle.svg            caret-right.svg                   emoji-kiss-fill.svg               grid-3x2.svg                      person-gear.svg                   suit-club.svg
arrow-right-short.svg             caret-up-fill.svg                 emoji-kiss.svg                    grid-3x3-gap-fill.svg             person-heart.svg                  suit-diamond-fill.svg
arrow-right-square-fill.svg       caret-up-square-fill.svg          emoji-laughing-fill.svg           grid-3x3-gap.svg                  person-hearts.svg                 suit-diamond.svg
arrow-right-square.svg            caret-up-square.svg               emoji-laughing.svg                grid-3x3.svg                      person-lines-fill.svg             suit-heart-fill.svg
arrow-right.svg                   caret-up.svg                      emoji-neutral-fill.svg            grid-fill.svg                     person-lock.svg                   suit-heart.svg
arrow-through-heart-fill.svg      cart-check-fill.svg               emoji-neutral.svg                 grid.svg                          person-plus-fill.svg              suit-spade-fill.svg
arrow-through-heart.svg           cart-check.svg                    emoji-smile-fill.svg              grip-horizontal.svg               person-plus.svg                   suit-spade.svg
arrow-up-circle-fill.svg          cart-dash-fill.svg                emoji-smile-upside-down-fill.svg  grip-vertical.svg                 person-rolodex.svg                sun-fill.svg
arrow-up-circle.svg               cart-dash.svg                     emoji-smile-upside-down.svg       h-circle-fill.svg                 person-slash.svg                  sun.svg
arrow-up-down.svg                 cart-fill.svg                     emoji-smile.svg                   h-circle.svg                      person-square.svg                 sunglasses.svg
arrow-up-left-circle-fill.svg     cart-plus-fill.svg                emoji-sunglasses-fill.svg         h-square-fill.svg                 person-up.svg                     sunrise-fill.svg
arrow-up-left-circle.svg          cart-plus.svg                     emoji-sunglasses.svg              h-square.svg                      person-vcard-fill.svg             sunrise.svg
arrow-up-left-square-fill.svg     cart-x-fill.svg                   emoji-wink-fill.svg               hammer.svg                        person-vcard.svg                  sunset-fill.svg
arrow-up-left-square.svg          cart-x.svg                        emoji-wink.svg                    hand-index-fill.svg               person-video.svg                  sunset.svg
arrow-up-left.svg                 cart.svg                          envelope-at-fill.svg              hand-index-thumb-fill.svg         person-video2.svg                 superscript.svg
arrow-up-right-circle-fill.svg    cart2.svg                         envelope-at.svg                   hand-index-thumb.svg              person-video3.svg                 symmetry-horizontal.svg
arrow-up-right-circle.svg         cart3.svg                         envelope-check-fill.svg           hand-index.svg                    person-workspace.svg              symmetry-vertical.svg
arrow-up-right-square-fill.svg    cart4.svg                         envelope-check.svg                hand-thumbs-down-fill.svg         person-x-fill.svg                 table.svg
arrow-up-right-square.svg         cash-coin.svg                     envelope-dash-fill.svg            hand-thumbs-down.svg              person-x.svg                      tablet-fill.svg
arrow-up-right.svg                cash-stack.svg                    envelope-dash.svg                 hand-thumbs-up-fill.svg           person.svg                        tablet-landscape-fill.svg
arrow-up-short.svg                cash.svg                          envelope-exclamation-fill.svg     hand-thumbs-up.svg                phone-fill.svg                    tablet-landscape.svg
arrow-up-square-fill.svg          cassette-fill.svg                 envelope-exclamation.svg          handbag-fill.svg                  phone-flip.svg                    tablet.svg
arrow-up-square.svg               cassette.svg                      envelope-fill.svg                 handbag.svg                       phone-landscape-fill.svg          tag-fill.svg
arrow-up.svg                      cast.svg                          envelope-heart-fill.svg           hash.svg                          phone-landscape.svg               tag.svg
arrows-angle-contract.svg         cc-circle-fill.svg                envelope-heart.svg                hdd-fill.svg                      phone-vibrate-fill.svg            tags-fill.svg
arrows-angle-expand.svg           cc-circle.svg                     envelope-open-fill.svg            hdd-network-fill.svg              phone-vibrate.svg                 tags.svg
arrows-collapse.svg               cc-square-fill.svg                envelope-open-heart-fill.svg      hdd-network.svg                   phone.svg                         taxi-front-fill.svg
arrows-expand.svg                 cc-square.svg                     envelope-open-heart.svg           hdd-rack-fill.svg                 pie-chart-fill.svg                taxi-front.svg
arrows-fullscreen.svg             chat-dots-fill.svg                envelope-open.svg                 hdd-rack.svg                      pie-chart.svg                     telegram.svg
arrows-move.svg                   chat-dots.svg                     envelope-paper-fill.svg           hdd-stack-fill.svg                piggy-bank-fill.svg               telephone-fill.svg
aspect-ratio-fill.svg             chat-fill.svg                     envelope-paper-heart-fill.svg     hdd-stack.svg                     piggy-bank.svg                    telephone-forward-fill.svg
aspect-ratio.svg                  chat-heart-fill.svg               envelope-paper-heart.svg          hdd.svg                           pin-angle-fill.svg                telephone-forward.svg
asterisk.svg                      chat-heart.svg                    envelope-paper.svg                hdmi-fill.svg                     pin-angle.svg                     telephone-inbound-fill.svg
at.svg                            chat-left-dots-fill.svg           envelope-plus-fill.svg            hdmi.svg                          pin-fill.svg                      telephone-inbound.svg
award-fill.svg                    chat-left-dots.svg                envelope-plus.svg                 headphones.svg                    pin-map-fill.svg                  telephone-minus-fill.svg
award.svg                         chat-left-fill.svg                envelope-slash-fill.svg           headset-vr.svg                    pin-map.svg                       telephone-minus.svg
back.svg                          chat-left-heart-fill.svg          envelope-slash.svg                headset.svg                       pin.svg                           telephone-outbound-fill.svg
backspace-fill.svg                chat-left-heart.svg               envelope-x-fill.svg               heart-arrow.svg                   pinterest.svg                     telephone-outbound.svg
backspace-reverse-fill.svg        chat-left-quote-fill.svg          envelope-x.svg                    heart-fill.svg                    pip-fill.svg                      telephone-plus-fill.svg
backspace-reverse.svg             chat-left-quote.svg               envelope.svg                      heart-half.svg                    pip.svg                           telephone-plus.svg
backspace.svg                     chat-left-text-fill.svg           eraser-fill.svg                   heart-pulse-fill.svg              play-btn-fill.svg                 telephone-x-fill.svg
badge-3d-fill.svg                 chat-left-text.svg                eraser.svg                        heart-pulse.svg                   play-btn.svg                      telephone-x.svg
badge-3d.svg                      chat-left.svg                     escape.svg                        heart.svg                         play-circle-fill.svg              telephone.svg
badge-4k-fill.svg                 chat-quote-fill.svg               ethernet.svg                      heartbreak-fill.svg               play-circle.svg                   tencent-qq.svg
badge-4k.svg                      chat-quote.svg                    ev-front-fill.svg                 heartbreak.svg                    play-fill.svg                     terminal-dash.svg
badge-8k-fill.svg                 chat-right-dots-fill.svg          ev-front.svg                      hearts.svg                        play.svg                          terminal-fill.svg
badge-8k.svg                      chat-right-dots.svg               ev-station-fill.svg               heptagon-fill.svg                 playstation.svg                   terminal-plus.svg
badge-ad-fill.svg                 chat-right-fill.svg               ev-station.svg                    heptagon-half.svg                 plug-fill.svg                     terminal-split.svg
badge-ad.svg                      chat-right-heart-fill.svg         exclamation-circle-fill.svg       heptagon.svg                      plug.svg                          terminal-x.svg
badge-ar-fill.svg                 chat-right-heart.svg              exclamation-circle.svg            hexagon-fill.svg                  plugin.svg                        terminal.svg
badge-ar.svg                      chat-right-quote-fill.svg         exclamation-diamond-fill.svg      hexagon-half.svg                  plus-circle-dotted.svg            text-center.svg
badge-cc-fill.svg                 chat-right-quote.svg              exclamation-diamond.svg           hexagon.svg                       plus-circle-fill.svg              text-indent-left.svg
badge-cc.svg                      chat-right-text-fill.svg          exclamation-lg.svg                hospital-fill.svg                 plus-circle.svg                   text-indent-right.svg
badge-hd-fill.svg                 chat-right-text.svg               exclamation-octagon-fill.svg      hospital.svg                      plus-lg.svg                       text-left.svg
badge-hd.svg                      chat-right.svg                    exclamation-octagon.svg           hourglass-bottom.svg              plus-slash-minus.svg              text-paragraph.svg
badge-sd-fill.svg                 chat-square-dots-fill.svg         exclamation-square-fill.svg       hourglass-split.svg               plus-square-dotted.svg            text-right.svg
badge-sd.svg                      chat-square-dots.svg              exclamation-square.svg            hourglass-top.svg                 plus-square-fill.svg              text-wrap.svg
badge-tm-fill.svg                 chat-square-fill.svg              exclamation-triangle-fill.svg     hourglass.svg                     plus-square.svg                   textarea-resize.svg
badge-tm.svg                      chat-square-heart-fill.svg        exclamation-triangle.svg          house-add-fill.svg                plus.svg                          textarea-t.svg
badge-vo-fill.svg                 chat-square-heart.svg             exclamation.svg                   house-add.svg                     postage-fill.svg                  textarea.svg
badge-vo.svg                      chat-square-quote-fill.svg        exclude.svg                       house-check-fill.svg              postage-heart-fill.svg            thermometer-half.svg
badge-vr-fill.svg                 chat-square-quote.svg             explicit-fill.svg                 house-check.svg                   postage-heart.svg                 thermometer-high.svg
badge-vr.svg                      chat-square-text-fill.svg         explicit.svg                      house-dash-fill.svg               postage.svg                       thermometer-low.svg
badge-wc-fill.svg                 chat-square-text.svg              eye-fill.svg                      house-dash.svg                    postcard-fill.svg                 thermometer-snow.svg
badge-wc.svg                      chat-square.svg                   eye-slash-fill.svg                house-door-fill.svg               postcard-heart-fill.svg           thermometer-sun.svg
bag-check-fill.svg                chat-text-fill.svg                eye-slash.svg                     house-door.svg                    postcard-heart.svg                thermometer.svg
bag-check.svg                     chat-text.svg                     eye.svg                           house-down-fill.svg               postcard.svg                      three-dots-vertical.svg
bag-dash-fill.svg                 chat.svg                          eyedropper.svg                    house-down.svg                    power.svg                         three-dots.svg
bag-dash.svg                      check-all.svg                     eyeglasses.svg                    house-exclamation-fill.svg        prescription.svg                  thunderbolt-fill.svg
bag-fill.svg                      check-box.svg                     facebook.svg                      house-exclamation.svg             prescription2.svg                 thunderbolt.svg
bag-heart-fill.svg                check-circle-fill.svg             fan.svg                           house-fill.svg                    printer-fill.svg                  ticket-detailed-fill.svg
bag-heart.svg                     check-circle.svg                  fast-forward-btn-fill.svg         house-gear-fill.svg               printer.svg                       ticket-detailed.svg
bag-plus-fill.svg                 check-lg.svg                      fast-forward-btn.svg              house-gear.svg                    projector-fill.svg                ticket-fill.svg
bag-plus.svg                      check-square-fill.svg             fast-forward-circle-fill.svg      house-heart-fill.svg              projector.svg                     ticket-perforated-fill.svg
bag-x-fill.svg                    check-square.svg                  fast-forward-circle.svg           house-heart.svg                   puzzle-fill.svg                   ticket-perforated.svg
bag-x.svg                         check.svg                         fast-forward-fill.svg             house-lock-fill.svg               puzzle.svg                        ticket.svg
bag.svg                           check2-all.svg                    fast-forward.svg                  house-lock.svg                    qr-code-scan.svg                  tiktok.svg
balloon-fill.svg                  check2-circle.svg                 file-arrow-down-fill.svg          house-slash-fill.svg              qr-code.svg                       toggle-off.svg
balloon-heart-fill.svg            check2-square.svg                 file-arrow-down.svg               house-slash.svg                   question-circle-fill.svg          toggle-on.svg
balloon-heart.svg                 check2.svg                        file-arrow-up-fill.svg            house-up-fill.svg                 question-circle.svg               toggle2-off.svg
balloon.svg                       chevron-bar-contract.svg          file-arrow-up.svg                 house-up.svg                      question-diamond-fill.svg         toggle2-on.svg
bandaid-fill.svg                  chevron-bar-down.svg              file-bar-graph-fill.svg           house-x-fill.svg                  question-diamond.svg              toggles.svg
bandaid.svg                       chevron-bar-expand.svg            file-bar-graph.svg                house-x.svg                       question-lg.svg                   toggles2.svg
bank.svg                          chevron-bar-left.svg              file-binary-fill.svg              house.svg                         question-octagon-fill.svg         tools.svg
bank2.svg                         chevron-bar-right.svg             file-binary.svg                   houses-fill.svg                   question-octagon.svg              tornado.svg
bar-chart-fill.svg                chevron-bar-up.svg                file-break-fill.svg               houses.svg                        question-square-fill.svg          train-freight-front-fill.svg
bar-chart-line-fill.svg           chevron-compact-down.svg          file-break.svg                    hr.svg                            question-square.svg               train-freight-front.svg
bar-chart-line.svg                chevron-compact-left.svg          file-check-fill.svg               hurricane.svg                     question.svg                      train-front-fill.svg
bar-chart-steps.svg               chevron-compact-right.svg         file-check.svg                    hypnotize.svg                     quora.svg                         train-front.svg
bar-chart.svg                     chevron-compact-up.svg            file-code-fill.svg                image-alt.svg                     quote.svg                         train-lightrail-front-fill.svg
basket-fill.svg                   chevron-contract.svg              file-code.svg                     image-fill.svg                    r-circle-fill.svg                 train-lightrail-front.svg
basket.svg                        chevron-double-down.svg           file-diff-fill.svg                image.svg                         r-circle.svg                      translate.svg
basket2-fill.svg                  chevron-double-left.svg           file-diff.svg                     images.svg                        r-square-fill.svg                 trash-fill.svg
basket2.svg                       chevron-double-right.svg          file-earmark-arrow-down-fill.svg  inbox-fill.svg                    r-square.svg                      trash.svg
basket3-fill.svg                  chevron-double-up.svg             file-earmark-arrow-down.svg       inbox.svg                         radioactive.svg                   trash2-fill.svg
basket3.svg                       chevron-down.svg                  file-earmark-arrow-up-fill.svg    inboxes-fill.svg                  rainbow.svg                       trash2.svg
battery-charging.svg              chevron-expand.svg                file-earmark-arrow-up.svg         inboxes.svg                       receipt-cutoff.svg                trash3-fill.svg
battery-full.svg                  chevron-left.svg                  file-earmark-bar-graph-fill.svg   incognito.svg                     receipt.svg                       trash3.svg
battery-half.svg                  chevron-right.svg                 file-earmark-bar-graph.svg        indent.svg                        reception-0.svg                   tree-fill.svg
battery.svg                       chevron-up.svg                    file-earmark-binary-fill.svg      infinity.svg                      reception-1.svg                   tree.svg
behance.svg                       circle-fill.svg                   file-earmark-binary.svg           info-circle-fill.svg              reception-2.svg                   trello.svg
bell-fill.svg                     circle-half.svg                   file-earmark-break-fill.svg       info-circle.svg                   reception-3.svg                   triangle-fill.svg
bell-slash-fill.svg               circle-square.svg                 file-earmark-break.svg            info-lg.svg                       reception-4.svg                   triangle-half.svg
bell-slash.svg                    circle.svg                        file-earmark-check-fill.svg       info-square-fill.svg              record-btn-fill.svg               triangle.svg
bell.svg                          clipboard-check-fill.svg          file-earmark-check.svg            info-square.svg                   record-btn.svg                    trophy-fill.svg
bezier.svg                        clipboard-check.svg               file-earmark-code-fill.svg        info.svg                          record-circle-fill.svg            trophy.svg
bezier2.svg                       clipboard-data-fill.svg           file-earmark-code.svg             input-cursor-text.svg             record-circle.svg                 tropical-storm.svg
bicycle.svg                       clipboard-data.svg                file-earmark-diff-fill.svg        input-cursor.svg                  record-fill.svg                   truck-flatbed.svg
binoculars-fill.svg               clipboard-fill.svg                file-earmark-diff.svg             instagram.svg                     record.svg                        truck-front-fill.svg
binoculars.svg                    clipboard-heart-fill.svg          file-earmark-easel-fill.svg       intersect.svg                     record2-fill.svg                  truck-front.svg
blockquote-left.svg               clipboard-heart.svg               file-earmark-easel.svg            journal-album.svg                 record2.svg                       truck.svg
blockquote-right.svg              clipboard-minus-fill.svg          file-earmark-excel-fill.svg       journal-arrow-down.svg            recycle.svg                       tsunami.svg
bluetooth.svg                     clipboard-minus.svg               file-earmark-excel.svg            journal-arrow-up.svg              reddit.svg                        tv-fill.svg
body-text.svg                     clipboard-plus-fill.svg           file-earmark-fill.svg             journal-bookmark-fill.svg         regex.svg                         tv.svg
book-fill.svg                     clipboard-plus.svg                file-earmark-font-fill.svg        journal-bookmark.svg              repeat-1.svg                      twitch.svg
book-half.svg                     clipboard-pulse.svg               file-earmark-font.svg             journal-check.svg                 repeat.svg                        twitter.svg
book.svg                          clipboard-x-fill.svg              file-earmark-image-fill.svg       journal-code.svg                  reply-all-fill.svg                type-bold.svg
bookmark-check-fill.svg           clipboard-x.svg                   file-earmark-image.svg            journal-medical.svg               reply-all.svg                     type-h1.svg
bookmark-check.svg                clipboard.svg                     file-earmark-lock-fill.svg        journal-minus.svg                 reply-fill.svg                    type-h2.svg
bookmark-dash-fill.svg            clipboard2-check-fill.svg         file-earmark-lock.svg             journal-plus.svg                  reply.svg                         type-h3.svg
bookmark-dash.svg                 clipboard2-check.svg              file-earmark-lock2-fill.svg       journal-richtext.svg              rewind-btn-fill.svg               type-italic.svg
bookmark-fill.svg                 clipboard2-data-fill.svg          file-earmark-lock2.svg            journal-text.svg                  rewind-btn.svg                    type-strikethrough.svg
bookmark-heart-fill.svg           clipboard2-data.svg               file-earmark-medical-fill.svg     journal-x.svg                     rewind-circle-fill.svg            type-underline.svg
bookmark-heart.svg                clipboard2-fill.svg               file-earmark-medical.svg          journal.svg                       rewind-circle.svg                 type.svg
bookmark-plus-fill.svg            clipboard2-heart-fill.svg         file-earmark-minus-fill.svg       journals.svg                      rewind-fill.svg                   ubuntu.svg
bookmark-plus.svg                 clipboard2-heart.svg              file-earmark-minus.svg            joystick.svg                      rewind.svg                        ui-checks-grid.svg
bookmark-star-fill.svg            clipboard2-minus-fill.svg         file-earmark-music-fill.svg       justify-left.svg                  robot.svg                         ui-checks.svg
bookmark-star.svg                 clipboard2-minus.svg              file-earmark-music.svg            justify-right.svg                 rocket-fill.svg                   ui-radios-grid.svg
bookmark-x-fill.svg               clipboard2-plus-fill.svg          file-earmark-pdf-fill.svg         justify.svg                       rocket-takeoff-fill.svg           ui-radios.svg
bookmark-x.svg                    clipboard2-plus.svg               file-earmark-pdf.svg              kanban-fill.svg                   rocket-takeoff.svg                umbrella-fill.svg
bookmark.svg                      clipboard2-pulse-fill.svg         file-earmark-person-fill.svg      kanban.svg                        rocket.svg                        umbrella.svg
bookmarks-fill.svg                clipboard2-pulse.svg              file-earmark-person.svg           key-fill.svg                      router-fill.svg                   unindent.svg
bookmarks.svg                     clipboard2-x-fill.svg             file-earmark-play-fill.svg        key.svg                           router.svg                        union.svg
bookshelf.svg                     clipboard2-x.svg                  file-earmark-play.svg             keyboard-fill.svg                 rss-fill.svg                      unity.svg
boombox-fill.svg                  clipboard2.svg                    file-earmark-plus-fill.svg        keyboard.svg                      rss.svg                           universal-access-circle.svg
boombox.svg                       clock-fill.svg                    file-earmark-plus.svg             ladder.svg                        rulers.svg                        universal-access.svg
bootstrap-fill.svg                clock-history.svg                 file-earmark-post-fill.svg        lamp-fill.svg                     safe-fill.svg                     unlock-fill.svg
bootstrap-icons.svg               clock.svg                         file-earmark-post.svg             lamp.svg                          safe.svg                          unlock.svg
bootstrap-reboot.svg              cloud-arrow-down-fill.svg         file-earmark-ppt-fill.svg         laptop-fill.svg                   safe2-fill.svg                    upc-scan.svg
bootstrap.svg                     cloud-arrow-down.svg              file-earmark-ppt.svg              laptop.svg                        safe2.svg                         upc.svg
border-all.svg                    cloud-arrow-up-fill.svg           file-earmark-richtext-fill.svg    layer-backward.svg                save-fill.svg                     upload.svg
border-bottom.svg                 cloud-arrow-up.svg                file-earmark-richtext.svg         layer-forward.svg                 save.svg                          usb-c-fill.svg
border-center.svg                 cloud-check-fill.svg              file-earmark-ruled-fill.svg       layers-fill.svg                   save2-fill.svg                    usb-c.svg
border-inner.svg                  cloud-check.svg                   file-earmark-ruled.svg            layers-half.svg                   save2.svg                         usb-drive-fill.svg
border-left.svg                   cloud-download-fill.svg           file-earmark-slides-fill.svg      layers.svg                        scissors.svg                      usb-drive.svg
border-middle.svg                 cloud-download.svg                file-earmark-slides.svg           layout-sidebar-inset-reverse.svg  scooter.svg                       usb-fill.svg
border-outer.svg                  cloud-drizzle-fill.svg            file-earmark-spreadsheet-fill.svg layout-sidebar-inset.svg          screwdriver.svg                   usb-micro-fill.svg
border-right.svg                  cloud-drizzle.svg                 file-earmark-spreadsheet.svg      layout-sidebar-reverse.svg        sd-card-fill.svg                  usb-micro.svg
border-style.svg                  cloud-fill.svg                    file-earmark-text-fill.svg        layout-sidebar.svg                sd-card.svg                       usb-mini-fill.svg
border-top.svg                    cloud-fog-fill.svg                file-earmark-text.svg             layout-split.svg                  search-heart-fill.svg             usb-mini.svg
border-width.svg                  cloud-fog.svg                     file-earmark-word-fill.svg        layout-text-sidebar-reverse.svg   search-heart.svg                  usb-plug-fill.svg
border.svg                        cloud-fog2-fill.svg               file-earmark-word.svg             layout-text-sidebar.svg           search.svg                        usb-plug.svg
bounding-box-circles.svg          cloud-fog2.svg                    file-earmark-x-fill.svg           layout-text-window-reverse.svg    segmented-nav.svg                 usb-symbol.svg
bounding-box.svg                  cloud-hail-fill.svg               file-earmark-x.svg                layout-text-window.svg            send-check-fill.svg               usb.svg
box-arrow-down-left.svg           cloud-hail.svg                    file-earmark-zip-fill.svg         layout-three-columns.svg          send-check.svg                    valentine.svg
box-arrow-down-right.svg          cloud-haze-1.svg                  file-earmark-zip.svg              layout-wtf.svg                    send-dash-fill.svg                valentine2.svg
box-arrow-down.svg                cloud-haze-fill.svg               file-earmark.svg                  life-preserver.svg                send-dash.svg                     vector-pen.svg
box-arrow-in-down-left.svg        cloud-haze.svg                    file-easel-fill.svg               lightbulb-fill.svg                send-exclamation-fill.svg         view-list.svg
box-arrow-in-down-right.svg       cloud-haze2-fill.svg              file-easel.svg                    lightbulb-off-fill.svg            send-exclamation.svg              view-stacked.svg
box-arrow-in-down.svg             cloud-haze2.svg                   file-excel-fill.svg               lightbulb-off.svg                 send-fill.svg                     vimeo.svg
box-arrow-in-left.svg             cloud-lightning-fill.svg          file-excel.svg                    lightbulb.svg                     send-plus-fill.svg                vinyl-fill.svg
box-arrow-in-right.svg            cloud-lightning-rain-fill.svg     file-fill.svg                     lightning-charge-fill.svg         send-plus.svg                     vinyl.svg
box-arrow-in-up-left.svg          cloud-lightning-rain.svg          file-font-fill.svg                lightning-charge.svg              send-slash-fill.svg               virus.svg
box-arrow-in-up-right.svg         cloud-lightning.svg               file-font.svg                     lightning-fill.svg                send-slash.svg                    virus2.svg
box-arrow-in-up.svg               cloud-minus-fill.svg              file-image-fill.svg               lightning.svg                     send-x-fill.svg                   voicemail.svg
box-arrow-left.svg                cloud-minus.svg                   file-image.svg                    line.svg                          send-x.svg                        volume-down-fill.svg
box-arrow-right.svg               cloud-moon-fill.svg               file-lock-fill.svg                link-45deg.svg                    send.svg                          volume-down.svg
box-arrow-up-left.svg             cloud-moon.svg                    file-lock.svg                     link.svg                          server.svg                        volume-mute-fill.svg
box-arrow-up-right.svg            cloud-plus-fill.svg               file-lock2-fill.svg               linkedin.svg                      share-fill.svg                    volume-mute.svg
box-arrow-up.svg                  cloud-plus.svg                    file-lock2.svg                    list-check.svg                    share.svg                         volume-off-fill.svg
box-fill.svg                      cloud-rain-fill.svg               file-medical-fill.svg             list-columns-reverse.svg          shield-check.svg                  volume-off.svg
box-seam-fill.svg                 cloud-rain-heavy-fill.svg         file-medical.svg                  list-columns.svg                  shield-exclamation.svg            volume-up-fill.svg
box-seam.svg                      cloud-rain-heavy.svg              file-minus-fill.svg               list-nested.svg                   shield-fill-check.svg             volume-up.svg
box.svg                           cloud-rain.svg                    file-minus.svg                    list-ol.svg                       shield-fill-exclamation.svg       vr.svg
box2-fill.svg                     cloud-slash-fill.svg              file-music-fill.svg               list-stars.svg                    shield-fill-minus.svg             wallet-fill.svg
box2-heart-fill.svg               cloud-slash.svg                   file-music.svg                    list-task.svg                     shield-fill-plus.svg              wallet.svg
box2-heart.svg                    cloud-sleet-fill.svg              file-pdf-fill.svg                 list-ul.svg                       shield-fill-x.svg                 wallet2.svg
box2.svg                          cloud-sleet.svg                   file-pdf.svg                      list.svg                          shield-fill.svg                   watch.svg
boxes.svg                         cloud-snow-fill.svg               file-person-fill.svg              lock-fill.svg                     shield-lock-fill.svg              water.svg
braces-asterisk.svg               cloud-snow.svg                    file-person.svg                   lock.svg                          shield-lock.svg                   webcam-fill.svg
braces.svg                        cloud-sun-fill.svg                file-play-fill.svg                lungs-fill.svg                    shield-minus.svg                  webcam.svg
bricks.svg                        cloud-sun.svg                     file-play.svg                     lungs.svg                         shield-plus.svg                   wechat.svg
briefcase-fill.svg                cloud-upload-fill.svg             file-plus-fill.svg                magic.svg                         shield-shaded.svg                 whatsapp.svg
briefcase.svg                     cloud-upload.svg                  file-plus.svg                     magnet-fill.svg                   shield-slash-fill.svg             wifi-1.svg
brightness-alt-high-fill.svg      cloud.svg                         file-post-fill.svg                magnet.svg                        shield-slash.svg                  wifi-2.svg
brightness-alt-high.svg           clouds-fill.svg                   file-post.svg                     mailbox.svg                       shield-x.svg                      wifi-off.svg
brightness-alt-low-fill.svg       clouds.svg                        file-ppt-fill.svg                 mailbox2.svg                      shield.svg                        wifi.svg
brightness-alt-low.svg            cloudy-fill.svg                   file-ppt.svg                      map-fill.svg                      shift-fill.svg                    wikipedia.svg
brightness-high-fill.svg          cloudy.svg                        file-richtext-fill.svg            map.svg                           shift.svg                         wind.svg
brightness-high.svg               code-slash.svg                    file-richtext.svg                 markdown-fill.svg                 shop-window.svg                   window-dash.svg
brightness-low-fill.svg           code-square.svg                   file-ruled-fill.svg               markdown.svg                      shop.svg                          window-desktop.svg
brightness-low.svg                code.svg                          file-ruled.svg                    mask.svg                          shuffle.svg                       window-dock.svg
broadcast-pin.svg                 coin.svg                          file-slides-fill.svg              mastodon.svg                      sign-dead-end-fill.svg            window-fullscreen.svg
broadcast.svg                     collection-fill.svg               file-slides.svg                   medium.svg                        sign-dead-end.svg                 window-plus.svg
browser-chrome.svg                collection-play-fill.svg          file-spreadsheet-fill.svg         megaphone-fill.svg                sign-do-not-enter-fill.svg        window-sidebar.svg
browser-edge.svg                  collection-play.svg               file-spreadsheet.svg              megaphone.svg                     sign-do-not-enter.svg             window-split.svg
browser-firefox.svg               collection.svg                    file-text-fill.svg                memory.svg                        sign-intersection-fill.svg        window-stack.svg
browser-safari.svg                columns-gap.svg                   file-text.svg                     menu-app-fill.svg                 sign-intersection-side-fill.svg   window-x.svg
brush-fill.svg                    columns.svg                       file-word-fill.svg                menu-app.svg                      sign-intersection-side.svg        window.svg
brush.svg                         command.svg                       file-word.svg                     menu-button-fill.svg              sign-intersection-t-fill.svg      windows.svg
bucket-fill.svg                   compass-fill.svg                  file-x-fill.svg                   menu-button-wide-fill.svg         sign-intersection-t.svg           wordpress.svg
bucket.svg                        compass.svg                       file-x.svg                        menu-button-wide.svg              sign-intersection-y-fill.svg      wrench-adjustable-circle-fill.svg
bug-fill.svg                      cone-striped.svg                  file-zip-fill.svg                 menu-button.svg                   sign-intersection-y.svg           wrench-adjustable-circle.svg
bug.svg                           cone.svg                          file-zip.svg                      menu-down.svg                     sign-intersection.svg             wrench-adjustable.svg
building-add.svg                  controller.svg                    file.svg                          menu-up.svg                       sign-merge-left-fill.svg          wrench.svg
building-check.svg                cpu-fill.svg                      files-alt.svg                     messenger.svg                     sign-merge-left.svg               x-circle-fill.svg
building-dash.svg                 cpu.svg                           files.svg                         meta.svg                          sign-merge-right-fill.svg         x-circle.svg
building-down.svg                 credit-card-2-back-fill.svg       filetype-aac.svg                  mic-fill.svg                      sign-merge-right.svg              x-diamond-fill.svg
building-exclamation.svg          credit-card-2-back.svg            filetype-ai.svg                   mic-mute-fill.svg                 sign-no-left-turn-fill.svg        x-diamond.svg
building-fill-add.svg             credit-card-2-front-fill.svg      filetype-bmp.svg                  mic-mute.svg                      sign-no-left-turn.svg             x-lg.svg
building-fill-check.svg           credit-card-2-front.svg           filetype-cs.svg                   mic.svg                           sign-no-parking-fill.svg          x-octagon-fill.svg
building-fill-dash.svg            credit-card-fill.svg              filetype-css.svg                  microsoft-teams.svg               sign-no-parking.svg               x-octagon.svg
building-fill-down.svg            credit-card.svg                   filetype-csv.svg                  microsoft.svg                     sign-no-right-turn-fill.svg       x-square-fill.svg
building-fill-exclamation.svg     crop.svg                          filetype-doc.svg                  minecart-loaded.svg               sign-no-right-turn.svg            x-square.svg
building-fill-gear.svg            cup-fill.svg                      filetype-docx.svg                 minecart.svg                      sign-railroad-fill.svg            x.svg
building-fill-lock.svg            cup-hot-fill.svg                  filetype-exe.svg                  modem-fill.svg                    sign-railroad.svg                 xbox.svg
building-fill-slash.svg           cup-hot.svg                       filetype-gif.svg                  modem.svg                         sign-stop-fill.svg                yelp.svg
building-fill-up.svg              cup-straw.svg                     filetype-heic.svg                 moisture.svg                      sign-stop-lights-fill.svg         yin-yang.svg
building-fill-x.svg               cup.svg                           filetype-html.svg                 moon-fill.svg                     sign-stop-lights.svg              youtube.svg
building-fill.svg                 currency-bitcoin.svg              filetype-java.svg                 moon-stars-fill.svg               sign-stop.svg                     zoom-in.svg
building-gear.svg                 currency-dollar.svg               filetype-jpg.svg                  moon-stars.svg                    sign-turn-left-fill.svg           zoom-out.svg
building-lock.svg                 currency-euro.svg                 filetype-js.svg                   moon.svg                          sign-turn-left.svg
building-slash.svg                currency-exchange.svg             filetype-json.svg                 mortarboard-fill.svg              sign-turn-right-fill.svg
building-up.svg                   currency-pound.svg                filetype-jsx.svg                  mortarboard.svg                   sign-turn-right.svg
building-x.svg                    currency-rupee.svg                filetype-key.svg                  motherboard-fill.svg              sign-turn-slight-left-fill.svg
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
