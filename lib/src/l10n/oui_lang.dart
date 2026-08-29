import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'oui_lang_ar.dart' deferred as oui_lang_ar;
import 'oui_lang_de.dart' deferred as oui_lang_de;
import 'oui_lang_en.dart' deferred as oui_lang_en;
import 'oui_lang_es.dart' deferred as oui_lang_es;
import 'oui_lang_fil.dart' deferred as oui_lang_fil;
import 'oui_lang_fr.dart' deferred as oui_lang_fr;
import 'oui_lang_hi.dart' deferred as oui_lang_hi;
import 'oui_lang_ht.dart' deferred as oui_lang_ht;
import 'oui_lang_ja.dart' deferred as oui_lang_ja;
import 'oui_lang_ko.dart' deferred as oui_lang_ko;
import 'oui_lang_ru.dart' deferred as oui_lang_ru;
import 'oui_lang_sw.dart' deferred as oui_lang_sw;
import 'oui_lang_uk.dart' deferred as oui_lang_uk;
import 'oui_lang_zh.dart' deferred as oui_lang_zh;

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of OUILang
/// returned by `OUILang.of(context)`.
///
/// Applications need to include `OUILang.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/oui_lang.dart';
///
/// return MaterialApp(
///   localizationsDelegates: OUILang.localizationsDelegates,
///   supportedLocales: OUILang.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the OUILang.supportedLocales
/// property.
abstract class OUILang {
  OUILang(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static OUILang? of(BuildContext context) {
    return Localizations.of<OUILang>(context, OUILang);
  }

  static const LocalizationsDelegate<OUILang> delegate = _OUILangDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('ar', 'EG'),
    Locale('de'),
    Locale('en'),
    Locale('en', 'US'),
    Locale('es'),
    Locale('fil'),
    Locale('fr'),
    Locale('hi'),
    Locale('ht'),
    Locale('ja'),
    Locale('ko'),
    Locale('ru'),
    Locale('sw'),
    Locale('uk'),
    Locale('zh'),
    Locale('zh', 'CN')
  ];

  /// No description provided for @gApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get gApply;

  /// No description provided for @gApplyChanges.
  ///
  /// In en, this message translates to:
  /// **'Apply changes'**
  String get gApplyChanges;

  /// No description provided for @gContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get gContinue;

  /// No description provided for @gOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get gOpen;

  /// No description provided for @gOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Open link'**
  String get gOpenLink;

  /// No description provided for @gSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get gSkip;

  /// No description provided for @gSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get gSuccess;

  /// No description provided for @gSuccessExl.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get gSuccessExl;

  /// No description provided for @gYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get gYes;

  /// No description provided for @gAnd.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get gAnd;

  /// No description provided for @gHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get gHelp;

  /// No description provided for @gNA.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get gNA;

  /// No description provided for @gNAHint.
  ///
  /// In en, this message translates to:
  /// **'Not applicable'**
  String get gNAHint;

  /// No description provided for @gOptional.
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get gOptional;

  /// No description provided for @gOptions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get gOptions;

  /// No description provided for @gRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get gRequired;

  /// No description provided for @gThe.
  ///
  /// In en, this message translates to:
  /// **'The'**
  String get gThe;

  /// No description provided for @gBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get gBack;

  /// No description provided for @gCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get gCancel;

  /// No description provided for @gClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get gClose;

  /// No description provided for @gDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get gDisabled;

  /// No description provided for @gError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get gError;

  /// No description provided for @gFailure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get gFailure;

  /// No description provided for @gLock.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get gLock;

  /// No description provided for @gNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get gNo;

  /// No description provided for @gPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get gPaste;

  /// No description provided for @gRedo.
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get gRedo;

  /// No description provided for @gUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get gUndo;

  /// No description provided for @gSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get gSettings;

  /// No description provided for @gGlobal.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get gGlobal;

  /// No description provided for @gColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get gColor;

  /// No description provided for @gDesign.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get gDesign;

  /// No description provided for @gLayout.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get gLayout;

  /// No description provided for @gText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get gText;

  /// No description provided for @gDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get gDark;

  /// No description provided for @gLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get gLight;

  /// No description provided for @gSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get gSystem;

  /// No description provided for @gEditing.
  ///
  /// In en, this message translates to:
  /// **'Editing: '**
  String get gEditing;

  /// No description provided for @gEditingHint.
  ///
  /// In en, this message translates to:
  /// **'Activate to edit'**
  String get gEditingHint;

  /// No description provided for @gDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get gDarkTheme;

  /// No description provided for @gLightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get gLightTheme;

  /// No description provided for @gBothThemes.
  ///
  /// In en, this message translates to:
  /// **'Both themes'**
  String get gBothThemes;

  /// No description provided for @gLeft.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get gLeft;

  /// No description provided for @gRight.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get gRight;

  /// No description provided for @gAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get gAdvanced;

  /// No description provided for @gQuick.
  ///
  /// In en, this message translates to:
  /// **'Quick'**
  String get gQuick;

  /// No description provided for @gDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get gDecrease;

  /// No description provided for @gIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get gIncrease;

  /// No description provided for @gMaximum.
  ///
  /// In en, this message translates to:
  /// **'Maximum'**
  String get gMaximum;

  /// No description provided for @gMinimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum'**
  String get gMinimum;

  /// No description provided for @gCenterReset.
  ///
  /// In en, this message translates to:
  /// **'Hold center to reset'**
  String get gCenterReset;

  /// No description provided for @gLoadingAnim.
  ///
  /// In en, this message translates to:
  /// **'Loading. The YWT hourglass logo is spinning.'**
  String get gLoadingAnim;

  /// No description provided for @gPlay.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get gPlay;

  /// No description provided for @gPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get gPause;

  /// No description provided for @gReplay.
  ///
  /// In en, this message translates to:
  /// **'Replay'**
  String get gReplay;

  /// No description provided for @gMute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get gMute;

  /// No description provided for @gUnMute.
  ///
  /// In en, this message translates to:
  /// **'Un-mute'**
  String get gUnMute;

  /// No description provided for @gPlaybackSpeed.
  ///
  /// In en, this message translates to:
  /// **'Playback speed'**
  String get gPlaybackSpeed;

  /// No description provided for @gFBF.
  ///
  /// In en, this message translates to:
  /// **'Frame by frame'**
  String get gFBF;

  /// No description provided for @gCaptions.
  ///
  /// In en, this message translates to:
  /// **'Subtitles/captions'**
  String get gCaptions;

  /// No description provided for @gCaptionsHint.
  ///
  /// In en, this message translates to:
  /// **'Hold for fonts'**
  String get gCaptionsHint;

  /// No description provided for @gFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Fullscreen'**
  String get gFullscreen;

  /// No description provided for @gMachineTranslated.
  ///
  /// In en, this message translates to:
  /// **'Machine translated'**
  String get gMachineTranslated;

  /// No description provided for @gUpdates.
  ///
  /// In en, this message translates to:
  /// **'Updates available'**
  String get gUpdates;

  /// No description provided for @gHardRefresh.
  ///
  /// In en, this message translates to:
  /// **'Please hard refresh the page...\nCtrl + Shift + R'**
  String get gHardRefresh;

  /// No description provided for @gHardRefreshMac.
  ///
  /// In en, this message translates to:
  /// **'Please hard refresh the page...\nCommand + Shift + R'**
  String get gHardRefreshMac;

  /// No description provided for @gHardRefreshMobile.
  ///
  /// In en, this message translates to:
  /// **'Please refresh the page in the browser menu.'**
  String get gHardRefreshMobile;

  /// No description provided for @gEnterURL.
  ///
  /// In en, this message translates to:
  /// **'Enter URL'**
  String get gEnterURL;

  /// No description provided for @gValidURL.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get gValidURL;

  /// No description provided for @g404Wonder.
  ///
  /// In en, this message translates to:
  /// **'Not all who wander are lost.'**
  String get g404Wonder;

  /// No description provided for @g404.
  ///
  /// In en, this message translates to:
  /// **'But, in this case: 404 page not found.'**
  String get g404;

  /// No description provided for @g404Note.
  ///
  /// In en, this message translates to:
  /// **'Note: Flutter web uses hash routing, like...\nhttps://www.example.com/#/destination'**
  String get g404Note;

  /// No description provided for @gOpenSource.
  ///
  /// In en, this message translates to:
  /// **'Open source'**
  String get gOpenSource;

  /// No description provided for @gOpenYWT.
  ///
  /// In en, this message translates to:
  /// **'Open a link to YWT'**
  String get gOpenYWT;

  /// No description provided for @gOpenUISourceHint.
  ///
  /// In en, this message translates to:
  /// **'Open the GitHub page for Open UI'**
  String get gOpenUISourceHint;

  /// No description provided for @gOpenUIReleases.
  ///
  /// In en, this message translates to:
  /// **'Open the releases page for Open UI'**
  String get gOpenUIReleases;

  /// No description provided for @gSupportEmail.
  ///
  /// In en, this message translates to:
  /// **'Our support Email'**
  String get gSupportEmail;

  /// No description provided for @gClipboard.
  ///
  /// In en, this message translates to:
  /// **'{thing} has been copied to the clipboard.'**
  String gClipboard(Object thing);

  /// No description provided for @gAttention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get gAttention;

  /// No description provided for @gCurrently.
  ///
  /// In en, this message translates to:
  /// **'Currently:'**
  String get gCurrently;

  /// No description provided for @gSetToValue.
  ///
  /// In en, this message translates to:
  /// **'{name} is set to {value}'**
  String gSetToValue(Object name, Object value);

  /// No description provided for @gRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get gRemove;

  /// No description provided for @gReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get gReset;

  /// No description provided for @gResetTo.
  ///
  /// In en, this message translates to:
  /// **'Reset:'**
  String get gResetTo;

  /// No description provided for @gResetValue.
  ///
  /// In en, this message translates to:
  /// **'Reset {name}?'**
  String gResetValue(Object name);

  /// No description provided for @gResetValueTo.
  ///
  /// In en, this message translates to:
  /// **'Reset {name} to {value}'**
  String gResetValueTo(Object name, Object value);

  /// No description provided for @gResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all'**
  String get gResetAll;

  /// No description provided for @gUndoWarn1.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone automatically.\n'**
  String get gUndoWarn1;

  /// No description provided for @gSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get gSave;

  /// No description provided for @gSaveHint.
  ///
  /// In en, this message translates to:
  /// **'Activate to save a JSON config file.'**
  String get gSaveHint;

  /// No description provided for @gSwitchHint.
  ///
  /// In en, this message translates to:
  /// **'Flip switch'**
  String get gSwitchHint;

  /// No description provided for @gUndoWarn2.
  ///
  /// In en, this message translates to:
  /// **' your current config to restore it manually.'**
  String get gUndoWarn2;

  /// No description provided for @gValue.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get gValue;

  /// No description provided for @gSource.
  ///
  /// In en, this message translates to:
  /// **'Source:'**
  String get gSource;

  /// No description provided for @gCreator.
  ///
  /// In en, this message translates to:
  /// **'Creator of'**
  String get gCreator;

  /// No description provided for @gMadeBy.
  ///
  /// In en, this message translates to:
  /// **'Made by'**
  String get gMadeBy;

  /// No description provided for @gYou.
  ///
  /// In en, this message translates to:
  /// **'Set by you'**
  String get gYou;

  /// No description provided for @ssNavHint.
  ///
  /// In en, this message translates to:
  /// **'Open the settings page'**
  String get ssNavHint;

  /// No description provided for @ssHaveFun.
  ///
  /// In en, this message translates to:
  /// **'Have fun!'**
  String get ssHaveFun;

  /// No description provided for @ssDominantHand.
  ///
  /// In en, this message translates to:
  /// **'Dominant hand'**
  String get ssDominantHand;

  /// No description provided for @ssThemeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get ssThemeMode;

  /// No description provided for @ssLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get ssLanguage;

  /// No description provided for @ssLangHint.
  ///
  /// In en, this message translates to:
  /// **'Activate to change the app language'**
  String get ssLangHint;

  /// No description provided for @ssUpdateDark.
  ///
  /// In en, this message translates to:
  /// **'Update dark theme'**
  String get ssUpdateDark;

  /// No description provided for @ssUpdateLight.
  ///
  /// In en, this message translates to:
  /// **'Update light theme'**
  String get ssUpdateLight;

  /// No description provided for @ssUpdateBoth.
  ///
  /// In en, this message translates to:
  /// **'Update both theme modes'**
  String get ssUpdateBoth;

  /// No description provided for @ssLoadPreset.
  ///
  /// In en, this message translates to:
  /// **'Load preset'**
  String get ssLoadPreset;

  /// No description provided for @ssLoadPresetHint.
  ///
  /// In en, this message translates to:
  /// **'Activate to show presets'**
  String get ssLoadPresetHint;

  /// No description provided for @ssDewIt.
  ///
  /// In en, this message translates to:
  /// **'Update both/auto confirm'**
  String get ssDewIt;

  /// No description provided for @ssBigButtons.
  ///
  /// In en, this message translates to:
  /// **'Big buttons'**
  String get ssBigButtons;

  /// No description provided for @ssHighVisibility.
  ///
  /// In en, this message translates to:
  /// **'High visibility'**
  String get ssHighVisibility;

  /// No description provided for @ssChalkboard.
  ///
  /// In en, this message translates to:
  /// **'Chalkboard'**
  String get ssChalkboard;

  /// No description provided for @ssNebula.
  ///
  /// In en, this message translates to:
  /// **'Nebula'**
  String get ssNebula;

  /// No description provided for @ssWallHoles.
  ///
  /// In en, this message translates to:
  /// **'Wall holes'**
  String get ssWallHoles;

  /// No description provided for @ssDarkOnly.
  ///
  /// In en, this message translates to:
  /// **'This is a dark theme preset.\nIt will set the theme mode to dark, and update that theme.\n\nContinue?'**
  String get ssDarkOnly;

  /// No description provided for @ssLightOnly.
  ///
  /// In en, this message translates to:
  /// **'This is a light theme preset.\nIt will set the theme mode to light, and update that theme.\n\nContinue?'**
  String get ssLightOnly;

  /// No description provided for @ssApplied.
  ///
  /// In en, this message translates to:
  /// **'{config} applied.'**
  String ssApplied(Object config);

  /// No description provided for @ssTryMe.
  ///
  /// In en, this message translates to:
  /// **'Try me'**
  String get ssTryMe;

  /// No description provided for @ssRandom.
  ///
  /// In en, this message translates to:
  /// **'Randomize'**
  String get ssRandom;

  /// No description provided for @ssRandomize.
  ///
  /// In en, this message translates to:
  /// **'Randomize {themeType} theme?'**
  String ssRandomize(Object themeType);

  /// No description provided for @ssConfigTip.
  ///
  /// In en, this message translates to:
  /// **'Save/load config'**
  String get ssConfigTip;

  /// No description provided for @ssSaveConfig.
  ///
  /// In en, this message translates to:
  /// **'Save config'**
  String get ssSaveConfig;

  /// No description provided for @ssConfigSaved.
  ///
  /// In en, this message translates to:
  /// **'Your configuration has been saved to {path}'**
  String ssConfigSaved(Object path);

  /// No description provided for @ssWrongConfigExt.
  ///
  /// In en, this message translates to:
  /// **'The file was not saved as '**
  String get ssWrongConfigExt;

  /// No description provided for @ssLoadConfig.
  ///
  /// In en, this message translates to:
  /// **'Load config'**
  String get ssLoadConfig;

  /// No description provided for @ssImageToo.
  ///
  /// In en, this message translates to:
  /// **'Background images too?'**
  String get ssImageToo;

  /// No description provided for @ssResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings?'**
  String get ssResetAll;

  /// No description provided for @ssResetAppearance.
  ///
  /// In en, this message translates to:
  /// **'Reset all appearance settings?'**
  String get ssResetAppearance;

  /// No description provided for @ssResetBoth.
  ///
  /// In en, this message translates to:
  /// **'Reset both theme modes'**
  String get ssResetBoth;

  /// No description provided for @csPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Color settings'**
  String get csPageTitle;

  /// No description provided for @csSchemeBase.
  ///
  /// In en, this message translates to:
  /// **'Build scheme\nfrom image'**
  String get csSchemeBase;

  /// No description provided for @csFromImage.
  ///
  /// In en, this message translates to:
  /// **'A color scheme will be generated from the image.'**
  String get csFromImage;

  /// No description provided for @csMonoChrome.
  ///
  /// In en, this message translates to:
  /// **'Use monochrome scheme'**
  String get csMonoChrome;

  /// No description provided for @csHighContrast.
  ///
  /// In en, this message translates to:
  /// **'Use high contrast scheme'**
  String get csHighContrast;

  /// No description provided for @csPrimary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get csPrimary;

  /// No description provided for @csPrimaryContainer.
  ///
  /// In en, this message translates to:
  /// **'Primary\noutline'**
  String get csPrimaryContainer;

  /// No description provided for @csSecondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get csSecondary;

  /// No description provided for @csSecondaryContainer.
  ///
  /// In en, this message translates to:
  /// **'Secondary\noutline'**
  String get csSecondaryContainer;

  /// No description provided for @csTertiary.
  ///
  /// In en, this message translates to:
  /// **'Tertiary'**
  String get csTertiary;

  /// No description provided for @csTertiaryContainer.
  ///
  /// In en, this message translates to:
  /// **'Tertiary\noutline'**
  String get csTertiaryContainer;

  /// No description provided for @csError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get csError;

  /// No description provided for @csErrorContainer.
  ///
  /// In en, this message translates to:
  /// **'Error\noutline'**
  String get csErrorContainer;

  /// No description provided for @csOutline.
  ///
  /// In en, this message translates to:
  /// **'Hint\ntext'**
  String get csOutline;

  /// No description provided for @csOutlineVariant.
  ///
  /// In en, this message translates to:
  /// **'Hint\noutline'**
  String get csOutlineVariant;

  /// No description provided for @csSurface.
  ///
  /// In en, this message translates to:
  /// **'Button\nbackground'**
  String get csSurface;

  /// No description provided for @csSurfaceDim.
  ///
  /// In en, this message translates to:
  /// **'Alert && app bar\nbackground'**
  String get csSurfaceDim;

  /// No description provided for @csSurfaceContainer.
  ///
  /// In en, this message translates to:
  /// **'Page && modal\nbackground'**
  String get csSurfaceContainer;

  /// No description provided for @csOnSurface.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get csOnSurface;

  /// No description provided for @csScrim.
  ///
  /// In en, this message translates to:
  /// **'Modal\ncover'**
  String get csScrim;

  /// No description provided for @csShadow.
  ///
  /// In en, this message translates to:
  /// **'Shadow'**
  String get csShadow;

  /// No description provided for @csSurfaceTint.
  ///
  /// In en, this message translates to:
  /// **'Surface\ntint'**
  String get csSurfaceTint;

  /// No description provided for @csPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a color'**
  String get csPickerTitle;

  /// No description provided for @csPickerHint.
  ///
  /// In en, this message translates to:
  /// **'Open a color picker. Long press for more options.'**
  String get csPickerHint;

  /// No description provided for @csRecommended.
  ///
  /// In en, this message translates to:
  /// **'Use contrast recommendation?'**
  String get csRecommended;

  /// No description provided for @csUseCustom.
  ///
  /// In en, this message translates to:
  /// **'Use custom'**
  String get csUseCustom;

  /// No description provided for @csCurrVal.
  ///
  /// In en, this message translates to:
  /// **'Current color value:'**
  String get csCurrVal;

  /// No description provided for @csReset.
  ///
  /// In en, this message translates to:
  /// **'Reset {themeType} colors?'**
  String csReset(Object themeType);

  /// No description provided for @csColorScheme.
  ///
  /// In en, this message translates to:
  /// **'color scheme'**
  String get csColorScheme;

  /// No description provided for @dsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Design settings'**
  String get dsPageTitle;

  /// No description provided for @dsButton.
  ///
  /// In en, this message translates to:
  /// **'Button'**
  String get dsButton;

  /// No description provided for @dsPage.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get dsPage;

  /// No description provided for @dsNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get dsNone;

  /// No description provided for @dsSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get dsSystem;

  /// No description provided for @dsPadding.
  ///
  /// In en, this message translates to:
  /// **'Padding'**
  String get dsPadding;

  /// No description provided for @dsStyle.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get dsStyle;

  /// No description provided for @dsBorderWidth.
  ///
  /// In en, this message translates to:
  /// **'Border width'**
  String get dsBorderWidth;

  /// No description provided for @dsPill.
  ///
  /// In en, this message translates to:
  /// **'Pill'**
  String get dsPill;

  /// No description provided for @dsRectangle.
  ///
  /// In en, this message translates to:
  /// **'Rectangle'**
  String get dsRectangle;

  /// No description provided for @dsRoundRectangle.
  ///
  /// In en, this message translates to:
  /// **'Rounded rectangle'**
  String get dsRoundRectangle;

  /// No description provided for @dsLeftGram.
  ///
  /// In en, this message translates to:
  /// **'Left parallel'**
  String get dsLeftGram;

  /// No description provided for @dsRightGram.
  ///
  /// In en, this message translates to:
  /// **'Right parallel'**
  String get dsRightGram;

  /// No description provided for @dsGem.
  ///
  /// In en, this message translates to:
  /// **'Gem'**
  String get dsGem;

  /// No description provided for @dsJewel.
  ///
  /// In en, this message translates to:
  /// **'Jewel'**
  String get dsJewel;

  /// No description provided for @dsAlwaysUnderline.
  ///
  /// In en, this message translates to:
  /// **'Always underline links'**
  String get dsAlwaysUnderline;

  /// No description provided for @dsShowBack.
  ///
  /// In en, this message translates to:
  /// **'Show back button'**
  String get dsShowBack;

  /// No description provided for @dsMargin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get dsMargin;

  /// No description provided for @dsSpacing.
  ///
  /// In en, this message translates to:
  /// **'Spacing'**
  String get dsSpacing;

  /// No description provided for @dsPageTransition.
  ///
  /// In en, this message translates to:
  /// **'Page transition'**
  String get dsPageTransition;

  /// No description provided for @dsTurnX.
  ///
  /// In en, this message translates to:
  /// **'Horizontal turn'**
  String get dsTurnX;

  /// No description provided for @dsTurnY.
  ///
  /// In en, this message translates to:
  /// **'Vertical turn'**
  String get dsTurnY;

  /// No description provided for @dsRotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get dsRotate;

  /// No description provided for @dsSlideX.
  ///
  /// In en, this message translates to:
  /// **'Horizontal slide'**
  String get dsSlideX;

  /// No description provided for @dsSlideY.
  ///
  /// In en, this message translates to:
  /// **'Vertical slide'**
  String get dsSlideY;

  /// No description provided for @dsZoom.
  ///
  /// In en, this message translates to:
  /// **'Zoom'**
  String get dsZoom;

  /// No description provided for @dsFadeTransition.
  ///
  /// In en, this message translates to:
  /// **'Fade transition'**
  String get dsFadeTransition;

  /// No description provided for @dsAnimStyle.
  ///
  /// In en, this message translates to:
  /// **'Animation style'**
  String get dsAnimStyle;

  /// No description provided for @dsPlay.
  ///
  /// In en, this message translates to:
  /// **'Play animation'**
  String get dsPlay;

  /// No description provided for @dsMilliseconds.
  ///
  /// In en, this message translates to:
  /// **'Milliseconds'**
  String get dsMilliseconds;

  /// No description provided for @dsCurve.
  ///
  /// In en, this message translates to:
  /// **'Curve'**
  String get dsCurve;

  /// No description provided for @dsBounce.
  ///
  /// In en, this message translates to:
  /// **'Bounce'**
  String get dsBounce;

  /// No description provided for @dsEase.
  ///
  /// In en, this message translates to:
  /// **'Ease'**
  String get dsEase;

  /// No description provided for @dsElastic.
  ///
  /// In en, this message translates to:
  /// **'Elastic'**
  String get dsElastic;

  /// No description provided for @dsLinear.
  ///
  /// In en, this message translates to:
  /// **'Linear'**
  String get dsLinear;

  /// No description provided for @dsBackgroundImg.
  ///
  /// In en, this message translates to:
  /// **'Background image'**
  String get dsBackgroundImg;

  /// No description provided for @dsImgSettingHint.
  ///
  /// In en, this message translates to:
  /// **'Update the {title} image'**
  String dsImgSettingHint(Object title);

  /// No description provided for @dsReFit.
  ///
  /// In en, this message translates to:
  /// **'Re-fit'**
  String get dsReFit;

  /// No description provided for @dsFromFile.
  ///
  /// In en, this message translates to:
  /// **'From file'**
  String get dsFromFile;

  /// No description provided for @dsFromCamera.
  ///
  /// In en, this message translates to:
  /// **'From camera'**
  String get dsFromCamera;

  /// No description provided for @dsFromNetwork.
  ///
  /// In en, this message translates to:
  /// **'From URL'**
  String get dsFromNetwork;

  /// No description provided for @dsSolidColor.
  ///
  /// In en, this message translates to:
  /// **'Solid color'**
  String get dsSolidColor;

  /// No description provided for @dsResetIt.
  ///
  /// In en, this message translates to:
  /// **'Reset it'**
  String get dsResetIt;

  /// No description provided for @dsClearIt.
  ///
  /// In en, this message translates to:
  /// **'Clear it'**
  String get dsClearIt;

  /// No description provided for @dsUseForColors.
  ///
  /// In en, this message translates to:
  /// **'Update the app colors using this image'**
  String get dsUseForColors;

  /// No description provided for @dsImgGetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve image'**
  String get dsImgGetFailed;

  /// No description provided for @dsImgSetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update image'**
  String get dsImgSetFailed;

  /// No description provided for @dsImgPermission.
  ///
  /// In en, this message translates to:
  /// **'Some sites don\'t allow their images to be accessed by others.\nTry an image from another host.'**
  String get dsImgPermission;

  /// No description provided for @dsUseFull.
  ///
  /// In en, this message translates to:
  /// **'Use full image?'**
  String get dsUseFull;

  /// No description provided for @dsFit.
  ///
  /// In en, this message translates to:
  /// **'How should it fit?'**
  String get dsFit;

  /// No description provided for @dsCrop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get dsCrop;

  /// No description provided for @dsNoWeb.
  ///
  /// In en, this message translates to:
  /// **'Image editing is not supported on web'**
  String get dsNoWeb;

  /// No description provided for @dsRotateLeft.
  ///
  /// In en, this message translates to:
  /// **'Rotate left'**
  String get dsRotateLeft;

  /// No description provided for @dsRotateRight.
  ///
  /// In en, this message translates to:
  /// **'Rotate right'**
  String get dsRotateRight;

  /// No description provided for @dsShowScroll.
  ///
  /// In en, this message translates to:
  /// **'Show scrollbars'**
  String get dsShowScroll;

  /// No description provided for @dsResetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset {themeType} button design?'**
  String dsResetButton(Object themeType);

  /// No description provided for @dsResetPage.
  ///
  /// In en, this message translates to:
  /// **'Reset {themeType} page design?'**
  String dsResetPage(Object themeType);

  /// No description provided for @tsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Text settings'**
  String get tsPageTitle;

  /// No description provided for @tsBatchOverride.
  ///
  /// In en, this message translates to:
  /// **'You have already made granular \"{setting}\" changes in advanced settings.\n\nAre you sure you want to override those changes with a batch update?'**
  String tsBatchOverride(Object setting);

  /// No description provided for @tsTextBackground.
  ///
  /// In en, this message translates to:
  /// **'Text background opacity'**
  String get tsTextBackground;

  /// No description provided for @tsIconSize.
  ///
  /// In en, this message translates to:
  /// **'Icon size'**
  String get tsIconSize;

  /// No description provided for @tsLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Activate to edit {style}'**
  String tsLinkHint(Object style);

  /// No description provided for @tsDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get tsDisplay;

  /// No description provided for @tsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Headline'**
  String get tsHeadline;

  /// No description provided for @tsTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get tsTitle;

  /// No description provided for @tsBody.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get tsBody;

  /// No description provided for @tsLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get tsLabel;

  /// No description provided for @tsFontFamily.
  ///
  /// In en, this message translates to:
  /// **'Font family'**
  String get tsFontFamily;

  /// No description provided for @tsFontSize.
  ///
  /// In en, this message translates to:
  /// **'Font size'**
  String get tsFontSize;

  /// No description provided for @tsBold.
  ///
  /// In en, this message translates to:
  /// **'Bold'**
  String get tsBold;

  /// No description provided for @tsItalic.
  ///
  /// In en, this message translates to:
  /// **'Italic'**
  String get tsItalic;

  /// No description provided for @tsUnderline.
  ///
  /// In en, this message translates to:
  /// **'Underline'**
  String get tsUnderline;

  /// No description provided for @tsLetterSpacing.
  ///
  /// In en, this message translates to:
  /// **'Letter spacing'**
  String get tsLetterSpacing;

  /// No description provided for @tsWordSpacing.
  ///
  /// In en, this message translates to:
  /// **'Word spacing'**
  String get tsWordSpacing;

  /// No description provided for @tsLineHeight.
  ///
  /// In en, this message translates to:
  /// **'Line height'**
  String get tsLineHeight;

  /// No description provided for @tsDisplayP1.
  ///
  /// In en, this message translates to:
  /// **'Does this '**
  String get tsDisplayP1;

  /// No description provided for @tsDisplayLink.
  ///
  /// In en, this message translates to:
  /// **'display'**
  String get tsDisplayLink;

  /// No description provided for @tsDisplayP2.
  ///
  /// In en, this message translates to:
  /// **' well?'**
  String get tsDisplayP2;

  /// No description provided for @tsHeadlineP1.
  ///
  /// In en, this message translates to:
  /// **'Are '**
  String get tsHeadlineP1;

  /// No description provided for @tsHeadlineLink.
  ///
  /// In en, this message translates to:
  /// **'headlines'**
  String get tsHeadlineLink;

  /// No description provided for @tsHeadlineP2.
  ///
  /// In en, this message translates to:
  /// **' distinct...'**
  String get tsHeadlineP2;

  /// No description provided for @tsTitleP1.
  ///
  /// In en, this message translates to:
  /// **'from '**
  String get tsTitleP1;

  /// No description provided for @tsTitleLink.
  ///
  /// In en, this message translates to:
  /// **'titles?'**
  String get tsTitleLink;

  /// No description provided for @tsBodyP1.
  ///
  /// In en, this message translates to:
  /// **'How about '**
  String get tsBodyP1;

  /// No description provided for @tsBodyLink.
  ///
  /// In en, this message translates to:
  /// **'the body?'**
  String get tsBodyLink;

  /// No description provided for @tsBodyP2.
  ///
  /// In en, this message translates to:
  /// **' Is it easy to read?'**
  String get tsBodyP2;

  /// No description provided for @tsLabelP1.
  ///
  /// In en, this message translates to:
  /// **'And '**
  String get tsLabelP1;

  /// No description provided for @tsLabelLink.
  ///
  /// In en, this message translates to:
  /// **'the labels?'**
  String get tsLabelLink;

  /// No description provided for @tsLabelP2.
  ///
  /// In en, this message translates to:
  /// **' Not too big, not too small?'**
  String get tsLabelP2;

  /// No description provided for @tsReset.
  ///
  /// In en, this message translates to:
  /// **'Reset {themeType} text styles?'**
  String tsReset(Object themeType);
}

class _OUILangDelegate extends LocalizationsDelegate<OUILang> {
  const _OUILangDelegate();

  @override
  Future<OUILang> load(Locale locale) {
    return lookupOUILang(locale);
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fil',
        'fr',
        'hi',
        'ht',
        'ja',
        'ko',
        'ru',
        'sw',
        'uk',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_OUILangDelegate old) => false;
}

Future<OUILang> lookupOUILang(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return oui_lang_ar
                .loadLibrary()
                .then((dynamic _) => oui_lang_ar.OUILangArEg());
        }
        break;
      }
    case 'en':
      {
        switch (locale.countryCode) {
          case 'US':
            return oui_lang_en
                .loadLibrary()
                .then((dynamic _) => oui_lang_en.OUILangEnUs());
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return oui_lang_zh
                .loadLibrary()
                .then((dynamic _) => oui_lang_zh.OUILangZhCn());
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return oui_lang_ar
          .loadLibrary()
          .then((dynamic _) => oui_lang_ar.OUILangAr());
    case 'de':
      return oui_lang_de
          .loadLibrary()
          .then((dynamic _) => oui_lang_de.OUILangDe());
    case 'en':
      return oui_lang_en
          .loadLibrary()
          .then((dynamic _) => oui_lang_en.OUILangEn());
    case 'es':
      return oui_lang_es
          .loadLibrary()
          .then((dynamic _) => oui_lang_es.OUILangEs());
    case 'fil':
      return oui_lang_fil
          .loadLibrary()
          .then((dynamic _) => oui_lang_fil.OUILangFil());
    case 'fr':
      return oui_lang_fr
          .loadLibrary()
          .then((dynamic _) => oui_lang_fr.OUILangFr());
    case 'hi':
      return oui_lang_hi
          .loadLibrary()
          .then((dynamic _) => oui_lang_hi.OUILangHi());
    case 'ht':
      return oui_lang_ht
          .loadLibrary()
          .then((dynamic _) => oui_lang_ht.OUILangHt());
    case 'ja':
      return oui_lang_ja
          .loadLibrary()
          .then((dynamic _) => oui_lang_ja.OUILangJa());
    case 'ko':
      return oui_lang_ko
          .loadLibrary()
          .then((dynamic _) => oui_lang_ko.OUILangKo());
    case 'ru':
      return oui_lang_ru
          .loadLibrary()
          .then((dynamic _) => oui_lang_ru.OUILangRu());
    case 'sw':
      return oui_lang_sw
          .loadLibrary()
          .then((dynamic _) => oui_lang_sw.OUILangSw());
    case 'uk':
      return oui_lang_uk
          .loadLibrary()
          .then((dynamic _) => oui_lang_uk.OUILangUk());
    case 'zh':
      return oui_lang_zh
          .loadLibrary()
          .then((dynamic _) => oui_lang_zh.OUILangZh());
  }

  throw FlutterError(
      'OUILang.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
