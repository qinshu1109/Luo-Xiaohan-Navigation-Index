#!/bin/bash

# 飞书官方MCP配置脚本
# 作者: 罗小涵
# 日期: 2025-01-12

echo "🚀 飞书官方MCP配置助手"
echo "================================"

# 检查Node.js环境
check_nodejs() {
    echo "📋 检查Node.js环境..."
    if ! command -v node &> /dev/null; then
        echo "❌ 未检测到Node.js，请先安装Node.js"
        echo "   下载地址: https://nodejs.org/"
        exit 1
    fi
    
    NODE_VERSION=$(node -v)
    echo "✅ Node.js版本: $NODE_VERSION"
}

# 获取用户输入
get_user_input() {
    echo ""
    echo "📝 请输入飞书应用信息:"
    
    read -p "App ID (cli_开头): " APP_ID
    if [[ ! $APP_ID =~ ^cli_ ]]; then
        echo "❌ App ID格式错误，应该以cli_开头"
        exit 1
    fi
    
    read -s -p "App Secret: " APP_SECRET
    echo ""
    
    if [ -z "$APP_SECRET" ]; then
        echo "❌ App Secret不能为空"
        exit 1
    fi
    
    echo "✅ 应用信息已获取"
}

# 选择配置模式
choose_config_mode() {
    echo ""
    echo "🔧 请选择配置模式:"
    echo "1. 轻量级配置 (preset.light) - Token优化"
    echo "2. 文档专用配置 (preset.doc.default)"
    echo "3. 消息通信配置 (preset.im.default)"
    echo "4. 自定义配置"
    
    read -p "请选择 (1-4): " MODE_CHOICE
    
    case $MODE_CHOICE in
        1)
            PRESET="preset.light"
            echo "✅ 已选择轻量级配置"
            ;;
        2)
            PRESET="preset.doc.default"
            echo "✅ 已选择文档专用配置"
            ;;
        3)
            PRESET="preset.im.default"
            echo "✅ 已选择消息通信配置"
            ;;
        4)
            read -p "请输入自定义工具列表 (逗号分隔): " CUSTOM_TOOLS
            PRESET="$CUSTOM_TOOLS"
            echo "✅ 已选择自定义配置: $PRESET"
            ;;
        *)
            echo "❌ 无效选择，使用默认轻量级配置"
            PRESET="preset.light"
            ;;
    esac
}

# 执行OAuth登录
perform_oauth_login() {
    echo ""
    echo "🔐 执行OAuth登录..."
    echo "注意: 将会打开浏览器进行授权"
    
    npx -y @larksuiteoapi/lark-mcp login -a "$APP_ID" -s "$APP_SECRET"
    
    if [ $? -eq 0 ]; then
        echo "✅ OAuth登录成功"
    else
        echo "❌ OAuth登录失败，请检查应用配置"
        echo "   确保重定向URL设置为: http://localhost:3000/callback"
        exit 1
    fi
}

# 测试MCP连接
test_mcp_connection() {
    echo ""
    echo "🧪 测试MCP连接..."
    
    timeout 10s npx -y @larksuiteoapi/lark-mcp mcp -a "$APP_ID" -s "$APP_SECRET" --oauth -t "$PRESET" -l zh &
    MCP_PID=$!
    
    sleep 3
    kill $MCP_PID 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ MCP连接测试成功"
    else
        echo "⚠️  MCP连接测试可能有问题，请检查配置"
    fi
}

# 生成VSCode Augment配置
generate_vscode_config() {
    echo ""
    echo "📄 生成VSCode Augment配置..."
    
    CONFIG_FILE="feishu-official-mcp-config.json"
    
    cat > "$CONFIG_FILE" << EOF
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
    "-a", "$APP_ID",
    "-s", "$APP_SECRET",
    "--oauth",
    "-l", "zh",
    "-t", "$PRESET"
  ]
}
EOF
    
    echo "✅ 配置文件已生成: $CONFIG_FILE"
    echo ""
    echo "📋 VSCode Augment导入步骤:"
    echo "1. 打开VSCode Augment"
    echo "2. 进入Tools → Import MCP Server"
    echo "3. 粘贴上述配置内容"
    echo "4. 点击Import"
}

# 显示使用指南
show_usage_guide() {
    echo ""
    echo "📚 使用指南:"
    echo "================================"
    echo ""
    echo "🔧 核心功能:"
    echo "• docx.v1.document.rawContent - 纯文本读取文档"
    echo "• docx.builtin.search - 搜索文档"
    echo "• im.v1.message.create - 发送消息"
    echo "• bitable.v1.appTableRecord.search - 搜索表格记录"
    echo ""
    echo "💡 Token优化建议:"
    echo "• 优先使用纯文本读取功能"
    echo "• 选择轻量级工具集"
    echo "• 避免频繁调用复杂API"
    echo ""
    echo "🔗 相关链接:"
    echo "• 官方文档: https://open.feishu.cn/document/uAjLw4CM/ukTMukTMukTM/mcp_integration/mcp_introduction"
    echo "• GitHub仓库: https://github.com/larksuite/lark-openapi-mcp"
}

# 主函数
main() {
    check_nodejs
    get_user_input
    choose_config_mode
    perform_oauth_login
    test_mcp_connection
    generate_vscode_config
    show_usage_guide
    
    echo ""
    echo "🎉 飞书官方MCP配置完成！"
    echo "现在可以在VSCode Augment中导入配置文件开始使用。"
}

# 执行主函数
main
