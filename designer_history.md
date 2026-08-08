

---
## Stage: design

# UX Design Spec — Flutter Counter App (30dcf5ed)

## 1. Design Specification JSON

```json
{
  "project_id": "30dcf5ed",
  "version": "1.0.0",
  "screens": [
    {
      "id": "screen_counter",
      "name": "Counter Screen",
      "route": "/",
      "description": "앱의 유일한 화면. 중앙에 카운터 숫자와 증가 버튼 표시.",
      "layout": "single_column_centered",
      "elements": [
        {
          "id": "el_title",
          "type": "Text",
          "content": "Counter",
          "position": "top_center",
          "style": "headline6"
        },
        {
          "id": "el_counter_value",
          "type": "Text",
          "content": "0",
          "position": "center",
          "style": "display_large",
          "description": "현재 카운터 값. 0부터 시작, 버튼 클릭 시 +1"
        },
        {
          "id": "el_increment_button",
          "type": "FloatingActionButton",
          "label": "+",
          "position": "center_bottom",
          "action": "increment_counter",
          "description": "탭 시 카운터 값 1 증가"
        }
      ],
      "states": [
        {
          "name": "initial",
          "counter_value": 0,
          "description": "앱 최초 실행 시 상태"
        },
        {
          "name": "counting",
          "counter_value": "N (N >= 1)",
          "description": "버튼 클릭 후 상태"
        }
      ]
    }
  ],
  "components": [
    {
      "id": "comp_counter_display",
      "name": "CounterDisplay",
      "type": "StatelessWidget",
      "props": [
        { "name": "value", "type": "int", "required": true, "default": 0 }
      ],
      "description": "현재 카운터 숫자를 크게 표시하는 텍스트 위젯"
    },
    {
      "id": "comp_increment_button",
      "name": "IncrementButton",
      "type": "FloatingActionButton",
      "props": [
        { "name": "onPressed", "type": "VoidCallback", "required": true }
      ],
      "description": "카운터를 1 증가시키는 버튼. 라벨: '+' 아이콘"
    },
    {
      "id": "comp_counter_screen",
      "name": "CounterScreen",
      "type": "StatefulWidget",
      "state": {
        "fields": [
          { "name": "_counter", "type": "int", "initial": 0 }
        ],
        "methods": [
          {
            "name": "_incrementCounter",
            "body": "setState(() { _counter++; })"
          }
        ]
      },
      "children": ["comp_counter_display", "comp_increment_button"],
      "description": "카운터 상태를 관리하는 최상위 화면 위젯"
    }
  ],
  "design_tokens": {
    "colors": {
      "primary": "#6200EE",
      "primary_variant": "#3700B3",
      "on_primary": "#FFFFFF",
      "background": "#FFFFFF",
      "surface": "#FFFFFF",
      "on_background": "#121212",
      "on_surface": "#121212",
      "counter_value_color": "#6200EE"
    },
    "typography": {
      "app_title": {
        "font_size": "20sp",
        "font_weight": "500",
        "color": "#FFFFFF"
      },
      "counter_value": {
        "font_size": "80sp",
        "font_weight": "300",
        "color": "#6200EE"
      },
      "counter_label": {
        "font_size": "16sp",
        "font_weight": "400",
        "color": "#666666"
      }
    },
    "spacing": {
      "counter_to_button_gap": "48dp",
      "label_to_counter_gap": "16dp"
    },
    "button": {
      "fab_size": "56dp",
      "fab_icon": "Icons.add",
      "fab_icon_size": "28dp",
      "fab_elevation": "6dp"
    },
    "elevation": {
      "app_bar": "4dp",
      "fab": "6dp"
    }
  },
  "user_flow": {
    "steps": [
      { "step": 1, "action": "앱 실행", "result": "Counter Screen 표시, 숫자 0" },
      { "step": 2, "action": "'+' 버튼 탭", "result": "숫자 1 증가 (0→1→2→...)" }
    ]
  }
}
```

---

## 2. 정적 HTML 목업

```html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Flutter Counter App — UX Mockup (30dcf5ed)</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      background: #F0F0F0;
      min-height: 100vh;
      padding: 32px 16px;
    }

    /* ── 페이지 헤더 ── */
    .page-header {
      text-align: center;
      margin-bottom: 40px;
    }
    .page-header h1 {
      font-size: 22px;
      font-weight: 700;
      color: #333;
    }
    .page-header p {
      font-size: 13px;
      color: #888;
      margin-top: 4px;
    }

    /* ── 화면들을 가로로 나란히 ── */
    .screens-row {
      display: flex;
      justify-content: center;
      align-items: flex-start;
      gap: 48px;
      flex-wrap: wrap;
    }

    /* ── 각 화면 래퍼(라벨 + 폰 프레임) ── */
    .screen-wrapper {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 14px;
    }
    .screen-label {
      font-size: 13px;
      font-weight: 600;
      color: #555;
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    /* ── 폰 프레임 ── */
    .phone-frame {
      width: 320px;
      height: 620px;
      background: #fff;
      border-radius: 40px;
      border: 8px solid #222;
      box-shadow: 0 8px 32px rgba(0,0,0,0.18), inset 0 0 0 2px #444;
      overflow: hidden;
      position: relative;
      display: flex;
      flex-direction: column;
    }

    /* 노치 */
    .phone-notch {
      position: absolute;
      top: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 90px;
      height: 20px;
      background: #222;
      border-radius: 0 0 14px 14px;
      z-index: 10;
    }

    /* ── AppBar ── */
    .app-bar {
      background: #6200EE;
      padding: 36px 16px 12px;
      text-align: center;
      box-shadow: 0 2px 6px rgba(0,0,0,0.25);
      flex-shrink: 0;
    }
    .app-bar-title {
      color: #fff;
      font-size: 18px;
      font-weight: 600;
      letter-spacing: 0.5px;
    }

    /* ── Body ── */
    .screen-body {
      flex: 1;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      background: #FFFFFF;
      position: relative;
      padding-bottom: 80px;
    }

    /* 카운터 레이블 */
    .counter-label {
      font-size: 14px;
      color: #888;
      font-weight: 400;
      margin-bottom: 12px;
      letter-spacing: 0.3px;
    }

    /* 카운터 숫자 */
    .counter-value {
      font-size: 88px;
      font-weight: 200;
      color: #6200EE;
      line-height: 1;
      letter-spacing: -2px;
      user-select: none;
    }
    .counter-value.updated {
      color: #3700B3;
    }

    /* ── FAB ── */
    .fab-area {
      position: absolute;
      bottom: 28px;
      right: 24px;
    }
    .fab {
      width: 56px;
      height: 56px;
      border-radius: 50%;
      background: #6200EE;
      color: #fff;
      font-size: 32px;
      font-weight: 300;
      border: none;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 4px 12px rgba(98,0,238,0.45);
      transition: background 0.15s, box-shadow 0.15s, transform 0.1s;
      line-height: 1;
    }
    .fab:hover {
      background: #3700B3;
      box-shadow: 0 6px 16px rgba(55,0,179,0.5);
      transform: scale(1.07);
    }
    .fab:active {
      transform: scale(0.95);
    }

    /* ── 홈 인디케이터 ── */
    .home-indicator {
      position: absolute;
      bottom: 6px;
      left: 50%;
      transform: translateX(-50%);
      width: 80px;
      height: 4px;
      background: #CCC;
      border-radius: 2px;
    }

    /* ── 어노테이션 패널 ── */
    .annotation-panel {
      width: 320px;
      background: #FAFAFA;
      border: 1.5px solid #E0E0E0;
      border-radius: 12px;
      padding: 16px 18px;
    }
    .annotation-panel h3 {
      font-size: 12px;
      font-weight: 700;
      color: #6200EE;
      text-transform: uppercase;
      letter-spacing: 0.8px;
      margin-bottom: 10px;
      border-bottom: 1px solid #E8E8E8;
      padding-bottom: 6px;
    }
    .annotation-row {
      display: flex;
      justify-content: space-between;
      align-items: baseline;
      margin-bottom: 6px;
      font-size: 12px;
    }
    .ann-key { color: #555; font-weight: 500; }
    .ann-val { color: #222; font-family: monospace; font-size: 11.5px; }

    /* ── 구분선 ── */
    .divider {
      width: 1px;
      height: 500px;
      background: #DDD;
      margin-top: 36px;
    }

    /* ── 범례 ── */
    .legend {
      margin-top: 40px;
      text-align: center;
      display: flex;
      justify-content: center;
      gap: 28px;
      flex-wrap: wrap;
    }
    .legend-item {
      display: flex;
      align-items: center;
      gap: 7px;
      font-size: 12px;
      color: #555;
    }
    .legend-dot {
      width: 12px;
      height: 12px;
      border-radius: 50%;
    }
  </style>
</head>
<body>

  <!-- 페이지 헤더 -->
  <div class="page-header">
    <h1>Flutter Counter App — UX Mockup</h1>
    <p>Project ID: 30dcf5ed &nbsp;|&nbsp; Stage: design &nbsp;|&nbsp; Repo: ych21c/counter-app</p>
  </div>

  <!-- 화면 나란히 배치 -->
  <div class="screens-row">

    <!-- ① 초기 상태 (counter = 0) -->
    <div class="screen-wrapper">
      <span class="screen-label">① 초기 상태 (counter = 0)</span>

      <div class="phone-frame">
        <div class="phone-notch"></div>

        <!-- AppBar -->
        <div class="app-bar">
          <span class="app-bar-title">Counter</span>
        </div>

        <!-- Body -->
        <div class="screen-body">
          <span class="counter-label">You have pushed the button this many times:</span>
          <span class="counter-value">0</span>

          <!-- FAB -->
          <div class="fab-area">
            <button class="fab" title="Increment">+</button>
          </div>

          <div class="home-indicator"></div>
        </div>
      </div>

      <!-- 어노테이션 -->
      <div class="annotation-panel">
        <h3>Design Tokens — Counter Display</h3>
        <div class="annotation-row">
          <span class="ann-key">counter font-size</span>
          <span class="ann-val">80sp / fw 200</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">counter color</span>
          <span class="ann-val">#6200EE (primary)</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">label font-size</span>
          <span class="ann-val">16sp / fw 400</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">background</span>
          <span class="ann-val">#FFFFFF</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">initial value</span>
          <span class="ann-val">0</span>
        </div>
      </div>
    </div>

    <!-- 구분선 -->
    <div class="divider"></div>

    <!-- ② 버튼 클릭 후 (counter = 3 예시) -->
    <div class="screen-wrapper">
      <span class="screen-label">② 버튼 클릭 후 (counter = 3)</span>

      <div class="phone-frame">
        <div class="phone-notch"></div>

---
## Stage: design

# UX Design Spec — Flutter Counter App
**Project ID**: 30dcf5ed | **Stage**: design

---

## 1. Design Spec JSON

```json
{
  "project_id": "30dcf5ed",
  "version": "1.0.0",
  "screens": [
    {
      "id": "screen_counter",
      "name": "Counter Screen",
      "route": "/",
      "description": "앱의 유일한 화면. 카운터 숫자 표시 + 증가 버튼.",
      "state": {
        "counter": { "type": "int", "initial": 0, "min": 0, "max": null }
      },
      "layout": {
        "type": "Scaffold",
        "children": [
          { "component": "AppBar", "props": { "title": "Counter" } },
          { "component": "CounterBody", "position": "body" },
          { "component": "FAB", "position": "floatingActionButton" }
        ]
      }
    }
  ],
  "components": [
    {
      "id": "AppBar",
      "type": "AppBar",
      "props": {
        "title": "Counter",
        "backgroundColor": "#6200EE",
        "foregroundColor": "#FFFFFF",
        "elevation": 4
      }
    },
    {
      "id": "CounterBody",
      "type": "Column",
      "alignment": "center",
      "children": [
        {
          "id": "CounterLabel",
          "type": "Text",
          "content": "You have pushed the button this many times:",
          "style": {
            "fontSize": 16,
            "fontWeight": "w400",
            "color": "#333333",
            "textAlign": "center"
          }
        },
        {
          "id": "CounterValue",
          "type": "Text",
          "content": "{{counter}}",
          "style": {
            "fontSize": 80,
            "fontWeight": "w200",
            "color": "#6200EE"
          }
        }
      ]
    },
    {
      "id": "FAB",
      "type": "FloatingActionButton",
      "icon": "Icons.add",
      "tooltip": "Increment",
      "backgroundColor": "#6200EE",
      "foregroundColor": "#FFFFFF",
      "onPressed": "_incrementCounter",
      "size": 56,
      "elevation": 6
    }
  ],
  "interactions": [
    {
      "trigger": "FAB.onPressed",
      "action": "counter += 1",
      "result": "CounterValue re-renders with new counter value"
    }
  ],
  "design_tokens": {
    "colors": {
      "primary": "#6200EE",
      "primaryVariant": "#3700B3",
      "onPrimary": "#FFFFFF",
      "background": "#FFFFFF",
      "surface": "#FFFFFF",
      "textPrimary": "#333333",
      "textSecondary": "#666666"
    },
    "typography": {
      "appBarTitle": { "fontSize": 20, "fontWeight": "w500", "color": "#FFFFFF" },
      "counterLabel": { "fontSize": 16, "fontWeight": "w400", "color": "#333333" },
      "counterValue": { "fontSize": 80, "fontWeight": "w200", "color": "#6200EE" }
    },
    "spacing": {
      "bodyPaddingH": 24,
      "labelToValueGap": 16,
      "fabBottomMargin": 16
    },
    "elevation": {
      "appBar": 4,
      "fab": 6
    },
    "borderRadius": {
      "fab": "50%"
    }
  }
}
```

---

## 2. HTML 목업

```html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Flutter Counter App — UX Mockup | 30dcf5ed</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      background: #F0F2F5;
      padding: 40px 20px 60px;
    }

    /* ── 페이지 헤더 ── */
    .page-header {
      text-align: center;
      margin-bottom: 48px;
    }
    .page-header h1 {
      font-size: 22px;
      font-weight: 700;
      color: #1a1a2e;
      margin-bottom: 6px;
    }
    .page-header p {
      font-size: 13px;
      color: #888;
      letter-spacing: 0.3px;
    }
    .page-header .badge {
      display: inline-block;
      margin-top: 10px;
      padding: 3px 12px;
      background: #6200EE;
      color: #fff;
      border-radius: 20px;
      font-size: 11px;
      letter-spacing: 0.5px;
    }

    /* ── 화면 행 ── */
    .screens-row {
      display: flex;
      justify-content: center;
      align-items: flex-start;
      gap: 0;
      flex-wrap: wrap;
    }

    /* ── 화면 래퍼 ── */
    .screen-wrapper {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 24px;
      padding: 0 32px;
    }
    .screen-label {
      font-size: 13px;
      font-weight: 600;
      color: #6200EE;
      letter-spacing: 0.4px;
      text-transform: uppercase;
    }

    /* ── 폰 프레임 ── */
    .phone-frame {
      width: 260px;
      height: 520px;
      border: 3px solid #222;
      border-radius: 36px;
      background: #fff;
      overflow: hidden;
      position: relative;
      box-shadow: 0 12px 40px rgba(0,0,0,0.18), 0 2px 8px rgba(0,0,0,0.10);
      display: flex;
      flex-direction: column;
    }

    /* 노치 */
    .phone-notch {
      position: absolute;
      top: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 80px;
      height: 22px;
      background: #222;
      border-radius: 0 0 16px 16px;
      z-index: 10;
    }

    /* ── AppBar ── */
    .app-bar {
      background: #6200EE;
      padding: 28px 16px 12px;
      display: flex;
      align-items: center;
      min-height: 64px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.22);
      position: relative;
      z-index: 5;
    }
    .app-bar-title {
      color: #fff;
      font-size: 18px;
      font-weight: 500;
      letter-spacing: 0.3px;
      width: 100%;
      text-align: center;
    }

    /* ── 스크린 바디 ── */
    .screen-body {
      flex: 1;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 16px 20px;
      position: relative;
    }

    .counter-label {
      font-size: 13px;
      color: #444;
      text-align: center;
      line-height: 1.5;
      margin-bottom: 12px;
      font-weight: 400;
    }

    .counter-value {
      font-size: 72px;
      font-weight: 200;
      color: #6200EE;
      line-height: 1;
      margin-bottom: 0;
      font-family: 'Segoe UI', sans-serif;
    }

    /* ── FAB 영역 ── */
    .fab-area {
      position: absolute;
      bottom: 28px;
      right: 20px;
    }
    .fab {
      width: 52px;
      height: 52px;
      border-radius: 50%;
      background: #6200EE;
      color: #fff;
      border: none;
      font-size: 28px;
      line-height: 52px;
      text-align: center;
      cursor: pointer;
      box-shadow: 0 4px 12px rgba(98,0,238,0.45);
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 300;
      transition: background 0.15s, transform 0.1s;
    }
    .fab:hover {
      background: #3700B3;
      transform: scale(1.07);
    }
    .fab:active {
      transform: scale(0.96);
    }

    /* 홈 인디케이터 */
    .home-indicator {
      position: absolute;
      bottom: 8px;
      left: 50%;
      transform: translateX(-50%);
      width: 60px;
      height: 4px;
      background: #ccc;
      border-radius: 4px;
    }

    /* ── 어노테이션 패널 ── */
    .annotation-panel {
      width: 240px;
      background: #fff;
      border: 1px solid #E0E0E0;
      border-radius: 10px;
      padding: 16px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    }
    .annotation-panel h3 {
      font-size: 11px;
      font-weight: 700;
      color: #6200EE;
      text-transform: uppercase;
      letter-spacing: 0.6px;
      margin-bottom: 12px;
      padding-bottom: 8px;
      border-bottom: 1px solid #EEE;
    }
    .annotation-row {
      display: flex;
      justify-content: space-between;
      align-items: baseline;
      margin-bottom: 7px;
      font-size: 12px;
    }
    .ann-key { color: #666; font-weight: 500; }
    .ann-val { color: #1a1a1a; font-family: monospace; font-size: 11px; background: #F5F5F5; padding: 1px 5px; border-radius: 3px; }

    /* ── 구분선 ── */
    .divider {
      width: 1px;
      height: 560px;
      background: linear-gradient(to bottom, transparent, #CCC 20%, #CCC 80%, transparent);
      margin: 40px 0 0;
    }

    /* ── 플로우 화살표 ── */
    .flow-arrow {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 0 8px;
      margin-top: 60px;
      gap: 6px;
    }
    .arrow-line {
      width: 2px;
      height: 40px;
      background: #6200EE;
      position: relative;
    }
    .arrow-head {
      width: 0; height: 0;
      border-left: 7px solid transparent;
      border-right: 7px solid transparent;
      border-top: 10px solid #6200EE;
    }
    .arrow-label {
      font-size: 10px;
      color: #6200EE;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      text-align: center;
      white-space: nowrap;
      margin-bottom: 4px;
    }

    /* ── 토큰 테이블 (하단) ── */
    .token-section {
      max-width: 780px;
      margin: 52px auto 0;
      background: #fff;
      border-radius: 12px;
      border: 1px solid #E0E0E0;
      padding: 28px 32px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.06);
    }
    .token-section h2 {
      font-size: 14px;
      font-weight: 700;
      color: #1a1a2e;
      margin-bottom: 18px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .token-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 24px;
    }
    .token-group h4 {
      font-size: 11px;
      font-weight: 700;
      color: #6200EE;
      text-transform: uppercase;
      letter-spacing: 0.6px;
      margin-bottom: 10px;
      padding-bottom: 6px;
      border-bottom: 2px solid #EDE7F6;
    }
    .token-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 12px;
      margin-bottom: 7px;
    }
    .token-key { color: #555; }
    .token-val {
      font-family: monospace;
      font-size: 11px;
      background: #F5F0FF;
      color: #3700B3;
      padding: 2px 6px;
      border-radius: 4px;
    }
    .color-swatch {
      display: inline-block;
      width: 14px;
      height: 14px;
      border-radius: 3px;
      border: 1px solid rgba(0,0,0,0.12);
      vertical-align: middle;
      margin-right: 4px;
    }

    /* ── 인터랙션 플로우 다이어그램 ── */
    .flow-section {
      max-width: 780px;
      margin: 28px auto 0;
      background: #fff;
      border-radius: 12px;
      border: 1px solid #E0E0E0;
      padding: 28px 32px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.06);
    }
    .flow-section h2 {
      font-size: 14px;
      font-weight: 700;
      color: #1a1a2e;
      margin-bottom: 20px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .flow-diagram {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0;
      flex-wrap: wrap;
    }
    .flow-box {
      background: #EDE7F6;
      border: 2px solid #6200EE;
      border-radius: 8px;
      padding: 10px 18px;
      font-size: 12px;
      font-weight: 600;
      color: #3700B3;
      text-align: center;
      min-width: 110px;
    }
    .flow-box.trigger {
      background: #6200EE;
      color: #fff;
      border-color: #3700B3;
    }
    .flow-box.result {
      background: #E8F5E9;
      border-color: #388E3C;
      color: #1B5E20;
    }
    .flow-connector {
      display: flex;
      align-items: center;
      gap: 0;
      margin: 0 4px;
    }
    .fc-line {
      width: 30px;
      height: 2px;
      background: #6200EE;
    }
    .fc-arrow {
      width: 0; height: 0;
      border-top: 6px solid transparent;
      border-bottom: 6px solid transparent;
      border-left: 9px solid #6200EE;
    }
    .fc-label {
      font-size: 10px;
      color: #888;
      text-align: center;
      display: block;
      margin-top: -18px;
      margin-bottom: 4px;
      white-space: nowrap;
    }
    .flow-step-wrap {
      display: flex;
      flex-direction: column;
      align-items: center;
    }
  </style>
</head>
<body>

  <!-- 페이지 헤더 -->
  <div class="page-header">
    <h1>Flutter Counter App — UX Mockup</h1>
    <p>Project ID: 30dcf5ed &nbsp;|&nbsp; Stage: design &nbsp;|&nbsp; Repo: ych21c/counter-app</p>
    <span class="badge">v1.0.0</span>
  </div>

  <!-- ───────────────────────── 화면 목업 ───────────────────────── -->
  <div class="screens-row">

    <!-- ① 초기 상태 (counter = 0) -->
    <div class="screen-wrapper">
      <span class="screen-label">① 초기 상태 (counter = 0)</span>

      <div class="phone-frame">
        <div class="phone-notch"></div>
        <div class="app-bar">
          <span class="app-bar-title">Counter</span>
        </div>
        <div class="screen-body">
          <span class="counter-label">You have pushed the button this many times:</span>
          <span class="counter-value">0</span>
          <div class="fab-area">
            <button class="fab" title="Increment">+</button>
          </div>
          <div class="home-indicator"></div>
        </div>
      </div>

      <!-- 어노테이션 -->
      <div class="annotation-panel">
        <h3>Counter Display</h3>
        <div class="annotation-row">
          <span class="ann-key">value font-size</span>
          <span class="ann-val">80sp / fw200</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">value color</span>
          <span class="ann-val">#6200EE</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">label font-size</span>
          <span class="ann-val">16sp / fw400</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">background</span>
          <span class="ann-val">#FFFFFF</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">initial value</span>
          <span class="ann-val">0 (int)</span>
        </div>
      </div>
    </div>

    <!-- 플로우 화살표 -->
    <div class="flow-arrow">
      <span class="arrow-label">FAB<br>Tap</span>
      <div class="arrow-line"></div>
      <div class="arrow-head"></div>
    </div>

    <!-- 구분선 -->
    <div class="divider"></div>

    <div style="width:16px;"></div>

    <!-- ② 버튼 클릭 후 (counter = 3) -->
    <div class="screen-wrapper">
      <span class="screen-label">② 버튼 클릭 후 (counter = 3)</span>

      <div class="phone-frame">
        <div class="phone-notch"></div>
        <div class="app-bar">
          <span class="app-bar-title">Counter</span>
        </div>
        <div class="screen-body">
          <span class="counter-label">You have pushed the button this many times:</span>
          <span class="counter-value">3</span>
          <div class="fab-area">
            <button class="fab" title="Increment">+</button>
          </div>
          <div class="home-indicator"></div>
        </div>
      </div>

      <!-- 어노테이션 -->
      <div class="annotation-panel">
        <h3>FAB Component</h3>
        <div class="annotation-row">
          <span class="ann-key">size</span>
          <span class="ann-val">56×56dp</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">bg color</span>
          <span class="ann-val">#6200EE</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">icon</span>
          <span class="ann-val">Icons.add</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">icon color</span>
          <span class="ann-val">#FFFFFF</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">elevation</span>
          <span class="ann-val">6dp</span>
        </div>
        <div class="annotation-row">
          <span class="ann-key">position</span>
          <span class="ann-val">bottomRight</span>
        </div>
      </div>
    </div>

  </div><!-- /.screens-row -->


  <!-- ───────────────────────── 인터랙션 플로우 ───────────────────────── -->
  <div class="flow-section">
    <h2>🔄 Interaction Flow</h2>
    <div class="flow-diagram">

      <div class="flow-step-wrap">
        <div class="flow-box trigger">User Taps FAB</div>
      </div>

      <div class="flow-step-wrap">
        <span class="fc-label">onPressed</span>
        <div class="flow-connector">
          <div class="fc-line"></div>
          <div class="fc-arrow"></div>
        </div>
      </div>

      <div class="flow-step-wrap">
        <div class="flow-box">_incrementCounter()</div>
      </div>

      <div class="flow-step-wrap">
        <span class="fc-label">setState()</span>
        <div class="flow-connector">
          <div class="fc-line"></div>
          <div class="fc-arrow"></div>
        </div>
      </div>

      <div class="flow-step-wrap">
        <div class="flow-box">counter += 1</div>
      </div>

      <div class="flow-step-wrap">
        <span class="fc-label">rebuild</span>
        <div class="flow-connector">
          <div class="fc-line"></div>
          <div class="fc-arrow"></div>
        </div>
      </div>

      <div class="flow-step-wrap">
        <div class="flow-box result">UI Re-renders<br/>new counter value</div>
      </div>

    </div>
  </div>

  <!-- ───────────────────────── 디자인 토큰 ───────────────────────── -->
  <div class="token-section">
    <h2>🎨 Design Tokens</h2>
    <div class="token-grid">

      <!-- Colors -->
      <div class="token-group">
        <h4>Colors</h4>
        <div class="token-row">
          <span class="token-key">primary</span>
          <span class="token-val">
            <span class="color-swatch" style="background:#6200EE;"></span>#6200EE
          </span>
        </div>
        <div class="token-row">
          <span class="token-key">primaryVariant</span>
          <span class="token-val">
            <span class="color-swatch" style="background:#3700B3;"></span>#3700B3
          </span>
        </div>
        <div class="token-row">
          <span class="token-key">onPrimary</span>
          <span class="token-val">
            <span class="color-swatch" style="background:#FFFFFF; border:1px solid #ccc;"></span>#FFFFFF
          </span>
        </div>
        <div class="token-row">
          <span class="token-key">background</span>
          <span class="token-val">
            <span class="color-swatch" style="background:#FFFFFF; border:1px solid #ccc;"></span>#FFFFFF
          </span>
        </div>
        <div class="token-row">
          <span class="token-key">textPrimary</span>
          <span class="token-val">
            <span class="color-swatch" style="background:#333333;"></span>#333333
          </span>
        </div>
      </div>

      <!-- Typography -->
      <div class="token-group">
        <h4>Typography</h4>
        <div class="token-row">
          <span class="token-key">appBar title</span>
          <span class="token-val">20sp / w500</span>
        </div>
        <div class="token-row">
          <span class="token-key">counter label</span>
          <span class="token-val">16sp / w400</span>
        </div>
        <div class="token-row">
          <span class="token-key">counter value</span>
          <span class="token-val">80sp / w200</span>
        </div>
      </div>

      <!-- Spacing & Elevation -->
      <div class="token-group">
        <h4>Spacing & Elevation</h4>
        <div class="token-row">
          <span class="token-key">body padding H</span>
          <span class="token-val">24dp</span>
        </div>
        <div class="token-row">
          <span class="token-key">label→value gap</span>
          <span class="token-val">16dp</span>
        </div>
        <div class="token-row">
          <span class="token-key">FAB size</span>
          <span class="token-val">56×56dp</span>
        </div>
        <div class="token-row">
          <span class="token-key">AppBar elevation</span>
          <span class="token-val">4dp</span>
        </div>
        <div class="token-row">
          <span class="token-key">FAB elevation</span>
          <span class="token-val">6dp</span>
        </div>
      </div>

    </div>
  </div>

</body>
</html>
```

---

## 산출물 요약

| 항목 | 내용 |
|------|------|
| 화면 수 | 1개 (`/` — CounterScreen) |
| 핵심 컴포넌트 | AppBar, CounterLabel, CounterValue, FAB |
| 상태 | `counter: int = 0` |
| 인터랙션 | FAB tap → `_incrementCounter()` → `setState()` → UI rebuild |
| Primary Color | `#6200EE` |
| Counter 폰트 | 80sp / FontWeight.w200 |

---
## Stage: design

# UX Design Spec — Flutter Counter App (30dcf5ed)

## 1. Design Specification JSON

```json
{
  "project_id": "30dcf5ed",
  "version": "1.0.0",
  "screens": [
    {
      "id": "screen_counter",
      "name": "CounterScreen",
      "route": "/",
      "description": "단일 화면 카운터 — 앱의 유일한 화면",
      "layout": "Scaffold",
      "background": "#FFFFFF",
      "regions": [
        {
          "id": "region_appbar",
          "type": "AppBar",
          "props": {
            "title": "Flutter Counter",
            "backgroundColor": "#6200EE",
            "foregroundColor": "#FFFFFF",
            "elevation": 4,
            "centerTitle": true
          }
        },
        {
          "id": "region_body",
          "type": "Center > Column",
          "mainAxisAlignment": "center",
          "crossAxisAlignment": "center",
          "children": ["comp_counter_label", "comp_counter_value"]
        },
        {
          "id": "region_fab",
          "type": "FloatingActionButton",
          "position": "bottomRight",
          "component": "comp_fab"
        }
      ]
    }
  ],
  "components": [
    {
      "id": "comp_counter_label",
      "name": "CounterLabel",
      "type": "Text",
      "props": {
        "text": "You have pushed the button this many times:",
        "textAlign": "center",
        "style": {
          "fontSize": "16sp",
          "fontWeight": "w400",
          "color": "#333333"
        }
      },
      "spacing": {
        "marginBottom": "16dp"
      }
    },
    {
      "id": "comp_counter_value",
      "name": "CounterValue",
      "type": "Text",
      "state_binding": "counter",
      "props": {
        "text": "${counter}",
        "initialValue": 0,
        "style": {
          "fontSize": "80sp",
          "fontWeight": "w200",
          "color": "#333333"
        }
      }
    },
    {
      "id": "comp_fab",
      "name": "IncrementFAB",
      "type": "FloatingActionButton",
      "props": {
        "backgroundColor": "#6200EE",
        "foregroundColor": "#FFFFFF",
        "icon": "Icons.add",
        "tooltip": "Increment",
        "size": "56x56dp",
        "elevation": 6
      },
      "interaction": {
        "onTap": "_incrementCounter()",
        "effect": "counter += 1 → setState() → UI rebuild"
      }
    }
  ],
  "state": {
    "counter": {
      "type": "int",
      "initial": 0,
      "mutators": ["_incrementCounter"],
      "scope": "_CounterScreenState"
    }
  },
  "interactions": [
    {
      "trigger": "FAB tap",
      "action": "_incrementCounter()",
      "state_change": "counter++",
      "ui_effect": "CounterValue 텍스트 즉시 갱신 (setState)"
    }
  ],
  "design_tokens": {
    "colors": {
      "primary": "#6200EE",
      "primaryVariant": "#3700B3",
      "onPrimary": "#FFFFFF",
      "background": "#FFFFFF",
      "textPrimary": "#333333",
      "textSecondary": "#757575"
    },
    "typography": {
      "appBarTitle": { "size": "20sp", "weight": "w500" },
      "counterLabel": { "size": "16sp", "weight": "w400" },
      "counterValue": { "size": "80sp", "weight": "w200" }
    },
    "spacing": {
      "bodyPaddingH": "24dp",
      "labelToValueGap": "16dp",
      "fabSize": "56dp"
    },
    "elevation": {
      "appBar": "4dp",
      "fab": "6dp"
    },
    "borderRadius": {
      "fab": "16dp"
    }
  }
}
```

---

## 2. HTML 목업

```html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Design Spec — Flutter Counter App (30dcf5ed)</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background: #F0F0F0;
      padding: 32px 24px;
      color: #222;
    }
    /* ── Page Header ── */
    .page-header {
      text-align: center;
      margin-bottom: 40px;
    }
    .page-header h1 { font-size: 22px; font-weight: 700; color: #1a1a1a; }
    .page-header p  { font-size: 13px; color: #888; margin-top: 6px; }

    /* ── Layout: two columns ── */
    .layout {
      display: flex;
      gap: 32px;
      align-items: flex-start;
      justify-content: center;
      flex-wrap: wrap;
    }

    /* ── Phone Frame ── */
    .phone-wrap { display: flex; flex-direction: column; align-items: center; gap: 12px; }
    .phone-label { font-size: 13px; font-weight: 600; color: #555; letter-spacing: 0.5px; text-transform: uppercase; }
    .phone {
      width: 320px;
      height: 620px;
      border-radius: 40px;
      border: 10px solid #1a1a1a;
      background: #fff;
      overflow: hidden;
      box-shadow: 0 12px 40px rgba(0,0,0,0.25);
      display: flex;
      flex-direction: column;
      position: relative;
    }
    /* notch */
    .phone::before {
      content: '';
      position: absolute;
      top: 0; left: 50%; transform: translateX(-50%);
      width: 100px; height: 24px;
      background: #1a1a1a;
      border-radius: 0 0 16px 16px;
      z-index: 10;
    }

    /* AppBar */
    .appbar {
      background: #6200EE;
      color: #fff;
      height: 60px;
      display: flex;
      align-items: flex-end;
      justify-content: center;
      padding-bottom: 12px;
      padding-top: 24px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.2);
      flex-shrink: 0;
      position: relative;
      z-index: 1;
    }
    .appbar span { font-size: 18px; font-weight: 500; letter-spacing: 0.3px; }

    /* Body */
    .body {
      flex: 1;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 0 24px;
      background: #fff;
      position: relative;
    }

    .counter-label {
      font-size: 14px;
      font-weight: 400;
      color: #333;
      text-align: center;
      line-height: 1.5;
      margin-bottom: 16px;
    }
    .counter-value {
      font-size: 72px;
      font-weight: 200;
      color: #333;
      line-height: 1;
    }

    /* FAB */
    .fab {
      position: absolute;
      bottom: 24px;
      right: 24px;
      width: 56px;
      height: 56px;
      border-radius: 16px;
      background: #6200EE;
      color: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 28px;
      font-weight: 300;
      box-shadow: 0 6px 16px rgba(98,0,238,0.45);
      cursor: pointer;
      user-select: none;
      transition: background 0.15s;
    }
    .fab:hover  { background: #3700B3; }
    .fab:active { background: #3700B3; transform: scale(0.95); }

    /* ── State Annotation ── */
    .annotation-wrap {
      display: flex;
      flex-direction: column;
      gap: 12px;
      width: 260px;
    }
    .annotation-card {
      background: #fff;
      border-radius: 12px;
      padding: 16px 18px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    }
    .annotation-card h3 {
      font-size: 11px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1px;
      color: #6200EE;
      margin-bottom: 10px;
    }
    .annotation-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 5px 0;
      border-bottom: 1px solid #F5F5F5;
      font-size: 12px;
    }
    .annotation-row:last-child { border-bottom: none; }
    .annotation-key   { color: #777; }
    .annotation-val   { font-weight: 600; color: #222; font-family: 'Courier New', monospace; }

    /* color swatch */
    .swatch {
      display: inline-block;
      width: 14px; height: 14px;
      border-radius: 3px;
      border: 1px solid rgba(0,0,0,0.12);
      margin-right: 5px;
      vertical-align: middle;
    }

    /* ── Interaction Flow ── */
    .flow-section {
      margin-top: 36px;
      background: #fff;
      border-radius: 14px;
      padding: 24px 28px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.07);
      max-width: 760px;
      margin-left: auto;
      margin-right: auto;
    }
    .flow-section h2 {
      font-size: 13px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1px;
      color: #6200EE;
      margin-bottom: 18px;
    }
    .flow {
      display: flex;
      align-items: center;
      gap: 0;
      flex-wrap: wrap;
    }
    .flow-step {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 6px;
    }
    .flow-box {
      background: #F3E8FD;
      border: 1.5px solid #6200EE;
      border-radius: 8px;
      padding: 10px 14px;
      font-size: 12px;
      font-weight: 600;
      color: #3700B3;
      text-align: center;
      white-space: nowrap;
    }
    .flow-box.state {
      background: #E8F5E9;
      border-color: #2E7D32;
      color: #1B5E20;
    }
    .flow-box.ui {
      background: #E3F2FD;
      border-color: #1565C0;
      color: #0D47A1;
    }
    .flow-sub { font-size: 10px; color: #999; }
    .flow-arrow {
      font-size: 20px;
      color: #BDBDBD;
      padding: 0 8px;
      margin-bottom: 22px;
    }

    /* ── Component Inventory ── */
    .comp-section {
      margin-top: 24px;
      max-width: 760px;
      margin-left: auto;
      margin-right: auto;
    }
    .comp-section h2 {
      font-size: 13px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1px;
      color: #6200EE;
      margin-bottom: 14px;
    }
    .comp-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
      gap: 12px;
    }
    .comp-card {
      background: #fff;
      border-radius: 10px;
      padding: 14px 16px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.07);
      border-top: 3px solid #6200EE;
    }
    .comp-card h4 { font-size: 13px; font-weight: 700; color: #222; margin-bottom: 6px; }
    .comp-card p  { font-size: 11px; color: #666; line-height: 1.5; }
    .comp-card .badge {
      display: inline-block;
      background: #F3E8FD;
      color: #6200EE;
      font-size: 10px;
      font-weight: 700;
      padding: 2px 7px;
      border-radius: 20px;
      margin-top: 8px;
    }
  </style>
</head>
<body>

  <!-- Page Header -->
  <div class="page-header">
    <h1>Flutter Counter App — Design Spec</h1>
    <p>Project: 30dcf5ed &nbsp;|&nbsp; Stage: Design &nbsp;|&nbsp; Screen: 1 &nbsp;|&nbsp; Components: 4</p>
  </div>

  <!-- Main: Phone + Annotations -->
  <div class="layout">

    <!-- Phone Mockup -->
    <div class="phone-wrap">
      <span class="phone-label">CounterScreen  (초기 상태: counter = 0)</span>
      <div class="phone">
        <!-- AppBar -->
        <div class="appbar">
          <span>Flutter Counter</span>
        </div>
        <!-- Body -->
        <div class="body">
          <p class="counter-label">You have pushed the button<br>this many times:</p>
          <span class="counter-value">0</span>
          <!-- FAB -->
          <div class="fab" title="Increment (onTap → counter++)">+</div>
        </div>
      </div>
    </div>

    <!-- Phone Mockup: After press -->
    <div class="phone-wrap">
      <span class="phone-label">CounterScreen  (버튼 3회 탭 후: counter = 3)</span>
      <div class="phone">
        <div class="appbar">
          <span>Flutter Counter</span>
        </div>
        <div class="body">
          <p class="counter-label">You have pushed the button<br>this many times:</p>
          <span class="counter-value">3</span>
          <div class="fab" title="Increment (onTap → counter++)">+</div>
        </div>
      </div>
    </div>

    <!-- Annotation Cards -->
    <div class="annotation-wrap">

      <!-- Design Tokens: Color -->
      <div class="annotation-card">
        <h3>🎨 Color Tokens</h3>
        <div class="annotation-row">
          <span class="annotation-key">primary</span>
          <span class="annotation-val"><span class="swatch" style="background:#6200EE;"></span>#6200EE</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">primaryVariant</span>
          <span class="annotation-val"><span class="swatch" style="background:#3700B3;"></span>#3700B3</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">onPrimary</span>
          <span class="annotation-val"><span class="swatch" style="background:#FFFFFF; border:1px solid #ddd;"></span>#FFFFFF</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">background</span>
          <span class="annotation-val"><span class="swatch" style="background:#FFFFFF; border:1px solid #ddd;"></span>#FFFFFF</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">textPrimary</span>
          <span class="annotation-val"><span class="swatch" style="background:#333333;"></span>#333333</span>
        </div>
      </div>

      <!-- Typography -->
      <div class="annotation-card">
        <h3>✏️ Typography</h3>
        <div class="annotation-row">
          <span class="annotation-key">AppBar title</span>
          <span class="annotation-val">20sp / w500</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">Counter label</span>
          <span class="annotation-val">16sp / w400</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">Counter value</span>
          <span class="annotation-val">80sp / w200</span>
        </div>
      </div>

      <!-- Spacing & Size -->
      <div class="annotation-card">
        <h3>📐 Spacing & Size</h3>
        <div class="annotation-row">
          <span class="annotation-key">Body padding H</span>
          <span class="annotation-val">24dp</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">Label → Value gap</span>
          <span class="annotation-val">16dp</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">FAB size</span>
          <span class="annotation-val">56 × 56dp</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">FAB radius</span>
          <span class="annotation-val">16dp</span>
        </div>
      </div>

      <!-- Elevation -->
      <div class="annotation-card">
        <h3>🌒 Elevation</h3>
        <div class="annotation-row">
          <span class="annotation-key">AppBar</span>
          <span class="annotation-val">4dp</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">FAB (resting)</span>
          <span class="annotation-val">6dp</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">FAB (pressed)</span>
          <span class="annotation-val">12dp</span>
        </div>
      </div>

      <!-- State -->
      <div class="annotation-card">
        <h3>⚙️ State</h3>
        <div class="annotation-row">
          <span class="annotation-key">variable</span>
          <span class="annotation-val">counter: int</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">initial</span>
          <span class="annotation-val">0</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">mutator</span>
          <span class="annotation-val">_incrementCounter()</span>
        </div>
        <div class="annotation-row">
          <span class="annotation-key">scope</span>
          <span class="annotation-val">_CounterScreenState</span>
        </div>
      </div>

    </div><!-- /.annotation-wrap -->
  </div><!-- /.layout -->

  <!-- Interaction Flow -->
  <div class="flow-section">
    <h2>🔄 Interaction Flow</h2>
    <div class="flow">
      <div class="flow-step">
        <div class="flow-box">FAB Tap</div>
        <span class="flow-sub">User action</span>
      </div>
      <div class="flow-arrow">→</div>
      <div class="flow-step">
        <div class="flow-box">_incrementCounter()</div>
        <span class="flow-sub">Method call</span>
      </div>
      <div class="flow-arrow">→</div>
      <div class="flow-step">
        <div class="flow-box state">counter++</div>
        <span class="flow-sub">State mutation</span>
      </div>
      <div class="flow-arrow">→</div>
      <div class="flow-step">
        <div class="flow-box state">setState()</div>
        <span class="flow-sub">Trigger rebuild</span>
      </div>
      <div class="flow-arrow">→</div>
      <div class="flow-step">
        <div class="flow-box ui">CounterValue rebuild</div>
        <span class="flow-sub">UI update</span>
      </div>
      <div class="flow-arrow">→</div>
      <div class="flow-step">
        <div class="flow-box ui">숫자 +1 표시</div>
        <span class="flow-sub">Visual result</span>
      </div>
    </div>
  </div>

  <!-- Component Inventory -->
  <div class="comp-section">
    <h2>🧩 Component Inventory</h2>
    <div class="comp-grid">
      <div class="comp-card">
        <h4>AppBar</h4>
        <p>상단 타이틀 바. "Flutter Counter" 텍스트, primary 색상, elevation 4dp.</p>
        <span class="badge">Stateless</span>
      </div>
      <div class="comp-card">
        <h4>CounterLabel</h4>
        <p>설명 텍스트. 16sp / w400 / center align. 고정값, 상태 무관.</p>
        <span class="badge">Stateless</span>
      </div>
      <div class="comp-card">
        <h4>CounterValue</h4>
        <p>현재 counter 값 표시. 80sp / w200. counter 상태에 바인딩.</p>
        <span class="badge">Stateful binding</span>
      </div>
      <div class="comp-card">
        <h4>IncrementFAB</h4>
        <p>+ 아이콘 버튼. 56×56dp. 탭 시 _incrementCounter() 호출.</p>
        <span class="badge">Trigger</span>
      </div>
    </div>
  </div>

</body>
</html>
```

---

## 3. 산출물 요약

| 항목 | 내용 |
|------|------|
| **저장 경로** | `/workspace/30dcf5ed/design_spec.md` |
| **화면 수** | 1개 (`CounterScreen`) |
| **컴포넌트** | AppBar, CounterLabel, CounterValue, IncrementFAB |
| **상태** | `counter: int = 0` → `_incrementCounter()` → `setState()` |
| **Primary** | `#6200EE` (Material Purple) |
| **Counter 폰트** | 80sp / w200 |
| **FAB 크기** | 56×56dp / radius 16dp / elevation 6dp |
| **인터랙션** | FAB tap 1가지만 존재 |