# 字体说明

本模板默认优先使用西文字体（`Times New Roman` / `Liberation Serif`）渲染英文与数字，使用中文字体（`SimSun` / `SimHei` / `Noto Serif CJK SC`）渲染中文。

- **Windows / macOS**：系统通常已预装 `Times New Roman`、`SimSun`、`SimHei`，直接编译即可。
- **Linux**：建议安装 `fonts-noto-cjk` 与 `fonts-liberation`，或将静态版 `SimSun.ttf` / `SimHei.ttf` 放入本目录后使用：
  ```bash
  typst compile --font-path fonts main.typ
  ```
