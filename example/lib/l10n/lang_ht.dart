// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Haitian Haitian Creole (`ht`).
class LangHt extends Lang {
  LangHt([String locale = 'ht']) : super(locale);

  @override
  String get csPageTitle => 'Konstriktè';

  @override
  String get csAppName => 'Non aplikasyon an';

  @override
  String get csNamePreview => 'aplikasyon_egzanp';

  @override
  String get csNameTip => 'Pi bon aplikasyon an';

  @override
  String get csBecomes => 'vin';

  @override
  String get csInvalidName =>
      'Sèlman lèt miniskil, nimewo, ak tirè ba ki otorize.';

  @override
  String get csYourApp => 'aplikasyon w lan';

  @override
  String get csPubName => 'Non piblikatè';

  @override
  String get csPubPreview => 'Òganizasyon Egzanp';

  @override
  String get csPubTip => 'Oswa, Moun Egzanp';

  @override
  String get csDescription => 'Deskripsyon';

  @override
  String get csDescPreview => 'Youn oswa de fraz sou aplikasyon w lan.';

  @override
  String get csDomainName => 'Non domèn';

  @override
  String get csDomainTip => 'Lè l ekri pa dèyè, se';

  @override
  String get csInvalidDomain =>
      '\'domèn.non\' sèlman; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String csGenApp(Object app_name) {
    return 'Lè w jenere $app_name, sa k kounye a ';
  }

  @override
  String get csTheApp => 'aplikasyon an';

  @override
  String get csTheConfig => 'konfigirasyon an';

  @override
  String csSetColors(Object app_name) {
    return ' (eksepte imaj yo) ap vin tounen konfigirasyon defo pou $app_name.\n\nLi nesesè pou mete yon konbinezon koulè pèsonalize. Si w bezwen èd pou kreye youn, eseye kòmanse ';
  }

  @override
  String get csHere => 'isit la.';

  @override
  String get csHereHint => 'Louvri yon kreyatè plan koulè sou entènèt';

  @override
  String get csFileBrowser => 'Louvri navigatè fichye';

  @override
  String get csFlutterPath => 'Chemen Flutter';

  @override
  String get csNoSpaces => 'Chemen an pa ka gen espas';

  @override
  String get csNotInstalled => 'Pa enstale?';

  @override
  String get csPathRequired =>
      'Chemen an obligatwa. Ou pa ka sèvi ak dosye rasin lan.';

  @override
  String get csBadPath => 'Chemen an pa valab';

  @override
  String get csAdvanced => 'Paramèt avanse';

  @override
  String csRestore(Object setting) {
    return 'Retabli $setting';
  }

  @override
  String get csOutputPath => 'Chemen pwodiksyon';

  @override
  String get csCopyright => 'Avi sou dwa otè';

  @override
  String get csCopyrightTip => 'Ap enkli nan tèt chak fichye Dart';

  @override
  String get csLicenseDocs => 'Louvri dokimantasyon sou lisans sous louvri';

  @override
  String get csL10nTip => 'Konfigirasyon lokalizasyon (oubyen tradiksyon)';

  @override
  String get csLintTip => 'Règ Lint yo';

  @override
  String get csLaunchTip => 'Ajoute opsyon lansman nan meni debogaj VS Code la';

  @override
  String get csGenerate => 'Jenere aplikasyon';

  @override
  String get csInvalidFields => 'Gen kèk chan ki pa valab';

  @override
  String get csRequired => 'Tout chan yo obligatwa';

  @override
  String get csResetHint => 'Aktive epi konfime sa k dwe reyinisyalize.';

  @override
  String get csResetBuilder => 'Valè konstriktè yo';

  @override
  String get csResetApp => 'Paramèt aplikasyon an';

  @override
  String get csResetBoth => 'Toulede';

  @override
  String get csResetNothing => 'Anyen';

  @override
  String get asPageTitle => 'Achivè';

  @override
  String get asUseIt => '\n\nSèvi avè l sou ';

  @override
  String asToGen(Object app_name) {
    return ' pou biwo pou jenere kòd la pou $app_name';
  }

  @override
  String get gsPageTitle => 'Jeneratè';

  @override
  String get gsConsole => 'Rezilta konsole a';

  @override
  String get gsIsReadyIn => 'prè nan';

  @override
  String get gsNeedPermission =>
      'Open UI bezwen Aksè Konplè sou Disk la.\n\nTanpri ale nan...\nParamèt Sistèm > Konfidansyalite ak Sekirite > Aksè Konplè sou Disk > Pèmèt Open UI; apresa eseye ankò.';

  @override
  String get gsSeeNBelieve => 'Si ou vle verifye sa Open UI fè, ale ';

  @override
  String get gsSeeNBelieveHint => 'Louvri kòd jenerasyon kòd Open UI a.';

  @override
  String get gsNotInstalled => 'Flutter pa enstale';

  @override
  String get gsPartialSuccess =>
      'Kòd la te jenere avèk siksè, men gen kèk konfigirasyon pwojè ki echwe.';

  @override
  String get rsWouldYou => 'èske w ta renmen...';

  @override
  String get rsInstall => 'Enstale li';

  @override
  String get rsInstallHint => 'Louvri gid enstalasyon Flutter a';

  @override
  String get rsRun => 'Egzekite l';

  @override
  String get rsWipe => 'Efase l';

  @override
  String get rsNextTime => 'Siksè, n ap kwaze dwèt nou pou pwochen fwa!';

  @override
  String get rsAnotherOne =>
      'Yon lòt echèk; ou ta pwobableman dwe pran kontwòl...';

  @override
  String get rsLeave => 'Kite li';
}
