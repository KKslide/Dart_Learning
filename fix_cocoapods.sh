#!/bin/bash

# 清理 CocoaPods 缓存和本地仓库
echo "清理 CocoaPods 缓存..."
cd ios
rm -rf Pods
rm -rf Podfile.lock
rm -rf ~/Library/Caches/CocoaPods
rm -rf ~/.cocoapods/repos

# 切换到 git 源（更稳定）
echo "切换到 git 源..."
pod repo remove trunk 2>/dev/null || true
pod repo add-cdn trunk https://cdn.cocoapods.org/ || true

# 重新安装
echo "重新安装 pods..."
pod install --repo-update

cd ..
