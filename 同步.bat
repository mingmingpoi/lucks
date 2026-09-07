@echo off
chcp 65001 >nul
title 同步主页数据到 Gitee
echo ============================================
echo   正在把最新数据同步到 Gitee 仓库...
echo ============================================
echo.

cd /d "%~dp0"

echo [1/4] 暂存改动文件...
git add config.json index.html
if errorlevel 1 goto :err

echo [2/4] 提交(Commit)...
git commit -m "更新主页数据 %date% %time%"
if errorlevel 1 (
  echo.
  echo 提示：没有可提交的新改动（或提交失败）。
  goto :push
)

:push
echo [3/4] 推送到 Gitee(Push)...
git push
if errorlevel 1 goto :err

echo [4/4] 完成！
echo.
echo ✅ 数据已同步到 Gitee。
echo 提示：若使用 Gitee Pages，请到仓库「服务-Gitee Pages」点一次“更新”触发重新审核，
echo 审核通过后访客才能看到最新内容。
echo.
pause
exit /b 0

:err
echo.
echo ❌ 同步出错。请检查：
echo   1) 本机已安装 Git：https://git-scm.com/
echo   2) 本文件夹已关联 Gitee 仓库（git remote -v 可查看）
echo   3) 首次推送需要账号密码/已配置凭据
echo.
pause
exit /b 1
