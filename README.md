# ImageSlim 🖼️

一鍵為圖片「減肥」的 macOS 快速動作工具。

## 功能特性

- 🎯 **支援多種格式**：PNG、JPG/JPEG、WebP
- ⚡ **快速便捷**：Finder 右鍵即可使用
- 🛠️ **自動配置**：一鍵安裝所有依賴
- 📦 **無損最優化**：智能壓縮演算法

## 支援的圖片格式

| 格式  | 工具 | 品質設定 | 說明 |
|-------|------|--------|------|
| PNG   | pngquant | 70-90 | 顏色量子化，跳過較大的文件 |
| JPG/JPEG | jpegoptim | 85 | 移除元數據，最大品質 85 |
| WebP | cwebp | 80 | 現代高效格式 |

## 安裝方式

```bash
bash install.sh
```

**需求：**
- macOS 系統
- 具有 Homebrew 的寫入權限

## 重啟 Finder

安裝完成後，需要重啟 Finder 以使快速動作生效：

```bash
killall Finder
```

或者通過 UI：按住 `Option` 鍵，右鍵點擊 Dock 中的 Finder 圖標，選擇「重新啟動」。

## 使用方法

1. 在 Finder 中選取一或多張圖片
2. 右鍵點擊
3. 選擇「快速動作」
4. 點擊「圖片減肥（PNG/JPG/WEBP）」

✅ 自動完成壓縮，原文件將被覆蓋為最佳化版本

## 腳本流程

```
① 檢查 macOS 系統
   ↓
② 檢查/安裝 Homebrew
   ↓
③ 安裝壓縮工具
   ├─ pngquant
   ├─ jpegoptim
   └─ webp
   ↓
④ 建立 Automator 快速動作
   ↓
⑤ 重新載入 Finder
   ↓
✨ 完成！
```

## 技術細節

### Shell Script 版本
- Shell: `/bin/zsh`
- 使用 case 語句根據副檔名選擇對應的壓縮工具

### Automator 工作流程
- 類型：Finder 快速動作
- 接受：圖片文件列表
- 執行：Run Shell Script 行動

## 故障排除

| 問題 | 解決方案 |
|-----|--------|
| 找不到快速動作 | 重啟 Finder 或檢查 `~/Library/Services/` 路徑 |
| 權限被拒 | 執行 `chmod +x install.sh` 後重試 |
| 工具未安裝 | 執行 `brew install pngquant jpegoptim webp` |

## 作者

Brian Han - [GitHub](https://github.com/sacahan)

## 授權

MIT License
