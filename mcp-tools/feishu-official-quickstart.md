# 飞书官方MCP快速配置指南

## 🚀 一键配置脚本

### 使用自动化脚本
```bash
# 进入工具目录
cd Luo-Xiaohan-Navigation-Index/mcp-tools

# 运行配置脚本
./feishu-official-setup.sh
```

脚本将自动完成：
1. ✅ 检查Node.js环境
2. ✅ 获取应用信息输入
3. ✅ 选择配置模式
4. ✅ 执行OAuth登录
5. ✅ 测试MCP连接
6. ✅ 生成VSCode配置

## 📋 手动配置步骤

### 步骤1: 创建飞书应用
1. 访问 [飞书开放平台](https://open.feishu.cn/app)
2. 点击"创建企业自建应用"
3. 填写应用信息，获取App ID和App Secret
4. 在"安全设置"中配置重定向URL: `http://localhost:3000/callback`

### 步骤2: 配置应用权限
在"权限管理"中添加以下权限：

**文档权限**:
- `docx:document` - 查看、编辑、评论和管理文档
- `docx:document:readonly` - 查看文档

**消息权限**:
- `im:message` - 获取与发送单聊、群组消息
- `im:message:readonly` - 读取用户发给机器人的单聊消息
- `im:chat` - 获取群组信息

**多维表格权限**:
- `bitable:app` - 查看、编辑多维表格

**知识库权限**:
- `wiki:wiki` - 查看、编辑知识库

### 步骤3: OAuth登录
```bash
# 首次登录
npx -y @larksuiteoapi/lark-mcp login -a your_app_id -s your_app_secret

# 指定权限范围登录（可选）
npx -y @larksuiteoapi/lark-mcp login -a your_app_id -s your_app_secret --scope offline_access docx:document
```

### 步骤4: VSCode Augment配置

#### 轻量级配置（推荐）
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
    "-a", "your_app_id",
    "-s", "your_app_secret",
    "--oauth",
    "-l", "zh",
    "-t", "preset.light"
  ]
}
```

#### 文档专用配置
```json
{
  "type": "stdio",
  "name": "飞书文档MCP",
  "id": "feishu-doc-mcp",
  "disabled": false,
  "useShellInterpolation": false,
  "command": "npx",
  "args": [
    "-y",
    "@larksuiteoapi/lark-mcp",
    "mcp",
    "-a", "your_app_id",
    "-s", "your_app_secret",
    "--oauth",
    "-l", "zh",
    "-t", "preset.doc.default"
  ]
}
```

## 🔧 核心功能使用

### 纯文本读取文档
```javascript
// 使用 docx.v1.document.rawContent 工具
// Token消耗: 2K-8K (节约85%+)
```

### 搜索文档
```javascript
// 使用 docx.builtin.search 工具
// 支持关键词搜索，快速定位文档
```

### 发送消息
```javascript
// 使用 im.v1.message.create 工具
// 支持发送文本、富文本、卡片消息
```

### 搜索多维表格
```javascript
// 使用 bitable.v1.appTableRecord.search 工具
// 支持条件查询、分页获取
```

## 💡 最佳实践

### Token优化策略
1. **优先使用轻量工具集**: `preset.light` 减少50%+ Token消耗
2. **纯文本读取优先**: 使用 `rawContent` 而非结构化读取
3. **批量操作**: 使用 `batchCreate` 等批量API
4. **精准权限**: 只申请必要的API权限

### 常用工具组合
- **文档管理**: `docx.v1.document.rawContent` + `docx.builtin.search`
- **消息通信**: `im.v1.message.create` + `im.v1.chat.list`
- **数据处理**: `bitable.v1.appTableRecord.search` + `bitable.v1.appTableRecord.batchCreate`

## 🔍 故障排查

### OAuth登录失败
- 检查重定向URL: `http://localhost:3000/callback`
- 确认应用状态为"已启用"
- 检查网络连接和防火墙设置

### 权限被拒绝
- 在开发者后台检查权限申请状态
- 部分高级权限需要人工审核
- 详细说明使用场景

### Token过期
- 使用 `--oauth` 参数启用自动刷新
- 手动重新登录: `npx -y @larksuiteoapi/lark-mcp login`

## 📚 参考资源

- [官方GitHub仓库](https://github.com/larksuite/lark-openapi-mcp)
- [飞书开放平台文档](https://open.feishu.cn/document/uAjLw4CM/ukTMukTMukTM/mcp_integration/mcp_introduction)
- [API权限说明](https://open.feishu.cn/document/ukTMukTMukTM/uQjN3QjL0YzN04CN2cDN)
- [OAuth 2.0指南](https://open.feishu.cn/document/uAjLw4CM/ukTMukTMukTM/authentication-management/access-token/get-user-access-token)

---
*配置完成后，即可在VSCode Augment中使用完整的飞书API功能！*
