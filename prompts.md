# forsaken-mail-zh Prompts

> 项目：denghongcai/forsaken-mail 汉化版（forsaken-mail-zh）
> 技术栈：Node.js + Express + Socket.IO 后端，jQuery + Semantic UI 前端，SMTP 服务器

---

## 功能迭代

**1. 添加邮件搜索功能**
在 forsaken-mail-zh 的邮件列表中添加搜索框，支持按发件人、主题关键词实时过滤邮件列表。使用前端 JavaScript 对已加载的邮件进行过滤，无需后端支持，提升用户查找特定邮件的效率。

**2. 支持邮件附件下载**
在 forsaken-mail-zh 中添加邮件附件支持。当收到带附件的邮件时，在邮件详情卡片中显示附件列表，用户可以点击下载附件。后端需要解析 MIME 附件并提供下载接口。

**3. 添加邮件有效期设置**
在 forsaken-mail-zh 中为临时邮箱添加有效期功能。用户可以设置邮箱的有效时间（1小时/6小时/24小时），到期后自动清除该邮箱的所有邮件，并在界面上显示剩余有效时间倒计时。

**4. 支持多个临时邮箱同时使用**
在 forsaken-mail-zh 中添加多邮箱管理功能。用户可以同时创建和管理多个临时邮箱地址，通过标签页切换查看不同邮箱的邮件，每个邮箱独立接收邮件。

**5. 添加邮件转发功能**
在 forsaken-mail-zh 中添加邮件转发功能。用户可以将收到的临时邮件转发到自己的真实邮箱，方便保存重要邮件。需要配置 SMTP 发件服务器，并在界面上提供转发按钮。

---

## Bug 修复

**6. 修复邮件 HTML 内容中的 XSS 漏洞**
在 forsaken-mail-zh 中，邮件的 HTML 内容直接通过 `innerHTML` 渲染，存在 XSS 安全风险。请使用 DOMPurify 对邮件 HTML 内容进行净化，过滤掉危险的脚本标签和事件处理器，同时保留正常的邮件格式。

**7. 修复 Socket.IO 断线后不自动重连**
在 forsaken-mail-zh 中，当网络短暂中断后，Socket.IO 连接断开，页面不会自动重连，需要手动刷新。请配置 Socket.IO 客户端的重连参数（reconnection: true, reconnectionAttempts: 5），并在重连成功后重新订阅邮件。

**8. 修复自定义邮箱地址包含大写字母时无法接收邮件**
在 forsaken-mail-zh 中，用户输入包含大写字母的自定义邮箱地址时，SMTP 服务器接收到的邮件地址是小写的，导致匹配失败无法接收邮件。请在设置自定义地址时统一转换为小写。

**9. 修复邮件时间显示为 UTC 而非本地时间**
在 forsaken-mail-zh 的邮件列表中，邮件时间使用 `toLocaleTimeString()` 显示，但在某些浏览器环境下显示的是 UTC 时间而非用户本地时间。请使用 `Intl.DateTimeFormat` 明确指定时区进行格式化。

**10. 修复大量邮件时列表性能下降**
在 forsaken-mail-zh 中，当同一临时邮箱收到超过 100 封邮件时，每次新邮件到达都会重新渲染整个列表，导致页面卡顿。请添加虚拟滚动或限制显示最新的 50 封邮件，超出部分提供"加载更多"功能。

---

## 重构

**11. 将前端重构为模块化结构**
forsaken-mail-zh 的前端 `app.js` 是单文件 jQuery 代码，所有逻辑混在一起。请将其重构为模块化结构：`mailList.js`（邮件列表管理）、`mailDetail.js`（邮件详情展示）、`socket.js`（WebSocket 连接管理）、`storage.js`（本地存储）。

**12. 将 SMTP 服务器逻辑提取为独立模块**
forsaken-mail-zh 的 SMTP 接收逻辑分散在多个文件中。请将其整合为独立的 `modules/smtp-server.js` 模块，封装邮件接收、解析、存储的完整流程，通过事件发射器与 Express 应用解耦。

---

## 测试

**13. 为 SMTP 邮件接收编写集成测试**
使用 Jest + nodemailer 为 forsaken-mail-zh 的 SMTP 服务器编写集成测试，覆盖：接收纯文本邮件、接收 HTML 邮件、接收带附件邮件、邮件地址路由（正确地址/错误地址）。

**14. 为 Socket.IO 实时推送编写测试**
使用 Jest + socket.io-client 为 forsaken-mail-zh 的实时邮件推送功能编写测试，覆盖：客户端连接和断开、请求新邮箱 ID、设置自定义邮箱 ID、接收新邮件推送。

**15. 为邮件 HTML 净化功能编写安全测试**
为 forsaken-mail-zh 的邮件 HTML 渲染编写安全测试，验证以下内容被正确过滤：`<script>` 标签、`onerror` 事件处理器、`javascript:` 协议链接、CSS 表达式注入，确保 XSS 防护有效。

---

## 代码理解

**16. 解释 SMTP 服务器的邮件接收流程**
在 forsaken-mail-zh 中，Node.js 直接监听 25 端口作为 SMTP 服务器。请解释 SMTP 协议的握手流程、邮件如何从 SMTP 连接解析为结构化数据、`mailparser` 库的作用，以及如何处理多部分 MIME 邮件。

**17. 解释 Socket.IO 的实时推送机制**
在 forsaken-mail-zh 中，新邮件通过 Socket.IO 实时推送到浏览器。请解释 Socket.IO 的房间（Room）机制如何实现按邮箱地址分发邮件、WebSocket 与长轮询的降级策略，以及如何处理多个浏览器标签页同时监听同一邮箱的情况。

---

## DevOps

**18. 编写 GitHub Actions 多架构构建流水线**
为 forsaken-mail-zh 编写 `.github/workflows/docker-build.yml`，实现推送 main 分支时自动构建多架构（amd64/arm64/armv7）Docker 镜像并推送到 Docker Hub，注意 SMTP 25 端口和 Web 3000 端口的映射说明。

**19. 编写 docker-compose.yml 生产部署配置**
为 forsaken-mail-zh 编写 `docker-compose.yml`，包含：forsaken-mail 服务（映射 25 和 3000 端口）、环境变量配置（域名、SMTP 端口、Web 端口）、数据目录挂载、Nginx 反向代理（仅代理 Web 端口，SMTP 直接暴露）。

**20. 编写邮件数据持久化方案**
forsaken-mail-zh 目前将邮件存储在内存中，服务重启后邮件丢失。请设计并实现基于 SQLite 的邮件持久化方案：创建邮件表结构、在接收邮件时写入数据库、在客户端连接时从数据库加载历史邮件，并添加自动清理过期邮件的定时任务。
