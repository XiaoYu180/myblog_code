#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# deploy to github pages
# echo 'xiaoyu180.cn' > CNAME

githubUrl=githubUrl=git@github.com:XiaoYu180/Blog.git

git init
git add -A
git commit -m "deploy"
git push -f $githubUrl master:gh-pages # 推送到github gh-pages分支


cd -
rm -rf docs/.vuepress/dist
