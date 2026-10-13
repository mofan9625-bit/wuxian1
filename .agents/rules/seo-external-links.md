# 外部商业链接与 SEO 规范约束（强制执行）

## 1. 外部跳转链接（包含联盟邀请码、主品购买注册、官网直达按钮等）
- 所有的外部商业链接 `<a>` 标签，必须强制携带属性：
  ```html
  target="_blank" rel="nofollow sponsored noopener"
  ```
- 范例写法：
  ```html
  <a href="https://你的链接..." target="_blank" rel="nofollow sponsored noopener" class="btn">立即订阅</a>
  ```
- 严禁出现裸链接、单独 `rel="noopener"` 或任何不带 `nofollow sponsored` 的外部商业出站链接。

## 2. 站内导航与内链保护
- 内部锚点（如 `href="#pricing"`、`href="#features"`）与站内页面（如 `href="article-1.html"`）严禁添加 `nofollow` 或 `sponsored`，保持标准站内相对链接。

## 3. 防作弊与重定向规则
- 严禁使用任何 JavaScript 自动跳转脚本（如 `window.location` 等）；
- 严禁在 `<head>` 中配置 `meta http-equiv="refresh"` 自动重定向；
- 所有流量转化必须由访客在页面阅读后自主点击触发。
