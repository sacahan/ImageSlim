#!/bin/bash
set -e

echo "🔍 檢查作業系統..."
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "❌ 此腳本僅支援 macOS"
  exit 1
fi

echo "🍺 檢查 Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  echo "➡️  未偵測到 Homebrew，開始安裝..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "✅ Homebrew 已存在"
fi

echo "📦 安裝圖片壓縮工具..."
brew install pngquant jpegoptim webp

echo "⚙️ 建立 Automator 快速動作..."

WORKFLOW_NAME="圖片減肥（PNG_JPG_WEBP）.workflow"
TARGET="$HOME/Library/Services/$WORKFLOW_NAME"

rm -rf "$TARGET"
mkdir -p "$TARGET/Contents"

cat > "$TARGET/Contents/document.wflow" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>AMApplicationVersion</key>
  <string>2.10</string>
  <key>AMDocumentVersion</key>
  <string>2</string>
  <key>actions</key>
  <array>
    <dict>
      <key>action</key>
      <dict>
        <key>AMAccepts</key>
        <dict>
          <key>Container</key>
          <string>List</string>
          <key>Optional</key>
          <true/>
          <key>Types</key>
          <array>
            <string>public.image</string>
          </array>
        </dict>
        <key>AMActionVersion</key>
        <string>2.0</string>
        <key>AMApplication</key>
        <array>
          <string>Finder</string>
        </array>
        <key>AMProvides</key>
        <dict>
          <key>Container</key>
          <string>List</string>
          <key>Types</key>
          <array>
            <string>public.image</string>
          </array>
        </dict>
        <key>ActionBundlePath</key>
        <string>/System/Library/Automator/Run Shell Script.action</string>
        <key>ActionName</key>
        <string>Run Shell Script</string>
        <key>Parameters</key>
        <dict>
          <key>inputMethod</key>
          <integer>1</integer>
          <key>shell</key>
          <string>/bin/zsh</string>
          <key>source</key>
          <string>
for file in "$@"; do
  ext="${file##*.}"
  ext="${ext:l}"

  case "$ext" in
    png)
      pngquant --force --skip-if-larger --quality=70-90 --ext .png "$file"
      ;;
    jpg|jpeg)
      jpegoptim --strip-all --max=85 "$file"
      ;;
    webp)
      cwebp -q 80 "$file" -o "$file"
      ;;
  esac
done
          </string>
        </dict>
      </dict>
    </dict>
  </array>
</dict>
</plist>
EOF

echo "🔄 重新載入 Finder..."
if killall Finder 2>/dev/null; then
  sleep 1
  echo "✅ Finder 已重新啟動，快速動作已激活"
else
  echo "⚠️  未能自動重啟 Finder，請手動重啟："
  echo "   按住 Option，右鍵點擊 Dock 中的 Finder，選擇「重新啟動」"
fi

echo ""
echo "🎉 安裝完成！"
echo "使用方式："
echo "Finder 選圖片 → 右鍵 → 快速動作 → 圖片減肥（PNG/JPG/WEBP）"
