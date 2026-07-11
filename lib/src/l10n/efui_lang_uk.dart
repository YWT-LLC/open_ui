// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class EFUILangUk extends EFUILang {
  EFUILangUk([String locale = 'uk']) : super(locale);

  @override
  String get gApply => 'Застосувати';

  @override
  String get gApplyChanges => 'Застосувати зміни';

  @override
  String get gContinue => 'Продовжити';

  @override
  String get gOpen => 'Відкрити';

  @override
  String get gOpenLink => 'Відкрити посилання';

  @override
  String get gSkip => 'Пропустити';

  @override
  String get gSuccess => 'Успіх';

  @override
  String get gSuccessExl => 'Успішно!';

  @override
  String get gYes => 'Так';

  @override
  String get gAnd => 'та';

  @override
  String get gHelp => 'Довідка';

  @override
  String get gNA => 'Н/Д';

  @override
  String get gNAHint => 'Не застосовується';

  @override
  String get gOptional => 'необов\'язково';

  @override
  String get gOptions => 'Параметри';

  @override
  String get gRequired => 'Обов\'язково';

  @override
  String get gThe => 'Цей';

  @override
  String get gBack => 'Назад';

  @override
  String get gCancel => 'Скасувати';

  @override
  String get gClose => 'Закрити';

  @override
  String get gDisabled => 'Вимкнено';

  @override
  String get gError => 'Помилка';

  @override
  String get gFailure => 'Збій';

  @override
  String get gNo => 'Ні';

  @override
  String get gRedo => 'Повторити';

  @override
  String get gUndo => 'Скасувати дію';

  @override
  String get gSettings => 'Налаштування';

  @override
  String get gGlobal => 'Глобальні';

  @override
  String get gColor => 'Колір';

  @override
  String get gDesign => 'Дизайн';

  @override
  String get gLayout => 'Макет';

  @override
  String get gText => 'Текст';

  @override
  String get gDark => 'Темна';

  @override
  String get gLight => 'Світла';

  @override
  String get gSystem => 'Системна';

  @override
  String get gEditing => 'Редагування: ';

  @override
  String get gEditingHint => 'Активуйте для редагування';

  @override
  String get gDarkTheme => 'Темна тема';

  @override
  String get gLightTheme => 'Світла тема';

  @override
  String get gBothThemes => 'Обидві теми';

  @override
  String get gLeft => 'Ліворуч';

  @override
  String get gRight => 'Праворуч';

  @override
  String get gAdvanced => 'Розширені';

  @override
  String get gQuick => 'Швидкі';

  @override
  String get gDecrease => 'Зменшити';

  @override
  String get gIncrease => 'Збільшити';

  @override
  String get gMaximum => 'Максимум';

  @override
  String get gMinimum => 'Мінімум';

  @override
  String get gCenterReset => 'Утримуйте центр для скидання';

  @override
  String get gLoadingAnim =>
      'Завантаження. Логотип Empathetic анімований як пісочний годинник, що обертається.';

  @override
  String get gPlay => 'Відтворити';

  @override
  String get gPause => 'Пауза';

  @override
  String get gReplay => 'Відтворити знову';

  @override
  String get gMute => 'Вимкнути звук';

  @override
  String get gUnMute => 'Увімкнути звук';

  @override
  String get gPlaybackSpeed => 'Швидкість відтворення';

  @override
  String get gFBF => 'Покадрово';

  @override
  String get gCaptions => 'Субтитри/підписи';

  @override
  String get gCaptionsHint => 'Утримуйте для вибору шрифтів';

  @override
  String get gFullscreen => 'На весь екран';

  @override
  String get gMachineTranslated => 'Машинний переклад';

  @override
  String get gUpdates => 'Доступні оновлення';

  @override
  String get gHardRefresh =>
      'Будь ласка, виконайте жорстке оновлення сторінки...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac =>
      'Будь ласка, виконайте жорстке оновлення сторінки...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile =>
      'Будь ласка, оновіть сторінку в меню браузера.';

  @override
  String get gEnterURL => 'Введіть URL';

  @override
  String get gValidURL => 'Будь ласка, введіть дійсний URL';

  @override
  String get g404Wonder => 'Не всі ті, хто блукають, загубилися.';

  @override
  String get g404 => 'Але в цьому випадку: 404 сторінку не знайдено.';

  @override
  String get g404Note =>
      'Примітка: Flutter web використовує хеш-маршрутизацію, наприклад...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => 'Відкритий вихідний код';

  @override
  String get gOpenEmpathetech => 'Відкрити посилання на Empathetic LLC';

  @override
  String get gEFUISourceHint => 'Відкрити сторінку GitHub для EFUI';

  @override
  String get gOpenUIReleases => 'Відкрити сторінку релізів для Open UI';

  @override
  String get gSupportEmail => 'Наша електронна пошта підтримки';

  @override
  String gClipboard(Object thing) {
    return '$thing скопійовано в буфер обміну.';
  }

  @override
  String get gAttention => 'Увага';

  @override
  String get gCurrently => 'Зараз:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name має значення $value';
  }

  @override
  String get gRemove => 'Видалити';

  @override
  String get gReset => 'Скинути';

  @override
  String get gResetTo => 'Скинути до:';

  @override
  String gResetValue(Object name) {
    return 'Скинути $name?';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return 'Скинути $name до $value';
  }

  @override
  String get gResetAll => 'Скинути все';

  @override
  String get gUndoWarn1 => 'Неможливо скасувати автоматично.\n';

  @override
  String get gSave => 'Зберегти';

  @override
  String get gSaveHint => 'Активуйте, щоб зберегти конфігураційний файл JSON.';

  @override
  String get gSwitchHint => 'Перемкнути';

  @override
  String get gUndoWarn2 =>
      ' вашу поточну конфігурацію, щоб відновити її вручну.';

  @override
  String get gValue => 'Значення';

  @override
  String get gSource => 'Джерело:';

  @override
  String get gCreator => 'Творець';

  @override
  String get gMadeBy => 'Зроблено';

  @override
  String get gYou => 'Встановлено вами';

  @override
  String get ssNavHint => 'Відкрити сторінку налаштувань';

  @override
  String get ssHaveFun => 'Приємного користування!';

  @override
  String get ssDominantHand => 'Провідна рука';

  @override
  String get ssThemeMode => 'Режим теми';

  @override
  String get ssLanguage => 'Мова';

  @override
  String get ssLangHint => 'Активуйте, щоб змінити мову програми';

  @override
  String get ssUpdateDark => 'Оновити темну тему';

  @override
  String get ssUpdateLight => 'Оновити світлу тему';

  @override
  String get ssUpdateBoth => 'Оновити обидва режими теми';

  @override
  String get ssLoadPreset => 'Завантажити пресет';

  @override
  String get ssLoadPresetHint => 'Активуйте, щоб показати пресети';

  @override
  String get ssDewIt => 'Оновити обидва/автопідтвердження';

  @override
  String get ssBigButtons => 'Великі кнопки';

  @override
  String get ssHighVisibility => 'Висока видимість';

  @override
  String get ssChalkboard => 'Шкільна дошка';

  @override
  String get ssNebula => 'Туманність';

  @override
  String get ssWallHoles => 'Отвори в стіні';

  @override
  String get ssDarkOnly =>
      'Це пресет темної теми.\nВін встановить режим теми на темний і оновить цю тему.\n\nПродовжити?';

  @override
  String get ssLightOnly =>
      'Це пресет світлої теми.\nВін встановить режим теми на світлий і оновить цю тему.\n\nПродовжити?';

  @override
  String ssApplied(Object config) {
    return '$config застосовано.';
  }

  @override
  String get ssTryMe => 'Спробуй';

  @override
  String get ssRandom => 'Випадково';

  @override
  String ssRandomize(Object themeType) {
    return 'Рандомізувати $themeType тему?';
  }

  @override
  String get ssConfigTip => 'Зберегти/завантажити конфігурацію';

  @override
  String get ssSaveConfig => 'Зберегти конфігурацію';

  @override
  String ssConfigSaved(Object path) {
    return 'Вашу конфігурацію збережено в $path';
  }

  @override
  String get ssWrongConfigExt => 'Файл не був збережений як ';

  @override
  String get ssLoadConfig => 'Завантажити конфігурацію';

  @override
  String get ssResetAll => 'Скинути всі налаштування?';

  @override
  String get ssResetAppearance =>
      'Скинути всі налаштування зовнішнього вигляду?';

  @override
  String get ssResetBoth => 'Скинути обидва режими теми';

  @override
  String get csPageTitle => 'Налаштування кольору';

  @override
  String get csSchemeBase => 'Створити схему\nіз зображення';

  @override
  String get csFromImage => 'Колірна схема буде згенерована із зображення.';

  @override
  String get csMonoChrome => 'Використовувати монохромну схему';

  @override
  String get csHighContrast => 'Використовувати схему з високим контрастом';

  @override
  String get csPrimary => 'Основний';

  @override
  String get csPrimaryContainer => 'Основний\nконтур';

  @override
  String get csSecondary => 'Вторинний';

  @override
  String get csSecondaryContainer => 'Вторинний\nконтур';

  @override
  String get csTertiary => 'Третинний';

  @override
  String get csTertiaryContainer => 'Третинний\nконтур';

  @override
  String get csError => 'Помилка';

  @override
  String get csErrorContainer => 'Контур\nпомилки';

  @override
  String get csOutline => 'Текст\nпідказки';

  @override
  String get csOutlineVariant => 'Контур\nпідказки';

  @override
  String get csSurface => 'Фон\nкнопки';

  @override
  String get csSurfaceDim => 'Фон сповіщень\nта панелі';

  @override
  String get csSurfaceContainer => 'Фон сторінки\nта модального вікна';

  @override
  String get csOnSurface => 'Текст';

  @override
  String get csScrim => 'Покриття\nмодального вікна';

  @override
  String get csShadow => 'Тінь';

  @override
  String get csSurfaceTint => 'Відтінок\nповерхні';

  @override
  String get csPickerTitle => 'Виберіть колір';

  @override
  String get csPickerHint =>
      'Відкрити палітру кольорів. Довге натискання для додаткових параметрів.';

  @override
  String get csRecommended => 'Використовувати рекомендацію щодо контрасту?';

  @override
  String get csUseCustom => 'Використовувати власний';

  @override
  String get csCurrVal => 'Поточне значення кольору:';

  @override
  String csReset(Object themeType) {
    return 'Скинути $themeType кольори?';
  }

  @override
  String get csColorScheme => 'колірна схема';

  @override
  String get dsPageTitle => 'Налаштування дизайну';

  @override
  String get dsButton => 'Кнопка';

  @override
  String get dsPage => 'Сторінка';

  @override
  String get dsNone => 'Жоден';

  @override
  String get dsSystem => 'Системний';

  @override
  String get dsPadding => 'Відступи';

  @override
  String get dsStyle => 'Стиль';

  @override
  String get dsBorderWidth => 'Ширина межі';

  @override
  String get dsPill => 'Таблетка';

  @override
  String get dsRectangle => 'Прямокутник';

  @override
  String get dsRoundRectangle => 'Округлений прямокутник';

  @override
  String get dsLeftGram => 'Ліва паралель';

  @override
  String get dsRightGram => 'Права паралель';

  @override
  String get dsGem => 'Самоцвіт';

  @override
  String get dsJewel => 'Дорогоцінний камінь';

  @override
  String get dsAlwaysUnderline => 'Завжди підкреслювати посилання';

  @override
  String get dsShowBack => 'Показувати кнопку \'Назад\'';

  @override
  String get dsMargin => 'Зовнішні поля';

  @override
  String get dsSpacing => 'Інтервал';

  @override
  String get dsPageTransition => 'Перехід між сторінками';

  @override
  String get dsTurnX => 'Горизонтальний поворот';

  @override
  String get dsTurnY => 'Вертикальний поворот';

  @override
  String get dsRotate => 'Обертання';

  @override
  String get dsSlideX => 'Горизонтальне ковзання';

  @override
  String get dsSlideY => 'Вертикальне ковзання';

  @override
  String get dsZoom => 'Масштабування';

  @override
  String get dsFadeTransition => 'Перехід згасанням';

  @override
  String get dsAnimStyle => 'Стиль анімації';

  @override
  String get dsPlay => 'Відтворити анімацію';

  @override
  String get dsMilliseconds => 'Мілісекунди';

  @override
  String get dsCurve => 'Крива';

  @override
  String get dsBounce => 'Відскок';

  @override
  String get dsEase => 'Плавність';

  @override
  String get dsElastic => 'Еластичність';

  @override
  String get dsLinear => 'Лінійна';

  @override
  String get dsBackgroundImg => 'Фонове зображення';

  @override
  String dsImgSettingHint(Object title) {
    return 'Оновити $title зображення';
  }

  @override
  String get dsReFit => 'Підігнати знову';

  @override
  String get dsFromFile => 'З файлу';

  @override
  String get dsFromCamera => 'З камери';

  @override
  String get dsFromNetwork => 'З URL-адреси';

  @override
  String get dsSolidColor => 'Суцільний колір';

  @override
  String get dsResetIt => 'Скинути';

  @override
  String get dsClearIt => 'Очистити';

  @override
  String get dsUseForColors =>
      'Оновити кольори програми за допомогою цього зображення';

  @override
  String get dsImgGetFailed => 'Не вдалося отримати зображення';

  @override
  String get dsImgSetFailed => 'Не вдалося оновити зображення';

  @override
  String get dsImgPermission =>
      'Деякі сайти не дозволяють іншим отримувати доступ до їхніх зображень.\nСпробуйте зображення з іншого хосту.';

  @override
  String get dsUseFull => 'Використати повне зображення?';

  @override
  String get dsFit => 'Як воно має вміщуватися?';

  @override
  String get dsCrop => 'Обрізати';

  @override
  String get dsNoWeb => 'Редагування зображень не підтримується у веб-версії';

  @override
  String get dsRotateLeft => 'Повернути вліво';

  @override
  String get dsRotateRight => 'Повернути вправо';

  @override
  String get dsShowScroll => 'Показувати смуги прокрутки';

  @override
  String dsResetButton(Object themeType) {
    return 'Скинути дизайн $themeType кнопки?';
  }

  @override
  String dsResetPage(Object themeType) {
    return 'Скинути дизайн $themeType сторінки?';
  }

  @override
  String get tsPageTitle => 'Налаштування тексту';

  @override
  String tsBatchOverride(Object setting) {
    return 'Ви вже внесли детальні зміни \"$setting\" у розширених налаштуваннях.\n\nВи впевнені, що хочете перевизначити ці зміни масовим оновленням?';
  }

  @override
  String get tsTextBackground => 'Непрозорість фону тексту';

  @override
  String get tsIconSize => 'Розмір піктограми';

  @override
  String tsLinkHint(Object style) {
    return 'Активуйте для редагування $style';
  }

  @override
  String get tsDisplay => 'Акцентний текст';

  @override
  String get tsHeadline => 'Заголовок';

  @override
  String get tsTitle => 'Назва';

  @override
  String get tsBody => 'Основний текст';

  @override
  String get tsLabel => 'Мітка';

  @override
  String get tsFontFamily => 'Сімейство шрифтів';

  @override
  String get tsFontSize => 'Розмір шрифту';

  @override
  String get tsBold => 'Жирний';

  @override
  String get tsItalic => 'Курсив';

  @override
  String get tsUnderline => 'Підкреслений';

  @override
  String get tsLetterSpacing => 'Міжлітерний інтервал';

  @override
  String get tsWordSpacing => 'Міжслівний інтервал';

  @override
  String get tsLineHeight => 'Висота рядка';

  @override
  String get tsDisplayP1 => 'Чи цей ';

  @override
  String get tsDisplayLink => 'акцентний текст';

  @override
  String get tsDisplayP2 => ' виглядає добре?';

  @override
  String get tsHeadlineP1 => 'Чи ';

  @override
  String get tsHeadlineLink => 'заголовки';

  @override
  String get tsHeadlineP2 => ' відрізняються...';

  @override
  String get tsTitleP1 => 'від ';

  @override
  String get tsTitleLink => 'назв?';

  @override
  String get tsBodyP1 => 'А як щодо ';

  @override
  String get tsBodyLink => 'основного тексту?';

  @override
  String get tsBodyP2 => ' Чи легко його читати?';

  @override
  String get tsLabelP1 => 'А ';

  @override
  String get tsLabelLink => 'мітки?';

  @override
  String get tsLabelP2 => ' Не занадто великі, не занадто малі?';

  @override
  String tsReset(Object themeType) {
    return 'Скинути стилі $themeType тексту?';
  }
}
