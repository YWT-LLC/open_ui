// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'oui_lang.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class OUILangDe extends OUILang {
  OUILangDe([String locale = 'de']) : super(locale);

  @override
  String get gApply => 'Anwenden';

  @override
  String get gApplyChanges => 'Änderungen anwenden';

  @override
  String get gContinue => 'Weiter';

  @override
  String get gOpen => 'Öffnen';

  @override
  String get gOpenLink => 'Link öffnen';

  @override
  String get gSkip => 'Überspringen';

  @override
  String get gSuccess => 'Erfolg';

  @override
  String get gSuccessExl => 'Erfolg!';

  @override
  String get gYes => 'Ja';

  @override
  String get gAnd => 'und';

  @override
  String get gHelp => 'Hilfe';

  @override
  String get gNA => 'N/A';

  @override
  String get gNAHint => 'Nicht zutreffend';

  @override
  String get gOptional => 'optional';

  @override
  String get gOptions => 'Optionen';

  @override
  String get gRequired => 'Erforderlich';

  @override
  String get gThe => 'Das';

  @override
  String get gBack => 'Zurück';

  @override
  String get gCancel => 'Abbrechen';

  @override
  String get gClose => 'Schließen';

  @override
  String get gDisabled => 'Deaktiviert';

  @override
  String get gError => 'Fehler';

  @override
  String get gFailure => 'Fehlschlag';

  @override
  String get gNo => 'Nein';

  @override
  String get gRedo => 'Wiederholen';

  @override
  String get gUndo => 'Rückgängig';

  @override
  String get gSettings => 'Einstellungen';

  @override
  String get gGlobal => 'Global';

  @override
  String get gColor => 'Farbe';

  @override
  String get gDesign => 'Design';

  @override
  String get gLayout => 'Layout';

  @override
  String get gText => 'Text';

  @override
  String get gDark => 'Dunkel';

  @override
  String get gLight => 'Hell';

  @override
  String get gSystem => 'System';

  @override
  String get gEditing => 'Bearbeiten: ';

  @override
  String get gEditingHint => 'Zum Bearbeiten aktivieren';

  @override
  String get gDarkTheme => 'Dunkles Design';

  @override
  String get gLightTheme => 'Helles Design';

  @override
  String get gBothThemes => 'Beide Designs';

  @override
  String get gLeft => 'Links';

  @override
  String get gRight => 'Rechts';

  @override
  String get gAdvanced => 'Erweitert';

  @override
  String get gQuick => 'Schnell';

  @override
  String get gDecrease => 'Verringern';

  @override
  String get gIncrease => 'Erhöhen';

  @override
  String get gMaximum => 'Maximum';

  @override
  String get gMinimum => 'Minimum';

  @override
  String get gCenterReset => 'Mitte gedrückt halten zum Zurücksetzen';

  @override
  String get gLoadingAnim => 'Lädt. Das YWT-Logo dreht sich wie eine Sanduhr.';

  @override
  String get gPlay => 'Abspielen';

  @override
  String get gPause => 'Pause';

  @override
  String get gReplay => 'Erneut abspielen';

  @override
  String get gMute => 'Stummschalten';

  @override
  String get gUnMute => 'Stummschaltung aufheben';

  @override
  String get gPlaybackSpeed => 'Wiedergabegeschwindigkeit';

  @override
  String get gFBF => 'Bild für Bild';

  @override
  String get gCaptions => 'Untertitel';

  @override
  String get gCaptionsHint => 'Für Schriftarten gedrückt halten';

  @override
  String get gFullscreen => 'Vollbild';

  @override
  String get gMachineTranslated => 'Maschinell übersetzt';

  @override
  String get gUpdates => 'Updates verfügbar';

  @override
  String get gHardRefresh =>
      'Bitte die Seite komplett neu laden...\nStrg + Umschalt + R';

  @override
  String get gHardRefreshMac =>
      'Bitte die Seite komplett neu laden...\nCmd + Umschalt + R';

  @override
  String get gHardRefreshMobile => 'Bitte die Seite im Browser-Menü neu laden.';

  @override
  String get gEnterURL => 'URL eingeben';

  @override
  String get gValidURL => 'Bitte eine gültige URL eingeben';

  @override
  String get g404Wonder => 'Nicht alle, die wandern, sind verloren.';

  @override
  String get g404 => 'Aber in diesem Fall: 404 Seite nicht gefunden.';

  @override
  String get g404Note =>
      'Hinweis: Flutter Web verwendet Hash-Routing, wie...\nhttps://www.example.com/#/ziel';

  @override
  String get gOpenSource => 'Open Source';

  @override
  String get gOpenYWT => 'Link zu YWT LLC öffnen';

  @override
  String get gOpenUISourceHint => 'GitHub-Seite für Open UI öffnen';

  @override
  String get gOpenUIReleases => 'Releases-Seite für Open UI öffnen';

  @override
  String get gSupportEmail => 'Unsere Support-E-Mail';

  @override
  String gClipboard(Object thing) {
    return '$thing wurde in die Zwischenablage kopiert.';
  }

  @override
  String get gAttention => 'Achtung';

  @override
  String get gCurrently => 'Aktuell:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name ist auf $value gesetzt';
  }

  @override
  String get gRemove => 'Entfernen';

  @override
  String get gReset => 'Zurücksetzen';

  @override
  String get gResetTo => 'Zurücksetzen:';

  @override
  String gResetValue(Object name) {
    return '$name zurücksetzen?';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return '$name auf $value zurücksetzen';
  }

  @override
  String get gResetAll => 'Alles zurücksetzen';

  @override
  String get gUndoWarn1 =>
      'Kann nicht automatisch rückgängig gemacht werden.\n';

  @override
  String get gSave => 'Speichern';

  @override
  String get gSaveHint =>
      'Aktivieren, um eine JSON-Konfigurationsdatei zu speichern.';

  @override
  String get gSwitchHint => 'Schalter umlegen';

  @override
  String get gUndoWarn2 =>
      ' Sie Ihre aktuelle Konfiguration, um sie manuell wiederherzustellen.';

  @override
  String get gValue => 'Wert';

  @override
  String get gSource => 'Quelle:';

  @override
  String get gCreator => 'Ersteller von';

  @override
  String get gMadeBy => 'Erstellt von';

  @override
  String get gYou => 'Von Ihnen festgelegt';

  @override
  String get ssNavHint => 'Einstellungsseite öffnen';

  @override
  String get ssHaveFun => 'Viel Spaß!';

  @override
  String get ssDominantHand => 'Dominante Hand';

  @override
  String get ssThemeMode => 'Design-Modus';

  @override
  String get ssLanguage => 'Sprache';

  @override
  String get ssLangHint => 'Aktivieren, um die App-Sprache zu ändern';

  @override
  String get ssUpdateDark => 'Dunkles Design aktualisieren';

  @override
  String get ssUpdateLight => 'Helles Design aktualisieren';

  @override
  String get ssUpdateBoth => 'Beide Design-Modi aktualisieren';

  @override
  String get ssLoadPreset => 'Voreinstellung laden';

  @override
  String get ssLoadPresetHint => 'Aktivieren, um Voreinstellungen anzuzeigen';

  @override
  String get ssDewIt => 'Beide aktualisieren/automatisch bestätigen';

  @override
  String get ssBigButtons => 'Große Schaltflächen';

  @override
  String get ssHighVisibility => 'Hohe Sichtbarkeit';

  @override
  String get ssChalkboard => 'Tafel';

  @override
  String get ssNebula => 'Nebel';

  @override
  String get ssWallHoles => 'Wandlöcher';

  @override
  String get ssDarkOnly =>
      'Dies ist eine Voreinstellung für das dunkle Design.\nDer Design-Modus wird auf dunkel gesetzt und aktualisiert.\n\nWeiter?';

  @override
  String get ssLightOnly =>
      'Dies ist eine Voreinstellung für das helle Design.\nDer Design-Modus wird auf hell gesetzt und aktualisiert.\n\nWeiter?';

  @override
  String ssApplied(Object config) {
    return '$config angewendet.';
  }

  @override
  String get ssTryMe => 'Probier mich aus';

  @override
  String get ssRandom => 'Zufällig';

  @override
  String ssRandomize(Object themeType) {
    return '$themeType Design zufällig generieren?';
  }

  @override
  String get ssConfigTip => 'Konfiguration speichern/laden';

  @override
  String get ssSaveConfig => 'Konfiguration speichern';

  @override
  String ssConfigSaved(Object path) {
    return 'Ihre Konfiguration wurde in $path gespeichert';
  }

  @override
  String get ssWrongConfigExt => 'Die Datei wurde nicht gespeichert als ';

  @override
  String get ssLoadConfig => 'Konfiguration laden';

  @override
  String get ssImageToo => 'Auch Hintergrundbilder?';

  @override
  String get ssResetAll => 'Alle Einstellungen zurücksetzen?';

  @override
  String get ssResetAppearance =>
      'Alle Erscheinungsbild-Einstellungen zurücksetzen?';

  @override
  String get ssResetBoth => 'Beide Design-Modi zurücksetzen';

  @override
  String get csPageTitle => 'Farbeinstellungen';

  @override
  String get csSchemeBase => 'Farbschema aus\nBild erstellen';

  @override
  String get csFromImage => 'Ein Farbschema wird aus dem Bild generiert.';

  @override
  String get csMonoChrome => 'Monochromes Schema verwenden';

  @override
  String get csHighContrast => 'Kontrastreiches Schema verwenden';

  @override
  String get csPrimary => 'Primär';

  @override
  String get csPrimaryContainer => 'Primäre\nKontur';

  @override
  String get csSecondary => 'Sekundär';

  @override
  String get csSecondaryContainer => 'Sekundäre\nKontur';

  @override
  String get csTertiary => 'Tertiär';

  @override
  String get csTertiaryContainer => 'Tertiäre\nKontur';

  @override
  String get csError => 'Fehler';

  @override
  String get csErrorContainer => 'Fehler-\nKontur';

  @override
  String get csOutline => 'Hinweis-\ntext';

  @override
  String get csOutlineVariant => 'Hinweis-\nKontur';

  @override
  String get csSurface => 'Schaltflächen-\nHintergrund';

  @override
  String get csSurfaceDim => 'Alarm && App-Leisten-\nHintergrund';

  @override
  String get csSurfaceContainer => 'Seiten- && Modal-\nHintergrund';

  @override
  String get csOnSurface => 'Text';

  @override
  String get csScrim => 'Modal-\nAbdeckung';

  @override
  String get csShadow => 'Schatten';

  @override
  String get csSurfaceTint => 'Oberflächen-\nFärbung';

  @override
  String get csPickerTitle => 'Farbe auswählen';

  @override
  String get csPickerHint =>
      'Farbauswahl öffnen. Für weitere Optionen gedrückt halten.';

  @override
  String get csRecommended => 'Kontrast-Empfehlung verwenden?';

  @override
  String get csUseCustom => 'Benutzerdefiniert verwenden';

  @override
  String get csCurrVal => 'Aktueller Farbwert:';

  @override
  String csReset(Object themeType) {
    return '$themeType Farben zurücksetzen?';
  }

  @override
  String get csColorScheme => 'Farbschema';

  @override
  String get dsPageTitle => 'Design-Einstellungen';

  @override
  String get dsButton => 'Schaltfläche';

  @override
  String get dsPage => 'Seite';

  @override
  String get dsNone => 'Keine';

  @override
  String get dsSystem => 'System';

  @override
  String get dsPadding => 'Innenabstand';

  @override
  String get dsStyle => 'Stil';

  @override
  String get dsBorderWidth => 'Randbreite';

  @override
  String get dsPill => 'Pille';

  @override
  String get dsRectangle => 'Rechteck';

  @override
  String get dsRoundRectangle => 'Abgerundetes Rechteck';

  @override
  String get dsLeftGram => 'Links parallel';

  @override
  String get dsRightGram => 'Rechts parallel';

  @override
  String get dsGem => 'Edelstein';

  @override
  String get dsJewel => 'Juwel';

  @override
  String get dsAlwaysUnderline => 'Links immer unterstreichen';

  @override
  String get dsShowBack => 'Zurück-Schaltfläche anzeigen';

  @override
  String get dsMargin => 'Außenabstand';

  @override
  String get dsSpacing => 'Abstand';

  @override
  String get dsPageTransition => 'Seitenübergang';

  @override
  String get dsTurnX => 'Horizontale Drehung';

  @override
  String get dsTurnY => 'Vertikale Drehung';

  @override
  String get dsRotate => 'Rotieren';

  @override
  String get dsSlideX => 'Horizontales Gleiten';

  @override
  String get dsSlideY => 'Vertikales Gleiten';

  @override
  String get dsZoom => 'Zoom';

  @override
  String get dsFadeTransition => 'Verblassen';

  @override
  String get dsAnimStyle => 'Animationsstil';

  @override
  String get dsPlay => 'Animation abspielen';

  @override
  String get dsMilliseconds => 'Millisekunden';

  @override
  String get dsCurve => 'Kurve';

  @override
  String get dsBounce => 'Hüpfen';

  @override
  String get dsEase => 'Weich';

  @override
  String get dsElastic => 'Elastisch';

  @override
  String get dsLinear => 'Linear';

  @override
  String get dsBackgroundImg => 'Hintergrundbild';

  @override
  String dsImgSettingHint(Object title) {
    return '$title-Bild aktualisieren';
  }

  @override
  String get dsReFit => 'Neu einpassen';

  @override
  String get dsFromFile => 'Aus Datei';

  @override
  String get dsFromCamera => 'Von Kamera';

  @override
  String get dsFromNetwork => 'Aus URL';

  @override
  String get dsSolidColor => 'Volltonfarbe';

  @override
  String get dsResetIt => 'Zurücksetzen';

  @override
  String get dsClearIt => 'Löschen';

  @override
  String get dsUseForColors => 'App-Farben mit diesem Bild aktualisieren';

  @override
  String get dsImgGetFailed => 'Bild konnte nicht abgerufen werden';

  @override
  String get dsImgSetFailed => 'Bild konnte nicht aktualisiert werden';

  @override
  String get dsImgPermission =>
      'Einige Websites erlauben keinen Fremdzugriff auf ihre Bilder.\nVersuchen Sie es mit einem Bild von einem anderen Host.';

  @override
  String get dsUseFull => 'Gesamtes Bild verwenden?';

  @override
  String get dsFit => 'Wie soll es eingepasst werden?';

  @override
  String get dsCrop => 'Zuschneiden';

  @override
  String get dsNoWeb => 'Bildbearbeitung wird im Web nicht unterstützt';

  @override
  String get dsRotateLeft => 'Nach links drehen';

  @override
  String get dsRotateRight => 'Nach rechts drehen';

  @override
  String get dsShowScroll => 'Bildlaufleisten anzeigen';

  @override
  String dsResetButton(Object themeType) {
    return '$themeType Schaltflächendesign zurücksetzen?';
  }

  @override
  String dsResetPage(Object themeType) {
    return '$themeType Seitendesign zurücksetzen?';
  }

  @override
  String get tsPageTitle => 'Texteinstellungen';

  @override
  String tsBatchOverride(Object setting) {
    return 'Sie haben bereits granulare Änderungen an \"$setting\" in den erweiterten Einstellungen vorgenommen.\n\nSind Sie sicher, dass Sie diese Änderungen mit einem Batch-Update überschreiben möchten?';
  }

  @override
  String get tsTextBackground => 'Text-Hintergrund-Deckkraft';

  @override
  String get tsIconSize => 'Symbolgröße';

  @override
  String tsLinkHint(Object style) {
    return 'Aktivieren, um $style zu bearbeiten';
  }

  @override
  String get tsDisplay => 'Anzeige';

  @override
  String get tsHeadline => 'Überschrift';

  @override
  String get tsTitle => 'Titel';

  @override
  String get tsBody => 'Fließtext';

  @override
  String get tsLabel => 'Beschriftung';

  @override
  String get tsFontFamily => 'Schriftart';

  @override
  String get tsFontSize => 'Schriftgröße';

  @override
  String get tsBold => 'Fett';

  @override
  String get tsItalic => 'Kursiv';

  @override
  String get tsUnderline => 'Unterstrichen';

  @override
  String get tsLetterSpacing => 'Zeichenabstand';

  @override
  String get tsWordSpacing => 'Wortabstand';

  @override
  String get tsLineHeight => 'Zeilenhöhe';

  @override
  String get tsDisplayP1 => 'Ist diese ';

  @override
  String get tsDisplayLink => 'Anzeige';

  @override
  String get tsDisplayP2 => ' gut?';

  @override
  String get tsHeadlineP1 => 'Sind ';

  @override
  String get tsHeadlineLink => 'Überschriften';

  @override
  String get tsHeadlineP2 => ' deutlich...';

  @override
  String get tsTitleP1 => 'von ';

  @override
  String get tsTitleLink => 'Titeln?';

  @override
  String get tsBodyP1 => 'Was ist mit ';

  @override
  String get tsBodyLink => 'dem Fließtext?';

  @override
  String get tsBodyP2 => ' Ist er gut lesbar?';

  @override
  String get tsLabelP1 => 'Und ';

  @override
  String get tsLabelLink => 'die Beschriftungen?';

  @override
  String get tsLabelP2 => ' Nicht zu groß, nicht zu klein?';

  @override
  String tsReset(Object themeType) {
    return '$themeType Textstile zurücksetzen?';
  }
}
