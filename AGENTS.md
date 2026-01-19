# AGENTS.md

此文件用於記錄與 ImageSlim 項目相關的自動化代理配置。

## 項目概述

**ImageSlim** 是一個 macOS 自動化工具，為圖片壓縮提供 Finder 快速動作集成。

### 核心功能
- 自動檢測圖片格式（PNG、JPG、WebP）
- 使用特定工具進行最優化壓縮
- 通過 Automator 與 Finder 集成
- 一鍵安裝和配置

## 工作流程拓撲

```
用戶操作（Finder 右鍵選單）
    ↓
Automator 快速動作觸發
    ↓
Run Shell Script 行動
    ↓
Shell 腳本處理
    ├─ PNG → pngquant
    ├─ JPG → jpegoptim
    └─ WebP → cwebp
    ↓
圖片壓縮完成
```

## 自動化元素

| 元素 | 類型 | 位置 | 說明 |
| --- | --- | --- | --- |
| 安裝腳本 | Bash | `install.sh` | 初始設置和依賴安裝 |
| Automator 工作流 | XML/Plist | `~/Library/Services/` | Finder 快速動作定義 |
| 壓縮邏輯 | Shell | 嵌入式 | 根據文件類型選擇工具 |

## 環境配置

### 依賴工具
- **pngquant**：PNG 壓縮（70-90% 品質）
- **jpegoptim**：JPEG 壓縮（品質 85）
- **cwebp**：WebP 轉換和壓縮（品質 80）

### 系統要求
- macOS 作業系統
- Homebrew 包管理器
- Finder 應用

## 代理擴展可能性

未來可考慮的自動化增強：

1. **批量處理代理**
   - 監視特定文件夾的新圖片
   - 自動觸發壓縮工作流程

2. **智能品質代理**
   - 分析圖片內容自動調整品質參數
   - 基於文件大小目標優化

3. **同步代理**
   - 在雲存儲服務（iCloud、Dropbox）中自動壓縮
   - 保持原件和壓縮版本的版本控制

4. **監控和日誌代理**
   - 記錄壓縮操作統計
   - 生成壓縮效率報告

## 配置管理

### 安裝流程
```bash
bash install.sh
```

### 卸載流程
```bash
rm -rf ~/Library/Services/圖片減肥（PNG_JPG_WEBP）.workflow
```

## 測試場景

- [ ] PNG 文件壓縮
- [ ] JPEG 文件壓縮
- [ ] WebP 文件壓縮
- [ ] 混合格式批量處理
- [ ] 已壓縮文件重複處理（應跳過或提示）

## 版本控制

- **v1.0**：初始版本，支持 PNG、JPG、WebP
- 未來改進待定

---

*最後更新：2026-01-19*
