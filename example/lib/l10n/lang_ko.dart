// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class LangKo extends Lang {
  LangKo([String locale = 'ko']) : super(locale);

  @override
  String get csPageTitle => '빌더';

  @override
  String get csAppName => '앱 이름';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => '최고의 앱';

  @override
  String get csBecomes => '변경됨';

  @override
  String get csInvalidName => '소문자, 숫자, 밑줄(_)만 허용됩니다.';

  @override
  String get csYourApp => '내 앱';

  @override
  String get csPubName => '게시자 이름';

  @override
  String get csPubPreview => '예시 조직';

  @override
  String get csPubTip => '또는 예시 담당자';

  @override
  String get csDescription => '설명';

  @override
  String get csDescPreview => '앱에 대한 한두 문장의 설명입니다.';

  @override
  String get csDomainName => '도메인 이름';

  @override
  String get csDomainTip => '역순으로는 다음과 같습니다';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' 형식만 가능합니다. 정규식: RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String get csInclude => '포함';

  @override
  String get csEasy => '나중에 쉽게 변경 가능';

  @override
  String csGenApp(Object app_name) {
    return '$app_name을(를) 생성할 때, 현재 ';
  }

  @override
  String get csTheApp => '앱';

  @override
  String get csTheConfig => '구성';

  @override
  String csSetColors(Object app_name) {
    return ' (이미지 제외)이(가) $app_name의 기본 구성이 됩니다.\n\n사용자 지정 색상표를 설정하는 것을 권장합니다. 설정에 도움이 필요하시다면 다음에서 시작해 보세요. ';
  }

  @override
  String get csHere => '여기.';

  @override
  String get csHereHint => '온라인 색상표 빌더 열기';

  @override
  String get csFileBrowser => '파일 탐색기 열기';

  @override
  String get csFlutterPath => 'Flutter 경로';

  @override
  String get csNoSpaces => '경로에는 공백이 포함될 수 없습니다';

  @override
  String get csNotInstalled => '설치되지 않았나요?';

  @override
  String get csPathRequired => '경로가 필요합니다. 루트 폴더는 사용할 수 없습니다.';

  @override
  String get csBadPath => '잘못된 경로';

  @override
  String get csAdvanced => '고급 설정';

  @override
  String csRestore(Object setting) {
    return '$setting 복원';
  }

  @override
  String get csOutputPath => '출력 경로';

  @override
  String get csCopyright => '저작권 고지';

  @override
  String get csCopyrightTip => '모든 Dart 파일의 상단에 포함됩니다';

  @override
  String get csLicenseDocs => '오픈소스 라이선스에 대한 문서 열기';

  @override
  String get csL10nTip => '현지화(번역) 구성';

  @override
  String get csLintTip => 'Lint 규칙';

  @override
  String get csLaunchTip => 'VS Code의 디버그 메뉴에 실행 옵션 추가';

  @override
  String get csGenerate => '앱 생성';

  @override
  String get csInvalidFields => '일부 필드가 잘못되었습니다';

  @override
  String get csRequired => '모든 필드는 필수 항목입니다';

  @override
  String get csResetHint => '초기화할 항목을 활성화하고 확인하세요.';

  @override
  String get csResetBuilder => '빌더 값';

  @override
  String get csResetApp => '앱 설정';

  @override
  String get csResetBoth => '둘 다';

  @override
  String get csResetNothing => '없음';

  @override
  String get asPageTitle => '아카이버';

  @override
  String get asUseIt => '\n\n다음에 사용하세요: ';

  @override
  String asToGen(Object app_name) {
    return ' 데스크톱용을 사용하여 $app_name의 코드를 생성합니다';
  }

  @override
  String get gsPageTitle => '생성기';

  @override
  String get gsConsole => '콘솔 출력';

  @override
  String get gsIsReadyIn => '준비 완료:';

  @override
  String get gsFirstRun => '첫 실행은 일반적으로 시간이 조금 걸립니다';

  @override
  String get gsNeedPermission =>
      'Open UI에 전체 디스크 접근 권한이 필요합니다.\n\n다음으로 이동하여...\n시스템 설정 > 개인정보 보호 및 보안 > 전체 디스크 접근 권한 > Open UI 활성화; 후 다시 시도해 주세요.';

  @override
  String get gsSeeNBelieve => 'Open UI가 수행하는 작업을 확인하려면 다음으로 이동하세요. ';

  @override
  String get gsSeeNBelieveHint => 'Open UI의 코드 생성 코드를 엽니다.';

  @override
  String get gsNotInstalled => 'Flutter가 설치되지 않았습니다';

  @override
  String get gsPartialSuccess => '코드가 성공적으로 생성되었지만 일부 프로젝트 설정에 실패했습니다.';

  @override
  String get rsWouldYou => '다음 작업을 하시겠습니까...';

  @override
  String get rsInstall => '설치하기';

  @override
  String get rsInstallHint => 'Flutter 설치 가이드 열기';

  @override
  String get rsRun => '실행하기';

  @override
  String get rsWipe => '초기화하기';

  @override
  String get rsNextTime => '성공입니다! 다음번에도 행운을 빕니다!';

  @override
  String get rsAnotherOne => '또 실패했습니다. 직접 확인해 보시는 것이 좋겠습니다...';

  @override
  String get rsLeave => '그대로 두기';
}
