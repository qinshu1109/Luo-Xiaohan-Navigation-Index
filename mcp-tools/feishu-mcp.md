# 飞书MCP配置指南（官方版本）

## 📋 项目信息
- **项目类型**: 飞书官方OpenAPI MCP
- **官方仓库**: https://github.com/larksuite/lark-openapi-mcp
- **npm包名**: @larksuiteoapi/lark-mcp
- **主要功能**: 完整的飞书API工具集、双重身份验证、灵活通信协议

## � 官方MCP配置方案

### 1. 快速安装配置

#### VSCode Augment配置
```json
{
  "mcpServers": {
    "lark-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "@larksuiteoapi/lark-mcp",
        "mcp",
        "-a",
        "cli_a8e4b7ee5234d00c",
        "-s",
        "aZredjZqWygP1kbFrwCfLK45FPxHa8wO",
        "--oauth"
      ]
    }
  }
}
```

#### 应用创建准备
1. 访问[飞书开放平台](https://open.feishu.cn/)并登录
2. 创建新应用，获取App ID和App Secret
3. 配置OAuth重定向URL: `http://localhost:3000/callback`
4. 添加所需API权限（文档读写、消息发送等）

### 2. 用户身份认证配置

#### OAuth登录（推荐）
```bash
# 首次登录获取用户访问令牌
npx -y @larksuiteoapi/lark-mcp login -a cli_a8e4b7ee5234d00c -s aZredjZqWygP1kbFrwCfLK45FPxHa8wO

# 指定权限范围登录
npx -y @larksuiteoapi/lark-mcp login -a cli_a8e4b7ee5234d00c -s aZredjZqWygP1kbFrwCfLK45FPxHa8wO --scope offline_access docx:document
```

#### 配置文件（启用OAuth）
```json
{
  "mcpServers": {
    "lark-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "@larksuiteoapi/lark-mcp",
        "mcp",
        "-a", "cli_a8e4b7ee5234d00c",
        "-s", "aZredjZqWygP1kbFrwCfLK45FPxHa8wO",
        "--oauth",
        "-l", "zh",
        "-t", "preset.light"
      ]
    }
  }
}
```

### 3. 预设工具集配置

#### 轻量级配置（推荐）
```bash
# 启用轻量级工具集，减少Token消耗
-t preset.light
```

#### 文档专用配置
```bash
# 启用文档相关工具
-t preset.doc.default
```

#### 自定义工具配置
```bash
# 只启用特定API工具
-t docx.v1.document.rawContent,docx.builtin.search,im.v1.message.create
```

## 🔧 核心工具功能

### 文档管理工具
- `docx.v1.document.rawContent`: **纯文本读取文档**（Token优化）
- `docx.builtin.search`: 搜索文档
- `docx.builtin.import`: 导入文档
- `drive.v1.permissionMember.create`: 添加协作者权限

### 消息通信工具
- `im.v1.message.create`: 发送消息
- `im.v1.message.list`: 获取消息列表
- `im.v1.chat.create`: 创建群聊
- `im.v1.chat.list`: 获取群聊列表

### 多维表格工具
- `bitable.v1.app.create`: 创建多维表格
- `bitable.v1.appTableRecord.search`: 搜索记录
- `bitable.v1.appTableRecord.batchCreate`: 批量创建记录

### 知识库工具
- `wiki.v2.space.getNode`: 获取知识库节点
- `wiki.v1.node.search`: 搜索知识库节点

## 🎯 Token优化策略

### 核心优化原则
1. **使用纯文本读取**: `docx.v1.document.rawContent` 替代复杂结构读取
2. **选择轻量工具集**: 使用 `preset.light` 减少工具数量
3. **精准权限配置**: 只申请必要的API权限
4. **批量操作优先**: 使用批量API减少调用次数

### Token消耗对比
- **纯文本读取**: 2K-8K Tokens（推荐）
- **结构化读取**: 30K-60K Tokens（避免使用）
- **轻量工具集**: 减少50%+ Token消耗
- **精准权限**: 减少不必要的权限检查开销

## �️ 实际配置步骤

### 步骤1: 创建飞书应用
1. 访问 https://open.feishu.cn/app
2. 创建企业自建应用
3. 记录App ID和App Secret
4. 配置重定向URL: `http://localhost:3000/callback`

### 步骤2: 配置应用权限
必需权限：
- `docx:document` - 文档读写权限
- `im:message` - 消息发送权限
- `im:chat` - 群聊管理权限
- `bitable:app` - 多维表格权限
- `wiki:wiki` - 知识库权限

### 步骤3: 安装和登录
```bash
# 首次登录
npx -y @larksuiteoapi/lark-mcp login -a cli_a8e4b7ee5234d00c -s aZredjZqWygP1kbFrwCfLK45FPxHa8wO

# 验证登录状态
npx -y @larksuiteoapi/lark-mcp mcp -a cli_a8e4b7ee5234d00c -s aZredjZqWygP1kbFrwCfLK45FPxHa8wO --oauth -t preset.light
```

### 步骤4: VSCode Augment配置
```json
{
  "type": "stdio",
  "name": "飞书官方MCP",
  "id": "feishu-official-mcp",
  "disabled": false,
  "useShellInterpolation": false,
  "command": "npx",
  "args": [
    "-y",
    "@larksuiteoapi/lark-mcp",
    "mcp",
    "-a", "cli_a8e4b7ee5234d00c",
    "-s", "aZredjZqWygP1kbFrwCfLK45FPxHa8wO",
    "--oauth",
    "-l", "zh",
    "-t", "preset.light"
  ]
}
```

## 🔗 相关链接
- [飞书官方MCP仓库](https://github.com/larksuite/lark-openapi-mcp)
- [飞书开放平台](https://open.feishu.cn/)
- [官方文档](https://open.feishu.cn/document/uAjLw4CM/ukTMukTMukTM/mcp_integration/mcp_introduction)
- [完整飞书链接索引](../feishu-links/README.md)
- [Token优化策略](../optimization/feishu-mcp-token.md)

## 📝 常见问题

### Q: 如何实现纯文本读取？
A: 使用 `docx.v1.document.rawContent` 工具，Token消耗仅2K-8K，比结构化读取节约85%+。

### Q: OAuth登录失败怎么办？
A: 检查重定向URL配置是否正确，确保为 `http://localhost:3000/callback`。

### Q: 如何选择合适的预设工具集？
A:
- `preset.light`: 轻量级，适合Token敏感场景
- `preset.doc.default`: 文档操作专用
- `preset.im.default`: 消息通信专用

### Q: 权限申请被拒绝怎么办？
A: 在开发者后台详细说明使用场景，部分高级权限需要人工审核。

### Q: 如何处理Token过期？
A: 使用 `--oauth` 参数启用自动Token刷新机制。

---
*最后更新: 2025-01-12*
