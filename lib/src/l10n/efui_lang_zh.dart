// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class EFUILangZh extends EFUILang {
  EFUILangZh([String locale = 'zh']) : super(locale);

  @override
  String get gApply => '应用';

  @override
  String get gApplyChanges => '应用更改';

  @override
  String get gContinue => '继续';

  @override
  String get gOpen => '打开';

  @override
  String get gOpenLink => '打开链接';

  @override
  String get gSkip => '跳过';

  @override
  String get gSuccess => '成功';

  @override
  String get gSuccessExl => '成功！';

  @override
  String get gYes => '是';

  @override
  String get gAnd => '和';

  @override
  String get gHelp => '帮助';

  @override
  String get gNA => '不适用';

  @override
  String get gNAHint => '不适用';

  @override
  String get gOptional => '可选';

  @override
  String get gOptions => '选项';

  @override
  String get gRequired => '必填';

  @override
  String get gThe => '该';

  @override
  String get gBack => '返回';

  @override
  String get gCancel => '取消';

  @override
  String get gClose => '关闭';

  @override
  String get gDisabled => '已禁用';

  @override
  String get gError => '错误';

  @override
  String get gFailure => '失败';

  @override
  String get gNo => '否';

  @override
  String get gRedo => '重做';

  @override
  String get gUndo => '撤销';

  @override
  String get gSettings => '设置';

  @override
  String get gGlobal => '全局';

  @override
  String get gColor => '颜色';

  @override
  String get gDesign => '设计';

  @override
  String get gLayout => '布局';

  @override
  String get gText => '文本';

  @override
  String get gDark => '深色';

  @override
  String get gLight => '浅色';

  @override
  String get gSystem => '系统';

  @override
  String get gEditing => '正在编辑： ';

  @override
  String get gEditingHint => '激活以编辑';

  @override
  String get gDarkTheme => '深色主题';

  @override
  String get gLightTheme => '浅色主题';

  @override
  String get gBothThemes => '双主题';

  @override
  String get gLeft => '左';

  @override
  String get gRight => '右';

  @override
  String get gAdvanced => '高级';

  @override
  String get gQuick => '快速';

  @override
  String get gDecrease => '减少';

  @override
  String get gIncrease => '增加';

  @override
  String get gMaximum => '最大值';

  @override
  String get gMinimum => '最小值';

  @override
  String get gCenterReset => '长按中间重置';

  @override
  String get gLoadingAnim => '加载中。Empathetic 标志像旋转的沙漏一样具有动画效果。';

  @override
  String get gPlay => '播放';

  @override
  String get gPause => '暂停';

  @override
  String get gReplay => '重播';

  @override
  String get gMute => '静音';

  @override
  String get gUnMute => '取消静音';

  @override
  String get gPlaybackSpeed => '播放速度';

  @override
  String get gCaptions => '字幕/说明';

  @override
  String get gCaptionsHint => '长按选择字体';

  @override
  String get gFullScreen => '全屏';

  @override
  String get gMachineTranslated => '机器翻译';

  @override
  String get gUpdates => '有可用更新';

  @override
  String get gHardRefresh => '请硬刷新页面...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac => '请硬刷新页面...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile => '请在浏览器菜单中刷新页面。';

  @override
  String get gEnterURL => '输入 URL';

  @override
  String get gValidURL => '请输入有效的 URL';

  @override
  String get g404Wonder => '漫游者未必都迷路。';

  @override
  String get g404 => '但是，在这种情况下：404 找不到页面。';

  @override
  String get g404Note =>
      '注意：Flutter web 使用哈希路由，例如...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => '开源';

  @override
  String get gOpenEmpathetech => '打开 Empathetic LLC 的链接';

  @override
  String get gEFUISourceHint => '打开 EFUI 的 GitHub 页面';

  @override
  String get gOpenUIReleases => '打开 Open UI 的发布页面';

  @override
  String get gGiveFeedback => '提供反馈';

  @override
  String get gOpeningFeedback => '正在打开反馈工具。';

  @override
  String get gAttachScreenshot => '请附上您的截图（在下载文件夹中）';

  @override
  String get gSupportEmail => '我们的支持电子邮件';

  @override
  String gClipboard(Object thing) {
    return '$thing 已复制到剪贴板。';
  }

  @override
  String get gAttention => '注意';

  @override
  String get gCurrently => '当前：';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name 已设置为 $value';
  }

  @override
  String get gRemove => '移除';

  @override
  String get gReset => '重置';

  @override
  String get gResetTo => '重置为：';

  @override
  String gResetValue(Object name) {
    return '重置 $name？';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return '将 $name 重置为 $value';
  }

  @override
  String get gResetAll => '全部重置';

  @override
  String get gUndoWarn1 => '无法自动撤销。\n';

  @override
  String get gSave => '保存';

  @override
  String get gSaveHint => '激活以保存 JSON 配置文件。';

  @override
  String get gSwitchHint => '拨动开关';

  @override
  String get gUndoWarn2 => ' 您的当前配置以进行手动恢复。';

  @override
  String get gValue => '值';

  @override
  String get gSource => '来源：';

  @override
  String get gCreator => '创作者：';

  @override
  String get gMadeBy => '制作人';

  @override
  String get gYou => '由您设置';

  @override
  String get ssNavHint => '打开设置页面';

  @override
  String get ssRestartReminder => '关闭并重新打开应用程序以应用您的更改。';

  @override
  String get ssRestartReminderWeb => '重新加载/刷新页面以应用您的更改。';

  @override
  String get ssHaveFun => '玩得开心！';

  @override
  String get ssDominantHand => '惯用手';

  @override
  String get ssThemeMode => '主题模式';

  @override
  String get ssLanguage => '语言';

  @override
  String get ssLangHint => '激活以更改应用语言';

  @override
  String get ssUpdateDark => '更新深色主题';

  @override
  String get ssUpdateLight => '更新浅色主题';

  @override
  String get ssUpdateBoth => '更新两种主题模式';

  @override
  String get ssLoadPreset => '加载预设';

  @override
  String get ssLoadPresetHint => '激活以显示预设';

  @override
  String get ssDewIt => '更新两者/自动确认';

  @override
  String get ssBigButtons => '大按钮';

  @override
  String get ssHighVisibility => '高可见度';

  @override
  String get ssChalkboard => '黑板';

  @override
  String get ssNebula => '星云';

  @override
  String get ssWallHoles => '墙洞';

  @override
  String get ssDarkOnly => '这是一个深色主题预设。\n它将把主题模式设置为深色，并更新该主题。\n\n是否继续？';

  @override
  String get ssLightOnly => '这是一个浅色主题预设。\n它将把主题模式设置为浅色，并更新该主题。\n\n是否继续？';

  @override
  String ssApplied(Object config) {
    return '$config 已应用。';
  }

  @override
  String get ssTryMe => '试试看';

  @override
  String get ssRandom => '随机化';

  @override
  String ssRandomize(Object themeType) {
    return '随机化 $themeType 主题？';
  }

  @override
  String get ssConfigTip => '保存/加载配置';

  @override
  String get ssSaveConfig => '保存配置';

  @override
  String ssConfigSaved(Object path) {
    return '您的配置已保存到 $path';
  }

  @override
  String get ssWrongConfigExt => '文件未保存为 ';

  @override
  String get ssLoadConfig => '加载配置';

  @override
  String get ssResetAll => '重置所有设置？';

  @override
  String get ssResetAppearance => '重置所有外观设置？';

  @override
  String get ssResetBoth => '重置两种主题模式';

  @override
  String get csPageTitle => '颜色设置';

  @override
  String get csSchemeBase => '从图像\n构建方案';

  @override
  String get csFromImage => '配色方案将从图像中生成。';

  @override
  String get csMonoChrome => '使用单色方案';

  @override
  String get csHighContrast => '使用高对比度方案';

  @override
  String get csPrimary => '主要';

  @override
  String get csPrimaryContainer => '主要\n轮廓';

  @override
  String get csSecondary => '次要';

  @override
  String get csSecondaryContainer => '次要\n轮廓';

  @override
  String get csTertiary => '第三';

  @override
  String get csTertiaryContainer => '第三\n轮廓';

  @override
  String get csError => '错误';

  @override
  String get csErrorContainer => '错误\n轮廓';

  @override
  String get csOutline => '提示\n文本';

  @override
  String get csOutlineVariant => '提示\n轮廓';

  @override
  String get csSurface => '按钮\n背景';

  @override
  String get csSurfaceDim => '警告 && 应用栏\n背景';

  @override
  String get csSurfaceContainer => '页面 && 模态框\n背景';

  @override
  String get csOnSurface => '文本';

  @override
  String get csScrim => '模态框\n覆盖层';

  @override
  String get csShadow => '阴影';

  @override
  String get csSurfaceTint => '表面\n色调';

  @override
  String get csPickerTitle => '选择颜色';

  @override
  String get csPickerHint => '打开颜色选择器。长按获取更多选项。';

  @override
  String get csRecommended => '使用对比度建议？';

  @override
  String get csUseCustom => '使用自定义';

  @override
  String get csCurrVal => '当前颜色值：';

  @override
  String csReset(Object themeType) {
    return '重置 $themeType 颜色？';
  }

  @override
  String get csColorScheme => '配色方案';

  @override
  String get dsPageTitle => '设计设置';

  @override
  String get dsButton => '按钮';

  @override
  String get dsPage => '页面';

  @override
  String get dsNone => '无';

  @override
  String get dsSystem => '系统';

  @override
  String get dsPadding => '内边距';

  @override
  String get dsStyle => '样式';

  @override
  String get dsBorderWidth => '边框宽度';

  @override
  String get dsPill => '药丸';

  @override
  String get dsRectangle => '矩形';

  @override
  String get dsRoundRectangle => '圆角矩形';

  @override
  String get dsLeftGram => '左平行四边形';

  @override
  String get dsRightGram => '右平行四边形';

  @override
  String get dsGem => '宝石';

  @override
  String get dsJewel => '珠宝';

  @override
  String get dsPreview => '预览';

  @override
  String get dsOpacity => '不透明度';

  @override
  String get dsBackground => '背景不透明度';

  @override
  String get dsOutline => '轮廓不透明度';

  @override
  String get dsAlwaysUnderline => '始终为链接加下划线';

  @override
  String get dsShowBack => '显示返回按钮';

  @override
  String get dsMargin => '外边距';

  @override
  String get dsSpacing => '间距';

  @override
  String get dsPageTransition => '页面过渡';

  @override
  String get dsTurnX => '水平翻转';

  @override
  String get dsTurnY => '垂直翻转';

  @override
  String get dsRotate => '旋转';

  @override
  String get dsSlideX => '水平滑动';

  @override
  String get dsSlideY => '垂直滑动';

  @override
  String get dsZoom => '缩放';

  @override
  String get dsFadeTransition => '淡入淡出过渡';

  @override
  String get dsAnimStyle => '动画样式';

  @override
  String get dsPlay => '播放动画';

  @override
  String get dsMilliseconds => '毫秒';

  @override
  String get dsCurve => '曲线';

  @override
  String get dsBounce => '弹跳';

  @override
  String get dsEase => '缓动';

  @override
  String get dsElastic => '弹性';

  @override
  String get dsLinear => '线性';

  @override
  String get dsBackgroundImg => '背景图片';

  @override
  String dsImgSettingHint(Object title) {
    return '更新 $title 图像';
  }

  @override
  String get dsReFit => '重新调整适应';

  @override
  String get dsFromFile => '来自文件';

  @override
  String get dsFromCamera => '来自相机';

  @override
  String get dsFromNetwork => '来自 URL';

  @override
  String get dsSolidColor => '纯色';

  @override
  String get dsResetIt => '重置它';

  @override
  String get dsClearIt => '清除它';

  @override
  String get dsUseForColors => '使用此图像更新应用颜色';

  @override
  String get dsImgGetFailed => '无法获取图像';

  @override
  String get dsImgSetFailed => '无法更新图像';

  @override
  String get dsImgPermission => '某些网站不允许其他人访问其图像。\n请尝试使用其他主机的图像。';

  @override
  String get dsUseFull => '使用完整图像？';

  @override
  String get dsFit => '应如何适应？';

  @override
  String get dsCrop => '裁剪';

  @override
  String get dsNoWeb => '网页版不支持图像编辑';

  @override
  String get dsRotateLeft => '向左旋转';

  @override
  String get dsRotateRight => '向右旋转';

  @override
  String get dsShowScroll => '显示滚动条';

  @override
  String dsResetButton(Object themeType) {
    return '重置 $themeType 按钮设计？';
  }

  @override
  String dsResetPage(Object themeType) {
    return '重置 $themeType 页面设计？';
  }

  @override
  String get tsPageTitle => '文本设置';

  @override
  String tsBatchOverride(Object setting) {
    return '您已在高级设置中进行了粒度级 \"$setting\" 更改。\n\n您确定要使用批量更新覆盖这些更改吗？';
  }

  @override
  String get tsTextBackground => '文本背景不透明度';

  @override
  String get tsIconSize => '图标大小';

  @override
  String tsLinkHint(Object style) {
    return '激活以编辑 $style';
  }

  @override
  String get tsDisplay => '显示';

  @override
  String get tsHeadline => '大标题';

  @override
  String get tsTitle => '标题';

  @override
  String get tsBody => '正文';

  @override
  String get tsLabel => '标签';

  @override
  String get tsFontFamily => '字体系列';

  @override
  String get tsFontSize => '字体大小';

  @override
  String get tsBold => '粗体';

  @override
  String get tsItalic => '斜体';

  @override
  String get tsUnderline => '下划线';

  @override
  String get tsLetterSpacing => '字母间距';

  @override
  String get tsWordSpacing => '单词间距';

  @override
  String get tsLineHeight => '行高';

  @override
  String get tsDisplayP1 => '这个';

  @override
  String get tsDisplayLink => '显示文本';

  @override
  String get tsDisplayP2 => ' 好看吗？';

  @override
  String get tsHeadlineP1 => '这些';

  @override
  String get tsHeadlineLink => '大标题';

  @override
  String get tsHeadlineP2 => ' 与...';

  @override
  String get tsTitleP1 => '';

  @override
  String get tsTitleLink => '标题区隔明显吗？';

  @override
  String get tsBodyP1 => '那';

  @override
  String get tsBodyLink => '正文';

  @override
  String get tsBodyP2 => ' 呢？容易阅读吗？';

  @override
  String get tsLabelP1 => '还有';

  @override
  String get tsLabelLink => '标签';

  @override
  String get tsLabelP2 => ' 呢？大小合适吗？';

  @override
  String tsReset(Object themeType) {
    return '重置 $themeType 文本样式？';
  }
}

/// The translations for Chinese, as used in China (`zh_CN`).
class EFUILangZhCn extends EFUILangZh {
  EFUILangZhCn() : super('zh_CN');

  @override
  String get gApply => '应用';

  @override
  String get gApplyChanges => '应用更改';

  @override
  String get gContinue => '继续';

  @override
  String get gOpen => '打开';

  @override
  String get gOpenLink => '打开链接';

  @override
  String get gSkip => '跳过';

  @override
  String get gSuccess => '成功';

  @override
  String get gSuccessExl => '成功！';

  @override
  String get gYes => '是';

  @override
  String get gAnd => '和';

  @override
  String get gHelp => '帮助';

  @override
  String get gNA => '不适用';

  @override
  String get gNAHint => '不适用';

  @override
  String get gOptional => '可选';

  @override
  String get gOptions => '选项';

  @override
  String get gRequired => '必填';

  @override
  String get gThe => '该';

  @override
  String get gBack => '返回';

  @override
  String get gCancel => '取消';

  @override
  String get gClose => '关闭';

  @override
  String get gDisabled => '已禁用';

  @override
  String get gError => '错误';

  @override
  String get gFailure => '失败';

  @override
  String get gNo => '否';

  @override
  String get gRedo => '重做';

  @override
  String get gUndo => '撤销';

  @override
  String get gSettings => '设置';

  @override
  String get gGlobal => '全局';

  @override
  String get gColor => '颜色';

  @override
  String get gDesign => '设计';

  @override
  String get gLayout => '布局';

  @override
  String get gText => '文本';

  @override
  String get gDark => '深色';

  @override
  String get gLight => '浅色';

  @override
  String get gSystem => '系统';

  @override
  String get gEditing => '正在编辑： ';

  @override
  String get gEditingHint => '激活以编辑';

  @override
  String get gDarkTheme => '深色主题';

  @override
  String get gLightTheme => '浅色主题';

  @override
  String get gBothThemes => '双主题';

  @override
  String get gLeft => '左';

  @override
  String get gRight => '右';

  @override
  String get gAdvanced => '高级';

  @override
  String get gQuick => '快速';

  @override
  String get gDecrease => '减少';

  @override
  String get gIncrease => '增加';

  @override
  String get gMaximum => '最大值';

  @override
  String get gMinimum => '最小值';

  @override
  String get gCenterReset => '长按中间重置';

  @override
  String get gLoadingAnim => '加载中。Empathetic 标志像旋转的沙漏一样具有动画效果。';

  @override
  String get gPlay => '播放';

  @override
  String get gPause => '暂停';

  @override
  String get gReplay => '重播';

  @override
  String get gMute => '静音';

  @override
  String get gUnMute => '取消静音';

  @override
  String get gPlaybackSpeed => '播放速度';

  @override
  String get gCaptions => '字幕/说明';

  @override
  String get gCaptionsHint => '长按选择字体';

  @override
  String get gFullScreen => '全屏';

  @override
  String get gMachineTranslated => '机器翻译';

  @override
  String get gUpdates => '有可用更新';

  @override
  String get gHardRefresh => '请硬刷新页面...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac => '请硬刷新页面...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile => '请在浏览器菜单中刷新页面。';

  @override
  String get gEnterURL => '输入 URL';

  @override
  String get gValidURL => '请输入有效的 URL';

  @override
  String get g404Wonder => '漫游者未必都迷路。';

  @override
  String get g404 => '但是，在这种情况下：404 找不到页面。';

  @override
  String get g404Note =>
      '注意：Flutter web 使用哈希路由，例如...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => '开源';

  @override
  String get gOpenEmpathetech => '打开 Empathetic LLC 的链接';

  @override
  String get gEFUISourceHint => '打开 EFUI 的 GitHub 页面';

  @override
  String get gOpenUIReleases => '打开 Open UI 的发布页面';

  @override
  String get gGiveFeedback => '提供反馈';

  @override
  String get gOpeningFeedback => '正在打开反馈工具。';

  @override
  String get gAttachScreenshot => '请附上您的截图（在下载文件夹中）';

  @override
  String get gSupportEmail => '我们的支持电子邮件';

  @override
  String gClipboard(Object thing) {
    return '$thing 已复制到剪贴板。';
  }

  @override
  String get gAttention => '注意';

  @override
  String get gCurrently => '当前：';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name 已设置为 $value';
  }

  @override
  String get gRemove => '移除';

  @override
  String get gReset => '重置';

  @override
  String get gResetTo => '重置为：';

  @override
  String gResetValue(Object name) {
    return '重置 $name？';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return '将 $name 重置为 $value';
  }

  @override
  String get gResetAll => '全部重置';

  @override
  String get gUndoWarn1 => '无法自动撤销。\n';

  @override
  String get gSave => '保存';

  @override
  String get gSaveHint => '激活以保存 JSON 配置文件。';

  @override
  String get gSwitchHint => '拨动开关';

  @override
  String get gUndoWarn2 => ' 您的当前配置以进行手动恢复。';

  @override
  String get gValue => '值';

  @override
  String get gSource => '来源：';

  @override
  String get gCreator => '创作者：';

  @override
  String get gMadeBy => '制作人';

  @override
  String get gYou => '由您设置';

  @override
  String get ssNavHint => '打开设置页面';

  @override
  String get ssRestartReminder => '关闭并重新打开应用程序以应用您的更改。';

  @override
  String get ssRestartReminderWeb => '重新加载/刷新页面以应用您的更改。';

  @override
  String get ssHaveFun => '玩得开心！';

  @override
  String get ssDominantHand => '惯用手';

  @override
  String get ssThemeMode => '主题模式';

  @override
  String get ssLanguage => '语言';

  @override
  String get ssLangHint => '激活以更改应用语言';

  @override
  String get ssUpdateDark => '更新深色主题';

  @override
  String get ssUpdateLight => '更新浅色主题';

  @override
  String get ssUpdateBoth => '更新两种主题模式';

  @override
  String get ssLoadPreset => '加载预设';

  @override
  String get ssLoadPresetHint => '激活以显示预设';

  @override
  String get ssDewIt => '更新两者/自动确认';

  @override
  String get ssBigButtons => '大按钮';

  @override
  String get ssHighVisibility => '高可见度';

  @override
  String get ssChalkboard => '黑板';

  @override
  String get ssNebula => '星云';

  @override
  String get ssWallHoles => '墙洞';

  @override
  String get ssDarkOnly => '这是一个深色主题预设。\n它将把主题模式设置为深色，并更新该主题。\n\n是否继续？';

  @override
  String get ssLightOnly => '这是一个浅色主题预设。\n它将把主题模式设置为浅色，并更新该主题。\n\n是否继续？';

  @override
  String ssApplied(Object config) {
    return '$config 已应用。';
  }

  @override
  String get ssTryMe => '试试看';

  @override
  String get ssRandom => '随机化';

  @override
  String ssRandomize(Object themeType) {
    return '随机化 $themeType 主题？';
  }

  @override
  String get ssConfigTip => '保存/加载配置';

  @override
  String get ssSaveConfig => '保存配置';

  @override
  String ssConfigSaved(Object path) {
    return '您的配置已保存到 $path';
  }

  @override
  String get ssWrongConfigExt => '文件未保存为 ';

  @override
  String get ssLoadConfig => '加载配置';

  @override
  String get ssResetAll => '重置所有设置？';

  @override
  String get ssResetAppearance => '重置所有外观设置？';

  @override
  String get ssResetBoth => '重置两种主题模式';

  @override
  String get csPageTitle => '颜色设置';

  @override
  String get csSchemeBase => '从图像\n构建方案';

  @override
  String get csFromImage => '配色方案将从图像中生成。';

  @override
  String get csMonoChrome => '使用单色方案';

  @override
  String get csHighContrast => '使用高对比度方案';

  @override
  String get csPrimary => '主要';

  @override
  String get csPrimaryContainer => '主要\n轮廓';

  @override
  String get csSecondary => '次要';

  @override
  String get csSecondaryContainer => '次要\n轮廓';

  @override
  String get csTertiary => '第三';

  @override
  String get csTertiaryContainer => '第三\n轮廓';

  @override
  String get csError => '错误';

  @override
  String get csErrorContainer => '错误\n轮廓';

  @override
  String get csOutline => '提示\n文本';

  @override
  String get csOutlineVariant => '提示\n轮廓';

  @override
  String get csSurface => '按钮\n背景';

  @override
  String get csSurfaceDim => '警告 && 应用栏\n背景';

  @override
  String get csSurfaceContainer => '页面 && 模态框\n背景';

  @override
  String get csOnSurface => '文本';

  @override
  String get csScrim => '模态框\n覆盖层';

  @override
  String get csShadow => '阴影';

  @override
  String get csSurfaceTint => '表面\n色调';

  @override
  String get csPickerTitle => '选择颜色';

  @override
  String get csPickerHint => '打开颜色选择器。长按获取更多选项。';

  @override
  String get csRecommended => '使用对比度建议？';

  @override
  String get csUseCustom => '使用自定义';

  @override
  String get csCurrVal => '当前颜色值：';

  @override
  String csReset(Object themeType) {
    return '重置 $themeType 颜色？';
  }

  @override
  String get csColorScheme => '配色方案';

  @override
  String get dsPageTitle => '设计设置';

  @override
  String get dsButton => '按钮';

  @override
  String get dsPage => '页面';

  @override
  String get dsNone => '无';

  @override
  String get dsSystem => '系统';

  @override
  String get dsPadding => '内边距';

  @override
  String get dsStyle => '样式';

  @override
  String get dsBorderWidth => '边框宽度';

  @override
  String get dsPill => '药丸';

  @override
  String get dsRectangle => '矩形';

  @override
  String get dsRoundRectangle => '圆角矩形';

  @override
  String get dsLeftGram => '左平行四边形';

  @override
  String get dsRightGram => '右平行四边形';

  @override
  String get dsGem => '宝石';

  @override
  String get dsJewel => '珠宝';

  @override
  String get dsPreview => '预览';

  @override
  String get dsOpacity => '不透明度';

  @override
  String get dsBackground => '背景不透明度';

  @override
  String get dsOutline => '轮廓不透明度';

  @override
  String get dsAlwaysUnderline => '始终为链接加下划线';

  @override
  String get dsShowBack => '显示返回按钮';

  @override
  String get dsMargin => '外边距';

  @override
  String get dsSpacing => '间距';

  @override
  String get dsPageTransition => '页面过渡';

  @override
  String get dsTurnX => '水平翻转';

  @override
  String get dsTurnY => '垂直翻转';

  @override
  String get dsRotate => '旋转';

  @override
  String get dsSlideX => '水平滑动';

  @override
  String get dsSlideY => '垂直滑动';

  @override
  String get dsZoom => '缩放';

  @override
  String get dsFadeTransition => '淡入淡出过渡';

  @override
  String get dsAnimStyle => '动画样式';

  @override
  String get dsPlay => '播放动画';

  @override
  String get dsMilliseconds => '毫秒';

  @override
  String get dsCurve => '曲线';

  @override
  String get dsBounce => '弹跳';

  @override
  String get dsEase => '缓动';

  @override
  String get dsElastic => '弹性';

  @override
  String get dsLinear => '线性';

  @override
  String get dsBackgroundImg => '背景图片';

  @override
  String dsImgSettingHint(Object title) {
    return '更新 $title 图像';
  }

  @override
  String get dsReFit => '重新调整适应';

  @override
  String get dsFromFile => '来自文件';

  @override
  String get dsFromCamera => '来自相机';

  @override
  String get dsFromNetwork => '来自 URL';

  @override
  String get dsSolidColor => '纯色';

  @override
  String get dsResetIt => '重置它';

  @override
  String get dsClearIt => '清除它';

  @override
  String get dsUseForColors => '使用此图像更新应用颜色';

  @override
  String get dsImgGetFailed => '无法获取图像';

  @override
  String get dsImgSetFailed => '无法更新图像';

  @override
  String get dsImgPermission => '某些网站不允许其他人访问其图像。\n请尝试使用其他主机的图像。';

  @override
  String get dsUseFull => '使用完整图像？';

  @override
  String get dsFit => '应如何适应？';

  @override
  String get dsCrop => '裁剪';

  @override
  String get dsNoWeb => '网页版不支持图像编辑';

  @override
  String get dsRotateLeft => '向左旋转';

  @override
  String get dsRotateRight => '向右旋转';

  @override
  String get dsShowScroll => '显示滚动条';

  @override
  String dsResetButton(Object themeType) {
    return '重置 $themeType 按钮设计？';
  }

  @override
  String dsResetPage(Object themeType) {
    return '重置 $themeType 页面设计？';
  }

  @override
  String get tsPageTitle => '文本设置';

  @override
  String tsBatchOverride(Object setting) {
    return '您已在高级设置中进行了粒度级 \"$setting\" 更改。\n\n您确定要使用批量更新覆盖这些更改吗？';
  }

  @override
  String get tsTextBackground => '文本背景不透明度';

  @override
  String get tsIconSize => '图标大小';

  @override
  String tsLinkHint(Object style) {
    return '激活以编辑 $style';
  }

  @override
  String get tsDisplay => '显示';

  @override
  String get tsHeadline => '大标题';

  @override
  String get tsTitle => '标题';

  @override
  String get tsBody => '正文';

  @override
  String get tsLabel => '标签';

  @override
  String get tsFontFamily => '字体系列';

  @override
  String get tsFontSize => '字体大小';

  @override
  String get tsBold => '粗体';

  @override
  String get tsItalic => '斜体';

  @override
  String get tsUnderline => '下划线';

  @override
  String get tsLetterSpacing => '字母间距';

  @override
  String get tsWordSpacing => '单词间距';

  @override
  String get tsLineHeight => '行高';

  @override
  String get tsDisplayP1 => '这个';

  @override
  String get tsDisplayLink => '显示文本';

  @override
  String get tsDisplayP2 => ' 好看吗？';

  @override
  String get tsHeadlineP1 => '这些';

  @override
  String get tsHeadlineLink => '大标题';

  @override
  String get tsHeadlineP2 => ' 与...';

  @override
  String get tsTitleP1 => '';

  @override
  String get tsTitleLink => '标题区隔明显吗？';

  @override
  String get tsBodyP1 => '那';

  @override
  String get tsBodyLink => '正文';

  @override
  String get tsBodyP2 => ' 呢？容易阅读吗？';

  @override
  String get tsLabelP1 => '还有';

  @override
  String get tsLabelLink => '标签';

  @override
  String get tsLabelP2 => ' 呢？大小合适吗？';

  @override
  String tsReset(Object themeType) {
    return '重置 $themeType 文本样式？';
  }
}
