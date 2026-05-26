// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class LangSw extends Lang {
  LangSw([String locale = 'sw']) : super(locale);

  @override
  String get csPageTitle => 'Mjenzi';

  @override
  String get csAppName => 'Jina la programu';

  @override
  String get csNamePreview => 'programu_mfano';

  @override
  String get csNameTip => 'Programu Bora Zaidi';

  @override
  String get csBecomes => 'inakuwa';

  @override
  String get csInvalidName =>
      'Herufi ndogo, nambari, na mistari chini zinaruhusiwa.';

  @override
  String get csYourApp => 'programu yako';

  @override
  String get csPubName => 'Jina la mchapishaji';

  @override
  String get csPubPreview => 'Shirika la Mfano';

  @override
  String get csPubTip => 'Au, Mtu wa Mfano';

  @override
  String get csDescription => 'Maelezo';

  @override
  String get csDescPreview => 'Sentensi moja au mbili kuhusu programu yako.';

  @override
  String get csDomainName => 'Jina la kikoa';

  @override
  String get csDomainTip => 'Kinyume chake, ni';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' pekee; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String csGenApp(Object app_name) {
    return 'Unapotengeneza $app_name, ';
  }

  @override
  String get csTheApp => 'programu';

  @override
  String get csTheConfig => 'usanidi';

  @override
  String csSetColors(Object app_name) {
    return ' ya sasa (isipokuwa picha) itakuwa usanidi chaguomsingi kwa $app_name.\n\nInahitajika kuweka mpango maalum wa rangi. Ikiwa unahitaji msaada wa kuunda mmoja, jaribu kuanzia ';
  }

  @override
  String get csHere => 'hapa.';

  @override
  String get csHereHint => 'Fungua mjenzi wa mpangilio wa rangi mtandaoni';

  @override
  String get csFileBrowser => 'Fungua kivinjari cha faili';

  @override
  String get csFlutterPath => 'Njia ya Flutter';

  @override
  String get csNoSpaces => 'Njia haiwezi kuwa na nafasi';

  @override
  String get csNotInstalled => 'Haijasakinishwa?';

  @override
  String get csPathRequired =>
      'Njia inahitajika. Huwezi kutumia folda ya msingi (root).';

  @override
  String get csBadPath => 'Njia batili';

  @override
  String get csAdvanced => 'Mipangilio ya kina';

  @override
  String csRestore(Object setting) {
    return 'Rejesha $setting';
  }

  @override
  String get csOutputPath => 'Njia ya pato';

  @override
  String get csCopyright => 'Taarifa ya hakimiliki';

  @override
  String get csCopyrightTip => 'Itajumuishwa juu ya kila faili la Dart';

  @override
  String get csLicenseDocs => 'Fungua nyaraka kuhusu leseni za programu huria';

  @override
  String get csL10nTip => 'Usanidi wa ujanibishaji (yaani tafsiri)';

  @override
  String get csLintTip => 'Sheria za lint';

  @override
  String get csLaunchTip =>
      'Inaongeza chaguo za kuanzisha kwenye menyu ya utatuzi (debug) ya VS Code';

  @override
  String get csGenerate => 'Tengeneza programu';

  @override
  String get csInvalidFields => 'Baadhi ya nyanja ni batili';

  @override
  String get csRequired => 'Nyanja zote zinahitajika';

  @override
  String get csResetHint =>
      'Washa na uthibitishe kile kinachopaswa kuwekwa upya.';

  @override
  String get csResetBuilder => 'Thamani za mjenzi';

  @override
  String get csResetApp => 'Mipangilio ya programu';

  @override
  String get csResetBoth => 'Zote mbili';

  @override
  String get csResetNothing => 'Hakuna chochote';

  @override
  String get asPageTitle => 'Kihifadhi';

  @override
  String get asUseIt => '\n\nItumie kwenye ';

  @override
  String asToGen(Object app_name) {
    return ' kwa eneo-kazi ili kutengeneza msimbo wa $app_name';
  }

  @override
  String get gsPageTitle => 'Kizalishi';

  @override
  String get gsConsole => 'Pato la kiweko';

  @override
  String get gsIsReadyIn => 'iko tayari baada ya';

  @override
  String get gsNeedPermission =>
      'Open UI inahitaji Ufikiaji Kamili wa Diski.\n\nTafadhali nenda kwenye...\nMipangilio ya Mfumo > Faragha na Usalama > Ufikiaji Kamili wa Diski > Washa Open UI; kisha ujaribu tena.';

  @override
  String get gsSeeNBelieve =>
      'Ikiwa unataka kuthibitisha kile Open UI inafanya, nenda ';

  @override
  String get gsSeeNBelieveHint =>
      'Fungua msimbo wa kutengeneza msimbo wa Open UI.';

  @override
  String get gsNotInstalled => 'Flutter haijasakinishwa';

  @override
  String get gsPartialSuccess =>
      'Msimbo ulitengenezwa kikamilifu, lakini baadhi ya usanidi wa mradi ulishindwa.';

  @override
  String get rsWouldYou => 'ungependa...';

  @override
  String get rsInstall => 'Isakinishe';

  @override
  String get rsInstallHint => 'Fungua mwongozo wa usakinishaji wa Flutter';

  @override
  String get rsRun => 'Iendeshe';

  @override
  String get rsWipe => 'Ifute';

  @override
  String get rsNextTime =>
      'Imefaulu, tunatumai mambo yatakuwa sawa wakati ujao!';

  @override
  String get rsAnotherOne =>
      'Kufeli kwingine; labda unapaswa kuchukua udhibiti...';

  @override
  String get rsLeave => 'Iiache';
}
