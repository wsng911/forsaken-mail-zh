# Forsaken Mail 汉化版

> 基于 [denghongcai/forsaken-mail](https://github.com/denghongcai/forsaken-mail) 的汉化版本，自托管临时邮箱服务。

## 功能特性

- 自动分配临时邮箱地址
- 自定义邮箱账号
- 实时接收邮件（WebSocket）
- 邮件 HTML 渲染
- 浏览器桌面通知
- 中文界面 + 国内 CDN

## 快速部署

```bash
docker run -d \
  -p 25:25 \
  -p 3000:3000 \
  --name forsaken-mail-zh \
  wsng911/forsaken-mail-zh:latest
```

访问 `http://localhost:3000`（需要 25 端口接收邮件）

## 国内适配

- npm 镜像：npmmirror.com
- 前端 CDN：lib.baomitu.com（国内）

## 原项目

https://github.com/denghongcai/forsaken-mail
