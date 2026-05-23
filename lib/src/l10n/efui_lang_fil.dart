// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class EFUILangFil extends EFUILang {
  EFUILangFil([String locale = 'fil']) : super(locale);

  @override
  String get gApply => 'Ilapat';

  @override
  String get gApplyChanges => 'Ilapat ang mga pagbabago';

  @override
  String get gContinue => 'Magpatuloy';

  @override
  String get gOpen => 'Buksan';

  @override
  String get gOpenLink => 'Buksan ang link';

  @override
  String get gSkip => 'Laktawan';

  @override
  String get gSuccess => 'Tagumpay';

  @override
  String get gSuccessExl => 'Tagumpay!';

  @override
  String get gYes => 'Oo';

  @override
  String get gAnd => 'at';

  @override
  String get gHelp => 'Tulong';

  @override
  String get gNA => 'N/A';

  @override
  String get gNAHint => 'Hindi naaangkop';

  @override
  String get gOptional => 'opsyonal';

  @override
  String get gOptions => 'Mga Opsyon';

  @override
  String get gRequired => 'Kinakailangan';

  @override
  String get gThe => 'Ang';

  @override
  String get gBack => 'Bumalik';

  @override
  String get gCancel => 'Kanselahin';

  @override
  String get gClose => 'Isara';

  @override
  String get gDisabled => 'Naka-disable';

  @override
  String get gError => 'Error';

  @override
  String get gFailure => 'Pagkabigo';

  @override
  String get gNo => 'Hindi';

  @override
  String get gRedo => 'I-redo';

  @override
  String get gUndo => 'I-undo';

  @override
  String get gSettings => 'Mga Setting';

  @override
  String get gGlobal => 'Pangkalahatan';

  @override
  String get gColor => 'Kulay';

  @override
  String get gDesign => 'Disenyo';

  @override
  String get gLayout => 'Layout';

  @override
  String get gText => 'Teksto';

  @override
  String get gDark => 'Madilim';

  @override
  String get gLight => 'Maliwanag';

  @override
  String get gSystem => 'System';

  @override
  String get gEditing => 'Ine-edit: ';

  @override
  String get gEditingHint => 'I-activate para i-edit';

  @override
  String get gDarkTheme => 'Madilim na tema';

  @override
  String get gLightTheme => 'Maliwanag na tema';

  @override
  String get gBothThemes => 'Parehong tema';

  @override
  String get gLeft => 'Kaliwa';

  @override
  String get gRight => 'Kanan';

  @override
  String get gAdvanced => 'Advanced';

  @override
  String get gQuick => 'Mabilis';

  @override
  String get gDecrease => 'Bawasan';

  @override
  String get gIncrease => 'Dagdagan';

  @override
  String get gMaximum => 'Maximum';

  @override
  String get gMinimum => 'Minimum';

  @override
  String get gCenterReset => 'Pindutin nang matagal ang gitna para i-reset';

  @override
  String get gLoadingAnim =>
      'Naglo-load. Ang logo ng Empathetic ay gumagalaw bilang isang umiikot na hourglass.';

  @override
  String get gPlay => 'I-play';

  @override
  String get gPause => 'I-pause';

  @override
  String get gReplay => 'I-replay';

  @override
  String get gMute => 'I-mute';

  @override
  String get gUnMute => 'I-unmute';

  @override
  String get gPlaybackSpeed => 'Bilis ng pag-playback';

  @override
  String get gCaptions => 'Mga subtitle/caption';

  @override
  String get gCaptionsHint => 'Pindutin nang matagal para sa mga font';

  @override
  String get gFullScreen => 'Fullscreen';

  @override
  String get gMachineTranslated => 'Isinalin ng makina';

  @override
  String get gUpdates => 'May mga available na update';

  @override
  String get gHardRefresh =>
      'Mangyaring i-hard refresh ang page...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac =>
      'Mangyaring i-hard refresh ang page...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile =>
      'Mangyaring i-refresh ang page sa menu ng browser.';

  @override
  String get gEnterURL => 'Ilagay ang URL';

  @override
  String get gValidURL => 'Mangyaring maglagay ng valid na URL';

  @override
  String get g404Wonder => 'Hindi lahat ng naglalagalag ay nawawala.';

  @override
  String get g404 => 'Pero, sa kasong ito: 404 page not found.';

  @override
  String get g404Note =>
      'Tandaan: Gumagamit ang Flutter web ng hash routing, tulad ng...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => 'Open source';

  @override
  String get gOpenEmpathetech => 'Magbukas ng link sa Empathetic LLC';

  @override
  String get gEFUISourceHint => 'Buksan ang GitHub page para sa EFUI';

  @override
  String get gOpenUIReleases => 'Buksan ang releases page para sa Open UI';

  @override
  String get gGiveFeedback => 'Magbigay ng feedback';

  @override
  String get gOpeningFeedback => 'Binubuksan ang feedback tool.';

  @override
  String get gAttachScreenshot =>
      'Mangyaring ilakip ang iyong screenshot (sa Downloads folder)';

  @override
  String get gSupportEmail => 'Ang aming support Email';

  @override
  String gClipboard(Object thing) {
    return 'Nakopya ang $thing sa clipboard.';
  }

  @override
  String get gAttention => 'Atensyon';

  @override
  String get gCurrently => 'Kasalukuyan:';

  @override
  String gSetToValue(Object name, Object value) {
    return 'Ang $name ay nakatakda sa $value';
  }

  @override
  String get gRemove => 'Alisin';

  @override
  String get gReset => 'I-reset';

  @override
  String get gResetTo => 'I-reset sa:';

  @override
  String gResetValue(Object name) {
    return 'I-reset ang $name?';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return 'I-reset ang $name sa $value';
  }

  @override
  String get gResetAll => 'I-reset lahat';

  @override
  String get gUndoWarn1 => 'Hindi awtomatikong maa-undo.\n';

  @override
  String get gSave => 'I-save';

  @override
  String get gSaveHint => 'I-activate para i-save ang JSON config file.';

  @override
  String get gSwitchHint => 'I-flip ang switch';

  @override
  String get gUndoWarn2 =>
      ' ang iyong kasalukuyang config para ma-restore ito nang manual.';

  @override
  String get gValue => 'Value';

  @override
  String get gSource => 'Pinagmulan:';

  @override
  String get gCreator => 'Tagalikha ng';

  @override
  String get gMadeBy => 'Ginawa ni';

  @override
  String get gYou => 'Itinakda mo';

  @override
  String get ssNavHint => 'Buksan ang page ng mga setting';

  @override
  String get ssRestartReminder =>
      'Isara at buksang muli ang app para mailapat ang iyong mga pagbabago.';

  @override
  String get ssRestartReminderWeb =>
      'I-reload/i-refresh ang page para mailapat ang iyong mga pagbabago.';

  @override
  String get ssHaveFun => 'Magsaya!';

  @override
  String get ssDominantHand => 'Dominanteng kamay';

  @override
  String get ssThemeMode => 'Mode ng tema';

  @override
  String get ssLanguage => 'Wika';

  @override
  String get ssLangHint => 'I-activate para baguhin ang wika ng app';

  @override
  String get ssUpdateDark => 'I-update ang madilim na tema';

  @override
  String get ssUpdateLight => 'I-update ang maliwanag na tema';

  @override
  String get ssUpdateBoth => 'I-update ang parehong mode ng tema';

  @override
  String get ssLoadPreset => 'I-load ang preset';

  @override
  String get ssLoadPresetHint => 'I-activate para ipakita ang mga preset';

  @override
  String get ssDewIt => 'I-update pareho/awtomatikong kumpirmahin';

  @override
  String get ssBigButtons => 'Malalaking button';

  @override
  String get ssHighVisibility => 'Mataas na visibility';

  @override
  String get ssChalkboard => 'Chalkboard';

  @override
  String get ssNebula => 'Nebula';

  @override
  String get ssWallHoles => 'Mga butas sa pader';

  @override
  String get ssDarkOnly =>
      'Ito ay isang preset ng madilim na tema.\nItatakda nito ang mode ng tema sa madilim, at iu-update ang temang iyon.\n\nMagpatuloy?';

  @override
  String get ssLightOnly =>
      'Ito ay isang preset ng maliwanag na tema.\nItatakda nito ang mode ng tema sa maliwanag, at iu-update ang temang iyon.\n\nMagpatuloy?';

  @override
  String ssApplied(Object config) {
    return 'Nailapat ang $config.';
  }

  @override
  String get ssTryMe => 'Subukan ako';

  @override
  String get ssRandom => 'I-randomize';

  @override
  String ssRandomize(Object themeType) {
    return 'I-randomize ang $themeType na tema?';
  }

  @override
  String get ssConfigTip => 'I-save/i-load ang config';

  @override
  String get ssSaveConfig => 'I-save ang config';

  @override
  String ssConfigSaved(Object path) {
    return 'Ang iyong configuration ay nai-save sa $path';
  }

  @override
  String get ssWrongConfigExt => 'Hindi nai-save ang file bilang ';

  @override
  String get ssLoadConfig => 'I-load ang config';

  @override
  String get ssResetAll => 'I-reset lahat ng mga setting?';

  @override
  String get ssResetAppearance => 'I-reset lahat ng mga setting ng hitsura?';

  @override
  String get ssResetBoth => 'I-reset ang parehong mode ng tema';

  @override
  String get csPageTitle => 'Mga setting ng kulay';

  @override
  String get csSchemeBase => 'Bumuo ng scheme\nmula sa larawan';

  @override
  String get csFromImage => 'Isang color scheme ang bubuuin mula sa larawan.';

  @override
  String get csMonoChrome => 'Gumamit ng monochrome scheme';

  @override
  String get csHighContrast => 'Gumamit ng high contrast scheme';

  @override
  String get csPrimary => 'Pangunahin';

  @override
  String get csPrimaryContainer => 'Pangunahing\noutline';

  @override
  String get csSecondary => 'Sekundarya';

  @override
  String get csSecondaryContainer => 'Sekundaryang\noutline';

  @override
  String get csTertiary => 'Tersiyaryo';

  @override
  String get csTertiaryContainer => 'Tersiyaryong\noutline';

  @override
  String get csError => 'Error';

  @override
  String get csErrorContainer => 'Outline ng\nerror';

  @override
  String get csOutline => 'Hint\nna teksto';

  @override
  String get csOutlineVariant => 'Hint\noutline';

  @override
  String get csSurface => 'Background ng\nbutton';

  @override
  String get csSurfaceDim => 'Background ng alert\n&& app bar';

  @override
  String get csSurfaceContainer => 'Background ng page\n&& modal';

  @override
  String get csOnSurface => 'Teksto';

  @override
  String get csScrim => 'Cover ng\nmodal';

  @override
  String get csShadow => 'Anino';

  @override
  String get csSurfaceTint => 'Tint ng\nsurface';

  @override
  String get csPickerTitle => 'Pumili ng kulay';

  @override
  String get csPickerHint =>
      'Magbukas ng tagapili ng kulay. Pindutin nang matagal para sa higit pang mga opsyon.';

  @override
  String get csRecommended => 'Gamitin ang rekomendasyon sa contrast?';

  @override
  String get csUseCustom => 'Gamitin ang custom';

  @override
  String get csCurrVal => 'Kasalukuyang value ng kulay:';

  @override
  String csReset(Object themeType) {
    return 'I-reset ang mga kulay ng $themeType?';
  }

  @override
  String get csColorScheme => 'color scheme';

  @override
  String get dsPageTitle => 'Mga setting ng disenyo';

  @override
  String get dsButton => 'Button';

  @override
  String get dsPage => 'Page';

  @override
  String get dsNone => 'Wala';

  @override
  String get dsSystem => 'System';

  @override
  String get dsPadding => 'Padding';

  @override
  String get dsStyle => 'Estilo';

  @override
  String get dsBorderWidth => 'Lapad ng border';

  @override
  String get dsPill => 'Pill';

  @override
  String get dsRectangle => 'Parihaba';

  @override
  String get dsRoundRectangle => 'Parihabang may bilugan na kanto';

  @override
  String get dsLeftGram => 'Left parallel';

  @override
  String get dsRightGram => 'Right parallel';

  @override
  String get dsGem => 'Gem';

  @override
  String get dsJewel => 'Jewel';

  @override
  String get dsPreview => 'Preview';

  @override
  String get dsOpacity => 'Opacity';

  @override
  String get dsBackground => 'Opacity ng background';

  @override
  String get dsOutline => 'Opacity ng outline';

  @override
  String get dsAlwaysUnderline => 'Palaging salungguhitan ang mga link';

  @override
  String get dsShowBack => 'Ipakita ang back button';

  @override
  String get dsMargin => 'Margin';

  @override
  String get dsSpacing => 'Spacing';

  @override
  String get dsPageTransition => 'Paglipat ng page';

  @override
  String get dsTurnX => 'Pahalang na pag-ikot';

  @override
  String get dsTurnY => 'Patayong pag-ikot';

  @override
  String get dsRotate => 'I-rotate';

  @override
  String get dsSlideX => 'Pahalang na pag-slide';

  @override
  String get dsSlideY => 'Patayong pag-slide';

  @override
  String get dsZoom => 'I-zoom';

  @override
  String get dsFadeTransition => 'Fade na paglipat';

  @override
  String get dsAnimStyle => 'Estilo ng animation';

  @override
  String get dsPlay => 'I-play ang animation';

  @override
  String get dsMilliseconds => 'Millisecond';

  @override
  String get dsCurve => 'Curve';

  @override
  String get dsBounce => 'Bounce';

  @override
  String get dsEase => 'Ease';

  @override
  String get dsElastic => 'Elastic';

  @override
  String get dsLinear => 'Linear';

  @override
  String get dsBackgroundImg => 'Larawan sa background';

  @override
  String dsImgSettingHint(Object title) {
    return 'I-update ang larawan sa $title';
  }

  @override
  String get dsReFit => 'I-fit muli';

  @override
  String get dsFromFile => 'Mula sa file';

  @override
  String get dsFromCamera => 'Mula sa camera';

  @override
  String get dsFromNetwork => 'Mula sa URL';

  @override
  String get dsSolidColor => 'Solid na kulay';

  @override
  String get dsResetIt => 'I-reset ito';

  @override
  String get dsClearIt => 'I-clear ito';

  @override
  String get dsUseForColors =>
      'I-update ang mga kulay ng app gamit ang larawang ito';

  @override
  String get dsImgGetFailed => 'Bigo na makuha ang larawan';

  @override
  String get dsImgSetFailed => 'Bigo na i-update ang larawan';

  @override
  String get dsImgPermission =>
      'Hindi pinapayagan ng ilang site na ma-access ng iba ang kanilang mga larawan.\nSubukan ang isang larawan mula sa ibang host.';

  @override
  String get dsUseFull => 'Gamitin ang buong larawan?';

  @override
  String get dsFit => 'Paano ito dapat magkasya?';

  @override
  String get dsCrop => 'I-crop';

  @override
  String get dsNoWeb => 'Hindi suportado ang pag-edit ng larawan sa web';

  @override
  String get dsRotateLeft => 'I-rotate pakaliwa';

  @override
  String get dsRotateRight => 'I-rotate pakanan';

  @override
  String get dsShowScroll => 'Ipakita ang mga scrollbar';

  @override
  String dsResetButton(Object themeType) {
    return 'I-reset ang disenyo ng button ng $themeType?';
  }

  @override
  String dsResetPage(Object themeType) {
    return 'I-reset ang disenyo ng page ng $themeType?';
  }

  @override
  String get tsPageTitle => 'Mga setting ng teksto';

  @override
  String tsBatchOverride(Object setting) {
    return 'Nakagawa ka na ng mga detalyadong pagbabago sa \"$setting\" sa mga advanced na setting.\n\nSigurado ka bang gusto mong i-override ang mga pagbabagong iyon ng isang batch update?';
  }

  @override
  String get tsTextBackground => 'Opacity ng background ng teksto';

  @override
  String get tsIconSize => 'Laki ng icon';

  @override
  String tsLinkHint(Object style) {
    return 'I-activate para i-edit ang $style';
  }

  @override
  String get tsDisplay => 'Display';

  @override
  String get tsHeadline => 'Headline';

  @override
  String get tsTitle => 'Pamagat';

  @override
  String get tsBody => 'Katawan';

  @override
  String get tsLabel => 'Label';

  @override
  String get tsFontFamily => 'Pamilya ng font';

  @override
  String get tsFontSize => 'Laki ng font';

  @override
  String get tsBold => 'Bold';

  @override
  String get tsItalic => 'Italic';

  @override
  String get tsUnderline => 'Salungguhit';

  @override
  String get tsLetterSpacing => 'Puwang ng mga titik';

  @override
  String get tsWordSpacing => 'Puwang ng mga salita';

  @override
  String get tsLineHeight => 'Taas ng linya';

  @override
  String get tsDisplayP1 => 'Maayos ba ang pag-';

  @override
  String get tsDisplayLink => 'display';

  @override
  String get tsDisplayP2 => ' nito?';

  @override
  String get tsHeadlineP1 => 'Malinaw ba ang mga ';

  @override
  String get tsHeadlineLink => 'headline';

  @override
  String get tsHeadlineP2 => '...';

  @override
  String get tsTitleP1 => 'mula sa mga ';

  @override
  String get tsTitleLink => 'pamagat?';

  @override
  String get tsBodyP1 => 'Paano naman ';

  @override
  String get tsBodyLink => 'ang katawan?';

  @override
  String get tsBodyP2 => ' Madali ba itong basahin?';

  @override
  String get tsLabelP1 => 'At ';

  @override
  String get tsLabelLink => 'ang mga label?';

  @override
  String get tsLabelP2 => ' Hindi masyadong malaki, hindi masyadong maliit?';

  @override
  String tsReset(Object themeType) {
    return 'I-reset ang mga estilo ng teksto ng $themeType?';
  }
}
