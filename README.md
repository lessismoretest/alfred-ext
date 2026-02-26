# Alfred 扩展（ChatGPT + Telegram + Feishu）

## 快速开始
1. 导入安装包：
   - `SendToChatGPT.alfredworkflow`
   - `SendToTelegram.alfredworkflow`
   - `SendToFeishu.alfredworkflow`
2. 开启 Fallback（只需一次）：
   - `Alfred Preferences -> Features -> Default Results -> Setup fallback results`
   - 勾选：
     - `Send to ChatGPT: '{query}'`
     - `Send to Telegram: '{query}'`
     - `Send to Feishu: '{query}'`

完成后就能直接在 Alfred 输入文本并选择对应项发送，无需前缀关键词。

## ChatGPT 扩展
主交互（推荐）：
1. Alfred 直接输入文本
2. 选择 `Send to ChatGPT: '{query}'`
3. 回车发送

备用入口：
- `cgp 你的文本`

## Telegram 扩展
先配置变量：
1. `Alfred Preferences -> Workflows -> Send to Telegram`
2. 右上角 `Variables` 新增：
   - `TG_BOT_USERNAME`（机器人用户名，不带 `@`）

触发方式：
- Fallback：`Send to Telegram: '{query}'`
- 关键词备用：`tgb 你的文本`

## Feishu 扩展
触发方式：
- Fallback：`Send to Feishu: '{query}'`
- 关键词备用：`fei 你的文本`

说明：
- 自动启动 Feishu/Lark 并发送到当前激活聊天窗口。
- 可选变量：`FEISHU_TARGET_NAME`（例如 `Openclaw`）、`FEISHU_TARGET_SHORTCUT=cmd_j|cmd_k`、`FEISHU_SEND_MODE=enter|cmd_enter|both`

## 权限
首次运行可能需要允许：
- `Alfred` 辅助功能权限（Accessibility）
- `ChatGPT` / `Telegram` / `Feishu` 自动化权限（Automation）
