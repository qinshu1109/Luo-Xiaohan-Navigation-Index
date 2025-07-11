# VSCode Augment MCP配置指南

## 📋 配置格式要求

### JSON格式规范
VSCode Augment插件要求单个服务器对象JSON格式（非mcpServers包装器）：

```json
{
  "type": "stdio",
  "name": "服务器名称",
  "id": "服务器ID",
  "disabled": false,
  "useShellInterpolation": false,
  "command": "命令",
  "args": ["参数1", "参数2", "--stdio"]
}
```

### 必需字段说明
- `type`: 通信类型，固定为"stdio"
- `name`: 显示名称
- `id`: 唯一标识符
- `disabled`: 是否禁用
- `useShellInterpolation`: Shell插值
- `--stdio`: MCP协议通信参数（必须）

## 🔧 常用MCP服务器配置

### Shrimp Task Manager
```json
{
  "type": "stdio",
  "name": "Shrimp Task Manager",
  "id": "shrimp-task-manager",
  "disabled": false,
  "useShellInterpolation": false,
  "command": "npx",
  "args": ["-y", "mcp-shrimp-task-manager", "--stdio"]
}
```

### 飞书MCP
```json
{
  "type": "stdio",
  "name": "Feishu MCP",
  "id": "feishu-mcp",
  "disabled": false,
  "useShellInterpolation": false,
  "command": "npx",
  "args": ["-y", "feishu-mcp", "--stdio"]
}
```

### Zen MCP
```json
{
  "type": "stdio",
  "name": "Zen MCP",
  "id": "zen-mcp",
  "disabled": false,
  "useShellInterpolation": false,
  "command": "npx",
  "args": ["-y", "zen-mcp", "--stdio"]
}
```

## 🎯 配置最佳实践

### 环境变量配置
```json
{
  "type": "stdio",
  "name": "Custom MCP",
  "id": "custom-mcp",
  "disabled": false,
  "useShellInterpolation": true,
  "command": "node",
  "args": ["${workspaceFolder}/dist/index.js", "--stdio"],
  "env": {
    "DATA_DIR": "${workspaceFolder}/data",
    "ENABLE_GUI": "true"
  }
}
```

### 多项目隔离
使用ListRoots协议支持项目隔离：
```json
{
  "type": "stdio",
  "name": "Project Specific MCP",
  "id": "project-mcp",
  "disabled": false,
  "useShellInterpolation": false,
  "command": "node",
  "args": ["dist/index.js", "--stdio", "--project-root", "${workspaceFolder}"]
}
```

## 🔍 调试与故障排除

### 常见错误
1. **缺少--stdio参数**: MCP协议要求必须包含
2. **JSON格式错误**: 确保使用单个对象而非数组
3. **路径问题**: 使用绝对路径或正确的相对路径
4. **权限问题**: 确保命令有执行权限

### 调试方法
1. 检查VSCode输出面板的MCP日志
2. 验证命令行是否能独立运行
3. 确认所有依赖已正确安装
4. 检查环境变量是否正确设置

## 🔗 相关链接
- [VSCode Augment官方文档](https://docs.augmentcode.com/)
- [MCP协议规范](https://modelcontextprotocol.io/)
- [Shrimp Task Manager配置](./shrimp-task-manager.md)
- [飞书MCP配置](./feishu-mcp.md)

## 📝 配置模板

### 基础模板
```json
{
  "type": "stdio",
  "name": "MCP_NAME",
  "id": "mcp-id",
  "disabled": false,
  "useShellInterpolation": false,
  "command": "COMMAND",
  "args": ["ARG1", "ARG2", "--stdio"]
}
```

### 高级模板（带环境变量）
```json
{
  "type": "stdio",
  "name": "Advanced MCP",
  "id": "advanced-mcp",
  "disabled": false,
  "useShellInterpolation": true,
  "command": "node",
  "args": ["${workspaceFolder}/path/to/server.js", "--stdio"],
  "env": {
    "NODE_ENV": "development",
    "DEBUG": "mcp:*"
  }
}
```

---
*最后更新: 2025-01-11*
