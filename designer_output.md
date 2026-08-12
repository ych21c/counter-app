# UX Designer
Project: 30dcf5ed | Stage: design

# Design Spec: Flutter Counter App

## 프로젝트 정보
- **프로젝트 ID**: 30dcf5ed
- **GitHub**: ych21c/counter-app
- **스테이지**: design (재작업)

---

## 1. JSON 스펙

```json
{
  "screens": [
    {
      "id": "counter_screen",
      "name": "CounterScreen",
      "description": "카운터 앱의 단일 메인 화면",
      "route": "/",
      "components": ["app_bar", "counter_display", "button_row", "reset_button"],
      "background_color": "#F0F4FF",
      "safe_area": true
    }
  ],
  "components": [
    {
      "id": "app_bar",
      "type": "AppBar",
      "props": {
        "title": "Flutter Counter",
        "backgroundColor": "#4F46E5",
        "foregroundColor": "#FFFFFF",
        "centerTitle": true,
        "elevation": 0,
        "fontSize": 20,
        "fontWeight": "bold"
      }
    },
    {
      "id": "counter_display",
      "type": "Card",
      "props": {
        "backgroundColor": "#FFFFFF",
        "borderRadius": 24,
        "elevation": 8,
        "shadowColor": "rgba(79,70,229,0.18)",
        "padding": "48px 64px",
        "margin": "32px 24px",
        "children": [
          {
            "id": "counter_label",
            "type": "Text",
            "text": "현재 카운트",
            "fontSize": 16,
            "fontWeight": "medium",
            "color": "#6B7280",
            "letterSpacing": 1.2
          },
          {
            "id": "counter_value",
            "type": "Text",
            "text": "0",
            "fontSize": 96,
            "fontWeight": "bold",
            "color": "#4F46E5",
            "letterSpacing": -2
          }
        ]
      }
    },
    {
      "id": "button_row",
      "type": "Row",
      "props": {
        "mainAxisAlignment": "center",
        "gap": 24,
        "children": [
          {
            "id": "decrement_button",
            "type": "FloatingActionButton",
            "icon": "remove",
            "backgroundColor": "#EF4444",
            "foregroundColor": "#FFFFFF",
            "size": 64,
            "borderRadius": 20,
            "elevation": 4,
            "tooltip": "감소"
          },
          {
            "id": "increment_button",
            "type": "FloatingActionButton",
            "icon": "add",
            "backgroundColor": "#4F46E5",
            "foregroundColor": "#FFFFFF",
            "size": 64,
            "borderRadius": 20,
            "elevation": 4,
            "tooltip": "증가"
          }
        ]
      }
    },
    {
      "id": "reset_button",
      "type": "TextButton",
      "props": {
        "text": "초기화",
        "icon": "refresh",
        "color": "#6B7280",
        "hoverColor": "#4F46E5",
        "fontSize": 14,
        "fontWeight": "medium",
        "padding": "12px 32px",
        "margin-top": 24,
        "underline": false
      }
    }
  ],
  "design_tokens": {
    "colors": {
      "primary": "#4F46E5",
      "primary_light": "#818CF8",
      "primary_dark": "#3730A3",
      "danger": "#EF4444",
      "danger_light": "#FCA5A5",
      "background": "#F0F4FF",
      "surface": "#FFFFFF",
      "text_primary": "#1F2937",
      "text_secondary": "#6B7280",
      "text_on_primary": "#FFFFFF",
      "border": "#E5E7EB",
      "shadow": "rgba(79,70,229,0.18)"
    },
    "typography": {
      "font_family": "Pretendard, Noto Sans KR, sans-serif",
      "counter_value": { "size": 96, "weight": 700, "line_height": 1.0 },
      "counter_label": { "size": 16, "weight": 500, "line_height": 1.5 },
      "app_bar_title": { "size": 20, "weight": 700, "line_height": 1.4 },
      "button_label": { "size": 14, "weight": 500, "line_height": 1.4 },
      "reset_label": { "size": 14, "weight": 500, "line_height": 1.4 }
    },
    "spacing": {
      "xs": 4,
      "sm": 8,
      "md": 16,
      "lg": 24,
      "xl": 32,
      "xxl": 48
    },
    "border_radius": {
      "sm": 8,
      "md": 16,
      "lg": 24,
      "full": 9999
    },
    "elevation": {
      "card": 8,
      "button": 4,
      "app_bar": 0
    },
    "animation": {
      "counter_scale": "bounce 150ms ease-out",
      "button_press": "scale(0.92) 80ms ease-in-out"
    }
  }
}
```

---

## 2. UX 플로우

```
[앱 시작]
    ↓
[CounterScreen 렌더링]
    ├─ AppBar: "Flutter Counter"
    ├─ CounterDisplay Card: 숫자 "0" 표시
    ├─ ButtonRow: [− 감소] [+ 증가]
    └─ ResetButton: "초기화"

[사용자 액션]
    ├─ + 버튼 클릭 → count++ → 숫자 애니메이션 업데이트
    ├─ − 버튼 클릭 → count-- → 숫자 애니메이션 업데이트
    └─ 초기화 클릭 → count = 0 → 숫자 리셋
```

---

## 3. 화면 스펙 (CounterScreen)

| 영역 | 속성 | 값 |
|------|------|-----|
| 배경색 | background | `#F0F4FF` |
| AppBar 배경 | backgroundColor | `#4F46E5` |
| AppBar 텍스트 | color | `#FFFFFF`, 20px Bold |
| 카드 배경 | backgroundColor | `#FFFFFF` |
| 카드 모서리 | borderRadius | `24px` |
| 카운터 숫자 | font | 96px Bold, `#4F46E5` |
| 카운터 레이블 | font | 16px Medium, `#6B7280` |
| + 버튼 | bg=`#4F46E5`, icon=white, 64×64px, r=20px |
| − 버튼 | bg=`#EF4444`, icon=white, 64×64px, r=20px |
| 초기화 버튼 | text=`#6B7280`, 14px Medium |

---

## SCENARIO:ATM-14

```html
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ATM-14: 카운터 초기 화면</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    font-family: 'Segoe UI', system-ui, sans-serif;
    background: #1a1a2e;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 24px;
  }
  .phone-frame {
    width: 375px;
    height: 780px;
    background: #F0F4FF;
    border-radius: 40px;
    overflow: hidden;
    box-shadow: 0 32px 80px rgba(0,0,0,0.5), 0 0 0 2px #333;
    display: flex;
    flex-direction: column;
    position: relative;
  }
  .status-bar {
    background: #3730A3;
    height: 28px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    padding: 0 20px;
    gap: 6px;
  }
  .status-dot { width: 6px; height: 6px; border-radius: 50%; background: rgba(255,255,255,0.7); }
  .app-bar {
    background: #4F46E5;
    padding: 16px 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 2px 12px rgba(79,70,229,0.3);
  }
  .app-bar-title {
    color: #FFFFFF;
    font-size: 20px;
    font-weight: 700;
    letter-spacing: 0.3px;
  }
  .screen-body {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 24px;
    gap: 32px;
  }
  .scenario-badge {
    position: absolute;
    top: 80px;
    right: 12px;
    background: rgba(79,70,229,0.15);
    color: #4F46E5;
    font-size: 10px;
    font-weight: 700;
    padding: 4px 8px;
    border-radius: 8px;
    border: 1px solid rgba(79,70,229,0.3);
  }
  .counter-card {
    width: 100%;
    background: #FFFFFF;
    border-radius: 24px;
    padding: 40px 32px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    box-shadow: 0 8px 32px rgba(79,70,229,0.18), 0 2px 8px rgba(0,0,0,0.06);
  }
  .counter-label {
    font-size: 13px;
    font-weight: 600;
    color: #6B7280;
    letter-spacing: 2px;
    text-transform: uppercase;
  }
  .counter-value {
    font-size: 96px;
    font-weight: 700;
    color: #4F46E5;
    line-height: 1;
    letter-spacing: -4px;
    font-variant-numeric: tabular-nums;
  }
  .counter-hint {
    font-size: 11px;
    color: #9CA3AF;
    margin-top: 4px;
  }
  .button-row {
    display: flex;
    align-items: center;
    gap: 24px;
  }
  .fab {
    width: 64px;
    height: 64px;
    border-radius: 20px;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    font-weight: 300;
    color: #FFFFFF;
    box-shadow: 0 4px 16px rgba(0,0,0,0.2);
    transition: transform 0.1s;
    position: relative;
    overflow: hidden;
  }
  .fab-decrement { background: linear-gradient(135deg, #EF4444, #DC2626); box-shadow: 0 4px 16px rgba(239,68,68,0.4); }
  .fab-increment { background: linear-gradient(135deg, #4F46E5, #4338CA); box-shadow: 0 4px 16px rgba(79,70,229,0.4); }
  .fab:active { transform: scale(0.92); }
  .fab-label {
    font-size: 10px;
    color: #9CA3AF;
    text-align: center;
    margin-top: 4px;
  }
  .fab-wrapper { display: flex; flex-direction: column; align-items: center; gap: 4px; }
  .reset-btn {
    background: transparent;
    border: 1.5px solid #E5E7EB;
    border-radius: 12px;
    padding: 10px 32px;
    font-size: 13px;
    font-weight: 600;
    color: #6B7280;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 6px;
    transition: all 0.2s;
  }
  .reset-btn:hover { border-color: #4F46E5; color: #4F46E5; }
  .scenario-info {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(79,70,229,0.08);
    padding: 10px 16px;
    border-top: 1px solid rgba(79,70,229,0.12);
  }
  .scenario-info p {
    font-size: 10px;
    color: #4F46E5;
    font-weight: 600;
    text-align: center;
  }
</style>
</head>
<body>
<div style="display:flex; flex-direction:column; align-items:center; gap:20px;">
  <div style="color:#fff; font-size:13px; opacity:0.6; font-weight:500;">ATM-14 · 초기 화면 (카운트 = 0)</div>
  <div class="phone-frame">
    <div class="status-bar">
      <div class="status-dot"></div>
      <div class="status-dot"></div>
      <div class="status-dot"></div>
    </div>
    <div class="app-bar">
      <span class="app-bar-title">🔢 Flutter Counter</span>
    </div>
    <div class="scenario-badge">ATM-14</div>
    <div class="screen-body">
      <div style="text-align:center;">
        <div style="font-size:12px; color:#9CA3AF; font-weight:500; margin-bottom:4px;">시나리오</div>
        <div style="font-size:14px; color:#4F46E5; font-weight:700;">앱 최초 실행 시 초기 상태</div>
      </div>
      <div class="counter-card">
        <div class="counter-label">현재 카운트</div>
        <div class="counter-value">0</div>
        <div class="counter-hint">버튼을 눌러 카운트를 변경하세요</div>
      </div>
      <div class="button-row">
        <div class="fab-wrapper">
          <button class="fab fab-decrement">−</button>
          <div class="fab-label">감소</div>
        </div>
        <div class="fab-wrapper">
          <button class="fab fab-increment">+</button>
          <div class="fab-label">증가</div>
        </div>
      </div>
      <button class="reset-btn">↺ 초기화</button>
    </div>
    <div class="scenario-info">
      <p>✅ 초기 상태: count = 0 | 모든 버튼 활성화</p>
    </div>
  </div>
</div>
</body>
</html>
```

---

## SCENARIO:ATM-15

```html
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ATM-15: 카운터 증가</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    font-family: 'Segoe UI', system-ui, sans-serif;
    background: #1a1a2e;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 24px;
  }
  .phone-frame {
    width: 375px;
    height: 780px;
    background: #F0F4FF;
    border-radius: 40px;
    overflow: hidden;
    box-shadow: 0 32px 80px rgba(0,0,0,0.5), 0 0 0 2px #333;
    display: flex;
    flex-direction: column;
    position: relative;
  }
  .status-bar { background: #3730A3; height: 28px; display: flex; align-items: center; justify-content: flex-end; padding: 0 20px; gap: 6px; }
  .status-dot { width: 6px; height: 6px; border-radius: 50%; background: rgba(255,255,255,0.7); }
  .app-bar { background: #4F46E5; padding: 16px 20px; display: flex; align-items: center; justify-content: center; }
  .app-bar-title { color: #FFFFFF; font-size: 20px; font-weight: 700; }
  .screen-body { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 24px; gap: 28px; }
  .scenario-badge { position: absolute; top: 80px; right: 12px; background: rgba(79,70,229,0.15); color: #4F46E5; font-size: 10px; font-weight: 700; padding: 4px 8px; border-radius: 8px; border: 1px solid rgba(79,70,229,0.3); }
  .counter-card {
    width: 100%;
    background: #FFFFFF;
    border-radius: 24px;
    padding: 40px 32px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    box-shadow: 0 8px 32px rgba(79,70,229,0.18), 0 2px 8px rgba(0,0,0,0.06);
    position: relative;
    overflow: hidden;
  }
  .counter-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 4px;
    background: linear-gradient(90deg, #4F46E5, #818CF8);
  }
  .counter-label { font-size: 13px; font-weight: 600; color: #6B7280; letter-spacing: 2px; text-transform: uppercase; }
  .counter-value { font-size: 96px; font-weight: 700; color: #4F46E5; line-height: 1; letter-spacing: -4px; }
  .change-indicator {
    display: flex;
    align-items: center;
    gap: 4px;
    background: #EEF2FF;
    border: 1px solid #C7D2FE;
    border-radius: 20px;
    padding: 4px 12px;
    font-size: 12px;
    font-weight: 600;
    color: #4F46E5;
    margin-top: 4px;
  }
  .button-row { display: flex; align-items: center; gap: 24px; }
  .fab {
    width: 64px; height: 64px; border-radius: 20px; border: none; cursor: pointer;
    display: flex; align-items: center; justify-content: center;
    font-size: 28px; font-weight: 300; color: #FFFFFF;
    box-shadow: 0 4px 16px rgba(0,0,0,0.2);
  }
  .fab-decrement { background: linear-gradient(135deg, #EF4444, #DC2626); box-shadow: 0 4px 16px rgba(239,68,68,0.4); }
  .fab-increment {
    background: linear-gradient(135deg, #4F46E5, #4338CA);
    box-shadow: 0 4px 24px rgba(79,70,229,0.5);
    transform: scale(1.08);
    outline: 3px solid rgba(79,70,229,0.3);
    outline-offset: 3px;
  }
  .fab-wrapper { display: flex; flex-direction: column; align-items: center; gap: 4px; }
  .fab-label { font-size: 10px; color: #9CA3AF; text-align: center; }
  .fab-active-label { font-size: 10px; color: #4F46E5; font-weight: 700; }
  .reset-btn { background: transparent; border: 1.5px solid #E5E7EB; border-radius: 12px; padding: 10px 32px; font-size: 13px; font-weight: 600; color: #6B7280; cursor: pointer; display: flex; align-items: center; gap: 6px; }
  .action-log {
    width: 100%;
    background: #F9FAFB;
    border: 1px solid #E5E7EB;
    border-radius: 12px;
    padding: 12px 16px;
  }
  .log-title { font-size: 10px; color: #9CA3AF; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 6px; }
  .log-item { font-size: 11px; color: #374151; display: flex; justify-content: space-between; padding: 2px 0; }
  .log-item span { color: #4F46E5; font-weight: 600; }
  .scenario-info { position: absolute; bottom: 0; left: 0; right: 0; background: rgba(79,70,229,0.08); padding: 10px 16px; border-top: 1px solid rgba(79,70,229,0.12); }
  .scenario-info p { font-size: 10px; color: #4F46E5; font-weight: 600; text-align: center; }
</style>
</head>
<body>
<div style="display:flex; flex-direction:column; align-items:center; gap:20px;">
  <div style="color:#fff; font-size:13px; opacity:0.6; font-weight:500;">ATM-15 · + 버튼 클릭으로 카운트 증가</div>
  <div class="phone-frame">
    <div class="status-bar">
      <div class="status-dot"></div><div class="status-dot"></div><div class="status-dot"></div>
    </div>
    <div class="app-bar"><span class="app-bar-title">🔢 Flutter Counter</span></div>
    <div class="scenario-badge">ATM-15</div>
    <div class="screen-body">
      <div style="text-align:center;">
        <div style="font-size:12px; color:#9CA3AF; font-weight:500; margin-bottom:4px;">시나리오</div>
        <div style="font-size:14px; color:#4F46E5; font-weight:700;">+ 버튼 클릭 → 카운트 증가</div>
      </div>
      <div class="counter-card">
        <div class="counter-label">현재 카운트</div>
        <div class="counter-value">5</div>
        <div class="change-indicator">▲ +1 증가됨</div>
      </div>
      <div class="action-log">
        <div class="log-title">액션 로그</div>
        <div class="log-item">초기값 <span>0</span></div>
        <div class="log-item">+1 클릭 × 5회 <span>→ 5</span></div>
      </div>
      <div class="button-row">
        <div class="fab-wrapper">
          <button class="fab fab-decrement">−</button>
          <div class="fab-label">감소</div>
        </div>
        <div class="fab-wrapper">
          <button class="fab fab-increment">+</button>
          <div class="fab-active-label">▶ 클릭됨</div>
        </div>
      </div>
      <button class="reset-btn">↺ 초기화</button>
    </div>
    <div class="scenario-info"><p>✅ + 버튼 클릭 시 count += 1 | 현재: 5</p></div>
  </div>
</div>
</body>
</html>
```

---

## SCENARIO:ATM-16

```html
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ATM-16: 카운터 감소</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    font-family: 'Segoe UI', system-ui, sans-serif;
    background: #1a1a2e;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 24px;
  }
  .phone-frame {
    width: 375px;
    height: 780px;
    background: #F0F4FF;
    border-radius: 40px;
    overflow: hidden;
    box-shadow: 0 32px 80px rgba(0,0,0,0.5), 0 0 0 2px #333;
    display: flex;
    flex-direction: column;
    position: relative;
  }
  .status-bar { background: #3730A3; height: 28px; display: flex; align-items: center; justify-content: flex-end; padding: 0 20px; gap: 6px; }
  .status-dot { width: 6px; height: 6px; border-radius: 50%; background: rgba(255,255,255,0.7); }
  .app-bar { background: #4F46E5; padding: 16px 20px; display: flex; align-items: center; justify-content: center; }
  .app-bar-title { color: #FFFFFF; font-size: 20px; font-weight: 700; }
  .screen-body { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 24px; gap: 28px; }
  .scenario-badge { position: absolute; top: 80px; right: 12px; background: rgba(239,68,68,0.12); color: #EF4444; font-size: 10px; font-weight: 700; padding: 4px 8px; border-radius: 8px; border: 1px solid rgba(239,68,68,0.25); }
  .counter-card {
    width: 100%;
    background: #FFFFFF;
    border-radius: 24px;
    padding: 40px 32px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    box-shadow: 0 8px 32px rgba(239,68,68,0.12), 0 2px 8px rgba(0,0,0,0.06);
    position: relative;
    overflow: hidden;
  }
  .counter-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 4px;
    background: linear-gradient(90deg, #EF4444, #FCA5A5);
  }
  .counter-label { font-size: 13px; font-weight: 600; color: #6B7280; letter-spacing: 2px; text-transform: uppercase; }
  .counter-value { font-size: 96px; font-weight: 700; color: #EF4444; line-height: 1; letter-spacing: -4px; }
  .change-indicator {
    display: flex;
    align-items: center;
    gap: 4px;
    background: #FEF2F2;
    border: 1px solid #FECACA;
    border-radius: 20px;
    padding: 4px 12px;
    font-size: 12px;
    font-weight: 600;
    color: #EF4444;
    margin-top: 4px;
  }
  .button-row { display: flex; align-items: center; gap: 24px; }
  .fab {
    width: 64px; height: 64px; border-radius: 20px; border: none; cursor: pointer;
    display: flex; align-items: center; justify-content: center;
    font-size: 28px; font-weight: 300; color: #FFFFFF;
  }
  .fab-decrement {
    background: linear-gradient(135deg, #EF4444, #DC2626);
    box-shadow: 0 4px 24px rgba(239,68,68,0.5);
    transform: scale(1.08);
    outline: 3px solid rgba(239,68,68,0.3);
    outline-offset: 3px;
  }
  .fab-increment { background: linear-gradient(135deg, #4F46E5, #4338CA); box-shadow: 0 4px 16px rgba(79,70,229,0.4); }
  .fab-wrapper { display: flex; flex-direction: column; align-items: center; gap: 4px; }
  .fab-label { font-size: 10px; color: #9CA3AF; text-align: center; }
  .fab-active-label { font-size: 10px; color: #EF4444; font-weight: 700; }
  .reset-btn { background: transparent; border: 1.5px solid #E5E7EB; border-radius: 12px; padding: 10px 32px; font-size: 13px; font-weight: 600; color: #6B7280; cursor: pointer; display: flex; align-items: center; gap: 6px; }
  .action-log { width