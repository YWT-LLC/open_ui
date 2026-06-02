// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class EFUILangAr extends EFUILang {
  EFUILangAr([String locale = 'ar']) : super(locale);

  @override
  String get gApply => 'تطبيق';

  @override
  String get gApplyChanges => 'تطبيق التغييرات';

  @override
  String get gContinue => 'متابعة';

  @override
  String get gOpen => 'فتح';

  @override
  String get gOpenLink => 'فتح الرابط';

  @override
  String get gSkip => 'تخطي';

  @override
  String get gSuccess => 'نجاح';

  @override
  String get gSuccessExl => 'نجاح!';

  @override
  String get gYes => 'نعم';

  @override
  String get gAnd => 'و';

  @override
  String get gHelp => 'مساعدة';

  @override
  String get gNA => 'غير متاح';

  @override
  String get gNAHint => 'لا ينطبق';

  @override
  String get gOptional => 'اختياري';

  @override
  String get gOptions => 'خيارات';

  @override
  String get gRequired => 'مطلوب';

  @override
  String get gThe => 'ال';

  @override
  String get gBack => 'رجوع';

  @override
  String get gCancel => 'إلغاء';

  @override
  String get gClose => 'إغلاق';

  @override
  String get gDisabled => 'معطل';

  @override
  String get gError => 'خطأ';

  @override
  String get gFailure => 'فشل';

  @override
  String get gNo => 'لا';

  @override
  String get gRedo => 'إعادة';

  @override
  String get gUndo => 'تراجع';

  @override
  String get gSettings => 'الإعدادات';

  @override
  String get gGlobal => 'عام';

  @override
  String get gColor => 'اللون';

  @override
  String get gDesign => 'التصميم';

  @override
  String get gLayout => 'التخطيط';

  @override
  String get gText => 'النص';

  @override
  String get gDark => 'داكن';

  @override
  String get gLight => 'فاتح';

  @override
  String get gSystem => 'النظام';

  @override
  String get gEditing => 'التحرير:';

  @override
  String get gEditingHint => 'تفعيل للتعديل';

  @override
  String get gDarkTheme => 'مظهر داكن';

  @override
  String get gLightTheme => 'مظهر فاتح';

  @override
  String get gBothThemes => 'كلا المظهرين';

  @override
  String get gLeft => 'يسار';

  @override
  String get gRight => 'يمين';

  @override
  String get gAdvanced => 'متقدم';

  @override
  String get gQuick => 'سريع';

  @override
  String get gDecrease => 'تقليل';

  @override
  String get gIncrease => 'زيادة';

  @override
  String get gMaximum => 'الحد الأقصى';

  @override
  String get gMinimum => 'الحد الأدنى';

  @override
  String get gCenterReset => 'اضغط باستمرار في المنتصف لإعادة الضبط';

  @override
  String get gLoadingAnim => 'جارٍ التحميل. شعار Empathetic يتحرك كساعة رملية دوارة.';

  @override
  String get gPlay => 'تشغيل';

  @override
  String get gPause => 'إيقاف مؤقت';

  @override
  String get gReplay => 'إعادة تشغيل';

  @override
  String get gMute => 'كتم الصوت';

  @override
  String get gUnMute => 'إلغاء كتم الصوت';

  @override
  String get gPlaybackSpeed => 'سرعة التشغيل';

  @override
  String get gCaptions => 'ترجمة/تسميات توضيحية';

  @override
  String get gCaptionsHint => 'اضغط باستمرار لاختيار الخطوط';

  @override
  String get gFullscreen => 'ملء الشاشة';

  @override
  String get gMachineTranslated => 'ترجمة آلية';

  @override
  String get gUpdates => 'تحديثات متاحة';

  @override
  String get gHardRefresh => 'يرجى إعادة تحميل الصفحة بالكامل...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac => 'يرجى إعادة تحميل الصفحة بالكامل...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile => 'يرجى تحديث الصفحة من قائمة المتصفح.';

  @override
  String get gEnterURL => 'إدخال الرابط (URL)';

  @override
  String get gValidURL => 'يرجى إدخال رابط (URL) صحيح';

  @override
  String get g404Wonder => 'ليس كل من يتجول تائهاً.';

  @override
  String get g404 => 'ولكن في هذه الحالة: الصفحة 404 غير موجودة.';

  @override
  String get g404Note =>
      'ملاحظة: يستخدم Flutter web التوجيه بالتجزئة (hash routing)، مثل...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => 'مفتوح المصدر';

  @override
  String get gOpenEmpathetech => 'فتح رابط إلى Empathetic LLC';

  @override
  String get gEFUISourceHint => 'فتح صفحة GitHub لـ EFUI';

  @override
  String get gOpenUIReleases => 'فتح صفحة الإصدارات لـ Open UI';

  @override
  String get gSupportEmail => 'بريد الدعم الخاص بنا';

  @override
  String gClipboard(Object thing) {
    return 'تم نسخ $thing إلى الحافظة.';
  }

  @override
  String get gAttention => 'انتباه';

  @override
  String get gCurrently => 'حالياً:';

  @override
  String gSetToValue(Object name, Object value) {
    return 'تم تعيين $name إلى $value';
  }

  @override
  String get gRemove => 'إزالة';

  @override
  String get gReset => 'إعادة ضبط';

  @override
  String get gResetTo => 'إعادة ضبط:';

  @override
  String gResetValue(Object name) {
    return 'إعادة ضبط $name؟';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return 'إعادة ضبط $name إلى $value';
  }

  @override
  String get gResetAll => 'إعادة ضبط الكل';

  @override
  String get gUndoWarn1 => 'لا يمكن التراجع تلقائياً.\n';

  @override
  String get gSave => 'حفظ';

  @override
  String get gSaveHint => 'تفعيل لحفظ ملف تكوين JSON.';

  @override
  String get gSwitchHint => 'تبديل الزر';

  @override
  String get gUndoWarn2 => ' التكوين الحالي لاستعادته يدوياً.';

  @override
  String get gValue => 'القيمة';

  @override
  String get gSource => 'المصدر:';

  @override
  String get gCreator => 'منشئ';

  @override
  String get gMadeBy => 'صُنع بواسطة';

  @override
  String get gYou => 'تم تعيينه بواسطتك';

  @override
  String get ssNavHint => 'فتح صفحة الإعدادات';

  @override
  String get ssRestartReminder => 'أغلق التطبيق وأعد فتحه لتطبيق التغييرات.';

  @override
  String get ssRestartReminderWeb => 'أعد تحميل/تحديث الصفحة لتطبيق التغييرات.';

  @override
  String get ssHaveFun => 'استمتع!';

  @override
  String get ssDominantHand => 'اليد المهيمنة';

  @override
  String get ssThemeMode => 'وضع المظهر';

  @override
  String get ssLanguage => 'اللغة';

  @override
  String get ssLangHint => 'تفعيل لتغيير لغة التطبيق';

  @override
  String get ssUpdateDark => 'تحديث المظهر الداكن';

  @override
  String get ssUpdateLight => 'تحديث المظهر الفاتح';

  @override
  String get ssUpdateBoth => 'تحديث كِلا المظهرين';

  @override
  String get ssLoadPreset => 'تحميل الإعداد المسبق';

  @override
  String get ssLoadPresetHint => 'تفعيل لإظهار الإعدادات المسبقة';

  @override
  String get ssDewIt => 'تحديث كلاهما/تأكيد تلقائي';

  @override
  String get ssBigButtons => 'أزرار كبيرة';

  @override
  String get ssHighVisibility => 'رؤية عالية';

  @override
  String get ssChalkboard => 'سبورة';

  @override
  String get ssNebula => 'سديم';

  @override
  String get ssWallHoles => 'ثقوب الجدار';

  @override
  String get ssDarkOnly =>
      'هذا إعداد مسبق لمظهر داكن.\nسيقوم بتعيين وضع المظهر إلى داكن، وتحديث ذلك المظهر.\n\nمتابعة؟';

  @override
  String get ssLightOnly =>
      'هذا إعداد مسبق لمظهر فاتح.\nسيقوم بتعيين وضع المظهر إلى فاتح، وتحديث ذلك المظهر.\n\nمتابعة؟';

  @override
  String ssApplied(Object config) {
    return 'تم تطبيق $config.';
  }

  @override
  String get ssTryMe => 'جربني';

  @override
  String get ssRandom => 'عشوائي';

  @override
  String ssRandomize(Object themeType) {
    return 'جعل مظهر $themeType عشوائياً؟';
  }

  @override
  String get ssConfigTip => 'حفظ/تحميل التكوين';

  @override
  String get ssSaveConfig => 'حفظ التكوين';

  @override
  String ssConfigSaved(Object path) {
    return 'تم حفظ التكوين الخاص بك في $path';
  }

  @override
  String get ssWrongConfigExt => 'لم يتم حفظ الملف باسم ';

  @override
  String get ssLoadConfig => 'تحميل التكوين';

  @override
  String get ssResetAll => 'إعادة ضبط جميع الإعدادات؟';

  @override
  String get ssResetAppearance => 'إعادة ضبط جميع إعدادات المظهر؟';

  @override
  String get ssResetBoth => 'إعادة ضبط كِلا المظهرين';

  @override
  String get csPageTitle => 'إعدادات الألوان';

  @override
  String get csSchemeBase => 'بناء مخطط\nمن صورة';

  @override
  String get csFromImage => 'سيتم إنشاء مخطط ألوان من الصورة.';

  @override
  String get csMonoChrome => 'استخدام مخطط أحادي اللون';

  @override
  String get csHighContrast => 'استخدام مخطط عالي التباين';

  @override
  String get csPrimary => 'أساسي';

  @override
  String get csPrimaryContainer => 'إطار\nأساسي';

  @override
  String get csSecondary => 'ثانوي';

  @override
  String get csSecondaryContainer => 'إطار\nثانوي';

  @override
  String get csTertiary => 'ثلاثي';

  @override
  String get csTertiaryContainer => 'إطار\nثلاثي';

  @override
  String get csError => 'خطأ';

  @override
  String get csErrorContainer => 'إطار\nالخطأ';

  @override
  String get csOutline => 'نص\nتلميحي';

  @override
  String get csOutlineVariant => 'إطار\nتلميحي';

  @override
  String get csSurface => 'خلفية\nالزر';

  @override
  String get csSurfaceDim => 'خلفية\nالتنبيه وشريط التطبيق';

  @override
  String get csSurfaceContainer => 'خلفية\nالصفحة والنافذة';

  @override
  String get csOnSurface => 'نص';

  @override
  String get csScrim => 'غطاء\nالنافذة';

  @override
  String get csShadow => 'ظل';

  @override
  String get csSurfaceTint => 'تلوين\nالسطح';

  @override
  String get csPickerTitle => 'اختر لوناً';

  @override
  String get csPickerHint => 'فتح منتقي الألوان. ضغطة مطولة لمزيد من الخيارات.';

  @override
  String get csRecommended => 'هل تريد استخدام توصية التباين؟';

  @override
  String get csUseCustom => 'استخدام مخصص';

  @override
  String get csCurrVal => 'قيمة اللون الحالية:';

  @override
  String csReset(Object themeType) {
    return 'إعادة ضبط ألوان مظهر $themeType؟';
  }

  @override
  String get csColorScheme => 'مخطط الألوان';

  @override
  String get dsPageTitle => 'إعدادات التصميم';

  @override
  String get dsButton => 'زر';

  @override
  String get dsPage => 'صفحة';

  @override
  String get dsNone => 'بدون';

  @override
  String get dsSystem => 'النظام';

  @override
  String get dsPadding => 'حشو';

  @override
  String get dsStyle => 'النمط';

  @override
  String get dsBorderWidth => 'عرض الحدود';

  @override
  String get dsPill => 'كبسولة';

  @override
  String get dsRectangle => 'مستطيل';

  @override
  String get dsRoundRectangle => 'مستطيل دائري';

  @override
  String get dsLeftGram => 'متوازي أيسر';

  @override
  String get dsRightGram => 'متوازي أيمن';

  @override
  String get dsGem => 'جوهرة';

  @override
  String get dsJewel => 'حجر كريم';

  @override
  String get dsAlwaysUnderline => 'وضع خط دائماً تحت الروابط';

  @override
  String get dsShowBack => 'إظهار زر الرجوع';

  @override
  String get dsMargin => 'هامش';

  @override
  String get dsSpacing => 'تباعد';

  @override
  String get dsPageTransition => 'انتقال الصفحة';

  @override
  String get dsTurnX => 'دوران أفقي';

  @override
  String get dsTurnY => 'دوران عمودي';

  @override
  String get dsRotate => 'تدوير';

  @override
  String get dsSlideX => 'انزلاق أفقي';

  @override
  String get dsSlideY => 'انزلاق عمودي';

  @override
  String get dsZoom => 'تكبير/تصغير';

  @override
  String get dsFadeTransition => 'انتقال التلاشي';

  @override
  String get dsAnimStyle => 'نمط الحركة';

  @override
  String get dsPlay => 'تشغيل الحركة';

  @override
  String get dsMilliseconds => 'أجزاء من الألف من الثانية';

  @override
  String get dsCurve => 'منحنى';

  @override
  String get dsBounce => 'ارتداد';

  @override
  String get dsEase => 'سهولة';

  @override
  String get dsElastic => 'مرن';

  @override
  String get dsLinear => 'خطي';

  @override
  String get dsBackgroundImg => 'صورة الخلفية';

  @override
  String dsImgSettingHint(Object title) {
    return 'تحديث صورة $title';
  }

  @override
  String get dsReFit => 'إعادة ملاءمة';

  @override
  String get dsFromFile => 'من ملف';

  @override
  String get dsFromCamera => 'من الكاميرا';

  @override
  String get dsFromNetwork => 'من رابط (URL)';

  @override
  String get dsSolidColor => 'لون خالص';

  @override
  String get dsResetIt => 'إعادة ضبطه';

  @override
  String get dsClearIt => 'مسحه';

  @override
  String get dsUseForColors => 'تحديث ألوان التطبيق باستخدام هذه الصورة';

  @override
  String get dsImgGetFailed => 'فشل في استرداد الصورة';

  @override
  String get dsImgSetFailed => 'فشل في تحديث الصورة';

  @override
  String get dsImgPermission =>
      'بعض المواقع لا تسمح للآخرين بالوصول إلى صورها.\nحاول استخدام صورة من مضيف آخر.';

  @override
  String get dsUseFull => 'استخدام الصورة كاملة؟';

  @override
  String get dsFit => 'كيف يجب أن تتلاءم؟';

  @override
  String get dsCrop => 'قص';

  @override
  String get dsNoWeb => 'تعديل الصور غير مدعوم على الويب';

  @override
  String get dsRotateLeft => 'تدوير لليسار';

  @override
  String get dsRotateRight => 'تدوير لليمين';

  @override
  String get dsShowScroll => 'إظهار أشرطة التمرير';

  @override
  String dsResetButton(Object themeType) {
    return 'إعادة ضبط تصميم زر مظهر $themeType؟';
  }

  @override
  String dsResetPage(Object themeType) {
    return 'إعادة ضبط تصميم صفحة مظهر $themeType؟';
  }

  @override
  String get tsPageTitle => 'إعدادات النص';

  @override
  String tsBatchOverride(Object setting) {
    return 'لقد قمت بالفعل بإجراء تغييرات دقيقة على \"$setting\" في الإعدادات المتقدمة.\n\nهل أنت متأكد أنك تريد تجاوز هذه التغييرات بتحديث جماعي؟';
  }

  @override
  String get tsTextBackground => 'تعتيم خلفية النص';

  @override
  String get tsIconSize => 'حجم الرمز';

  @override
  String tsLinkHint(Object style) {
    return 'تفعيل لتعديل $style';
  }

  @override
  String get tsDisplay => 'العرض';

  @override
  String get tsHeadline => 'العنوان الرئيسي';

  @override
  String get tsTitle => 'العنوان';

  @override
  String get tsBody => 'المتن';

  @override
  String get tsLabel => 'التسمية';

  @override
  String get tsFontFamily => 'عائلة الخط';

  @override
  String get tsFontSize => 'حجم الخط';

  @override
  String get tsBold => 'عريض';

  @override
  String get tsItalic => 'مائل';

  @override
  String get tsUnderline => 'تسطير';

  @override
  String get tsLetterSpacing => 'تباعد الأحرف';

  @override
  String get tsWordSpacing => 'تباعد الكلمات';

  @override
  String get tsLineHeight => 'ارتفاع السطر';

  @override
  String get tsDisplayP1 => 'هل يتم ';

  @override
  String get tsDisplayLink => 'عرض';

  @override
  String get tsDisplayP2 => ' هذا بشكل جيد؟';

  @override
  String get tsHeadlineP1 => 'هل ';

  @override
  String get tsHeadlineLink => 'العناوين الرئيسية';

  @override
  String get tsHeadlineP2 => ' واضحة...';

  @override
  String get tsTitleP1 => 'عن ';

  @override
  String get tsTitleLink => 'العناوين؟';

  @override
  String get tsBodyP1 => 'ماذا عن ';

  @override
  String get tsBodyLink => 'المتن؟';

  @override
  String get tsBodyP2 => ' هل يسهل قراءته؟';

  @override
  String get tsLabelP1 => 'و';

  @override
  String get tsLabelLink => 'التسميات؟';

  @override
  String get tsLabelP2 => ' ليست كبيرة جداً، وليست صغيرة جداً؟';

  @override
  String tsReset(Object themeType) {
    return 'إعادة ضبط أنماط نصوص مظهر $themeType؟';
  }
}

/// The translations for Arabic, as used in Egypt (`ar_EG`).
class EFUILangArEg extends EFUILangAr {
  EFUILangArEg() : super('ar_EG');

  @override
  String get gApply => 'تطبيق';

  @override
  String get gApplyChanges => 'تطبيق التغييرات';

  @override
  String get gContinue => 'متابعة';

  @override
  String get gOpen => 'فتح';

  @override
  String get gOpenLink => 'فتح الرابط';

  @override
  String get gSkip => 'تخطي';

  @override
  String get gSuccess => 'نجاح';

  @override
  String get gSuccessExl => 'نجاح!';

  @override
  String get gYes => 'نعم';

  @override
  String get gAnd => 'و';

  @override
  String get gHelp => 'مساعدة';

  @override
  String get gNA => 'غير متاح';

  @override
  String get gNAHint => 'لا ينطبق';

  @override
  String get gOptional => 'اختياري';

  @override
  String get gOptions => 'خيارات';

  @override
  String get gRequired => 'مطلوب';

  @override
  String get gThe => 'ال';

  @override
  String get gBack => 'رجوع';

  @override
  String get gCancel => 'إلغاء';

  @override
  String get gClose => 'إغلاق';

  @override
  String get gDisabled => 'معطل';

  @override
  String get gError => 'خطأ';

  @override
  String get gFailure => 'فشل';

  @override
  String get gNo => 'لا';

  @override
  String get gRedo => 'إعادة';

  @override
  String get gUndo => 'تراجع';

  @override
  String get gSettings => 'الإعدادات';

  @override
  String get gGlobal => 'عام';

  @override
  String get gColor => 'اللون';

  @override
  String get gDesign => 'التصميم';

  @override
  String get gLayout => 'التخطيط';

  @override
  String get gText => 'النص';

  @override
  String get gDark => 'داكن';

  @override
  String get gLight => 'فاتح';

  @override
  String get gSystem => 'النظام';

  @override
  String get gEditing => 'التحرير:';

  @override
  String get gEditingHint => 'تفعيل للتعديل';

  @override
  String get gDarkTheme => 'مظهر داكن';

  @override
  String get gLightTheme => 'مظهر فاتح';

  @override
  String get gBothThemes => 'كلا المظهرين';

  @override
  String get gLeft => 'يسار';

  @override
  String get gRight => 'يمين';

  @override
  String get gAdvanced => 'متقدم';

  @override
  String get gQuick => 'سريع';

  @override
  String get gDecrease => 'تقليل';

  @override
  String get gIncrease => 'زيادة';

  @override
  String get gMaximum => 'الحد الأقصى';

  @override
  String get gMinimum => 'الحد الأدنى';

  @override
  String get gCenterReset => 'اضغط باستمرار في المنتصف لإعادة الضبط';

  @override
  String get gLoadingAnim => 'جارٍ التحميل. شعار Empathetic يتحرك كساعة رملية دوارة.';

  @override
  String get gPlay => 'تشغيل';

  @override
  String get gPause => 'إيقاف مؤقت';

  @override
  String get gReplay => 'إعادة تشغيل';

  @override
  String get gMute => 'كتم الصوت';

  @override
  String get gUnMute => 'إلغاء كتم الصوت';

  @override
  String get gPlaybackSpeed => 'سرعة التشغيل';

  @override
  String get gCaptions => 'ترجمة/تسميات توضيحية';

  @override
  String get gCaptionsHint => 'اضغط باستمرار لاختيار الخطوط';

  @override
  String get gFullscreen => 'ملء الشاشة';

  @override
  String get gMachineTranslated => 'ترجمة آلية';

  @override
  String get gUpdates => 'تحديثات متاحة';

  @override
  String get gHardRefresh => 'يرجى إعادة تحميل الصفحة بالكامل...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac => 'يرجى إعادة تحميل الصفحة بالكامل...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile => 'يرجى تحديث الصفحة من قائمة المتصفح.';

  @override
  String get gEnterURL => 'إدخال الرابط (URL)';

  @override
  String get gValidURL => 'يرجى إدخال رابط (URL) صحيح';

  @override
  String get g404Wonder => 'ليس كل من يتجول تائهاً.';

  @override
  String get g404 => 'ولكن في هذه الحالة: الصفحة 404 غير موجودة.';

  @override
  String get g404Note =>
      'ملاحظة: يستخدم Flutter web التوجيه بالتجزئة (hash routing)، مثل...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => 'مفتوح المصدر';

  @override
  String get gOpenEmpathetech => 'فتح رابط إلى Empathetic LLC';

  @override
  String get gEFUISourceHint => 'فتح صفحة GitHub لـ EFUI';

  @override
  String get gOpenUIReleases => 'فتح صفحة الإصدارات لـ Open UI';

  @override
  String get gSupportEmail => 'بريد الدعم الخاص بنا';

  @override
  String gClipboard(Object thing) {
    return 'تم نسخ $thing إلى الحافظة.';
  }

  @override
  String get gAttention => 'انتباه';

  @override
  String get gCurrently => 'حالياً:';

  @override
  String gSetToValue(Object name, Object value) {
    return 'تم تعيين $name إلى $value';
  }

  @override
  String get gRemove => 'إزالة';

  @override
  String get gReset => 'إعادة ضبط';

  @override
  String get gResetTo => 'إعادة ضبط:';

  @override
  String gResetValue(Object name) {
    return 'إعادة ضبط $name؟';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return 'إعادة ضبط $name إلى $value';
  }

  @override
  String get gResetAll => 'إعادة ضبط الكل';

  @override
  String get gUndoWarn1 => 'لا يمكن التراجع تلقائياً.\n';

  @override
  String get gSave => 'حفظ';

  @override
  String get gSaveHint => 'تفعيل لحفظ ملف تكوين JSON.';

  @override
  String get gSwitchHint => 'تبديل الزر';

  @override
  String get gUndoWarn2 => ' التكوين الحالي لاستعادته يدوياً.';

  @override
  String get gValue => 'القيمة';

  @override
  String get gSource => 'المصدر:';

  @override
  String get gCreator => 'منشئ';

  @override
  String get gMadeBy => 'صُنع بواسطة';

  @override
  String get gYou => 'تم تعيينه بواسطتك';

  @override
  String get ssNavHint => 'فتح صفحة الإعدادات';

  @override
  String get ssRestartReminder => 'أغلق التطبيق وأعد فتحه لتطبيق التغييرات.';

  @override
  String get ssRestartReminderWeb => 'أعد تحميل/تحديث الصفحة لتطبيق التغييرات.';

  @override
  String get ssHaveFun => 'استمتع!';

  @override
  String get ssDominantHand => 'اليد المهيمنة';

  @override
  String get ssThemeMode => 'وضع المظهر';

  @override
  String get ssLanguage => 'اللغة';

  @override
  String get ssLangHint => 'تفعيل لتغيير لغة التطبيق';

  @override
  String get ssUpdateDark => 'تحديث المظهر الداكن';

  @override
  String get ssUpdateLight => 'تحديث المظهر الفاتح';

  @override
  String get ssUpdateBoth => 'تحديث كِلا المظهرين';

  @override
  String get ssLoadPreset => 'تحميل الإعداد المسبق';

  @override
  String get ssLoadPresetHint => 'تفعيل لإظهار الإعدادات المسبقة';

  @override
  String get ssDewIt => 'تحديث كلاهما/تأكيد تلقائي';

  @override
  String get ssBigButtons => 'أزرار كبيرة';

  @override
  String get ssHighVisibility => 'رؤية عالية';

  @override
  String get ssChalkboard => 'سبورة';

  @override
  String get ssNebula => 'سديم';

  @override
  String get ssWallHoles => 'ثقوب الجدار';

  @override
  String get ssDarkOnly =>
      'هذا إعداد مسبق لمظهر داكن.\nسيقوم بتعيين وضع المظهر إلى داكن، وتحديث ذلك المظهر.\n\nمتابعة؟';

  @override
  String get ssLightOnly =>
      'هذا إعداد مسبق لمظهر فاتح.\nسيقوم بتعيين وضع المظهر إلى فاتح، وتحديث ذلك المظهر.\n\nمتابعة؟';

  @override
  String ssApplied(Object config) {
    return 'تم تطبيق $config.';
  }

  @override
  String get ssTryMe => 'جربني';

  @override
  String get ssRandom => 'عشوائي';

  @override
  String ssRandomize(Object themeType) {
    return 'جعل مظهر $themeType عشوائياً؟';
  }

  @override
  String get ssConfigTip => 'حفظ/تحميل التكوين';

  @override
  String get ssSaveConfig => 'حفظ التكوين';

  @override
  String ssConfigSaved(Object path) {
    return 'تم حفظ التكوين الخاص بك في $path';
  }

  @override
  String get ssWrongConfigExt => 'لم يتم حفظ الملف باسم ';

  @override
  String get ssLoadConfig => 'تحميل التكوين';

  @override
  String get ssResetAll => 'إعادة ضبط جميع الإعدادات؟';

  @override
  String get ssResetAppearance => 'إعادة ضبط جميع إعدادات المظهر؟';

  @override
  String get ssResetBoth => 'إعادة ضبط كِلا المظهرين';

  @override
  String get csPageTitle => 'إعدادات الألوان';

  @override
  String get csSchemeBase => 'بناء مخطط\nمن صورة';

  @override
  String get csFromImage => 'سيتم إنشاء مخطط ألوان من الصورة.';

  @override
  String get csMonoChrome => 'استخدام مخطط أحادي اللون';

  @override
  String get csHighContrast => 'استخدام مخطط عالي التباين';

  @override
  String get csPrimary => 'أساسي';

  @override
  String get csPrimaryContainer => 'إطار\nأساسي';

  @override
  String get csSecondary => 'ثانوي';

  @override
  String get csSecondaryContainer => 'إطار\nثانوي';

  @override
  String get csTertiary => 'ثلاثي';

  @override
  String get csTertiaryContainer => 'إطار\nثلاثي';

  @override
  String get csError => 'خطأ';

  @override
  String get csErrorContainer => 'إطار\nالخطأ';

  @override
  String get csOutline => 'نص\nتلميحي';

  @override
  String get csOutlineVariant => 'إطار\nتلميحي';

  @override
  String get csSurface => 'خلفية\nالزر';

  @override
  String get csSurfaceDim => 'خلفية\nالتنبيه وشريط التطبيق';

  @override
  String get csSurfaceContainer => 'خلفية\nالصفحة والنافذة';

  @override
  String get csOnSurface => 'نص';

  @override
  String get csScrim => 'غطاء\nالنافذة';

  @override
  String get csShadow => 'ظل';

  @override
  String get csSurfaceTint => 'تلوين\nالسطح';

  @override
  String get csPickerTitle => 'اختر لوناً';

  @override
  String get csPickerHint => 'فتح منتقي الألوان. ضغطة مطولة لمزيد من الخيارات.';

  @override
  String get csRecommended => 'هل تريد استخدام توصية التباين؟';

  @override
  String get csUseCustom => 'استخدام مخصص';

  @override
  String get csCurrVal => 'قيمة اللون الحالية:';

  @override
  String csReset(Object themeType) {
    return 'إعادة ضبط ألوان مظهر $themeType؟';
  }

  @override
  String get csColorScheme => 'مخطط الألوان';

  @override
  String get dsPageTitle => 'إعدادات التصميم';

  @override
  String get dsButton => 'زر';

  @override
  String get dsPage => 'صفحة';

  @override
  String get dsNone => 'بدون';

  @override
  String get dsSystem => 'النظام';

  @override
  String get dsPadding => 'حشو';

  @override
  String get dsStyle => 'النمط';

  @override
  String get dsBorderWidth => 'عرض الحدود';

  @override
  String get dsPill => 'كبسولة';

  @override
  String get dsRectangle => 'مستطيل';

  @override
  String get dsRoundRectangle => 'مستطيل دائري';

  @override
  String get dsLeftGram => 'متوازي أيسر';

  @override
  String get dsRightGram => 'متوازي أيمن';

  @override
  String get dsGem => 'جوهرة';

  @override
  String get dsJewel => 'حجر كريم';

  @override
  String get dsAlwaysUnderline => 'وضع خط دائماً تحت الروابط';

  @override
  String get dsShowBack => 'إظهار زر الرجوع';

  @override
  String get dsMargin => 'هامش';

  @override
  String get dsSpacing => 'تباعد';

  @override
  String get dsPageTransition => 'انتقال الصفحة';

  @override
  String get dsTurnX => 'دوران أفقي';

  @override
  String get dsTurnY => 'دوران عمودي';

  @override
  String get dsRotate => 'تدوير';

  @override
  String get dsSlideX => 'انزلاق أفقي';

  @override
  String get dsSlideY => 'انزلاق عمودي';

  @override
  String get dsZoom => 'تكبير/تصغير';

  @override
  String get dsFadeTransition => 'انتقال التلاشي';

  @override
  String get dsAnimStyle => 'نمط الحركة';

  @override
  String get dsPlay => 'تشغيل الحركة';

  @override
  String get dsMilliseconds => 'أجزاء من الألف من الثانية';

  @override
  String get dsCurve => 'منحنى';

  @override
  String get dsBounce => 'ارتداد';

  @override
  String get dsEase => 'سهولة';

  @override
  String get dsElastic => 'مرن';

  @override
  String get dsLinear => 'خطي';

  @override
  String get dsBackgroundImg => 'صورة الخلفية';

  @override
  String dsImgSettingHint(Object title) {
    return 'تحديث صورة $title';
  }

  @override
  String get dsReFit => 'إعادة ملاءمة';

  @override
  String get dsFromFile => 'من ملف';

  @override
  String get dsFromCamera => 'من الكاميرا';

  @override
  String get dsFromNetwork => 'من رابط (URL)';

  @override
  String get dsSolidColor => 'لون خالص';

  @override
  String get dsResetIt => 'إعادة ضبطه';

  @override
  String get dsClearIt => 'مسحه';

  @override
  String get dsUseForColors => 'تحديث ألوان التطبيق باستخدام هذه الصورة';

  @override
  String get dsImgGetFailed => 'فشل في استرداد الصورة';

  @override
  String get dsImgSetFailed => 'فشل في تحديث الصورة';

  @override
  String get dsImgPermission =>
      'بعض المواقع لا تسمح للآخرين بالوصول إلى صورها.\nحاول استخدام صورة من مضيف آخر.';

  @override
  String get dsUseFull => 'استخدام الصورة كاملة؟';

  @override
  String get dsFit => 'كيف يجب أن تتلاءم؟';

  @override
  String get dsCrop => 'قص';

  @override
  String get dsNoWeb => 'تعديل الصور غير مدعوم على الويب';

  @override
  String get dsRotateLeft => 'تدوير لليسار';

  @override
  String get dsRotateRight => 'تدوير لليمين';

  @override
  String get dsShowScroll => 'إظهار أشرطة التمرير';

  @override
  String dsResetButton(Object themeType) {
    return 'إعادة ضبط تصميم زر مظهر $themeType؟';
  }

  @override
  String dsResetPage(Object themeType) {
    return 'إعادة ضبط تصميم صفحة مظهر $themeType؟';
  }

  @override
  String get tsPageTitle => 'إعدادات النص';

  @override
  String tsBatchOverride(Object setting) {
    return 'لقد قمت بالفعل بإجراء تغييرات دقيقة على \"$setting\" في الإعدادات المتقدمة.\n\nهل أنت متأكد أنك تريد تجاوز هذه التغييرات بتحديث جماعي؟';
  }

  @override
  String get tsTextBackground => 'تعتيم خلفية النص';

  @override
  String get tsIconSize => 'حجم الرمز';

  @override
  String tsLinkHint(Object style) {
    return 'تفعيل لتعديل $style';
  }

  @override
  String get tsDisplay => 'العرض';

  @override
  String get tsHeadline => 'العنوان الرئيسي';

  @override
  String get tsTitle => 'العنوان';

  @override
  String get tsBody => 'المتن';

  @override
  String get tsLabel => 'التسمية';

  @override
  String get tsFontFamily => 'عائلة الخط';

  @override
  String get tsFontSize => 'حجم الخط';

  @override
  String get tsBold => 'عريض';

  @override
  String get tsItalic => 'مائل';

  @override
  String get tsUnderline => 'تسطير';

  @override
  String get tsLetterSpacing => 'تباعد الأحرف';

  @override
  String get tsWordSpacing => 'تباعد الكلمات';

  @override
  String get tsLineHeight => 'ارتفاع السطر';

  @override
  String get tsDisplayP1 => 'هل يتم ';

  @override
  String get tsDisplayLink => 'عرض';

  @override
  String get tsDisplayP2 => ' هذا بشكل جيد؟';

  @override
  String get tsHeadlineP1 => 'هل ';

  @override
  String get tsHeadlineLink => 'العناوين الرئيسية';

  @override
  String get tsHeadlineP2 => ' واضحة...';

  @override
  String get tsTitleP1 => 'عن ';

  @override
  String get tsTitleLink => 'العناوين؟';

  @override
  String get tsBodyP1 => 'ماذا عن ';

  @override
  String get tsBodyLink => 'المتن؟';

  @override
  String get tsBodyP2 => ' هل يسهل قراءته؟';

  @override
  String get tsLabelP1 => 'و';

  @override
  String get tsLabelLink => 'التسميات؟';

  @override
  String get tsLabelP2 => ' ليست كبيرة جداً، وليست صغيرة جداً؟';

  @override
  String tsReset(Object themeType) {
    return 'إعادة ضبط أنماط نصوص مظهر $themeType؟';
  }
}
