# Alfred 扩展：发送文本到 Telegram 机器人

## 主要用法
- 直接输入文本（Fallback）：
  在 Alfred 输入任意文本后，选择 `Send to Telegram: '{query}'`
- 关键词备用：`tgb 你的文本`

## 必配
在该 Workflow 中设置环境变量：
- `TG_BOT_USERNAME`：目标机器人用户名（不带 `@`）

例如：`my_alert_bot`

## 首次配置
1. 导入 `SendToTelegram.alfredworkflow`
2. Alfred -> Workflows -> Send to Telegram -> [x] Variables
3. 新增 `TG_BOT_USERNAME`
4. 如需 fallback 体验：
   `Features -> Default Results -> Setup fallback results` 中勾选本 workflow 的 fallback 项

## 说明
- 通过 `tg://resolve?domain=...&text=...` 打开 Telegram 并填入文本。
- 脚本会尝试自动回车发送；若 Telegram 客户端设置阻止回车发送，请改客户端设置。
