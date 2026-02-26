# Alfred 扩展：发送文本到飞书

## 触发方式
- Fallback：直接输入文本后选择 `Send to Feishu: '{query}'`
- 关键词备用：`fei 你的文本`

## 说明
- 脚本会自动启动 Feishu/Lark（如未启动），并发送到“当前激活聊天窗口输入框”。
- 默认发送按键是 Enter。

可选变量：
- 默认内置目标：`Openclaw`（脚本内置，无需配置）
- 可选覆盖变量：
  - `FEISHU_TARGET_NAME`：目标联系人/机器人名称
  - `FEISHU_TARGET_SHORTCUT`：`cmd_k`（默认）或 `cmd_j`
  - `FEISHU_SEND_MODE`：`enter`（默认）/`cmd_enter`/`both`
