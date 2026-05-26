// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class LangAr extends Lang {
  LangAr([String locale = 'ar']) : super(locale);

  @override
  String get csPageTitle => 'أداة البناء';

  @override
  String get csAppName => 'اسم التطبيق';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => 'أفضل تطبيق على الإطلاق';

  @override
  String get csBecomes => 'يصبح';

  @override
  String get csInvalidName =>
      'يُسمح بالأحرف الصغيرة والأرقام والشرطات السفلية فقط.';

  @override
  String get csYourApp => 'تطبيقك';

  @override
  String get csPubName => 'اسم الناشر';

  @override
  String get csPubPreview => 'مؤسسة تجريبية';

  @override
  String get csPubTip => 'أو، شخص كمثال';

  @override
  String get csDescription => 'الوصف';

  @override
  String get csDescPreview => 'جملة أو جملتان عن تطبيقك.';

  @override
  String get csDomainName => 'اسم النطاق';

  @override
  String get csDomainTip => 'بالعكس، يكون';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' فقط؛ RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String csGenApp(Object app_name) {
    return 'عندما تقوم بإنشاء $app_name، فإن ';
  }

  @override
  String get csTheApp => 'التطبيق الحالي';

  @override
  String get csTheConfig => 'الإعدادات الحالية';

  @override
  String csSetColors(Object app_name) {
    return ' (باستثناء الصور) ستصبح الإعدادات الافتراضية لـ $app_name.\n\nيُوصى بتعيين نظام ألوان مخصص. إذا كنت بحاجة إلى مساعدة في بناء واحد، حاول البدء ';
  }

  @override
  String get csHere => 'هنا.';

  @override
  String get csHereHint => 'فتح أداة بناء نظام ألوان عبر الإنترنت';

  @override
  String get csFileBrowser => 'فتح متصفح الملفات';

  @override
  String get csFlutterPath => 'مسار Flutter';

  @override
  String get csNoSpaces => 'لا يمكن أن يحتوي المسار على مسافات';

  @override
  String get csNotInstalled => 'غير مثبت؟';

  @override
  String get csPathRequired => 'المسار مطلوب. لا يمكن استخدام المجلد الجذري.';

  @override
  String get csBadPath => 'مسار غير صالح';

  @override
  String get csAdvanced => 'إعدادات متقدمة';

  @override
  String csRestore(Object setting) {
    return 'استعادة $setting';
  }

  @override
  String get csOutputPath => 'مسار المخرجات';

  @override
  String get csCopyright => 'إشعار حقوق الطبع والنشر';

  @override
  String get csCopyrightTip => 'سيتم تضمينه في أعلى كل ملف Dart';

  @override
  String get csLicenseDocs => 'فتح الوثائق الخاصة بتراخيص المصادر المفتوحة';

  @override
  String get csL10nTip => 'إعدادات الأقلمة (أي الترجمات)';

  @override
  String get csLintTip => 'قواعد Lint';

  @override
  String get csLaunchTip => 'يضيف خيارات التشغيل إلى قائمة التصحيح في VS Code';

  @override
  String get csGenerate => 'إنشاء التطبيق';

  @override
  String get csInvalidFields => 'بعض الحقول غير صالحة';

  @override
  String get csRequired => 'جميع الحقول مطلوبة';

  @override
  String get csResetHint => 'قم بالتفعيل والتأكيد على ما يجب إعادة ضبطه.';

  @override
  String get csResetBuilder => 'قيم أداة البناء';

  @override
  String get csResetApp => 'إعدادات التطبيق';

  @override
  String get csResetBoth => 'كلاهما';

  @override
  String get csResetNothing => 'لا شيء';

  @override
  String get asPageTitle => 'المؤرشف';

  @override
  String get asUseIt => '\n\nاستخدمه على ';

  @override
  String asToGen(Object app_name) {
    return ' لسطح المكتب لإنشاء الكود لـ $app_name';
  }

  @override
  String get gsPageTitle => 'المولد';

  @override
  String get gsConsole => 'مخرجات وحدة التحكم';

  @override
  String get gsIsReadyIn => 'جاهز في';

  @override
  String get gsNeedPermission =>
      'تحتاج Open UI إلى وصول كامل للقرص.\n\nيرجى الذهاب إلى...\nإعدادات النظام > الخصوصية والأمان > الوصول الكامل للقرص > تفعيل Open UI؛ ثم حاول مرة أخرى.';

  @override
  String get gsSeeNBelieve => 'إذا كنت تريد التحقق مما تفعله Open UI، اذهب ';

  @override
  String get gsSeeNBelieveHint => 'فتح كود إنشاء الأكواد الخاص بـ Open UI.';

  @override
  String get gsNotInstalled => 'Flutter غير مثبت';

  @override
  String get gsPartialSuccess =>
      'تم إنشاء الكود بنجاح، ولكن فشل إعداد بعض أجزاء المشروع.';

  @override
  String get rsWouldYou => 'هل ترغب في...';

  @override
  String get rsInstall => 'تثبيته';

  @override
  String get rsInstallHint => 'فتح دليل تثبيت Flutter';

  @override
  String get rsRun => 'تشغيله';

  @override
  String get rsWipe => 'مسحه';

  @override
  String get rsNextTime => 'نجاح، نتمنى التوفيق في المرة القادمة!';

  @override
  String get rsAnotherOne => 'فشل آخر؛ ربما يجب أن تتولى الأمر بنفسك...';

  @override
  String get rsLeave => 'تركه';
}

/// The translations for Arabic, as used in Egypt (`ar_EG`).
class LangArEg extends LangAr {
  LangArEg() : super('ar_EG');

  @override
  String get csPageTitle => 'أداة البناء';

  @override
  String get csAppName => 'اسم التطبيق';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => 'أفضل تطبيق على الإطلاق';

  @override
  String get csBecomes => 'يصبح';

  @override
  String get csInvalidName =>
      'يُسمح بالأحرف الصغيرة والأرقام والشرطات السفلية فقط.';

  @override
  String get csYourApp => 'تطبيقك';

  @override
  String get csPubName => 'اسم الناشر';

  @override
  String get csPubPreview => 'مؤسسة تجريبية';

  @override
  String get csPubTip => 'أو، شخص كمثال';

  @override
  String get csDescription => 'الوصف';

  @override
  String get csDescPreview => 'جملة أو جملتان عن تطبيقك.';

  @override
  String get csDomainName => 'اسم النطاق';

  @override
  String get csDomainTip => 'بالعكس، يكون';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' فقط؛ RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String csGenApp(Object app_name) {
    return 'عندما تقوم بإنشاء $app_name، فإن ';
  }

  @override
  String get csTheApp => 'التطبيق الحالي';

  @override
  String get csTheConfig => 'الإعدادات الحالية';

  @override
  String csSetColors(Object app_name) {
    return ' (باستثناء الصور) ستصبح الإعدادات الافتراضية لـ $app_name.\n\nيُوصى بتعيين نظام ألوان مخصص. إذا كنت بحاجة إلى مساعدة في بناء واحد، حاول البدء ';
  }

  @override
  String get csHere => 'هنا.';

  @override
  String get csHereHint => 'فتح أداة بناء نظام ألوان عبر الإنترنت';

  @override
  String get csFileBrowser => 'فتح متصفح الملفات';

  @override
  String get csFlutterPath => 'مسار Flutter';

  @override
  String get csNoSpaces => 'لا يمكن أن يحتوي المسار على مسافات';

  @override
  String get csNotInstalled => 'غير مثبت؟';

  @override
  String get csPathRequired => 'المسار مطلوب. لا يمكن استخدام المجلد الجذري.';

  @override
  String get csBadPath => 'مسار غير صالح';

  @override
  String get csAdvanced => 'إعدادات متقدمة';

  @override
  String csRestore(Object setting) {
    return 'استعادة $setting';
  }

  @override
  String get csOutputPath => 'مسار المخرجات';

  @override
  String get csCopyright => 'إشعار حقوق الطبع والنشر';

  @override
  String get csCopyrightTip => 'سيتم تضمينه في أعلى كل ملف Dart';

  @override
  String get csLicenseDocs => 'فتح الوثائق الخاصة بتراخيص المصادر المفتوحة';

  @override
  String get csL10nTip => 'إعدادات الأقلمة (أي الترجمات)';

  @override
  String get csLintTip => 'قواعد Lint';

  @override
  String get csLaunchTip => 'يضيف خيارات التشغيل إلى قائمة التصحيح في VS Code';

  @override
  String get csGenerate => 'إنشاء التطبيق';

  @override
  String get csInvalidFields => 'بعض الحقول غير صالحة';

  @override
  String get csRequired => 'جميع الحقول مطلوبة';

  @override
  String get csResetHint => 'قم بالتفعيل والتأكيد على ما يجب إعادة ضبطه.';

  @override
  String get csResetBuilder => 'قيم أداة البناء';

  @override
  String get csResetApp => 'إعدادات التطبيق';

  @override
  String get csResetBoth => 'كلاهما';

  @override
  String get csResetNothing => 'لا شيء';

  @override
  String get asPageTitle => 'المؤرشف';

  @override
  String get asUseIt => '\n\nاستخدمه على ';

  @override
  String asToGen(Object app_name) {
    return ' لسطح المكتب لإنشاء الكود لـ $app_name';
  }

  @override
  String get gsPageTitle => 'المولد';

  @override
  String get gsConsole => 'مخرجات وحدة التحكم';

  @override
  String get gsIsReadyIn => 'جاهز في';

  @override
  String get gsNeedPermission =>
      'تحتاج Open UI إلى وصول كامل للقرص.\n\nيرجى الذهاب إلى...\nإعدادات النظام > الخصوصية والأمان > الوصول الكامل للقرص > تفعيل Open UI؛ ثم حاول مرة أخرى.';

  @override
  String get gsSeeNBelieve => 'إذا كنت تريد التحقق مما تفعله Open UI، اذهب ';

  @override
  String get gsSeeNBelieveHint => 'فتح كود إنشاء الأكواد الخاص بـ Open UI.';

  @override
  String get gsNotInstalled => 'Flutter غير مثبت';

  @override
  String get gsPartialSuccess =>
      'تم إنشاء الكود بنجاح، ولكن فشل إعداد بعض أجزاء المشروع.';

  @override
  String get rsWouldYou => 'هل ترغب في...';

  @override
  String get rsInstall => 'تثبيته';

  @override
  String get rsInstallHint => 'فتح دليل تثبيت Flutter';

  @override
  String get rsRun => 'تشغيله';

  @override
  String get rsWipe => 'مسحه';

  @override
  String get rsNextTime => 'نجاح، نتمنى التوفيق في المرة القادمة!';

  @override
  String get rsAnotherOne => 'فشل آخر؛ ربما يجب أن تتولى الأمر بنفسك...';

  @override
  String get rsLeave => 'تركه';
}
