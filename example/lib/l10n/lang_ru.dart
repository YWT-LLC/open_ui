// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class LangRu extends Lang {
  LangRu([String locale = 'ru']) : super(locale);

  @override
  String get csPageTitle => 'Конструктор';

  @override
  String get csAppName => 'Название приложения';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => 'Лучшее приложение';

  @override
  String get csBecomes => 'становится';

  @override
  String get csInvalidName =>
      'Разрешены строчные буквы, цифры и подчеркивания.';

  @override
  String get csYourApp => 'ваше приложение';

  @override
  String get csPubName => 'Имя издателя';

  @override
  String get csPubPreview => 'Пример Организации';

  @override
  String get csPubTip => 'Или имя разработчика';

  @override
  String get csDescription => 'Описание';

  @override
  String get csDescPreview => 'Одно или два предложения о вашем приложении.';

  @override
  String get csDomainName => 'Доменное имя';

  @override
  String get csDomainTip => 'В обратном порядке это';

  @override
  String get csInvalidDomain =>
      'Только \'domain.name\'; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String csGenApp(Object app_name) {
    return 'При генерации $app_name, текущий ';
  }

  @override
  String get csTheApp => 'приложение';

  @override
  String get csTheConfig => 'конфигурация';

  @override
  String csSetColors(Object app_name) {
    return ' (кроме изображений) станет конфигурацией по умолчанию для $app_name.\n\nРекомендуется настроить пользовательскую цветовую схему. Если вам нужна помощь в ее создании, попробуйте начать ';
  }

  @override
  String get csHere => 'здесь.';

  @override
  String get csHereHint => 'Открыть онлайн-конструктор цветовых схем';

  @override
  String get csFileBrowser => 'Открыть файловый менеджер';

  @override
  String get csFlutterPath => 'Путь к Flutter';

  @override
  String get csNoSpaces => 'В пути не должно быть пробелов';

  @override
  String get csNotInstalled => 'Не установлено?';

  @override
  String get csPathRequired =>
      'Требуется путь. Нельзя использовать корневую папку.';

  @override
  String get csBadPath => 'Неверный путь';

  @override
  String get csAdvanced => 'Дополнительные настройки';

  @override
  String csRestore(Object setting) {
    return 'Восстановить $setting';
  }

  @override
  String get csOutputPath => 'Путь вывода';

  @override
  String get csCopyright => 'Уведомление об авторских правах';

  @override
  String get csCopyrightTip => 'Будет включено в начало каждого файла Dart';

  @override
  String get csLicenseDocs =>
      'Открыть документацию по лицензиям открытого исходного кода';

  @override
  String get csL10nTip => 'Конфигурация локализации (переводов)';

  @override
  String get csLintTip => 'Правила линтинга';

  @override
  String get csLaunchTip =>
      'Добавляет параметры запуска в меню отладки VS Code';

  @override
  String get csGenerate => 'Сгенерировать приложение';

  @override
  String get csInvalidFields => 'Некоторые поля заполнены неверно';

  @override
  String get csRequired => 'Все поля обязательны для заполнения';

  @override
  String get csResetHint => 'Активируйте и подтвердите, что следует сбросить.';

  @override
  String get csResetBuilder => 'Значения конструктора';

  @override
  String get csResetApp => 'Настройки приложения';

  @override
  String get csResetBoth => 'И то, и другое';

  @override
  String get csResetNothing => 'Ничего';

  @override
  String get asPageTitle => 'Архиватор';

  @override
  String get asUseIt => '\n\nИспользуйте это на ';

  @override
  String asToGen(Object app_name) {
    return ' для ПК, чтобы сгенерировать код для $app_name';
  }

  @override
  String get gsPageTitle => 'Генератор';

  @override
  String get gsConsole => 'Вывод консоли';

  @override
  String get gsIsReadyIn => 'готово через';

  @override
  String get gsNeedPermission =>
      'Open UI требуется полный доступ к диску.\n\nПожалуйста, перейдите в...\nСистемные настройки > Конфиденциальность и безопасность > Полный доступ к диску > Включить Open UI; затем повторите попытку.';

  @override
  String get gsSeeNBelieve =>
      'Если вы хотите проверить, что делает Open UI, перейдите ';

  @override
  String get gsSeeNBelieveHint => 'Откройте код генерации кода Open UI.';

  @override
  String get gsNotInstalled => 'Flutter не установлен';

  @override
  String get gsPartialSuccess =>
      'Код был успешно сгенерирован, но некоторые настройки проекта не удались.';

  @override
  String get rsWouldYou => 'вы бы хотели...';

  @override
  String get rsInstall => 'Установить';

  @override
  String get rsInstallHint => 'Открыть руководство по установке Flutter';

  @override
  String get rsRun => 'Запустить';

  @override
  String get rsWipe => 'Стереть';

  @override
  String get rsNextTime => 'Успех, скрестим пальцы на следующий раз!';

  @override
  String get rsAnotherOne =>
      'Очередная неудача; вам, вероятно, стоит взять все в свои руки...';

  @override
  String get rsLeave => 'Оставить';
}
