// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class LangJa extends Lang {
  LangJa([String locale = 'ja']) : super(locale);

  @override
  String get csPageTitle => 'ビルダー';

  @override
  String get csAppName => 'アプリ名';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => '最高のアプリ';

  @override
  String get csBecomes => 'になります';

  @override
  String get csInvalidName => '小文字、数字、アンダースコアのみ使用可能です。';

  @override
  String get csYourApp => 'あなたのアプリ';

  @override
  String get csPubName => 'パブリッシャー名';

  @override
  String get csPubPreview => 'Example Organization';

  @override
  String get csPubTip => 'または、個人の名前';

  @override
  String get csDescription => '説明';

  @override
  String get csDescPreview => 'アプリに関する1〜2文の説明。';

  @override
  String get csDomainName => 'ドメイン名';

  @override
  String get csDomainTip => '逆にすると、次のようになります:';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' の形式のみ; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String csGenApp(Object app_name) {
    return '$app_name を生成すると、現在の';
  }

  @override
  String get csTheApp => 'アプリの';

  @override
  String get csTheConfig => '設定';

  @override
  String csSetColors(Object app_name) {
    return '（画像を除く）が $app_name のデフォルト設定になります。\n\nカスタム配色を設定する必要があります。作成のヒントが必要な場合は、ここから始めてみてください: ';
  }

  @override
  String get csHere => 'こちら';

  @override
  String get csHereHint => 'オンラインのカラースキームビルダーを開く';

  @override
  String get csFileBrowser => 'ファイルブラウザを開く';

  @override
  String get csFlutterPath => 'Flutterのパス';

  @override
  String get csNoSpaces => 'パスにスペースを含めることはできません';

  @override
  String get csNotInstalled => 'インストールされていませんか？';

  @override
  String get csPathRequired => 'パスが必要です。ルートフォルダは使用できません。';

  @override
  String get csBadPath => '無効なパス';

  @override
  String get csAdvanced => '詳細設定';

  @override
  String csRestore(Object setting) {
    return '$setting を復元';
  }

  @override
  String get csOutputPath => '出力パス';

  @override
  String get csCopyright => '著作権表示';

  @override
  String get csCopyrightTip => 'すべてのDartファイルの先頭に含まれます';

  @override
  String get csLicenseDocs => 'オープンソースライセンスに関するドキュメントを開く';

  @override
  String get csL10nTip => 'ローカリゼーション（翻訳）設定';

  @override
  String get csLintTip => 'Lintルール';

  @override
  String get csLaunchTip => 'VS Codeのデバッグメニューに起動オプションを追加します';

  @override
  String get csGenerate => 'アプリを生成';

  @override
  String get csInvalidFields => '一部のフィールドが無効です';

  @override
  String get csRequired => 'すべてのフィールドが必須です';

  @override
  String get csResetHint => 'リセットする項目を有効にして確認してください。';

  @override
  String get csResetBuilder => 'ビルダーの値';

  @override
  String get csResetApp => 'アプリの設定';

  @override
  String get csResetBoth => '両方';

  @override
  String get csResetNothing => 'なし';

  @override
  String get asPageTitle => 'アーカイバー';

  @override
  String get asUseIt => '\n\n以下で使用してください: ';

  @override
  String asToGen(Object app_name) {
    return ' (デスクトップ版) を使用して $app_name のコードを生成します';
  }

  @override
  String get gsPageTitle => 'ジェネレーター';

  @override
  String get gsConsole => 'コンソール出力';

  @override
  String get gsIsReadyIn => 'で準備完了';

  @override
  String get gsNeedPermission =>
      'Open UI にはフルディスクアクセスが必要です。\n\nシステム設定 > プライバシーとセキュリティ > フルディスクアクセス に移動し、Open UI を有効にしてからもう一度お試しください。';

  @override
  String get gsSeeNBelieve => 'Open UI の動作を確認したい場合は、こちらへ: ';

  @override
  String get gsSeeNBelieveHint => 'Open UI のコード生成コードを開く';

  @override
  String get gsNotInstalled => 'Flutterがインストールされていません';

  @override
  String get gsPartialSuccess => 'コードは正常に生成されましたが、プロジェクトのセットアップの一部が失敗しました。';

  @override
  String get rsWouldYou => '次は何をしますか...';

  @override
  String get rsInstall => 'インストールする';

  @override
  String get rsInstallHint => 'Flutterのインストールガイドを開く';

  @override
  String get rsRun => '実行する';

  @override
  String get rsWipe => 'ワイプする';

  @override
  String get rsNextTime => '成功です、次回もうまくいくことを祈りましょう！';

  @override
  String get rsAnotherOne => 'また失敗しました。手動で対応したほうがいいかもしれません...';

  @override
  String get rsLeave => 'そのままにする';
}
