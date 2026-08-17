// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'oui_lang.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class OUILangKo extends OUILang {
  OUILangKo([String locale = 'ko']) : super(locale);

  @override
  String get gApply => '적용';

  @override
  String get gApplyChanges => '변경 사항 적용';

  @override
  String get gContinue => '계속';

  @override
  String get gOpen => '열기';

  @override
  String get gOpenLink => '링크 열기';

  @override
  String get gSkip => '건너뛰기';

  @override
  String get gSuccess => '성공';

  @override
  String get gSuccessExl => '성공!';

  @override
  String get gYes => '예';

  @override
  String get gAnd => '및';

  @override
  String get gHelp => '도움말';

  @override
  String get gNA => '해당 없음';

  @override
  String get gNAHint => '해당 없음';

  @override
  String get gOptional => '선택 사항';

  @override
  String get gOptions => '옵션';

  @override
  String get gRequired => '필수';

  @override
  String get gThe => '그';

  @override
  String get gBack => '뒤로';

  @override
  String get gCancel => '취소';

  @override
  String get gClose => '닫기';

  @override
  String get gDisabled => '비활성화됨';

  @override
  String get gError => '오류';

  @override
  String get gFailure => '실패';

  @override
  String get gNo => '아니요';

  @override
  String get gRedo => '다시 실행';

  @override
  String get gUndo => '실행 취소';

  @override
  String get gSettings => '설정';

  @override
  String get gGlobal => '글로벌';

  @override
  String get gColor => '색상';

  @override
  String get gDesign => '디자인';

  @override
  String get gLayout => '레이아웃';

  @override
  String get gText => '텍스트';

  @override
  String get gDark => '다크';

  @override
  String get gLight => '라이트';

  @override
  String get gSystem => '시스템';

  @override
  String get gEditing => '편집 중: ';

  @override
  String get gEditingHint => '편집하려면 활성화하세요';

  @override
  String get gDarkTheme => '다크 테마';

  @override
  String get gLightTheme => '라이트 테마';

  @override
  String get gBothThemes => '두 테마 모두';

  @override
  String get gLeft => '왼쪽';

  @override
  String get gRight => '오른쪽';

  @override
  String get gAdvanced => '고급';

  @override
  String get gQuick => '빠른 설정';

  @override
  String get gDecrease => '감소';

  @override
  String get gIncrease => '증가';

  @override
  String get gMaximum => '최대';

  @override
  String get gMinimum => '최소';

  @override
  String get gCenterReset => '가운데를 길게 누르면 초기화됩니다';

  @override
  String get gLoadingAnim => '로딩 중. YWT 로고가 회전하는 모래시계처럼 애니메이션 처리됩니다.';

  @override
  String get gPlay => '재생';

  @override
  String get gPause => '일시 정지';

  @override
  String get gReplay => '다시 재생';

  @override
  String get gMute => '음소거';

  @override
  String get gUnMute => '음소거 해제';

  @override
  String get gPlaybackSpeed => '재생 속도';

  @override
  String get gFBF => '프레임 단위';

  @override
  String get gCaptions => '자막/캡션';

  @override
  String get gCaptionsHint => '글꼴을 보려면 길게 누르세요';

  @override
  String get gFullscreen => '전체 화면';

  @override
  String get gMachineTranslated => '기계 번역됨';

  @override
  String get gUpdates => '업데이트 가능';

  @override
  String get gHardRefresh => '페이지를 강력 새로고침하세요...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac => '페이지를 강력 새로고침하세요...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile => '브라우저 메뉴에서 페이지를 새로고침하세요.';

  @override
  String get gEnterURL => 'URL 입력';

  @override
  String get gValidURL => '유효한 URL을 입력하세요';

  @override
  String get g404Wonder => '방황하는 모든 이가 길을 잃은 것은 아닙니다.';

  @override
  String get g404 => '하지만 이 경우에는 맞습니다: 404 페이지를 찾을 수 없음.';

  @override
  String get g404Note =>
      '참고: Flutter 웹은 다음과 같은 해시 라우팅을 사용합니다...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => '오픈 소스';

  @override
  String get gOpenYWT => 'YWT LLC 링크 열기';

  @override
  String get gOpenUISourceHint => 'OpenUI용 GitHub 페이지 열기';

  @override
  String get gOpenUIReleases => 'Open UI의 릴리스 페이지 열기';

  @override
  String get gSupportEmail => '고객 지원 이메일';

  @override
  String gClipboard(Object thing) {
    return '$thing이(가) 클립보드에 복사되었습니다.';
  }

  @override
  String get gAttention => '주의';

  @override
  String get gCurrently => '현재:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name이(가) $value(으)로 설정됨';
  }

  @override
  String get gRemove => '제거';

  @override
  String get gReset => '초기화';

  @override
  String get gResetTo => '초기화:';

  @override
  String gResetValue(Object name) {
    return '$name을(를) 초기화하시겠습니까?';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return '$name을(를) $value(으)로 초기화';
  }

  @override
  String get gResetAll => '모두 초기화';

  @override
  String get gUndoWarn1 => '자동으로 실행 취소할 수 없습니다.\n';

  @override
  String get gSave => '저장';

  @override
  String get gSaveHint => 'JSON 구성 파일을 저장하려면 활성화하세요.';

  @override
  String get gSwitchHint => '스위치 켜기/끄기';

  @override
  String get gUndoWarn2 => ' 하여 수동으로 복원할 수 있도록 현재 구성을 저장하세요.';

  @override
  String get gValue => '값';

  @override
  String get gSource => '출처:';

  @override
  String get gCreator => '제작자:';

  @override
  String get gMadeBy => '만든 사람:';

  @override
  String get gYou => '사용자가 설정함';

  @override
  String get ssNavHint => '설정 페이지 열기';

  @override
  String get ssHaveFun => '즐기세요!';

  @override
  String get ssDominantHand => '주로 사용하는 손';

  @override
  String get ssThemeMode => '테마 모드';

  @override
  String get ssLanguage => '언어';

  @override
  String get ssLangHint => '앱 언어를 변경하려면 활성화하세요';

  @override
  String get ssUpdateDark => '다크 테마 업데이트';

  @override
  String get ssUpdateLight => '라이트 테마 업데이트';

  @override
  String get ssUpdateBoth => '두 테마 모드 모두 업데이트';

  @override
  String get ssLoadPreset => '사전 설정 불러오기';

  @override
  String get ssLoadPresetHint => '사전 설정을 보려면 활성화하세요';

  @override
  String get ssDewIt => '둘 다 업데이트/자동 확인';

  @override
  String get ssBigButtons => '큰 버튼';

  @override
  String get ssHighVisibility => '고대비 가시성';

  @override
  String get ssChalkboard => '칠판';

  @override
  String get ssNebula => '성운';

  @override
  String get ssWallHoles => '벽 구멍';

  @override
  String get ssDarkOnly =>
      '다크 테마 사전 설정입니다.\n테마 모드를 다크로 설정하고 해당 테마를 업데이트합니다.\n\n계속하시겠습니까?';

  @override
  String get ssLightOnly =>
      '라이트 테마 사전 설정입니다.\n테마 모드를 라이트로 설정하고 해당 테마를 업데이트합니다.\n\n계속하시겠습니까?';

  @override
  String ssApplied(Object config) {
    return '$config이(가) 적용되었습니다.';
  }

  @override
  String get ssTryMe => '적용해 보기';

  @override
  String get ssRandom => '무작위';

  @override
  String ssRandomize(Object themeType) {
    return '$themeType 테마를 무작위로 하시겠습니까?';
  }

  @override
  String get ssConfigTip => '구성 저장/불러오기';

  @override
  String get ssSaveConfig => '구성 저장';

  @override
  String ssConfigSaved(Object path) {
    return '구성이 $path에 저장되었습니다';
  }

  @override
  String get ssWrongConfigExt => '파일이 다음으로 저장되지 않았습니다: ';

  @override
  String get ssLoadConfig => '구성 불러오기';

  @override
  String get ssImageToo => '배경 이미지도 포함인가요?';

  @override
  String get ssResetAll => '모든 설정을 초기화하시겠습니까?';

  @override
  String get ssResetAppearance => '모든 모양 설정을 초기화하시겠습니까?';

  @override
  String get ssResetBoth => '두 테마 모드 모두 초기화';

  @override
  String get csPageTitle => '색상 설정';

  @override
  String get csSchemeBase => '이미지에서\n구성표 만들기';

  @override
  String get csFromImage => '이미지에서 색상 구성표가 생성됩니다.';

  @override
  String get csMonoChrome => '단색 구성표 사용';

  @override
  String get csHighContrast => '고대비 구성표 사용';

  @override
  String get csPrimary => '기본';

  @override
  String get csPrimaryContainer => '기본\n윤곽선';

  @override
  String get csSecondary => '보조';

  @override
  String get csSecondaryContainer => '보조\n윤곽선';

  @override
  String get csTertiary => '제3의';

  @override
  String get csTertiaryContainer => '제3의\n윤곽선';

  @override
  String get csError => '오류';

  @override
  String get csErrorContainer => '오류\n윤곽선';

  @override
  String get csOutline => '힌트\n텍스트';

  @override
  String get csOutlineVariant => '힌트\n윤곽선';

  @override
  String get csSurface => '버튼\n배경';

  @override
  String get csSurfaceDim => '알림 && 앱 바\n배경';

  @override
  String get csSurfaceContainer => '페이지 && 모달\n배경';

  @override
  String get csOnSurface => '텍스트';

  @override
  String get csScrim => '모달\n커버';

  @override
  String get csShadow => '그림자';

  @override
  String get csSurfaceTint => '표면\n색조';

  @override
  String get csPickerTitle => '색상 선택';

  @override
  String get csPickerHint => '색상 선택기를 엽니다. 더 많은 옵션을 보려면 길게 누르세요.';

  @override
  String get csRecommended => '대비 권장 사항을 사용하시겠습니까?';

  @override
  String get csUseCustom => '사용자 지정 사용';

  @override
  String get csCurrVal => '현재 색상 값:';

  @override
  String csReset(Object themeType) {
    return '$themeType 색상을 초기화하시겠습니까?';
  }

  @override
  String get csColorScheme => '색상 구성표';

  @override
  String get dsPageTitle => '디자인 설정';

  @override
  String get dsButton => '버튼';

  @override
  String get dsPage => '페이지';

  @override
  String get dsNone => '없음';

  @override
  String get dsSystem => '시스템';

  @override
  String get dsPadding => '패딩';

  @override
  String get dsStyle => '스타일';

  @override
  String get dsBorderWidth => '테두리 너비';

  @override
  String get dsPill => '알약 모양';

  @override
  String get dsRectangle => '직사각형';

  @override
  String get dsRoundRectangle => '둥근 직사각형';

  @override
  String get dsLeftGram => '왼쪽 평행';

  @override
  String get dsRightGram => '오른쪽 평행';

  @override
  String get dsGem => '젬';

  @override
  String get dsJewel => '주얼';

  @override
  String get dsAlwaysUnderline => '링크에 항상 밑줄 표시';

  @override
  String get dsShowBack => '뒤로 가기 버튼 표시';

  @override
  String get dsMargin => '여백';

  @override
  String get dsSpacing => '간격';

  @override
  String get dsPageTransition => '페이지 전환';

  @override
  String get dsTurnX => '가로 회전(Turn)';

  @override
  String get dsTurnY => '세로 회전(Turn)';

  @override
  String get dsRotate => '회전(Rotate)';

  @override
  String get dsSlideX => '가로 슬라이드';

  @override
  String get dsSlideY => '세로 슬라이드';

  @override
  String get dsZoom => '확대/축소';

  @override
  String get dsFadeTransition => '페이드 전환';

  @override
  String get dsAnimStyle => '애니메이션 스타일';

  @override
  String get dsPlay => '애니메이션 재생';

  @override
  String get dsMilliseconds => '밀리초';

  @override
  String get dsCurve => '곡선(Curve)';

  @override
  String get dsBounce => '바운스';

  @override
  String get dsEase => '이즈(Ease)';

  @override
  String get dsElastic => '탄성(Elastic)';

  @override
  String get dsLinear => '선형(Linear)';

  @override
  String get dsBackgroundImg => '배경 이미지';

  @override
  String dsImgSettingHint(Object title) {
    return '$title 이미지 업데이트';
  }

  @override
  String get dsReFit => '다시 맞추기';

  @override
  String get dsFromFile => '파일에서';

  @override
  String get dsFromCamera => '카메라에서';

  @override
  String get dsFromNetwork => 'URL에서';

  @override
  String get dsSolidColor => '단색';

  @override
  String get dsResetIt => '초기화하기';

  @override
  String get dsClearIt => '지우기';

  @override
  String get dsUseForColors => '이 이미지를 사용하여 앱 색상 업데이트';

  @override
  String get dsImgGetFailed => '이미지를 가져오지 못했습니다';

  @override
  String get dsImgSetFailed => '이미지를 업데이트하지 못했습니다';

  @override
  String get dsImgPermission =>
      '일부 사이트는 다른 사람이 이미지에 접근하는 것을 허용하지 않습니다.\n다른 호스트의 이미지를 사용해 보세요.';

  @override
  String get dsUseFull => '전체 이미지를 사용하시겠습니까?';

  @override
  String get dsFit => '어떻게 맞출까요?';

  @override
  String get dsCrop => '자르기';

  @override
  String get dsNoWeb => '웹에서는 이미지 편집이 지원되지 않습니다';

  @override
  String get dsRotateLeft => '왼쪽으로 회전';

  @override
  String get dsRotateRight => '오른쪽으로 회전';

  @override
  String get dsShowScroll => '스크롤바 표시';

  @override
  String dsResetButton(Object themeType) {
    return '$themeType 버튼 디자인을 초기화하시겠습니까?';
  }

  @override
  String dsResetPage(Object themeType) {
    return '$themeType 페이지 디자인을 초기화하시겠습니까?';
  }

  @override
  String get tsPageTitle => '텍스트 설정';

  @override
  String tsBatchOverride(Object setting) {
    return '이미 고급 설정에서 세부적인 \"$setting\" 변경을 수행했습니다.\n\n일괄 업데이트로 이러한 변경 사항을 덮어쓰시겠습니까?';
  }

  @override
  String get tsTextBackground => '텍스트 배경 불투명도';

  @override
  String get tsIconSize => '아이콘 크기';

  @override
  String tsLinkHint(Object style) {
    return '$style을(를) 편집하려면 활성화하세요';
  }

  @override
  String get tsDisplay => '디스플레이';

  @override
  String get tsHeadline => '헤드라인';

  @override
  String get tsTitle => '제목';

  @override
  String get tsBody => '본문';

  @override
  String get tsLabel => '레이블';

  @override
  String get tsFontFamily => '글꼴 모음';

  @override
  String get tsFontSize => '글꼴 크기';

  @override
  String get tsBold => '굵게';

  @override
  String get tsItalic => '기울임꼴';

  @override
  String get tsUnderline => '밑줄';

  @override
  String get tsLetterSpacing => '자간';

  @override
  String get tsWordSpacing => '어간';

  @override
  String get tsLineHeight => '줄 높이';

  @override
  String get tsDisplayP1 => '이 ';

  @override
  String get tsDisplayLink => '디스플레이';

  @override
  String get tsDisplayP2 => '가 잘 보이나요?';

  @override
  String get tsHeadlineP1 => '헤드라인이 ';

  @override
  String get tsHeadlineLink => '제목과';

  @override
  String get tsHeadlineP2 => ' 명확히 구분되나요...';

  @override
  String get tsTitleP1 => '';

  @override
  String get tsTitleLink => '제목과?';

  @override
  String get tsBodyP1 => '본문';

  @override
  String get tsBodyLink => '은 어떤가요?';

  @override
  String get tsBodyP2 => ' 읽기 편한가요?';

  @override
  String get tsLabelP1 => '그리고 ';

  @override
  String get tsLabelLink => '레이블';

  @override
  String get tsLabelP2 => '은요? 너무 크지도, 너무 작지도 않나요?';

  @override
  String tsReset(Object themeType) {
    return '$themeType 텍스트 스타일을 초기화하시겠습니까?';
  }
}
