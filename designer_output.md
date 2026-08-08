# UX Designer
Project: 30dcf5ed | Stage: design

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