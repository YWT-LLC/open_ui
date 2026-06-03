// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class EFUILangRu extends EFUILang {
  EFUILangRu([String locale = 'ru']) : super(locale);

  @override
  String get gApply => 'Применить';

  @override
  String get gApplyChanges => 'Применить изменения';

  @override
  String get gContinue => 'Продолжить';

  @override
  String get gOpen => 'Открыть';

  @override
  String get gOpenLink => 'Открыть ссылку';

  @override
  String get gSkip => 'Пропустить';

  @override
  String get gSuccess => 'Успешно';

  @override
  String get gSuccessExl => 'Успешно!';

  @override
  String get gYes => 'Да';

  @override
  String get gAnd => 'и';

  @override
  String get gHelp => 'Справка';

  @override
  String get gNA => 'Н/Д';

  @override
  String get gNAHint => 'Неприменимо';

  @override
  String get gOptional => 'необязательно';

  @override
  String get gOptions => 'Параметры';

  @override
  String get gRequired => 'Обязательно';

  @override
  String get gThe => 'Этот';

  @override
  String get gBack => 'Назад';

  @override
  String get gCancel => 'Отмена';

  @override
  String get gClose => 'Закрыть';

  @override
  String get gDisabled => 'Отключено';

  @override
  String get gError => 'Ошибка';

  @override
  String get gFailure => 'Сбой';

  @override
  String get gNo => 'Нет';

  @override
  String get gRedo => 'Повторить';

  @override
  String get gUndo => 'Отменить';

  @override
  String get gSettings => 'Настройки';

  @override
  String get gGlobal => 'Глобальные';

  @override
  String get gColor => 'Цвет';

  @override
  String get gDesign => 'Дизайн';

  @override
  String get gLayout => 'Макет';

  @override
  String get gText => 'Текст';

  @override
  String get gDark => 'Темная';

  @override
  String get gLight => 'Светлая';

  @override
  String get gSystem => 'Системная';

  @override
  String get gEditing => 'Редактирование: ';

  @override
  String get gEditingHint => 'Активируйте для редактирования';

  @override
  String get gDarkTheme => 'Темная тема';

  @override
  String get gLightTheme => 'Светлая тема';

  @override
  String get gBothThemes => 'Обе темы';

  @override
  String get gLeft => 'Слева';

  @override
  String get gRight => 'Справа';

  @override
  String get gAdvanced => 'Расширенные';

  @override
  String get gQuick => 'Быстрые';

  @override
  String get gDecrease => 'Уменьшить';

  @override
  String get gIncrease => 'Увеличить';

  @override
  String get gMaximum => 'Максимум';

  @override
  String get gMinimum => 'Минимум';

  @override
  String get gCenterReset => 'Удерживайте центр для сброса';

  @override
  String get gLoadingAnim =>
      'Загрузка. Логотип Empathetic анимирован в виде вращающихся песочных часов.';

  @override
  String get gPlay => 'Воспроизвести';

  @override
  String get gPause => 'Пауза';

  @override
  String get gReplay => 'Повторить';

  @override
  String get gMute => 'Выключить звук';

  @override
  String get gUnMute => 'Включить звук';

  @override
  String get gPlaybackSpeed => 'Скорость воспроизведения';

  @override
  String get gCaptions => 'Субтитры';

  @override
  String get gCaptionsHint => 'Удерживайте для выбора шрифтов';

  @override
  String get gFullscreen => 'Во весь экран';

  @override
  String get gMachineTranslated => 'Машинный перевод';

  @override
  String get gUpdates => 'Доступны обновления';

  @override
  String get gHardRefresh =>
      'Пожалуйста, выполните жесткую перезагрузку страницы...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac =>
      'Пожалуйста, выполните жесткую перезагрузку страницы...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile =>
      'Пожалуйста, обновите страницу в меню браузера.';

  @override
  String get gEnterURL => 'Введите URL';

  @override
  String get gValidURL => 'Пожалуйста, введите корректный URL';

  @override
  String get g404Wonder => 'Не все те, кто блуждают, потеряны.';

  @override
  String get g404 => 'Но в данном случае: страница 404 не найдена.';

  @override
  String get g404Note =>
      'Примечание: Flutter web использует хэш-маршрутизацию, например...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => 'Открытый исходный код';

  @override
  String get gOpenEmpathetech => 'Открыть ссылку на Empathetic LLC';

  @override
  String get gEFUISourceHint => 'Открыть страницу GitHub для EFUI';

  @override
  String get gOpenUIReleases => 'Открыть страницу релизов для Open UI';

  @override
  String get gSupportEmail => 'Наш Email поддержки';

  @override
  String gClipboard(Object thing) {
    return '$thing скопировано в буфер обмена.';
  }

  @override
  String get gAttention => 'Внимание';

  @override
  String get gCurrently => 'В настоящее время:';

  @override
  String gSetToValue(Object name, Object value) {
    return 'Для $name установлено значение $value';
  }

  @override
  String get gRemove => 'Удалить';

  @override
  String get gReset => 'Сбросить';

  @override
  String get gResetTo => 'Сбросить:';

  @override
  String gResetValue(Object name) {
    return 'Сбросить $name?';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return 'Сбросить $name до $value';
  }

  @override
  String get gResetAll => 'Сбросить все';

  @override
  String get gUndoWarn1 => 'Не может быть отменено автоматически.\n';

  @override
  String get gSave => 'Сохранить';

  @override
  String get gSaveHint =>
      'Активируйте, чтобы сохранить файл конфигурации JSON.';

  @override
  String get gSwitchHint => 'Переключить';

  @override
  String get gUndoWarn2 =>
      ' вашу текущую конфигурацию, чтобы восстановить ее вручную.';

  @override
  String get gValue => 'Значение';

  @override
  String get gSource => 'Источник:';

  @override
  String get gCreator => 'Создатель';

  @override
  String get gMadeBy => 'Сделано';

  @override
  String get gYou => 'Установлено вами';

  @override
  String get ssNavHint => 'Открыть страницу настроек';

  @override
  String get ssRestartReminder =>
      'Закройте и снова откройте приложение, чтобы применить изменения.';

  @override
  String get ssRestartReminderWeb =>
      'Перезагрузите/обновите страницу, чтобы применить изменения.';

  @override
  String get ssHaveFun => 'Удачного использования!';

  @override
  String get ssDominantHand => 'Ведущая рука';

  @override
  String get ssThemeMode => 'Режим темы';

  @override
  String get ssLanguage => 'Язык';

  @override
  String get ssLangHint => 'Активируйте для изменения языка приложения';

  @override
  String get ssUpdateDark => 'Обновить темную тему';

  @override
  String get ssUpdateLight => 'Обновить светлую тему';

  @override
  String get ssUpdateBoth => 'Обновить оба режима темы';

  @override
  String get ssLoadPreset => 'Загрузить пресет';

  @override
  String get ssLoadPresetHint => 'Активируйте для показа пресетов';

  @override
  String get ssDewIt => 'Обновить оба/автоподтверждение';

  @override
  String get ssBigButtons => 'Большие кнопки';

  @override
  String get ssHighVisibility => 'Высокая видимость';

  @override
  String get ssChalkboard => 'Классная доска';

  @override
  String get ssNebula => 'Туманность';

  @override
  String get ssWallHoles => 'Дыры в стене';

  @override
  String get ssDarkOnly =>
      'Это пресет темной темы.\nОн установит темный режим темы и обновит эту тему.\n\nПродолжить?';

  @override
  String get ssLightOnly =>
      'Это пресет светлой темы.\nОн установит светлый режим темы и обновит эту тему.\n\nПродолжить?';

  @override
  String ssApplied(Object config) {
    return 'Конфигурация $config применена.';
  }

  @override
  String get ssTryMe => 'Попробуй';

  @override
  String get ssRandom => 'Случайный выбор';

  @override
  String ssRandomize(Object themeType) {
    return 'Случайный выбор для $themeType темы?';
  }

  @override
  String get ssConfigTip => 'Сохранить/загрузить конфигурацию';

  @override
  String get ssSaveConfig => 'Сохранить конфигурацию';

  @override
  String ssConfigSaved(Object path) {
    return 'Ваша конфигурация была сохранена в $path';
  }

  @override
  String get ssWrongConfigExt => 'Файл не был сохранен как ';

  @override
  String get ssLoadConfig => 'Загрузить конфигурацию';

  @override
  String get ssResetAll => 'Сбросить все настройки?';

  @override
  String get ssResetAppearance => 'Сбросить все настройки внешнего вида?';

  @override
  String get ssResetBoth => 'Сбросить оба режима темы';

  @override
  String get csPageTitle => 'Настройки цвета';

  @override
  String get csSchemeBase => 'Создать схему\nиз изображения';

  @override
  String get csFromImage =>
      'Цветовая схема будет сгенерирована из изображения.';

  @override
  String get csMonoChrome => 'Использовать монохромную схему';

  @override
  String get csHighContrast => 'Использовать высококонтрастную схему';

  @override
  String get csPrimary => 'Основной';

  @override
  String get csPrimaryContainer => 'Основной\nконтур';

  @override
  String get csSecondary => 'Вторичный';

  @override
  String get csSecondaryContainer => 'Вторичный\nконтур';

  @override
  String get csTertiary => 'Третичный';

  @override
  String get csTertiaryContainer => 'Третичный\nконтур';

  @override
  String get csError => 'Ошибка';

  @override
  String get csErrorContainer => 'Контур\nошибки';

  @override
  String get csOutline => 'Текст\nподсказки';

  @override
  String get csOutlineVariant => 'Контур\nподсказки';

  @override
  String get csSurface => 'Фон\nкнопки';

  @override
  String get csSurfaceDim => 'Фон оповещений\n&& панели';

  @override
  String get csSurfaceContainer => 'Фон страницы\n&& модального окна';

  @override
  String get csOnSurface => 'Текст';

  @override
  String get csScrim => 'Покрытие\nмодального окна';

  @override
  String get csShadow => 'Тень';

  @override
  String get csSurfaceTint => 'Оттенок\nповерхности';

  @override
  String get csPickerTitle => 'Выберите цвет';

  @override
  String get csPickerHint =>
      'Открыть палитру цветов. Долгое нажатие для дополнительных параметров.';

  @override
  String get csRecommended => 'Использовать рекомендованный контраст?';

  @override
  String get csUseCustom => 'Использовать пользовательский';

  @override
  String get csCurrVal => 'Текущее значение цвета:';

  @override
  String csReset(Object themeType) {
    return 'Сбросить $themeType цвета?';
  }

  @override
  String get csColorScheme => 'цветовая схема';

  @override
  String get dsPageTitle => 'Настройки дизайна';

  @override
  String get dsButton => 'Кнопка';

  @override
  String get dsPage => 'Страница';

  @override
  String get dsNone => 'Нет';

  @override
  String get dsSystem => 'Системный';

  @override
  String get dsPadding => 'Внутренний отступ';

  @override
  String get dsStyle => 'Стиль';

  @override
  String get dsBorderWidth => 'Толщина границы';

  @override
  String get dsPill => 'Капсула';

  @override
  String get dsRectangle => 'Прямоугольник';

  @override
  String get dsRoundRectangle => 'Скругленный прямоугольник';

  @override
  String get dsLeftGram => 'Левый параллелограмм';

  @override
  String get dsRightGram => 'Правый параллелограмм';

  @override
  String get dsGem => 'Самоцвет';

  @override
  String get dsJewel => 'Драгоценность';

  @override
  String get dsAlwaysUnderline => 'Всегда подчеркивать ссылки';

  @override
  String get dsShowBack => 'Показывать кнопку \"Назад\"';

  @override
  String get dsMargin => 'Внешний отступ';

  @override
  String get dsSpacing => 'Интервал';

  @override
  String get dsPageTransition => 'Переход между страницами';

  @override
  String get dsTurnX => 'Горизонтальный поворот';

  @override
  String get dsTurnY => 'Вертикальный поворот';

  @override
  String get dsRotate => 'Вращение';

  @override
  String get dsSlideX => 'Горизонтальное скольжение';

  @override
  String get dsSlideY => 'Вертикальное скольжение';

  @override
  String get dsZoom => 'Масштабирование';

  @override
  String get dsFadeTransition => 'Плавное затухание';

  @override
  String get dsAnimStyle => 'Стиль анимации';

  @override
  String get dsPlay => 'Воспроизвести анимацию';

  @override
  String get dsMilliseconds => 'Миллисекунды';

  @override
  String get dsCurve => 'Кривая';

  @override
  String get dsBounce => 'Отскок';

  @override
  String get dsEase => 'Плавность';

  @override
  String get dsElastic => 'Эластичность';

  @override
  String get dsLinear => 'Линейная';

  @override
  String get dsBackgroundImg => 'Фоновое изображение';

  @override
  String dsImgSettingHint(Object title) {
    return 'Обновить изображение: $title';
  }

  @override
  String get dsReFit => 'Подогнать заново';

  @override
  String get dsFromFile => 'Из файла';

  @override
  String get dsFromCamera => 'С камеры';

  @override
  String get dsFromNetwork => 'По URL';

  @override
  String get dsSolidColor => 'Сплошной цвет';

  @override
  String get dsResetIt => 'Сбросить';

  @override
  String get dsClearIt => 'Очистить';

  @override
  String get dsUseForColors =>
      'Обновить цвета приложения с помощью этого изображения';

  @override
  String get dsImgGetFailed => 'Не удалось получить изображение';

  @override
  String get dsImgSetFailed => 'Не удалось обновить изображение';

  @override
  String get dsImgPermission =>
      'Некоторые сайты не разрешают доступ к своим изображениям другим.\nПопробуйте изображение с другого хоста.';

  @override
  String get dsUseFull => 'Использовать полное изображение?';

  @override
  String get dsFit => 'Как оно должно вписываться?';

  @override
  String get dsCrop => 'Обрезать';

  @override
  String get dsNoWeb =>
      'Редактирование изображений не поддерживается в браузере';

  @override
  String get dsRotateLeft => 'Повернуть влево';

  @override
  String get dsRotateRight => 'Повернуть вправо';

  @override
  String get dsShowScroll => 'Показывать полосы прокрутки';

  @override
  String dsResetButton(Object themeType) {
    return 'Сбросить дизайн кнопки для $themeType темы?';
  }

  @override
  String dsResetPage(Object themeType) {
    return 'Сбросить дизайн страницы для $themeType темы?';
  }

  @override
  String get tsPageTitle => 'Настройки текста';

  @override
  String tsBatchOverride(Object setting) {
    return 'Вы уже внесли точечные изменения \"$setting\" в расширенных настройках.\n\nВы уверены, что хотите переопределить эти изменения пакетным обновлением?';
  }

  @override
  String get tsTextBackground => 'Непрозрачность фона текста';

  @override
  String get tsIconSize => 'Размер значка';

  @override
  String tsLinkHint(Object style) {
    return 'Активируйте, чтобы изменить $style';
  }

  @override
  String get tsDisplay => 'Крупный текст';

  @override
  String get tsHeadline => 'Заголовок';

  @override
  String get tsTitle => 'Название';

  @override
  String get tsBody => 'Основной текст';

  @override
  String get tsLabel => 'Метка';

  @override
  String get tsFontFamily => 'Семейство шрифтов';

  @override
  String get tsFontSize => 'Размер шрифта';

  @override
  String get tsBold => 'Жирный';

  @override
  String get tsItalic => 'Курсив';

  @override
  String get tsUnderline => 'Подчеркнутый';

  @override
  String get tsLetterSpacing => 'Межбуквенный интервал';

  @override
  String get tsWordSpacing => 'Межсловный интервал';

  @override
  String get tsLineHeight => 'Высота строки';

  @override
  String get tsDisplayP1 => 'Хорошо ли выглядит этот ';

  @override
  String get tsDisplayLink => 'крупный текст';

  @override
  String get tsDisplayP2 => '?';

  @override
  String get tsHeadlineP1 => 'Отличаются ли ';

  @override
  String get tsHeadlineLink => 'заголовки';

  @override
  String get tsHeadlineP2 => '...';

  @override
  String get tsTitleP1 => 'от ';

  @override
  String get tsTitleLink => 'названий?';

  @override
  String get tsBodyP1 => 'Как насчет ';

  @override
  String get tsBodyLink => 'основного текста?';

  @override
  String get tsBodyP2 => ' Его легко читать?';

  @override
  String get tsLabelP1 => 'А ';

  @override
  String get tsLabelLink => 'метки?';

  @override
  String get tsLabelP2 => ' Не слишком большие, не слишком маленькие?';

  @override
  String tsReset(Object themeType) {
    return 'Сбросить стили текста для $themeType темы?';
  }
}
