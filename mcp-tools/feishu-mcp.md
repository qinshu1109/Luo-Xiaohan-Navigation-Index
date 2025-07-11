# 飞书MCP配置指南

## 📋 项目信息
- **项目类型**: 飞书文档管理MCP
- **主要功能**: 飞书文档操作、知识库管理、内容编辑

## 🚨 Token优化策略

### 问题描述
- `get_feishu_document_blocks`工具单次调用消耗60K Tokens
- 全文档结构加载导致Token浪费
- 需要优化策略减少Token消耗

### 解决方案A+B（推荐）

#### A方案：工具瘦身
```bash
# 升级到v0.15+版本
npm install feishu-mcp@latest

# 配置参数
--tool-set core
--nav-lazy true
--nav-top-k 30
--nav-max-depth 2
```

#### B方案：懒加载导航
- Token消耗从60K降至<10K
- 实施AI端摘要优先规则
- 结构化文档管理

### Git仓库方案（最简单）
- 使用Git仓库存储导航索引
- 避免飞书MCP全量加载
- 通过GitHub PAT访问导航信息

## 🔧 核心工具功能

### 文档管理
- `create_feishu_document`: 创建新文档
- `get_feishu_document_info`: 获取文档信息
- `get_feishu_document_blocks`: 获取文档结构（高Token消耗）
- `search_feishu_documents`: 搜索文档

### 内容编辑
- `batch_create_feishu_blocks`: 批量创建内容块（推荐）
- `update_feishu_block_text`: 更新文本内容
- `delete_feishu_document_blocks`: 删除内容块

### 文件管理
- `get_feishu_folder_files`: 获取文件夹内容
- `create_feishu_folder`: 创建文件夹
- `upload_and_bind_image_to_block`: 图片上传绑定

## 🎯 使用最佳实践

### Token优化策略
1. **避免全量加载**: 不使用`get_feishu_document_blocks`除非必要
2. **Playwright定位**: 使用Playwright找到位置后用API精确操作
3. **批量操作**: 优先使用`batch_create_feishu_blocks`
4. **摘要优先**: AI端实施摘要优先规则

### 文档操作流程
1. 使用Playwright定位目标位置
2. 获取必要的blockId信息
3. 使用精确的API工具进行操作
4. 避免加载完整文档结构

### 知识库管理
- **Context 7 + Playwright + Web搜索AI**: 自主管理最佳实践
- **避免导航索引全量加载**: 防止60K Token消耗
- **结构化存储**: 使用Git仓库存储导航信息

## 🔗 相关链接
- [飞书开发者文档](https://open.feishu.cn/document/)
- [MCP工具使用指南（合并版）](https://fcn8mctq4tqd.feishu.cn/docx/W2xid0FolojOyUx02r4c9zian7g)
- [完整飞书链接索引](../feishu-links/README.md)
- [Token优化策略](../optimization/feishu-mcp-token.md)

## 📝 常见问题

### Q: 如何避免60K Token消耗？
A: 使用A+B方案或Git仓库方案，避免调用`get_feishu_document_blocks`。

### Q: 如何精确定位文档位置？
A: 结合Playwright UI定位和飞书MCP API精确操作。

### Q: 批量操作有什么优势？
A: `batch_create_feishu_blocks`可减少90%的API调用次数。

### Q: 如何处理图片上传？
A: 先创建空白图片块，再使用`upload_and_bind_image_to_block`绑定。

---
*最后更新: 2025-01-11*
