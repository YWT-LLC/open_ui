// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class LangHi extends Lang {
  LangHi([String locale = 'hi']) : super(locale);

  @override
  String get csPageTitle => 'बिल्डर';

  @override
  String get csAppName => 'ऐप का नाम';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => 'अब तक का सबसे अच्छा ऐप';

  @override
  String get csBecomes => 'बन जाता है';

  @override
  String get csInvalidName =>
      'लोअरकेस अक्षर, संख्याएं और अंडरस्कोर की अनुमति है।';

  @override
  String get csYourApp => 'आपका ऐप';

  @override
  String get csPubName => 'प्रकाशक का नाम';

  @override
  String get csPubPreview => 'उदाहरण संगठन';

  @override
  String get csPubTip => 'या, उदाहरण व्यक्ति';

  @override
  String get csDescription => 'विवरण';

  @override
  String get csDescPreview => 'आपके ऐप के बारे में एक या दो वाक्य।';

  @override
  String get csDomainName => 'डोमेन नाम';

  @override
  String get csDomainTip => 'उल्टे क्रम में, यह है';

  @override
  String get csInvalidDomain =>
      'केवल \'domain.name\'; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String csGenApp(Object app_name) {
    return 'जब आप $app_name जनरेट करते हैं, तो वर्तमान ';
  }

  @override
  String get csTheApp => 'ऐप';

  @override
  String get csTheConfig => 'कॉन्फ़िगरेशन';

  @override
  String csSetColors(Object app_name) {
    return ' (छवियों को छोड़कर) $app_name के लिए डिफ़ॉल्ट कॉन्फ़िगरेशन बन जाएगा।\n\nएक कस्टम रंग योजना सेट करना आवश्यक है। यदि आपको इसे बनाने में सहायता चाहिए, तो यहां से शुरू करने का प्रयास करें ';
  }

  @override
  String get csHere => 'यहां।';

  @override
  String get csHereHint => 'एक ऑनलाइन कलर स्कीम बिल्डर खोलें';

  @override
  String get csFileBrowser => 'फ़ाइल ब्राउज़र खोलें';

  @override
  String get csFlutterPath => 'फ़्लटर (Flutter) पथ';

  @override
  String get csNoSpaces => 'पथ में रिक्त स्थान (spaces) नहीं हो सकते';

  @override
  String get csNotInstalled => 'इंस्टॉल नहीं है?';

  @override
  String get csPathRequired =>
      'पथ आवश्यक है। रूट फ़ोल्डर का उपयोग नहीं किया जा सकता।';

  @override
  String get csBadPath => 'अमान्य पथ';

  @override
  String get csAdvanced => 'उन्नत सेटिंग्स';

  @override
  String csRestore(Object setting) {
    return '$setting को पुनर्स्थापित करें';
  }

  @override
  String get csOutputPath => 'आउटपुट पथ';

  @override
  String get csCopyright => 'कॉपीराइट नोटिस';

  @override
  String get csCopyrightTip =>
      'प्रत्येक Dart फ़ाइल के शीर्ष पर शामिल किया जाएगा';

  @override
  String get csLicenseDocs => 'ओपन सोर्स लाइसेंस पर दस्तावेज़ खोलें';

  @override
  String get csL10nTip => 'स्थानीयकरण (अर्थात अनुवाद) कॉन्फ़िगरेशन';

  @override
  String get csLintTip => 'लिंट (Lint) नियम';

  @override
  String get csLaunchTip => 'VS Code के डीबग मेनू में लॉन्च विकल्प जोड़ता है';

  @override
  String get csGenerate => 'ऐप जनरेट करें';

  @override
  String get csInvalidFields => 'कुछ फ़ील्ड अमान्य हैं';

  @override
  String get csRequired => 'सभी फ़ील्ड आवश्यक हैं';

  @override
  String get csResetHint =>
      'सक्रिय करें और पुष्टि करें कि क्या रीसेट किया जाना चाहिए।';

  @override
  String get csResetBuilder => 'बिल्डर मान';

  @override
  String get csResetApp => 'ऐप सेटिंग्स';

  @override
  String get csResetBoth => 'दोनों';

  @override
  String get csResetNothing => 'कुछ नहीं';

  @override
  String get asPageTitle => 'आर्काइवर';

  @override
  String get asUseIt => '\n\nइसका उपयोग ';

  @override
  String asToGen(Object app_name) {
    return ' पर डेस्कटॉप के लिए करें ताकि $app_name के लिए कोड जनरेट किया जा सके';
  }

  @override
  String get gsPageTitle => 'जनरेटर';

  @override
  String get gsConsole => 'कंसोल आउटपुट';

  @override
  String get gsIsReadyIn => 'में तैयार है';

  @override
  String get gsNeedPermission =>
      'Open UI को पूर्ण डिस्क एक्सेस (Full Disk Access) की आवश्यकता है।\n\nकृपया यहां जाएं...\nसिस्टम सेटिंग्स > गोपनीयता और सुरक्षा > पूर्ण डिस्क एक्सेस > Open UI सक्षम करें; फिर पुनः प्रयास करें।';

  @override
  String get gsSeeNBelieve =>
      'यदि आप सत्यापित करना चाहते हैं कि Open UI क्या करता है, तो जाएं ';

  @override
  String get gsSeeNBelieveHint => 'Open UI का कोड जनरेशन कोड खोलें।';

  @override
  String get gsNotInstalled => 'फ़्लटर (Flutter) इंस्टॉल नहीं है';

  @override
  String get gsPartialSuccess =>
      'कोड सफलतापूर्वक जनरेट हो गया था, लेकिन प्रोजेक्ट का कुछ सेटअप विफल रहा।';

  @override
  String get rsWouldYou => 'क्या आप चाहेंगे कि...';

  @override
  String get rsInstall => 'इसे इंस्टॉल करें';

  @override
  String get rsInstallHint => 'फ़्लटर (Flutter) की इंस्टॉलेशन गाइड खोलें';

  @override
  String get rsRun => 'इसे चलाएं';

  @override
  String get rsWipe => 'इसे मिटाएं';

  @override
  String get rsNextTime => 'सफलता, अगली बार के लिए शुभकामनाएँ!';

  @override
  String get rsAnotherOne =>
      'एक और विफलता; संभवतः अब आपको कमान संभाल लेनी चाहिए...';

  @override
  String get rsLeave => 'इसे छोड़ दें';
}
