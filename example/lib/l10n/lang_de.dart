// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class LangDe extends Lang {
  LangDe([String locale = 'de']) : super(locale);

  @override
  String get csPageTitle => 'Builder';

  @override
  String get csAppName => 'App-Name';

  @override
  String get csNamePreview => 'beispiel_app';

  @override
  String get csNameTip => 'Beste App aller Zeiten';

  @override
  String get csBecomes => 'wird zu';

  @override
  String get csInvalidName =>
      'Kleinbuchstaben, Zahlen und Unterstriche sind erlaubt.';

  @override
  String get csYourApp => 'deine App';

  @override
  String get csPubName => 'Name des Herausgebers';

  @override
  String get csPubPreview => 'Beispiel-Organisation';

  @override
  String get csPubTip => 'Oder eine Beispiel-Person';

  @override
  String get csDescription => 'Beschreibung';

  @override
  String get csDescPreview => 'Ein oder zwei Sätze über deine App.';

  @override
  String get csDomainName => 'Domain-Name';

  @override
  String get csDomainTip => 'Rückwärts lautet sie';

  @override
  String get csInvalidDomain =>
      'Nur \'domain.name\'; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String get csInclude => 'Einschließen';

  @override
  String get csEasy => 'Später leicht zu ändern';

  @override
  String csGenApp(Object app_name) {
    return 'Wenn du $app_name generierst, wird die aktuelle ';
  }

  @override
  String get csTheApp => 'App';

  @override
  String get csTheConfig => 'Konfiguration';

  @override
  String csSetColors(Object app_name) {
    return ' (außer Bildern) zur Standardkonfiguration für $app_name.\n\nEs wird empfohlen, ein benutzerdefiniertes Farbschema festzulegen. Wenn du Hilfe bei der Erstellung benötigst, starte am besten ';
  }

  @override
  String get csHere => 'hier.';

  @override
  String get csHereHint => 'Öffne einen Online-Generator für Farbschemas';

  @override
  String get csFileBrowser => 'Dateibrowser öffnen';

  @override
  String get csFlutterPath => 'Flutter-Pfad';

  @override
  String get csNoSpaces => 'Der Pfad darf keine Leerzeichen enthalten';

  @override
  String get csNotInstalled => 'Nicht installiert?';

  @override
  String get csPathRequired =>
      'Pfad erforderlich. Der Stammordner kann nicht verwendet werden.';

  @override
  String get csBadPath => 'Ungültiger Pfad';

  @override
  String get csAdvanced => 'Erweiterte Einstellungen';

  @override
  String csRestore(Object setting) {
    return '$setting wiederherstellen';
  }

  @override
  String get csOutputPath => 'Ausgabepfad';

  @override
  String get csCopyright => 'Copyright-Hinweis';

  @override
  String get csCopyrightTip => 'Wird am Anfang jeder Dart-Datei eingefügt';

  @override
  String get csLicenseDocs => 'Dokumentation zu Open-Source-Lizenzen öffnen';

  @override
  String get csL10nTip => 'Konfiguration für Lokalisierung (Übersetzungen)';

  @override
  String get csLintTip => 'Lint-Regeln';

  @override
  String get csLaunchTip =>
      'Fügt Startoptionen zum Debug-Menü von VS Code hinzu';

  @override
  String get csGenerate => 'App generieren';

  @override
  String get csInvalidFields => 'Einige Felder sind ungültig';

  @override
  String get csRequired => 'Alle Felder sind erforderlich';

  @override
  String get csResetHint =>
      'Aktiviere und bestätige, was zurückgesetzt werden soll.';

  @override
  String get csResetBuilder => 'Builder-Werte';

  @override
  String get csResetApp => 'App-Einstellungen';

  @override
  String get csResetBoth => 'Beides';

  @override
  String get csResetNothing => 'Nichts';

  @override
  String get asPageTitle => 'Archivierer';

  @override
  String get asUseIt => '\n\nVerwende es auf ';

  @override
  String asToGen(Object app_name) {
    return ' für Desktop, um den Code für $app_name zu generieren';
  }

  @override
  String get gsPageTitle => 'Generator';

  @override
  String get gsConsole => 'Konsolenausgabe';

  @override
  String get gsIsReadyIn => 'ist fertig in';

  @override
  String get gsFirstRun =>
      'Der erste Durchlauf dauert normalerweise etwas länger';

  @override
  String get gsNeedPermission =>
      'Open UI benötigt Festplattenvollzugriff.\n\nBitte gehe zu...\nSystemeinstellungen > Datenschutz & Sicherheit > Festplattenvollzugriff > Open UI aktivieren; versuche es dann erneut.';

  @override
  String get gsSeeNBelieve =>
      'Wenn du überprüfen möchtest, was Open UI tut, gehe ';

  @override
  String get gsSeeNBelieveHint =>
      'Öffne den Code-Generierungscode von Open UI.';

  @override
  String get gsNotInstalled => 'Flutter ist nicht installiert';

  @override
  String get gsPartialSuccess =>
      'Der Code wurde erfolgreich generiert, aber einige Teile der Projekteinrichtung sind fehlgeschlagen.';

  @override
  String get rsWouldYou => 'möchtest du...';

  @override
  String get rsInstall => 'Installieren';

  @override
  String get rsInstallHint => 'Öffne die Installationsanleitung für Flutter';

  @override
  String get rsRun => 'Ausführen';

  @override
  String get rsWipe => 'Bereinigen';

  @override
  String get rsNextTime =>
      'Erfolg, drücken wir die Daumen für das nächste Mal!';

  @override
  String get rsAnotherOne =>
      'Ein weiterer Fehler; du solltest wahrscheinlich übernehmen...';

  @override
  String get rsLeave => 'So lassen';
}
