// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'oui_lang.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class OUILangJa extends OUILang {
  OUILangJa([String locale = 'ja']) : super(locale);

  @override
  String get gApply => '適用';

  @override
  String get gApplyChanges => '変更を適用';

  @override
  String get gContinue => '続行';

  @override
  String get gOpen => '開く';

  @override
  String get gOpenLink => 'リンクを開く';

  @override
  String get gSkip => 'スキップ';

  @override
  String get gSuccess => '成功';

  @override
  String get gSuccessExl => '成功しました！';

  @override
  String get gYes => 'はい';

  @override
  String get gAnd => 'および';

  @override
  String get gHelp => 'ヘルプ';

  @override
  String get gNA => '該当なし';

  @override
  String get gNAHint => '該当しません';

  @override
  String get gOptional => '任意';

  @override
  String get gOptions => 'オプション';

  @override
  String get gRequired => '必須';

  @override
  String get gThe => 'その';

  @override
  String get gBack => '戻る';

  @override
  String get gCancel => 'キャンセル';

  @override
  String get gClose => '閉じる';

  @override
  String get gDisabled => '無効';

  @override
  String get gError => 'エラー';

  @override
  String get gFailure => '失敗';

  @override
  String get gNo => 'いいえ';

  @override
  String get gRedo => 'やり直す';

  @override
  String get gUndo => '元に戻す';

  @override
  String get gSettings => '設定';

  @override
  String get gGlobal => 'グローバル';

  @override
  String get gColor => 'カラー';

  @override
  String get gDesign => 'デザイン';

  @override
  String get gLayout => 'レイアウト';

  @override
  String get gText => 'テキスト';

  @override
  String get gDark => 'ダーク';

  @override
  String get gLight => 'ライト';

  @override
  String get gSystem => 'システム';

  @override
  String get gEditing => '編集中の項目: ';

  @override
  String get gEditingHint => 'アクティブにして編集';

  @override
  String get gDarkTheme => 'ダークテーマ';

  @override
  String get gLightTheme => 'ライトテーマ';

  @override
  String get gBothThemes => '両方のテーマ';

  @override
  String get gLeft => '左';

  @override
  String get gRight => '右';

  @override
  String get gAdvanced => '詳細';

  @override
  String get gQuick => 'クイック';

  @override
  String get gDecrease => '減らす';

  @override
  String get gIncrease => '増やす';

  @override
  String get gMaximum => '最大';

  @override
  String get gMinimum => '最小';

  @override
  String get gCenterReset => '中央を長押ししてリセット';

  @override
  String get gLoadingAnim => '読み込み中。YWTのロゴが砂時計のように回転しています。';

  @override
  String get gPlay => '再生';

  @override
  String get gPause => '一時停止';

  @override
  String get gReplay => 'もう一度再生';

  @override
  String get gMute => 'ミュート';

  @override
  String get gUnMute => 'ミュート解除';

  @override
  String get gPlaybackSpeed => '再生速度';

  @override
  String get gFBF => 'コマ送り';

  @override
  String get gCaptions => '字幕 / キャプション';

  @override
  String get gCaptionsHint => '長押しでフォントを変更';

  @override
  String get gFullscreen => '全画面表示';

  @override
  String get gMachineTranslated => '機械翻訳';

  @override
  String get gUpdates => '利用可能なアップデートがあります';

  @override
  String get gHardRefresh => 'ページのハードリフレッシュを行ってください...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac => 'ページのハードリフレッシュを行ってください...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile => 'ブラウザのメニューからページを更新してください。';

  @override
  String get gEnterURL => 'URLを入力';

  @override
  String get gValidURL => '有効なURLを入力してください';

  @override
  String get g404Wonder => 'さまよう者すべてが迷うわけではない。';

  @override
  String get g404 => 'しかし、この場合は異なります：404 ページが見つかりません。';

  @override
  String get g404Note =>
      '注: Flutter webは次のようなハッシュルーティングを使用します...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => 'オープンソース';

  @override
  String get gOpenYWT => 'YWT LLCへのリンクを開く';

  @override
  String get gOpenUISourceHint => 'OpenUIのGitHubページを開く';

  @override
  String get gOpenUIReleases => 'Open UIのリリースぺージを開く';

  @override
  String get gSupportEmail => 'サポートメール';

  @override
  String gClipboard(Object thing) {
    return '$thing がクリップボードにコピーされました。';
  }

  @override
  String get gAttention => '注意';

  @override
  String get gCurrently => '現在:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name は $value に設定されています';
  }

  @override
  String get gRemove => '削除';

  @override
  String get gReset => 'リセット';

  @override
  String get gResetTo => 'リセット先:';

  @override
  String gResetValue(Object name) {
    return '$name をリセットしますか？';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return '$name を $value にリセット';
  }

  @override
  String get gResetAll => 'すべてリセット';

  @override
  String get gUndoWarn1 => '自動で元に戻すことはできません。\n';

  @override
  String get gSave => '保存';

  @override
  String get gSaveHint => 'アクティブにしてJSON設定ファイルを保存します。';

  @override
  String get gSwitchHint => 'スイッチを切り替える';

  @override
  String get gUndoWarn2 => ' 現在の設定を保存して、後で手動で復元できるようにしてください。';

  @override
  String get gValue => '値';

  @override
  String get gSource => 'ソース:';

  @override
  String get gCreator => '作成者';

  @override
  String get gMadeBy => '制作';

  @override
  String get gYou => 'あなたによる設定';

  @override
  String get ssNavHint => '設定ページを開く';

  @override
  String get ssHaveFun => 'お楽しみください！';

  @override
  String get ssDominantHand => '利き手';

  @override
  String get ssThemeMode => 'テーマモード';

  @override
  String get ssLanguage => '言語';

  @override
  String get ssLangHint => 'アクティブにしてアプリの言語を変更します';

  @override
  String get ssUpdateDark => 'ダークテーマを更新';

  @override
  String get ssUpdateLight => 'ライトテーマを更新';

  @override
  String get ssUpdateBoth => '両方のテーマモードを更新';

  @override
  String get ssLoadPreset => 'プリセットを読み込む';

  @override
  String get ssLoadPresetHint => 'アクティブにしてプリセットを表示します';

  @override
  String get ssDewIt => '両方更新/自動確認';

  @override
  String get ssBigButtons => '大きなボタン';

  @override
  String get ssHighVisibility => '高視認性';

  @override
  String get ssChalkboard => '黒板';

  @override
  String get ssNebula => '星雲';

  @override
  String get ssWallHoles => '壁の穴';

  @override
  String get ssDarkOnly =>
      'これはダークテーマのプリセットです。\nテーマモードをダークに設定し、そのテーマを更新します。\n\n続行しますか？';

  @override
  String get ssLightOnly =>
      'これはライトテーマのプリセットです。\nテーマモードをライトに設定し、そのテーマを更新します。\n\n続行しますか？';

  @override
  String ssApplied(Object config) {
    return '$config が適用されました。';
  }

  @override
  String get ssTryMe => 'お試し';

  @override
  String get ssRandom => 'ランダム化';

  @override
  String ssRandomize(Object themeType) {
    return '$themeTypeテーマをランダム化しますか？';
  }

  @override
  String get ssConfigTip => '設定の保存/読み込み';

  @override
  String get ssSaveConfig => '設定を保存';

  @override
  String ssConfigSaved(Object path) {
    return '設定が $path に保存されました';
  }

  @override
  String get ssWrongConfigExt => 'ファイルは次の形式で保存されませんでした: ';

  @override
  String get ssLoadConfig => '設定を読み込む';

  @override
  String get ssResetAll => 'すべての設定をリセットしますか？';

  @override
  String get ssResetAppearance => 'すべての外観設定をリセットしますか？';

  @override
  String get ssResetBoth => '両方のテーマモードをリセット';

  @override
  String get csPageTitle => 'カラー設定';

  @override
  String get csSchemeBase => '画像からスキーム\nを作成';

  @override
  String get csFromImage => '画像からカラースキームが生成されます。';

  @override
  String get csMonoChrome => 'モノクロスキームを使用';

  @override
  String get csHighContrast => 'ハイコントラストスキームを使用';

  @override
  String get csPrimary => 'プライマリ';

  @override
  String get csPrimaryContainer => 'プライマリ\nアウトライン';

  @override
  String get csSecondary => 'セカンダリ';

  @override
  String get csSecondaryContainer => 'セカンダリ\nアウトライン';

  @override
  String get csTertiary => 'ターシャリ';

  @override
  String get csTertiaryContainer => 'ターシャリ\nアウトライン';

  @override
  String get csError => 'エラー';

  @override
  String get csErrorContainer => 'エラー\nアウトライン';

  @override
  String get csOutline => 'ヒント\nテキスト';

  @override
  String get csOutlineVariant => 'ヒント\nアウトライン';

  @override
  String get csSurface => 'ボタン\n背景';

  @override
  String get csSurfaceDim => 'アラート && アプリバー\n背景';

  @override
  String get csSurfaceContainer => 'ページ && モーダル\n背景';

  @override
  String get csOnSurface => 'テキスト';

  @override
  String get csScrim => 'モーダル\nカバー';

  @override
  String get csShadow => 'シャドウ';

  @override
  String get csSurfaceTint => 'サーフェス\nティント';

  @override
  String get csPickerTitle => '色を選択';

  @override
  String get csPickerHint => 'カラーピッカーを開きます。長押しでその他のオプションを表示します。';

  @override
  String get csRecommended => '推奨コントラストを使用しますか？';

  @override
  String get csUseCustom => 'カスタムを使用';

  @override
  String get csCurrVal => '現在のカラー値:';

  @override
  String csReset(Object themeType) {
    return '$themeTypeカラーをリセットしますか？';
  }

  @override
  String get csColorScheme => 'カラースキーム';

  @override
  String get dsPageTitle => 'デザイン設定';

  @override
  String get dsButton => 'ボタン';

  @override
  String get dsPage => 'ページ';

  @override
  String get dsNone => 'なし';

  @override
  String get dsSystem => 'システム';

  @override
  String get dsPadding => 'パディング';

  @override
  String get dsStyle => 'スタイル';

  @override
  String get dsBorderWidth => 'ボーダー幅';

  @override
  String get dsPill => 'ピル';

  @override
  String get dsRectangle => '長方形';

  @override
  String get dsRoundRectangle => '角丸長方形';

  @override
  String get dsLeftGram => '左平行四辺形';

  @override
  String get dsRightGram => '右平行四辺形';

  @override
  String get dsGem => '宝石';

  @override
  String get dsJewel => 'ジュエル';

  @override
  String get dsAlwaysUnderline => 'リンクに常に下線を引く';

  @override
  String get dsShowBack => '戻るボタンを表示';

  @override
  String get dsMargin => 'マージン';

  @override
  String get dsSpacing => '間隔';

  @override
  String get dsPageTransition => 'ページ遷移';

  @override
  String get dsTurnX => '水平回転';

  @override
  String get dsTurnY => '垂直回転';

  @override
  String get dsRotate => '回転';

  @override
  String get dsSlideX => '水平スライド';

  @override
  String get dsSlideY => '垂直スライド';

  @override
  String get dsZoom => 'ズーム';

  @override
  String get dsFadeTransition => 'フェード遷移';

  @override
  String get dsAnimStyle => 'アニメーションスタイル';

  @override
  String get dsPlay => 'アニメーションを再生';

  @override
  String get dsMilliseconds => 'ミリ秒';

  @override
  String get dsCurve => 'カーブ';

  @override
  String get dsBounce => 'バウンス';

  @override
  String get dsEase => 'イーズ';

  @override
  String get dsElastic => 'エラスティック';

  @override
  String get dsLinear => 'リニア';

  @override
  String get dsBackgroundImg => '背景画像';

  @override
  String dsImgSettingHint(Object title) {
    return '$title 画像を更新';
  }

  @override
  String get dsReFit => 'リフィット';

  @override
  String get dsFromFile => 'ファイルから';

  @override
  String get dsFromCamera => 'カメラから';

  @override
  String get dsFromNetwork => 'URLから';

  @override
  String get dsSolidColor => '単色';

  @override
  String get dsResetIt => 'リセットする';

  @override
  String get dsClearIt => 'クリアする';

  @override
  String get dsUseForColors => 'この画像を使用してアプリのカラーを更新する';

  @override
  String get dsImgGetFailed => '画像の取得に失敗しました';

  @override
  String get dsImgSetFailed => '画像の更新に失敗しました';

  @override
  String get dsImgPermission =>
      '一部のサイトでは、他者による画像へのアクセスが許可されていません。\n別のホストの画像を試してください。';

  @override
  String get dsUseFull => '画像全体を使用しますか？';

  @override
  String get dsFit => 'どのようにフィットさせますか？';

  @override
  String get dsCrop => '切り抜き';

  @override
  String get dsNoWeb => 'Webでは画像編集はサポートされていません';

  @override
  String get dsRotateLeft => '左に回転';

  @override
  String get dsRotateRight => '右に回転';

  @override
  String get dsShowScroll => 'スクロールバーを表示';

  @override
  String dsResetButton(Object themeType) {
    return '$themeTypeボタンのデザインをリセットしますか？';
  }

  @override
  String dsResetPage(Object themeType) {
    return '$themeTypeページのデザインをリセットしますか？';
  }

  @override
  String get tsPageTitle => 'テキスト設定';

  @override
  String tsBatchOverride(Object setting) {
    return 'すでに詳細設定で細かな「$setting」の変更が行われています。\n\nそれらの変更を上書きして一括更新を適用してもよろしいですか？';
  }

  @override
  String get tsTextBackground => 'テキスト背景の不透明度';

  @override
  String get tsIconSize => 'アイコンサイズ';

  @override
  String tsLinkHint(Object style) {
    return 'アクティブにして $style を編集';
  }

  @override
  String get tsDisplay => 'ディスプレイ';

  @override
  String get tsHeadline => '見出し';

  @override
  String get tsTitle => 'タイトル';

  @override
  String get tsBody => '本文';

  @override
  String get tsLabel => 'ラベル';

  @override
  String get tsFontFamily => 'フォントファミリー';

  @override
  String get tsFontSize => 'フォントサイズ';

  @override
  String get tsBold => '太字';

  @override
  String get tsItalic => '斜体';

  @override
  String get tsUnderline => '下線';

  @override
  String get tsLetterSpacing => '文字間隔';

  @override
  String get tsWordSpacing => '単語間隔';

  @override
  String get tsLineHeight => '行の高さ';

  @override
  String get tsDisplayP1 => 'この';

  @override
  String get tsDisplayLink => 'ディスプレイ';

  @override
  String get tsDisplayP2 => 'は見やすいですか？';

  @override
  String get tsHeadlineP1 => 'これらの';

  @override
  String get tsHeadlineLink => '見出し';

  @override
  String get tsHeadlineP2 => 'は...';

  @override
  String get tsTitleP1 => '次の';

  @override
  String get tsTitleLink => 'タイトルと区別できますか？';

  @override
  String get tsBodyP1 => 'では、';

  @override
  String get tsBodyLink => '本文';

  @override
  String get tsBodyP2 => 'はどうですか？ 読みやすいですか？';

  @override
  String get tsLabelP1 => 'そして';

  @override
  String get tsLabelLink => 'ラベル';

  @override
  String get tsLabelP2 => 'についてはどうでしょう？ 大きすぎず、小さすぎませんか？';

  @override
  String tsReset(Object themeType) {
    return '$themeTypeテキストのスタイルをリセットしますか？';
  }
}
