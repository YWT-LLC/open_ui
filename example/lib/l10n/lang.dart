import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'lang_ar.dart' deferred as lang_ar;
import 'lang_de.dart' deferred as lang_de;
import 'lang_en.dart' deferred as lang_en;
import 'lang_es.dart' deferred as lang_es;
import 'lang_fil.dart' deferred as lang_fil;
import 'lang_fr.dart' deferred as lang_fr;
import 'lang_hi.dart' deferred as lang_hi;
import 'lang_ht.dart' deferred as lang_ht;
import 'lang_ja.dart' deferred as lang_ja;
import 'lang_ko.dart' deferred as lang_ko;
import 'lang_ru.dart' deferred as lang_ru;
import 'lang_sw.dart' deferred as lang_sw;
import 'lang_uk.dart' deferred as lang_uk;
import 'lang_zh.dart' deferred as lang_zh;

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Lang
/// returned by `Lang.of(context)`.
///
/// Applications need to include `Lang.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/lang.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Lang.localizationsDelegates,
///   supportedLocales: Lang.supportedLocales,
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
/// be consistent with the languages listed in the Lang.supportedLocales
/// property.
abstract class Lang {
  Lang(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Lang? of(BuildContext context) {
    return Localizations.of<Lang>(context, Lang);
  }

  static const LocalizationsDelegate<Lang> delegate = _LangDelegate();

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

  /// No description provided for @csPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Builder'**
  String get csPageTitle;

  /// No description provided for @csAppName.
  ///
  /// In en, this message translates to:
  /// **'App name'**
  String get csAppName;

  /// No description provided for @csNamePreview.
  ///
  /// In en, this message translates to:
  /// **'example_app'**
  String get csNamePreview;

  /// No description provided for @csNameTip.
  ///
  /// In en, this message translates to:
  /// **'Best App Ever'**
  String get csNameTip;

  /// No description provided for @csBecomes.
  ///
  /// In en, this message translates to:
  /// **'becomes'**
  String get csBecomes;

  /// No description provided for @csInvalidName.
  ///
  /// In en, this message translates to:
  /// **'Lowercase letters, numbers, and underscores are allowed.'**
  String get csInvalidName;

  /// No description provided for @csYourApp.
  ///
  /// In en, this message translates to:
  /// **'your app'**
  String get csYourApp;

  /// No description provided for @csPubName.
  ///
  /// In en, this message translates to:
  /// **'Publisher name'**
  String get csPubName;

  /// No description provided for @csPubPreview.
  ///
  /// In en, this message translates to:
  /// **'Example Organization'**
  String get csPubPreview;

  /// No description provided for @csPubTip.
  ///
  /// In en, this message translates to:
  /// **'Or, Example Person'**
  String get csPubTip;

  /// No description provided for @csDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get csDescription;

  /// No description provided for @csDescPreview.
  ///
  /// In en, this message translates to:
  /// **'One or two sentences about your app.'**
  String get csDescPreview;

  /// No description provided for @csDomainName.
  ///
  /// In en, this message translates to:
  /// **'Domain name'**
  String get csDomainName;

  /// No description provided for @csDomainTip.
  ///
  /// In en, this message translates to:
  /// **'Backwards, it is'**
  String get csDomainTip;

  /// No description provided for @csInvalidDomain.
  ///
  /// In en, this message translates to:
  /// **'\'domain.name\' only; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')'**
  String get csInvalidDomain;

  /// No description provided for @csGenApp.
  ///
  /// In en, this message translates to:
  /// **'When you generate {app_name}, the current '**
  String csGenApp(Object app_name);

  /// No description provided for @csTheApp.
  ///
  /// In en, this message translates to:
  /// **'the app'**
  String get csTheApp;

  /// No description provided for @csTheConfig.
  ///
  /// In en, this message translates to:
  /// **'the config'**
  String get csTheConfig;

  /// No description provided for @csSetColors.
  ///
  /// In en, this message translates to:
  /// **' (except images) will become the default config for {app_name}.\n\nIt is required to set a custom color scheme. If you need help building one, try starting '**
  String csSetColors(Object app_name);

  /// No description provided for @csHere.
  ///
  /// In en, this message translates to:
  /// **'here.'**
  String get csHere;

  /// No description provided for @csHereHint.
  ///
  /// In en, this message translates to:
  /// **'Open an online color scheme builder'**
  String get csHereHint;

  /// No description provided for @csFileBrowser.
  ///
  /// In en, this message translates to:
  /// **'Open file browser'**
  String get csFileBrowser;

  /// No description provided for @csFlutterPath.
  ///
  /// In en, this message translates to:
  /// **'Flutter path'**
  String get csFlutterPath;

  /// No description provided for @csNoSpaces.
  ///
  /// In en, this message translates to:
  /// **'Path cannot have spaces'**
  String get csNoSpaces;

  /// No description provided for @csNotInstalled.
  ///
  /// In en, this message translates to:
  /// **'Not installed?'**
  String get csNotInstalled;

  /// No description provided for @csPathRequired.
  ///
  /// In en, this message translates to:
  /// **'Path required. Cannot use root folder.'**
  String get csPathRequired;

  /// No description provided for @csBadPath.
  ///
  /// In en, this message translates to:
  /// **'Invalid path'**
  String get csBadPath;

  /// No description provided for @csAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced settings'**
  String get csAdvanced;

  /// No description provided for @csRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore {setting}'**
  String csRestore(Object setting);

  /// No description provided for @csOutputPath.
  ///
  /// In en, this message translates to:
  /// **'Output path'**
  String get csOutputPath;

  /// No description provided for @csCopyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright notice'**
  String get csCopyright;

  /// No description provided for @csCopyrightTip.
  ///
  /// In en, this message translates to:
  /// **'Will be included at the top of every Dart file'**
  String get csCopyrightTip;

  /// No description provided for @csLicenseDocs.
  ///
  /// In en, this message translates to:
  /// **'Open documentation on open source licenses'**
  String get csLicenseDocs;

  /// No description provided for @csL10nTip.
  ///
  /// In en, this message translates to:
  /// **'Localization (aka translations) config'**
  String get csL10nTip;

  /// No description provided for @csLintTip.
  ///
  /// In en, this message translates to:
  /// **'Lint rules'**
  String get csLintTip;

  /// No description provided for @csLaunchTip.
  ///
  /// In en, this message translates to:
  /// **'Adds launch options to VS Code\'s debug menu'**
  String get csLaunchTip;

  /// No description provided for @csGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate app'**
  String get csGenerate;

  /// No description provided for @csInvalidFields.
  ///
  /// In en, this message translates to:
  /// **'Some fields are invalid'**
  String get csInvalidFields;

  /// No description provided for @csRequired.
  ///
  /// In en, this message translates to:
  /// **'All fields are required'**
  String get csRequired;

  /// No description provided for @csResetHint.
  ///
  /// In en, this message translates to:
  /// **'Activate and confirm what should be reset.'**
  String get csResetHint;

  /// No description provided for @csResetBuilder.
  ///
  /// In en, this message translates to:
  /// **'Builder values'**
  String get csResetBuilder;

  /// No description provided for @csResetApp.
  ///
  /// In en, this message translates to:
  /// **'App settings'**
  String get csResetApp;

  /// No description provided for @csResetBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get csResetBoth;

  /// No description provided for @csResetNothing.
  ///
  /// In en, this message translates to:
  /// **'Nothing'**
  String get csResetNothing;

  /// No description provided for @asPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Archiver'**
  String get asPageTitle;

  /// No description provided for @asUseIt.
  ///
  /// In en, this message translates to:
  /// **'\n\nUse it on '**
  String get asUseIt;

  /// No description provided for @asToGen.
  ///
  /// In en, this message translates to:
  /// **' for desktop to generate the code for {app_name}'**
  String asToGen(Object app_name);

  /// No description provided for @gsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Generator'**
  String get gsPageTitle;

  /// No description provided for @gsConsole.
  ///
  /// In en, this message translates to:
  /// **'Console output'**
  String get gsConsole;

  /// No description provided for @gsIsReadyIn.
  ///
  /// In en, this message translates to:
  /// **'is ready in'**
  String get gsIsReadyIn;

  /// No description provided for @gsNeedPermission.
  ///
  /// In en, this message translates to:
  /// **'Open UI needs Full Disk Access.\n\nPlease go to...\nSystem Settings > Privacy & Security > Full Disk Access > Enable Open UI; then try again.'**
  String get gsNeedPermission;

  /// No description provided for @gsSeeNBelieve.
  ///
  /// In en, this message translates to:
  /// **'If you want to verify what Open UI does, go '**
  String get gsSeeNBelieve;

  /// No description provided for @gsSeeNBelieveHint.
  ///
  /// In en, this message translates to:
  /// **'Open Open UI\'s code generation code.'**
  String get gsSeeNBelieveHint;

  /// No description provided for @gsNotInstalled.
  ///
  /// In en, this message translates to:
  /// **'Flutter is not installed'**
  String get gsNotInstalled;

  /// No description provided for @gsPartialSuccess.
  ///
  /// In en, this message translates to:
  /// **'The code was successfully generated, but some of the project setup failed.'**
  String get gsPartialSuccess;

  /// No description provided for @rsWouldYou.
  ///
  /// In en, this message translates to:
  /// **'would you like to...'**
  String get rsWouldYou;

  /// No description provided for @rsInstall.
  ///
  /// In en, this message translates to:
  /// **'Install it'**
  String get rsInstall;

  /// No description provided for @rsInstallHint.
  ///
  /// In en, this message translates to:
  /// **'Open Flutter\'s installation guide'**
  String get rsInstallHint;

  /// No description provided for @rsRun.
  ///
  /// In en, this message translates to:
  /// **'Run it'**
  String get rsRun;

  /// No description provided for @rsWipe.
  ///
  /// In en, this message translates to:
  /// **'Wipe it'**
  String get rsWipe;

  /// No description provided for @rsNextTime.
  ///
  /// In en, this message translates to:
  /// **'Success, fingers crossed for next time!'**
  String get rsNextTime;

  /// No description provided for @rsAnotherOne.
  ///
  /// In en, this message translates to:
  /// **'Another failure; you should probably take over...'**
  String get rsAnotherOne;

  /// No description provided for @rsLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave it'**
  String get rsLeave;
}

class _LangDelegate extends LocalizationsDelegate<Lang> {
  const _LangDelegate();

  @override
  Future<Lang> load(Locale locale) {
    return lookupLang(locale);
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
  bool shouldReload(_LangDelegate old) => false;
}

Future<Lang> lookupLang(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return lang_ar
                .loadLibrary()
                .then((dynamic _) => lang_ar.LangArEg());
        }
        break;
      }
    case 'en':
      {
        switch (locale.countryCode) {
          case 'US':
            return lang_en
                .loadLibrary()
                .then((dynamic _) => lang_en.LangEnUs());
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return lang_zh
                .loadLibrary()
                .then((dynamic _) => lang_zh.LangZhCn());
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return lang_ar.loadLibrary().then((dynamic _) => lang_ar.LangAr());
    case 'de':
      return lang_de.loadLibrary().then((dynamic _) => lang_de.LangDe());
    case 'en':
      return lang_en.loadLibrary().then((dynamic _) => lang_en.LangEn());
    case 'es':
      return lang_es.loadLibrary().then((dynamic _) => lang_es.LangEs());
    case 'fil':
      return lang_fil.loadLibrary().then((dynamic _) => lang_fil.LangFil());
    case 'fr':
      return lang_fr.loadLibrary().then((dynamic _) => lang_fr.LangFr());
    case 'hi':
      return lang_hi.loadLibrary().then((dynamic _) => lang_hi.LangHi());
    case 'ht':
      return lang_ht.loadLibrary().then((dynamic _) => lang_ht.LangHt());
    case 'ja':
      return lang_ja.loadLibrary().then((dynamic _) => lang_ja.LangJa());
    case 'ko':
      return lang_ko.loadLibrary().then((dynamic _) => lang_ko.LangKo());
    case 'ru':
      return lang_ru.loadLibrary().then((dynamic _) => lang_ru.LangRu());
    case 'sw':
      return lang_sw.loadLibrary().then((dynamic _) => lang_sw.LangSw());
    case 'uk':
      return lang_uk.loadLibrary().then((dynamic _) => lang_uk.LangUk());
    case 'zh':
      return lang_zh.loadLibrary().then((dynamic _) => lang_zh.LangZh());
  }

  throw FlutterError(
      'Lang.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
