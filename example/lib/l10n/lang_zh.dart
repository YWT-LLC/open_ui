// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class LangZh extends Lang {
  LangZh([String locale = 'zh']) : super(locale);

  @override
  String get csPageTitle => '构建器';

  @override
  String get csAppName => '应用名称';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => '史上最佳应用';

  @override
  String get csBecomes => '变为';

  @override
  String get csInvalidName => '仅允许使用小写字母、数字和下划线。';

  @override
  String get csYourApp => '你的应用';

  @override
  String get csPubName => '发布者名称';

  @override
  String get csPubPreview => '示例组织';

  @override
  String get csPubTip => '或者，示例个人';

  @override
  String get csDescription => '描述';

  @override
  String get csDescPreview => '关于你的应用的一两句话。';

  @override
  String get csDomainName => '域名';

  @override
  String get csDomainTip => '反过来是';

  @override
  String get csInvalidDomain =>
      '仅限 \'domain.name\' 格式；RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String get csInclude => '包含';

  @override
  String get csEasy => '方便以后更改';

  @override
  String csGenApp(Object app_name) {
    return '当你生成 $app_name 时，当前的';
  }

  @override
  String get csTheApp => '应用';

  @override
  String get csTheConfig => '配置';

  @override
  String csSetColors(Object app_name) {
    return '（除图片外）将成为 $app_name 的默认配置。\n\n建议设置自定义配色方案。如果你需要帮助来构建配色方案，可以尝试从';
  }

  @override
  String get csHere => '这里开始。';

  @override
  String get csHereHint => '打开在线配色方案生成器';

  @override
  String get csFileBrowser => '打开文件浏览器';

  @override
  String get csFlutterPath => 'Flutter 路径';

  @override
  String get csNoSpaces => '路径不能包含空格';

  @override
  String get csNotInstalled => '未安装？';

  @override
  String get csPathRequired => '需要路径。不能使用根目录。';

  @override
  String get csBadPath => '无效路径';

  @override
  String get csAdvanced => '高级设置';

  @override
  String csRestore(Object setting) {
    return '恢复 $setting';
  }

  @override
  String get csOutputPath => '输出路径';

  @override
  String get csCopyright => '版权声明';

  @override
  String get csCopyrightTip => '将包含在每个 Dart 文件的顶部';

  @override
  String get csLicenseDocs => '打开关于开源许可证的文档';

  @override
  String get csL10nTip => '本地化（即翻译）配置';

  @override
  String get csLintTip => 'Lint 规则';

  @override
  String get csLaunchTip => '在 VS Code 的调试菜单中添加启动选项';

  @override
  String get csGenerate => '生成应用';

  @override
  String get csInvalidFields => '部分字段无效';

  @override
  String get csRequired => '所有字段均为必填项';

  @override
  String get csResetHint => '激活并确认要重置的内容。';

  @override
  String get csResetBuilder => '构建器值';

  @override
  String get csResetApp => '应用设置';

  @override
  String get csResetBoth => '全部';

  @override
  String get csResetNothing => '无';

  @override
  String get asPageTitle => '归档器';

  @override
  String get asUseIt => '\n\n在 ';

  @override
  String asToGen(Object app_name) {
    return ' 桌面版上使用它，为 $app_name 生成代码';
  }

  @override
  String get gsPageTitle => '生成器';

  @override
  String get gsConsole => '控制台输出';

  @override
  String get gsIsReadyIn => '已准备就绪，用时';

  @override
  String get gsFirstRun => '首次运行通常需要一些时间';

  @override
  String get gsNeedPermission =>
      'Open UI 需要完全磁盘访问权限。\n\n请前往...\n系统设置 > 隐私与安全性 > 完全磁盘访问权限 > 启用 Open UI；然后重试。';

  @override
  String get gsSeeNBelieve => '如果你想验证 Open UI 的工作原理，请前往';

  @override
  String get gsSeeNBelieveHint => '打开 Open UI 的代码生成源码。';

  @override
  String get gsNotInstalled => '未安装 Flutter';

  @override
  String get gsPartialSuccess => '代码生成成功，但部分项目设置失败。';

  @override
  String get rsWouldYou => '你想...';

  @override
  String get rsInstall => '安装';

  @override
  String get rsInstallHint => '打开 Flutter 安装指南';

  @override
  String get rsRun => '运行它';

  @override
  String get rsWipe => '清除它';

  @override
  String get rsNextTime => '成功，希望下次也能顺利！';

  @override
  String get rsAnotherOne => '又失败了；你可能需要接手处理...';

  @override
  String get rsLeave => '保留它';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class LangZhCn extends LangZh {
  LangZhCn() : super('zh_CN');

  @override
  String get csPageTitle => '构建器';

  @override
  String get csAppName => '应用名称';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => '史上最佳应用';

  @override
  String get csBecomes => '变为';

  @override
  String get csInvalidName => '仅允许使用小写字母、数字和下划线。';

  @override
  String get csYourApp => '你的应用';

  @override
  String get csPubName => '发布者名称';

  @override
  String get csPubPreview => '示例组织';

  @override
  String get csPubTip => '或者，示例个人';

  @override
  String get csDescription => '描述';

  @override
  String get csDescPreview => '关于你的应用的一两句话。';

  @override
  String get csDomainName => '域名';

  @override
  String get csDomainTip => '反过来是';

  @override
  String get csInvalidDomain =>
      '仅限 \'domain.name\' 格式；RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String get csInclude => '包含';

  @override
  String get csEasy => '方便以后更改';

  @override
  String csGenApp(Object app_name) {
    return '当你生成 $app_name 时，当前的';
  }

  @override
  String get csTheApp => '应用';

  @override
  String get csTheConfig => '配置';

  @override
  String csSetColors(Object app_name) {
    return '（除图片外）将成为 $app_name 的默认配置。\n\n建议设置自定义配色方案。如果你需要帮助来构建配色方案，可以尝试从';
  }

  @override
  String get csHere => '这里开始。';

  @override
  String get csHereHint => '打开在线配色方案生成器';

  @override
  String get csFileBrowser => '打开文件浏览器';

  @override
  String get csFlutterPath => 'Flutter 路径';

  @override
  String get csNoSpaces => '路径不能包含空格';

  @override
  String get csNotInstalled => '未安装？';

  @override
  String get csPathRequired => '需要路径。不能使用根目录。';

  @override
  String get csBadPath => '无效路径';

  @override
  String get csAdvanced => '高级设置';

  @override
  String csRestore(Object setting) {
    return '恢复 $setting';
  }

  @override
  String get csOutputPath => '输出路径';

  @override
  String get csCopyright => '版权声明';

  @override
  String get csCopyrightTip => '将包含在每个 Dart 文件的顶部';

  @override
  String get csLicenseDocs => '打开关于开源许可证的文档';

  @override
  String get csL10nTip => '本地化（即翻译）配置';

  @override
  String get csLintTip => 'Lint 规则';

  @override
  String get csLaunchTip => '在 VS Code 的调试菜单中添加启动选项';

  @override
  String get csGenerate => '生成应用';

  @override
  String get csInvalidFields => '部分字段无效';

  @override
  String get csRequired => '所有字段均为必填项';

  @override
  String get csResetHint => '激活并确认要重置的内容。';

  @override
  String get csResetBuilder => '构建器值';

  @override
  String get csResetApp => '应用设置';

  @override
  String get csResetBoth => '全部';

  @override
  String get csResetNothing => '无';

  @override
  String get asPageTitle => '归档器';

  @override
  String get asUseIt => '\n\n在 ';

  @override
  String asToGen(Object app_name) {
    return ' 桌面版上使用它，为 $app_name 生成代码';
  }

  @override
  String get gsPageTitle => '生成器';

  @override
  String get gsConsole => '控制台输出';

  @override
  String get gsIsReadyIn => '已准备就绪，用时';

  @override
  String get gsFirstRun => '首次运行通常需要一些时间';

  @override
  String get gsNeedPermission =>
      'Open UI 需要完全磁盘访问权限。\n\n请前往...\n系统设置 > 隐私与安全性 > 完全磁盘访问权限 > 启用 Open UI；然后重试。';

  @override
  String get gsSeeNBelieve => '如果你想验证 Open UI 的工作原理，请前往';

  @override
  String get gsSeeNBelieveHint => '打开 Open UI 的代码生成源码。';

  @override
  String get gsNotInstalled => '未安装 Flutter';

  @override
  String get gsPartialSuccess => '代码生成成功，但部分项目设置失败。';

  @override
  String get rsWouldYou => '你想...';

  @override
  String get rsInstall => '安装';

  @override
  String get rsInstallHint => '打开 Flutter 安装指南';

  @override
  String get rsRun => '运行它';

  @override
  String get rsWipe => '清除它';

  @override
  String get rsNextTime => '成功，希望下次也能顺利！';

  @override
  String get rsAnotherOne => '又失败了；你可能需要接手处理...';

  @override
  String get rsLeave => '保留它';
}
