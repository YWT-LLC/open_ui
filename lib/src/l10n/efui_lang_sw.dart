// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class EFUILangSw extends EFUILang {
  EFUILangSw([String locale = 'sw']) : super(locale);

  @override
  String get gApply => 'Tekeleza';

  @override
  String get gApplyChanges => 'Tekeleza mabadiliko';

  @override
  String get gContinue => 'Endelea';

  @override
  String get gOpen => 'Fungua';

  @override
  String get gOpenLink => 'Fungua kiungo';

  @override
  String get gSkip => 'Ruka';

  @override
  String get gSuccess => 'Mafanikio';

  @override
  String get gSuccessExl => 'Mafanikio!';

  @override
  String get gYes => 'Ndiyo';

  @override
  String get gAnd => 'na';

  @override
  String get gHelp => 'Msaada';

  @override
  String get gNA => 'N/A';

  @override
  String get gNAHint => 'Haitumiki';

  @override
  String get gOptional => 'hiari';

  @override
  String get gOptions => 'Chaguo';

  @override
  String get gRequired => 'Inahitajika';

  @override
  String get gThe => 'Hiyo';

  @override
  String get gBack => 'Rudi';

  @override
  String get gCancel => 'Ghairi';

  @override
  String get gClose => 'Funga';

  @override
  String get gDisabled => 'Imezimwa';

  @override
  String get gError => 'Hitilafu';

  @override
  String get gFailure => 'Kushindwa';

  @override
  String get gNo => 'Hapana';

  @override
  String get gRedo => 'Fanya upya';

  @override
  String get gUndo => 'Tendua';

  @override
  String get gSettings => 'Mipangilio';

  @override
  String get gGlobal => 'Jumla';

  @override
  String get gColor => 'Rangi';

  @override
  String get gDesign => 'Muundo';

  @override
  String get gLayout => 'Mpangilio';

  @override
  String get gText => 'Maandishi';

  @override
  String get gDark => 'Giza';

  @override
  String get gLight => 'Mwanga';

  @override
  String get gSystem => 'Mfumo';

  @override
  String get gEditing => 'Inahariri: ';

  @override
  String get gEditingHint => 'Washa ili kuhariri';

  @override
  String get gDarkTheme => 'Mandhari ya giza';

  @override
  String get gLightTheme => 'Mandhari ya mwanga';

  @override
  String get gBothThemes => 'Mandhari zote mbili';

  @override
  String get gLeft => 'Kushoto';

  @override
  String get gRight => 'Kulia';

  @override
  String get gAdvanced => 'Ya hali ya juu';

  @override
  String get gQuick => 'Haraka';

  @override
  String get gDecrease => 'Punguza';

  @override
  String get gIncrease => 'Ongeza';

  @override
  String get gMaximum => 'Upeo';

  @override
  String get gMinimum => 'Kiwango cha chini';

  @override
  String get gCenterReset => 'Shikilia katikati ili kuweka upya';

  @override
  String get gLoadingAnim =>
      'Inapakia. Nembo ya Empathetic inasonga kama glasi ya saa inayozunguka.';

  @override
  String get gPlay => 'Cheza';

  @override
  String get gPause => 'Sitisha';

  @override
  String get gReplay => 'Cheza tena';

  @override
  String get gMute => 'Nyamazisha';

  @override
  String get gUnMute => 'Acha kunyamazisha';

  @override
  String get gPlaybackSpeed => 'Kasi ya kucheza';

  @override
  String get gCaptions => 'Manukuu';

  @override
  String get gCaptionsHint => 'Shikilia kwa fonti';

  @override
  String get gFullscreen => 'Skrini nzima';

  @override
  String get gMachineTranslated => 'Imetafsiriwa na mashine';

  @override
  String get gUpdates => 'Masasisho yanapatikana';

  @override
  String get gHardRefresh =>
      'Tafadhali onyesha upya ukurasa kwa lazima...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac =>
      'Tafadhali onyesha upya ukurasa kwa lazima...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile =>
      'Tafadhali onyesha upya ukurasa kwenye menyu ya kivinjari.';

  @override
  String get gEnterURL => 'Weka URL';

  @override
  String get gValidURL => 'Tafadhali weka URL halali';

  @override
  String get g404Wonder => 'Sio wote wanaotangatanga wamepotea.';

  @override
  String get g404 => 'Lakini, katika hali hii: 404 ukurasa haujapatikana.';

  @override
  String get g404Note =>
      'Kumbuka: Wavuti ya Flutter inatumia uelekezaji wa reli (hash routing), kama...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => 'Programu huria';

  @override
  String get gOpenEmpathetech => 'Fungua kiungo cha Empathetic LLC';

  @override
  String get gEFUISourceHint => 'Fungua ukurasa wa GitHub wa EFUI';

  @override
  String get gOpenUIReleases => 'Fungua ukurasa wa matoleo wa Open UI';

  @override
  String get gSupportEmail => 'Barua pepe yetu ya msaada';

  @override
  String gClipboard(Object thing) {
    return '$thing imenakiliwa kwenye ubao wa kunakili.';
  }

  @override
  String get gAttention => 'Makini';

  @override
  String get gCurrently => 'Sasa hivi:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name imewekwa kuwa $value';
  }

  @override
  String get gRemove => 'Ondoa';

  @override
  String get gReset => 'Weka upya';

  @override
  String get gResetTo => 'Weka upya:';

  @override
  String gResetValue(Object name) {
    return 'Weka upya $name?';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return 'Weka upya $name kuwa $value';
  }

  @override
  String get gResetAll => 'Weka upya zote';

  @override
  String get gUndoWarn1 => 'Haziwezi kutenguliwa kiotomatiki.\n';

  @override
  String get gSave => 'Hifadhi';

  @override
  String get gSaveHint => 'Washa ili kuhifadhi faili ya usanidi ya JSON.';

  @override
  String get gSwitchHint => 'Geuza swichi';

  @override
  String get gUndoWarn2 => ' usanidi wako wa sasa ili kuurejesha kwa mikono.';

  @override
  String get gValue => 'Thamani';

  @override
  String get gSource => 'Chanzo:';

  @override
  String get gCreator => 'Muundaji wa';

  @override
  String get gMadeBy => 'Imetengenezwa na';

  @override
  String get gYou => 'Imewekwa na wewe';

  @override
  String get ssNavHint => 'Fungua ukurasa wa mipangilio';

  @override
  String get ssRestartReminder =>
      'Funga na ufungue upya programu ili kutekeleza mabadiliko yako.';

  @override
  String get ssRestartReminderWeb =>
      'Pakia upya/onyesha upya ukurasa ili kutekeleza mabadiliko yako.';

  @override
  String get ssHaveFun => 'Furahia!';

  @override
  String get ssDominantHand => 'Mkono unaotumia zaidi';

  @override
  String get ssThemeMode => 'Hali ya mandhari';

  @override
  String get ssLanguage => 'Lugha';

  @override
  String get ssLangHint => 'Washa ili kubadilisha lugha ya programu';

  @override
  String get ssUpdateDark => 'Sasisha mandhari ya giza';

  @override
  String get ssUpdateLight => 'Sasisha mandhari ya mwanga';

  @override
  String get ssUpdateBoth => 'Sasisha hali zote mbili za mandhari';

  @override
  String get ssLoadPreset => 'Pakia iliyowekwa tayari';

  @override
  String get ssLoadPresetHint => 'Washa ili kuonyesha zilizowekwa tayari';

  @override
  String get ssDewIt => 'Sasisha zote mbili/thibitisha kiotomatiki';

  @override
  String get ssBigButtons => 'Vifungo vikubwa';

  @override
  String get ssHighVisibility => 'Uonekanaji wa juu';

  @override
  String get ssChalkboard => 'Ubao';

  @override
  String get ssNebula => 'Nebula';

  @override
  String get ssWallHoles => 'Mashimo ya ukuta';

  @override
  String get ssDarkOnly =>
      'Huu ni mpangilio wa mandhari ya giza.\nItaweka hali ya mandhari kuwa giza, na kusasisha mandhari hiyo.\n\nEndelea?';

  @override
  String get ssLightOnly =>
      'Huu ni mpangilio wa mandhari ya mwanga.\nItaweka hali ya mandhari kuwa mwanga, na kusasisha mandhari hiyo.\n\nEndelea?';

  @override
  String ssApplied(Object config) {
    return '$config imetekelezwa.';
  }

  @override
  String get ssTryMe => 'Nijaribu';

  @override
  String get ssRandom => 'Changanya';

  @override
  String ssRandomize(Object themeType) {
    return 'Changanya mandhari ya $themeType?';
  }

  @override
  String get ssConfigTip => 'Hifadhi/pakia usanidi';

  @override
  String get ssSaveConfig => 'Hifadhi usanidi';

  @override
  String ssConfigSaved(Object path) {
    return 'Usanidi wako umehifadhiwa kwenye $path';
  }

  @override
  String get ssWrongConfigExt => 'Faili haikuhifadhiwa kama ';

  @override
  String get ssLoadConfig => 'Pakia usanidi';

  @override
  String get ssResetAll => 'Kuweka upya mipangilio yote?';

  @override
  String get ssResetAppearance => 'Kuweka upya mipangilio yote ya mwonekano?';

  @override
  String get ssResetBoth => 'Weka upya hali zote mbili za mandhari';

  @override
  String get csPageTitle => 'Mipangilio ya rangi';

  @override
  String get csSchemeBase => 'Tengeneza mpangilio\nKutoka kwenye picha';

  @override
  String get csFromImage =>
      'Mpangilio wa rangi utatengenezwa kutoka kwenye picha.';

  @override
  String get csMonoChrome => 'Tumia mpangilio wa rangi moja';

  @override
  String get csHighContrast => 'Tumia mpangilio wa tofauti kubwa ya rangi';

  @override
  String get csPrimary => 'Msingi';

  @override
  String get csPrimaryContainer => 'Muhtasari\nwa msingi';

  @override
  String get csSecondary => 'Sekondari';

  @override
  String get csSecondaryContainer => 'Muhtasari\nwa sekondari';

  @override
  String get csTertiary => 'Tatu';

  @override
  String get csTertiaryContainer => 'Muhtasari\nwa tatu';

  @override
  String get csError => 'Hitilafu';

  @override
  String get csErrorContainer => 'Muhtasari\nwa hitilafu';

  @override
  String get csOutline => 'Maandishi\nya dokezo';

  @override
  String get csOutlineVariant => 'Muhtasari\nwa dokezo';

  @override
  String get csSurface => 'Asili\nya kitufe';

  @override
  String get csSurfaceDim => 'Tahadhari && asili ya mwambaa\nwa programu';

  @override
  String get csSurfaceContainer => 'Ukurasa && asili\nya modali';

  @override
  String get csOnSurface => 'Maandishi';

  @override
  String get csScrim => 'Kifuniko\ncha modali';

  @override
  String get csShadow => 'Kivuli';

  @override
  String get csSurfaceTint => 'Rangi kuu\nya uso';

  @override
  String get csPickerTitle => 'Chagua rangi';

  @override
  String get csPickerHint =>
      'Fungua kichagua rangi. Bonyeza kwa muda mrefu kwa chaguo zaidi.';

  @override
  String get csRecommended => 'Tumia pendekezo la utofauti wa rangi?';

  @override
  String get csUseCustom => 'Tumia maalum';

  @override
  String get csCurrVal => 'Thamani ya rangi ya sasa:';

  @override
  String csReset(Object themeType) {
    return 'Weka upya rangi za $themeType?';
  }

  @override
  String get csColorScheme => 'mpangilio wa rangi';

  @override
  String get dsPageTitle => 'Mipangilio ya muundo';

  @override
  String get dsButton => 'Kitufe';

  @override
  String get dsPage => 'Ukurasa';

  @override
  String get dsNone => 'Hakuna';

  @override
  String get dsSystem => 'Mfumo';

  @override
  String get dsPadding => 'Nafasi ya ndani';

  @override
  String get dsStyle => 'Mtindo';

  @override
  String get dsBorderWidth => 'Upana wa mpaka';

  @override
  String get dsPill => 'Kidonge';

  @override
  String get dsRectangle => 'Mstatili';

  @override
  String get dsRoundRectangle => 'Mstatili wa mviringo';

  @override
  String get dsLeftGram => 'Sambamba kushoto';

  @override
  String get dsRightGram => 'Sambamba kulia';

  @override
  String get dsGem => 'Kito';

  @override
  String get dsJewel => 'Johari';

  @override
  String get dsAlwaysUnderline => 'Piga mstari chini ya viungo kila wakati';

  @override
  String get dsShowBack => 'Onyesha kitufe cha kurudi';

  @override
  String get dsMargin => 'Ukingo';

  @override
  String get dsSpacing => 'Nafasi';

  @override
  String get dsPageTransition => 'Mabadiliko ya ukurasa';

  @override
  String get dsTurnX => 'Zungusha mlalo';

  @override
  String get dsTurnY => 'Zungusha wima';

  @override
  String get dsRotate => 'Zungusha';

  @override
  String get dsSlideX => 'Telezesha mlalo';

  @override
  String get dsSlideY => 'Telezesha wima';

  @override
  String get dsZoom => 'Kuza';

  @override
  String get dsFadeTransition => 'Mabadiliko ya kufifia';

  @override
  String get dsAnimStyle => 'Mtindo wa uhuishaji';

  @override
  String get dsPlay => 'Cheza uhuishaji';

  @override
  String get dsMilliseconds => 'Milisekunde';

  @override
  String get dsCurve => 'Mviringo';

  @override
  String get dsBounce => 'Dunda';

  @override
  String get dsEase => 'Laini';

  @override
  String get dsElastic => 'Nyumbufu';

  @override
  String get dsLinear => 'Mstari nyofu';

  @override
  String get dsBackgroundImg => 'Picha ya asili';

  @override
  String dsImgSettingHint(Object title) {
    return 'Sasisha picha ya $title';
  }

  @override
  String get dsReFit => 'Oanisha upya';

  @override
  String get dsFromFile => 'Kutoka kwenye faili';

  @override
  String get dsFromCamera => 'Kutoka kwenye kamera';

  @override
  String get dsFromNetwork => 'Kutoka kwenye URL';

  @override
  String get dsSolidColor => 'Rangi imara';

  @override
  String get dsResetIt => 'Iweke upya';

  @override
  String get dsClearIt => 'Ifute';

  @override
  String get dsUseForColors => 'Sasisha rangi za programu ukitumia picha hii';

  @override
  String get dsImgGetFailed => 'Imeshindwa kupata picha';

  @override
  String get dsImgSetFailed => 'Imeshindwa kusasisha picha';

  @override
  String get dsImgPermission =>
      'Baadhi ya tovuti haziruhusu picha zao kufikiwa na wengine.\nJaribu picha kutoka kwa mwenyeji mwingine.';

  @override
  String get dsUseFull => 'Tumia picha kamili?';

  @override
  String get dsFit => 'Ilingane vipi?';

  @override
  String get dsCrop => 'Punguza';

  @override
  String get dsNoWeb => 'Uhariri wa picha hautumiki kwenye wavuti';

  @override
  String get dsRotateLeft => 'Zungusha kushoto';

  @override
  String get dsRotateRight => 'Zungusha kulia';

  @override
  String get dsShowScroll => 'Onyesha mialo ya kusogeza';

  @override
  String dsResetButton(Object themeType) {
    return 'Weka upya muundo wa kitufe wa $themeType?';
  }

  @override
  String dsResetPage(Object themeType) {
    return 'Weka upya muundo wa ukurasa wa $themeType?';
  }

  @override
  String get tsPageTitle => 'Mipangilio ya maandishi';

  @override
  String tsBatchOverride(Object setting) {
    return 'Tayari umeshafanya mabadiliko maalum ya \"$setting\" katika mipangilio ya hali ya juu.\n\nUna uhakika unataka kubatilisha mabadiliko hayo kwa usasisho wa pamoja?';
  }

  @override
  String get tsTextBackground => 'Uangavu wa asili ya maandishi';

  @override
  String get tsIconSize => 'Ukubwa wa aikoni';

  @override
  String tsLinkHint(Object style) {
    return 'Washa ili kuhariri $style';
  }

  @override
  String get tsDisplay => 'Onyesho';

  @override
  String get tsHeadline => 'Kichwa cha habari';

  @override
  String get tsTitle => 'Kichwa';

  @override
  String get tsBody => 'Mwili';

  @override
  String get tsLabel => 'Lebo';

  @override
  String get tsFontFamily => 'Aina ya fonti';

  @override
  String get tsFontSize => 'Ukubwa wa fonti';

  @override
  String get tsBold => 'Nene';

  @override
  String get tsItalic => 'Italiki';

  @override
  String get tsUnderline => 'Piga mstari chini';

  @override
  String get tsLetterSpacing => 'Nafasi ya herufi';

  @override
  String get tsWordSpacing => 'Nafasi ya maneno';

  @override
  String get tsLineHeight => 'Urefu wa mstari';

  @override
  String get tsDisplayP1 => 'Je, hili ';

  @override
  String get tsDisplayLink => 'onyesho';

  @override
  String get tsDisplayP2 => ' linaonekana vizuri?';

  @override
  String get tsHeadlineP1 => 'Je, ';

  @override
  String get tsHeadlineLink => 'vichwa vya habari';

  @override
  String get tsHeadlineP2 => ' ni tofauti...';

  @override
  String get tsTitleP1 => 'kutoka kwa ';

  @override
  String get tsTitleLink => 'vichwa?';

  @override
  String get tsBodyP1 => 'Vipi kuhusu ';

  @override
  String get tsBodyLink => 'mwili?';

  @override
  String get tsBodyP2 => ' Je, ni rahisi kusoma?';

  @override
  String get tsLabelP1 => 'Na ';

  @override
  String get tsLabelLink => 'lebo?';

  @override
  String get tsLabelP2 => ' Sio kubwa sana, sio ndogo sana?';

  @override
  String tsReset(Object themeType) {
    return 'Weka upya mitindo ya maandishi ya $themeType?';
  }
}
