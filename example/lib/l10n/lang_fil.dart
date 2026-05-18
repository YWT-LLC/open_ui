// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class LangFil extends Lang {
  LangFil([String locale = 'fil']) : super(locale);

  @override
  String get csPageTitle => 'Tagabuo';

  @override
  String get csAppName => 'Pangalan ng app';

  @override
  String get csNamePreview => 'halimbawang_app';

  @override
  String get csNameTip => 'Pinakamagandang App Kailanman';

  @override
  String get csBecomes => 'ay nagiging';

  @override
  String get csInvalidName =>
      'Maliit na titik, numero, at mga underscore lang ang pinapayagan.';

  @override
  String get csYourApp => 'iyong app';

  @override
  String get csPubName => 'Pangalan ng publisher';

  @override
  String get csPubPreview => 'Halimbawang Organisasyon';

  @override
  String get csPubTip => 'O kaya, Halimbawang Tao';

  @override
  String get csDescription => 'Paglalarawan';

  @override
  String get csDescPreview =>
      'Isa o dalawang pangungusap tungkol sa iyong app.';

  @override
  String get csDomainName => 'Pangalan ng domain';

  @override
  String get csDomainTip => 'Pabaligtad, ito ay';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' lamang; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String get csInclude => 'Isama';

  @override
  String get csEasy => 'Madaling palitan mamaya';

  @override
  String csGenApp(Object app_name) {
    return 'Kapag binuo mo ang $app_name, ang kasalukuyang ';
  }

  @override
  String get csTheApp => 'ang app';

  @override
  String get csTheConfig => 'ang config';

  @override
  String csSetColors(Object app_name) {
    return ' (maliban sa mga larawan) ay magiging default na config para sa $app_name.\n\nInirerekomenda na magtakda ng custom na color scheme. Kung kailangan mo ng tulong sa pagbuo nito, subukang magsimula ';
  }

  @override
  String get csHere => 'dito.';

  @override
  String get csHereHint => 'Magbukas ng online na tagabuo ng color scheme';

  @override
  String get csFileBrowser => 'Buksan ang file browser';

  @override
  String get csFlutterPath => 'Path ng Flutter';

  @override
  String get csNoSpaces => 'Hindi maaaring magkaroon ng mga espasyo ang path';

  @override
  String get csNotInstalled => 'Hindi naka-install?';

  @override
  String get csPathRequired =>
      'Kinakailangan ang path. Hindi magagamit ang root folder.';

  @override
  String get csBadPath => 'Hindi wastong path';

  @override
  String get csAdvanced => 'Mga advanced na setting';

  @override
  String csRestore(Object setting) {
    return 'I-restore ang $setting';
  }

  @override
  String get csOutputPath => 'Output path';

  @override
  String get csCopyright => 'Pabatid sa copyright';

  @override
  String get csCopyrightTip => 'Isasama sa itaas ng bawat Dart file';

  @override
  String get csLicenseDocs =>
      'Buksan ang dokumentasyon tungkol sa mga open source na lisensya';

  @override
  String get csL10nTip => 'Config ng lokalisasyon (o mga pagsasalin)';

  @override
  String get csLintTip => 'Mga panuntunan ng lint';

  @override
  String get csLaunchTip =>
      'Nagdaragdag ng mga opsyon sa paglunsad sa debug menu ng VS Code';

  @override
  String get csGenerate => 'Bumuo ng app';

  @override
  String get csInvalidFields => 'May mga field na hindi wasto';

  @override
  String get csRequired => 'Kinakailangan ang lahat ng field';

  @override
  String get csResetHint =>
      'I-activate at kumpirmahin kung ano ang dapat i-reset.';

  @override
  String get csResetBuilder => 'Mga value ng tagabuo';

  @override
  String get csResetApp => 'Mga setting ng app';

  @override
  String get csResetBoth => 'Pareho';

  @override
  String get csResetNothing => 'Wala';

  @override
  String get asPageTitle => 'Taga-archive';

  @override
  String get asUseIt => '\n\nGamitin ito sa ';

  @override
  String asToGen(Object app_name) {
    return ' para sa desktop upang mabuo ang code para sa $app_name';
  }

  @override
  String get gsPageTitle => 'Generator';

  @override
  String get gsConsole => 'Output sa console';

  @override
  String get gsIsReadyIn => 'ay handa na sa loob ng';

  @override
  String get gsFirstRun => 'Karaniwang matagal ang unang pagpapatakbo';

  @override
  String get gsNeedPermission =>
      'Kailangan ng Open UI ng Full Disk Access.\n\nMangyaring pumunta sa...\nSystem Settings > Privacy & Security > Full Disk Access > I-enable ang Open UI; pagkatapos ay subukang muli.';

  @override
  String get gsSeeNBelieve =>
      'Kung gusto mong suriin kung ano ang ginagawa ng Open UI, pumunta ';

  @override
  String get gsSeeNBelieveHint =>
      'Buksan ang code ng pagbuo ng code ng Open UI.';

  @override
  String get gsNotInstalled => 'Hindi naka-install ang Flutter';

  @override
  String get gsPartialSuccess =>
      'Matagumpay na nabuo ang code, ngunit nabigo ang ilan sa pag-setup ng proyekto.';

  @override
  String get rsWouldYou => 'gusto mo bang...';

  @override
  String get rsInstall => 'I-install ito';

  @override
  String get rsInstallHint => 'Buksan ang gabay sa pag-install ng Flutter';

  @override
  String get rsRun => 'Patakbuhin ito';

  @override
  String get rsWipe => 'Burahin ito';

  @override
  String get rsNextTime => 'Tagumpay, umasa tayong maayos ulit sa susunod!';

  @override
  String get rsAnotherOne =>
      'Panibagong pagkabigo; baka dapat ikaw na ang mag-ayos...';

  @override
  String get rsLeave => 'Iwanan ito';
}
