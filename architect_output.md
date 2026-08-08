# Software Architect
Project: 30dcf5ed | Stage: design

# Software Architect — Design Stage
**Project:** `30dcf5ed` | **Stage:** `design`

---

## `/workspace/30dcf5ed/architecture.md`

```markdown
# Architecture: Flutter Counter App
- **Project ID**: 30dcf5ed
- **Stage**: design
- **Version**: 1.0.0

## 1. 기술 스택

| 항목 | 선택 | 근거 |
|------|------|------|
| Framework | Flutter ≥ 3.0.0 | 요구사항 명시 |
| Language | Dart ≥ 3.0.0 | Flutter 기본 언어 |
| State Management | StatefulWidget | 단일 int 값 — 외부 패키지 불필요 |
| External Packages | 없음 | 순수 SDK로 요구사항 100% 충족 |
| Platforms | Android (API 21+), iOS (12+) | Flutter 기본 지원 범위 |

## 2. 프로젝트 구조

lib/
└── main.dart       ← 진입점 + MyApp + CounterScreen (전체 1파일)

## 3. 화면 설계

### CounterScreen (유일한 화면)
- Route: /
- 위젯 트리:
  MaterialApp
  └── CounterScreen (StatefulWidget)
      └── Scaffold
          └── Center
              └── Column (mainAxisAlignment: center)
                  ├── Text(_counter.toString())
                  └── ElevatedButton(onPressed: _increment, "증가")

## 4. 데이터 모델

### _CounterScreenState
| 필드 | 타입 | 초기값 | 설명 |
|------|------|--------|------|
| _counter | int | 0 | 현재 카운터 값 |

| 메서드 | 반환 | 로직 |
|--------|------|------|
| _increment() | void | setState(() { _counter++; }) |

## 5. API 스펙
- 해당 없음 (외부 통신 없음)

## 6. 설계 결정 근거 (ADR)

| 결정 | 근거 |
|------|------|
| StatefulWidget | 상태 1개 — Provider/Riverpod은 과잉 설계 |
| 단일 파일 | YAGNI — 분리 시 복잡도만 증가 |
| 외부 패키지 0 | 순수 SDK로 충분 |
| 영속성 없음 | 요구사항 미명시 → YAGNI |
```

---

## JSON 산출물

```json
{
  "tech_stack": {
    "framework": "Flutter",
    "framework_version": ">=3.0.0",
    "language": "Dart",
    "language_version": ">=3.0.0",
    "state_management": "StatefulWidget",
    "external_packages": [],
    "platforms": ["Android", "iOS"],
    "min_sdk": {
      "android": "API 21",
      "ios": "12"
    }
  },
  "api_spec": [],
  "data_models": [
    {
      "name": "_CounterScreenState",
      "type": "State<CounterScreen>",
      "file": "lib/main.dart",
      "fields": [
        {
          "name": "_counter",
          "type": "int",
          "initial_value": 0,
          "description": "현재 카운터 값. 버튼 클릭 시 1씩 증가."
        }
      ],
      "methods": [
        {
          "name": "_increment",
          "return_type": "void",
          "description": "setState 호출로 _counter를 1 증가시켜 UI 재빌드 트리거",
          "logic": "setState(() { _counter++; })"
        }
      ]
    }
  ],
  "screens": [
    {
      "name": "CounterScreen",
      "type": "StatefulWidget",
      "route": "/",
      "file": "lib/main.dart",
      "description": "앱의 유일한 화면. 중앙에 카운터 숫자와 증가 버튼 표시.",
      "widget_tree": {
        "widget": "Scaffold",
        "children": [
          {
            "widget": "Center",
            "children": [
              {
                "widget": "Column",
                "props": {
                  "mainAxisAlignment": "MainAxisAlignment.center"
                },
                "children": [
                  {
                    "widget": "Text",
                    "content": "_counter.toString()",
                    "description": "현재 카운터 값 표시"
                  },
                  {
                    "widget": "ElevatedButton",
                    "label": "증가",
                    "onPressed": "_increment",
                    "description": "탭 시 카운터 1 증가"
                  }
                ]
              }
            ]
          }
        ]
      }
    }
  ],
  "project_structure": {
    "entry_point": "lib/main.dart",
    "total_files": 1,
    "total_screens": 1,
    "total_external_packages": 0
  },
  "file_output": "/workspace/30dcf5ed/architecture.md"
}
```

---

## ✅ Design Stage 완료

| 항목 | 상태 |
|------|------|
| 기술 스택 확정 | ✅ Flutter 3.0 / Dart 3.0 / StatefulWidget |
| 화면 구조 정의 | ✅ CounterScreen — 위젯 트리 완성 |
| 데이터 모델 설계 | ✅ `_counter: int = 0` + `_increment()` |
| API 스펙 | ✅ 해당 없음 확인 |
| 외부 패키지 검토 | ✅ 0개 (YAGNI) |
| `architecture.md` 저장 | ✅ `/workspace/30dcf5ed/architecture.md` |

> **→ 다음 스테이지: `implementation`**
> `lib/main.dart` 단일 파일 작성 — 설계 기준 확정 완료.