#!/bin/bash

# Hexo 博客自动更新脚本
# 用法: ./update.sh [提交信息]

set -e  # 遇到错误立即退出

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 开始更新博客...${NC}"

# 检查是否有修改
if [[ -z $(git status -s) ]]; then
    echo -e "${YELLOW}⚠️  没有检测到任何修改${NC}"
    exit 0
fi

# 显示修改的文件
echo -e "${GREEN}📝 修改的文件:${NC}"
git status -s

# 添加所有修改
echo -e "${GREEN}📦 添加所有修改...${NC}"
git add .

# 获取提交信息
if [ -z "$1" ]; then
    # 如果没有提供参数，使用默认信息（东八区时间）
    COMMIT_MSG="Update blog: $(TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S')"
else
    # 使用用户提供的信息
    COMMIT_MSG="$1"
fi

# 提交
echo -e "${GREEN}💾 提交修改: $COMMIT_MSG${NC}"
git commit -m "$COMMIT_MSG"

# 推送到 GitHub
echo -e "${GREEN}⬆️  推送到 GitHub...${NC}"
git push origin master

echo -e "${GREEN}✅ 更新完成!${NC}"
echo -e "${GREEN}🔄 GitHub Actions 正在自动部署...${NC}"
echo ""
echo -e "${YELLOW}📊 查看部署状态:${NC}"
echo "   gh run watch"
echo ""
echo -e "${YELLOW}🌐 你的博客地址:${NC}"
echo "   https://zzxy1999.github.io/myblog"
echo ""
echo -e "${GREEN}⏱️  等待 1-2 分钟后刷新页面查看最新内容${NC}"
