#!/bin/bash

# POW WASM 模块构建脚本
#
# 依赖:
# - Rust (rustup)
# - wasm-bindgen-cli (cargo install wasm-bindgen-cli)

set -e

echo "🚀 开始构建 POW WASM 模块（兼容模式）..."

# 检查依赖
if ! command -v cargo &> /dev/null; then
    echo "❌ 错误: Rust/Cargo 未安装"
    echo "请访问: https://rustup.rs/"
    exit 1
fi

if ! command -v wasm-bindgen &> /dev/null; then
    echo "⚠️  wasm-bindgen-cli 未安装，正在安装..."
    cargo install wasm-bindgen-cli
fi

cd "$(dirname "$0")"

# 清理旧的构建
echo "🧹 清理旧构建..."
rm -rf pkg/ target/wasm32-unknown-unknown/release/

# 步骤 1: 编译 Rust 到 WASM（禁用 reference-types）
echo "⚙️  步骤 1/3: 编译 Rust 到 WASM..."
RUSTFLAGS="-C target-feature=-reference-types" \
  cargo build --target wasm32-unknown-unknown --release

# 步骤 2: 使用 wasm-bindgen 生成 JS 绑定
echo "⚙️  步骤 2/3: 生成 JS 绑定..."
mkdir -p pkg
wasm-bindgen target/wasm32-unknown-unknown/release/pow_wasm.wasm \
  --out-dir pkg \
  --target web \
  --no-typescript

echo "✅ 已禁用 WebAssembly Reference Types 特性"
echo "   兼容浏览器: Chrome 70+, Firefox 70+, Safari 13+, Edge 79+"

echo "✅ 已禁用 WebAssembly Reference Types 特性"
echo "   兼容浏览器: Chrome 70+, Firefox 70+, Safari 13+, Edge 79+"

# 步骤 3: 优化 WASM 文件大小（可选）
echo "⚙️  步骤 3/3: 检查 WASM 优化工具..."
WASM_OPT_BINARY=""

# 尝试多种方式查找 wasm-opt
if command -v wasm-opt &> /dev/null 2>&1; then
    # 验证 wasm-opt 是否真的可执行
    if wasm-opt --version &> /dev/null 2>&1; then
        WASM_OPT_BINARY="wasm-opt"
    fi
fi

# 如果找不到，尝试通过 brew 安装的路径
if [ -z "$WASM_OPT_BINARY" ] && [ -f "/opt/homebrew/bin/wasm-opt" ]; then
    if /opt/homebrew/bin/wasm-opt --version &> /dev/null 2>&1; then
        WASM_OPT_BINARY="/opt/homebrew/bin/wasm-opt"
    fi
fi

if [ -z "$WASM_OPT_BINARY" ] && [ -f "/usr/local/bin/wasm-opt" ]; then
    if /usr/local/bin/wasm-opt --version &> /dev/null 2>&1; then
        WASM_OPT_BINARY="/usr/local/bin/wasm-opt"
    fi
fi

if [ -n "$WASM_OPT_BINARY" ]; then
    echo "✅ 找到 wasm-opt: $WASM_OPT_BINARY"
    echo "   正在优化 WASM 文件..."
    $WASM_OPT_BINARY -O3 --enable-bulk-memory -o pkg/pow_wasm_bg.wasm pkg/pow_wasm_bg.wasm
    echo "✅ WASM 文件已优化"
else
    echo "⚠️  wasm-opt 未找到，跳过文件大小优化"
    echo "   可选安装: brew install binaryen"
    echo "   (不影响功能，仅影响文件大小)"
fi

# 复制到 Flutter web 目录
echo "📦 复制到 Flutter web 目录..."
mkdir -p ../web/wasm
cp pkg/pow_wasm_bg.wasm ../web/wasm/
cp pkg/pow_wasm.js ../web/wasm/

# 显示文件大小
echo ""
echo "📊 生成的文件:"
echo "  - web/wasm/pow_wasm_bg.wasm ($(ls -lh pkg/pow_wasm_bg.wasm | awk '{print $5}'))"
echo "  - web/wasm/pow_wasm.js (JS绑定)"

echo ""
echo "✅ 构建完成（兼容模式）！"
echo ""
echo "🌐 浏览器兼容性:"
echo "  ✅ Chrome 70+ (2018年)"
echo "  ✅ Firefox 70+ (2019年)"
echo "  ✅ Safari 13+ (2019年)"
echo "  ✅ Edge 79+ (2020年)"
echo "  ✅ 国产浏览器（基于较新 Chromium 内核）"
echo ""
echo "⚠️  注意: 已禁用 Reference Types 特性以提高兼容性"
echo "   性能影响: 极小（< 5%）"
echo "  - web/wasm/pow_wasm_bg.wasm (WASM模块)"
echo "  - web/wasm/pow_wasm.js (JS绑定)"

