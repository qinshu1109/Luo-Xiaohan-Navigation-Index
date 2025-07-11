# Shrimp Task Manager MCP 配置指南

## 📋 项目信息
- **项目仓库**: https://github.com/cjo4m06/mcp-shrimp-task-manager
- **配置类型**: MCP Server
- **主要功能**: 任务管理、项目规划、工作流程协调

## 🔧 配置方法

### 方法1: NPX配置（推荐）
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

### 方法2: 本地构建配置
```json
{
  "type": "stdio",
  "name": "Shrimp Task Manager",
  "id": "shrimp-task-manager",
  "disabled": false,
  "useShellInterpolation": false,
  "command": "node",
  "args": ["dist/index.js", "--stdio"]
}
```

## 🌟 核心功能

### 任务规划工具
- `plan_task`: 任务规划指导
- `analyze_task`: 深入分析任务需求
- `reflect_task`: 批判性审查分析结果
- `split_tasks`: 复杂任务分解

### 任务管理工具
- `list_tasks`: 生成结构化任务清单
- `execute_task`: 获取任务执行指导
- `verify_task`: 任务验证评分
- `update_task`: 更新任务内容

### 思维工具
- `process_thought`: 灵活思考流程
- `research_mode`: 专门研究模式

## ⚙️ 环境变量配置

```bash
# 数据存储目录
DATA_DIR=/path/to/data

# 模板使用
TEMPLATES_USE=true

# GUI界面
ENABLE_GUI=true

# Web端口
WEB_PORT=3000
```

## 🎯 使用最佳实践

### 任务拆分原则
1. **最小可交付单元**: 1-2个工作天完成
2. **最大复杂度限制**: 不跨越多个技术领域
3. **任务数量建议**: 一次不超过10项子任务
4. **深度层级限制**: 不超过3层

### 工作流程
1. 使用`plan_task`进行初始规划
2. 通过`analyze_task`深入分析
3. 用`reflect_task`批判性审查
4. 执行`split_tasks`进行任务分解
5. 使用`execute_task`获取执行指导
6. 完成后用`verify_task`进行验证

## 🔗 相关链接
- [项目文档](https://github.com/cjo4m06/mcp-shrimp-task-manager/blob/main/README.md)
- [VSCode Augment配置](./vscode-augment.md)
- [任务管理最佳实践](../knowledge/best-practices.md)

## 📝 常见问题

### Q: 如何处理任务依赖关系？
A: 在`split_tasks`时明确标注dependencies字段，系统会自动计算执行顺序。

### Q: 任务验证评分标准是什么？
A: 基于需求符合性(30%)、技术质量(30%)、集成兼容性(20%)、性能可扩展性(20%)。

### Q: 如何优化Token使用？
A: 使用gemini-2.5-flash-preview-05-20-thinking模型进行规划，开启两个IDE窗口并发执行。

---
*最后更新: 2025-01-11*
