# Zen MCP配置指南

## 📋 项目信息
- **项目类型**: AI协作工具集
- **主要功能**: 15个AI工具，专注高效协作和智能分析
- **配置位置**: `/home/qqinshu/视频/zen-mcp-server/`

## 🔧 VSCode Augment配置
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

## 💡 核心工具（推荐优先使用）
- 💬 **chat_zen**: 通用对话和协作思考
- 🧠 **thinkdeep_zen**: 深度调查分析，系统性问题解决
- 📋 **planner_zen**: 交互式规划工具，逐步构建计划
- 🐛 **debug_zen**: 调试和根因分析
- 🔍 **analyze_zen**: 综合分析工具，代码和架构评估

## ⚠️ 高消耗工具（谨慎使用）
- 🤝 **consensus_zen**: 多模型共识分析（消耗多个模型tokens）
- 🔒 **secaudit_zen**: 安全审计工具（大型项目时token消耗巨大）
- 📚 **docgen_zen**: 文档生成工具
- 👁️ **codereview_zen**: 代码审查工具

## 🎯 Token节约策略
1. **优先使用高效工具**: chat_zen, thinkdeep_zen, planner_zen
2. **精准使用高消耗工具**: 只在真正需要时使用consensus_zen等
3. **分批处理大型任务**: 将复杂项目分解为小模块
4. **模型选择优化**: 根据任务复杂度选择合适的AI模型

## 🔗 相关链接
- [MCP工具使用指南](https://fcn8mctq4tqd.feishu.cn/docx/W2xid0FolojOyUx02r4c9zian7g)
- [VSCode Augment配置](./vscode-augment.md)
- [Token优化策略](../optimization/feishu-mcp-token.md)

---
*最后更新: 2025-01-11*
