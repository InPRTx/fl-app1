#!/bin/bash

# POW WASM 模块构建脚本
#
# 依赖:
# - Rust (rustup)
# - wasm-pack (cargo install wasm-pack)

set -e

echo "🚀 开始构建 POW WASM 模块..."

# 检查 wasm-pack 是否安装
if ! command -v wasm-pack &> /dev/null; then
    echo "❌ 错误: wasm-pack 未安装"
    echo "请运行: cargo install wasm-pack"
    exit 1
fi

cd "$(dirname "$0")"

# 清理旧的构建
echo "🧹 清理旧构建..."
rm -rf pkg/

# 构建 WASM 模块（发布模式，针对 web 平台）
echo "⚙️  编译 WASM 模块..."
wasm-pack build --target web --release

# 优化 WASM 文件大小（可选，需要安装 wasm-opt）
if command -v wasm-opt &> /dev/null; then
    echo "🔧 优化 WASM 文件大小..."
    wasm-opt -Oz --enable-bulk-memory -o pkg/pow_wasm_bg.wasm pkg/pow_wasm_bg.wasm
else
    echo "⚠️  wasm-opt 未安装，跳过文件大小优化"
    echo "   可选安装: npm install -g wasm-opt 或 brew install binaryen"
fi

# 复制到 Flutter web 目录
echo "📦 复制到 Flutter web 目录..."
mkdir -p ../web/wasm
cp pkg/pow_wasm_bg.wasm ../web/wasm/
cp pkg/pow_wasm.js ../web/wasm/

# 显示文件大小
echo "📊 WASM 文件大小:"
ls -lh pkg/pow_wasm_bg.wasm

echo "✅ 构建完成！"
echo ""
echo "生成的文件:"
echo "  - web/wasm/pow_wasm_bg.wasm (WASM模块)"
echo "  - web/wasm/pow_wasm.js (JS绑定)"

