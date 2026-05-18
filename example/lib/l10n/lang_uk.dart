// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class LangUk extends Lang {
  LangUk([String locale = 'uk']) : super(locale);

  @override
  String get csPageTitle => 'Конструктор';

  @override
  String get csAppName => 'Назва застосунку';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => 'Найкращий застосунок';

  @override
  String get csBecomes => 'стає';

  @override
  String get csInvalidName =>
      'Дозволені лише малі літери, цифри та нижні підкреслення.';

  @override
  String get csYourApp => 'ваш застосунок';

  @override
  String get csPubName => 'Назва видавця';

  @override
  String get csPubPreview => 'Приклад Організації';

  @override
  String get csPubTip => 'Або ім\'я особи';

  @override
  String get csDescription => 'Опис';

  @override
  String get csDescPreview => 'Одне або два речення про ваш застосунок.';

  @override
  String get csDomainName => 'Доменне ім\'я';

  @override
  String get csDomainTip => 'У зворотному порядку це';

  @override
  String get csInvalidDomain =>
      'Лише \'domain.name\'; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String get csInclude => 'Включити';

  @override
  String get csEasy => 'Легко змінити пізніше';

  @override
  String csGenApp(Object app_name) {
    return 'Коли ви генеруєте $app_name, поточний ';
  }

  @override
  String get csTheApp => 'застосунок';

  @override
  String get csTheConfig => 'конфігурація';

  @override
  String csSetColors(Object app_name) {
    return ' (окрім зображень) стане конфігурацією за замовчуванням для $app_name.\n\nРекомендується встановити власну колірну схему. Якщо вам потрібна допомога у її створенні, спробуйте почати ';
  }

  @override
  String get csHere => 'тут.';

  @override
  String get csHereHint => 'Відкрити онлайн-конструктор колірних схем';

  @override
  String get csFileBrowser => 'Відкрити файловий менеджер';

  @override
  String get csFlutterPath => 'Шлях до Flutter';

  @override
  String get csNoSpaces => 'Шлях не може містити пробілів';

  @override
  String get csNotInstalled => 'Не встановлено?';

  @override
  String get csPathRequired =>
      'Потрібно вказати шлях. Не можна використовувати кореневу папку.';

  @override
  String get csBadPath => 'Недійсний шлях';

  @override
  String get csAdvanced => 'Розширені налаштування';

  @override
  String csRestore(Object setting) {
    return 'Відновити $setting';
  }

  @override
  String get csOutputPath => 'Шлях виводу';

  @override
  String get csCopyright => 'Повідомлення про авторські права';

  @override
  String get csCopyrightTip => 'Буде додано на початку кожного файлу Dart';

  @override
  String get csLicenseDocs =>
      'Відкрити документацію щодо ліцензій з відкритим кодом';

  @override
  String get csL10nTip => 'Конфігурація локалізації (перекладів)';

  @override
  String get csLintTip => 'Правила лінтера';

  @override
  String get csLaunchTip =>
      'Додає параметри запуску до меню налагодження VS Code';

  @override
  String get csGenerate => 'Згенерувати застосунок';

  @override
  String get csInvalidFields => 'Деякі поля недійсні';

  @override
  String get csRequired => 'Усі поля обов\'язкові';

  @override
  String get csResetHint =>
      'Активуйте та підтвердіть, що саме потрібно скинути.';

  @override
  String get csResetBuilder => 'Значення конструктора';

  @override
  String get csResetApp => 'Налаштування застосунку';

  @override
  String get csResetBoth => 'Обидва';

  @override
  String get csResetNothing => 'Нічого';

  @override
  String get asPageTitle => 'Архіватор';

  @override
  String get asUseIt => '\n\nВикористовуйте це на ';

  @override
  String asToGen(Object app_name) {
    return ' для десктопу, щоб згенерувати код для $app_name';
  }

  @override
  String get gsPageTitle => 'Генератор';

  @override
  String get gsConsole => 'Вивід консолі';

  @override
  String get gsIsReadyIn => 'готово за';

  @override
  String get gsFirstRun => 'Перший запуск зазвичай займає деякий час';

  @override
  String get gsNeedPermission =>
      'Open UI потребує повного доступу до диска.\n\nБудь ласка, перейдіть до...\nСистемні параметри > Приватність і безпека > Повний доступ до диска > Увімкніть Open UI; потім спробуйте ще раз.';

  @override
  String get gsSeeNBelieve =>
      'Якщо ви хочете перевірити, що робить Open UI, перейдіть ';

  @override
  String get gsSeeNBelieveHint => 'Відкрити код генерації коду Open UI.';

  @override
  String get gsNotInstalled => 'Flutter не встановлено';

  @override
  String get gsPartialSuccess =>
      'Код було успішно згенерувано, але деякі налаштування проєкту не вдалися.';

  @override
  String get rsWouldYou => 'чи бажаєте ви...';

  @override
  String get rsInstall => 'Встановити';

  @override
  String get rsInstallHint => 'Відкрити посібник зі встановлення Flutter';

  @override
  String get rsRun => 'Запустити';

  @override
  String get rsWipe => 'Стерти';

  @override
  String get rsNextTime => 'Успіх, тримаємо кулаки на наступний раз!';

  @override
  String get rsAnotherOne =>
      'Чергова невдача; мабуть, вам варто взяти це на себе...';

  @override
  String get rsLeave => 'Залишити';
}
