# 🚀 Subscription Page Template for 3x-ui

[🇮🇷 فارسی](README_FA.md)

A modern, responsive, and customizable subscription page template for **3x-ui** panels.

## ✨ Features

* Circular traffic usage indicator
* Service status display
* Expiration date and last connection
* Configuration list with copy button
* Subscription URL with copy button
* Persian / English language support
* Light / Dark theme
* Support ID configuration via `config.json` (no need to edit HTML)

---

## 📁 Project Structure

```text
3x-ui-Subscription-Template/
├── sub.html           (Main template file - must be named sub.html)
├── config.json        (Configuration file)
├── README.md          (English documentation)
└── README_FA.md       (Persian documentation)
```

---
## 📸 Screenshots

### Main Dashboard

Displays subscription information, traffic usage, expiration date, and service status in a modern and responsive layout.


<p align="center">
  <img src="assets/Screenshot_20260623_231231.png" alt="Main Dashboard" width="900">
</p>

## 🛠️ Installation

### 1. Clone Repository

```bash
cd /root
git clone https://github.com/mahdizo3181/3x-ui-Subscription-Template.git
```

### 2. Get Absolute Path

```bash
cd 3x-ui-Subscription-Template
pwd
```

Example output:

```text
/root/3x-ui-Subscription-Template
```

Copy this path.

---

### 3. Configure Template Path in 3x-ui

1. Open the 3x-ui panel.
2. Go to **Settings**.
3. Open the **Subscription** .
4. Click **Profile**.
5. Enter the absolute folder path in **Sub Theme Directory**.

Example:

```text
/root/3x-ui-Subscription-Template
```

6. Save changes.
7. Restart the panel once.

> The template file must be named `sub.html`.

---

### 4. Configure Support ID (Optional)

Edit `config.json`:

```json
{
  "support_id": "@your_support_username"
}
```

Example:

```json
{
  "support_id": "@NetRon_Support"
}
```

Leave it empty if you do not want to display a support link.

---

### 5. Final Test

Create a user with an active subscription and open the subscription URL. The new template should be displayed automatically.

---

## 🔧 Notes

* The template file must be named `sub.html`.
* Use an absolute path, not a relative path.
* Make sure `sub.html` exists in the configured folder.
* Changes in `config.json` do not require a panel restart.

---

## 🧑‍💻 Customization

* Edit CSS variables in the `:root` section to change colors.
* Edit the `i18n` object in JavaScript to change texts.

---

## 📄 License

Feel free to modify and use this template in your own projects.

---

**Developer:** Mahdi Zolfaghari

**GitHub:** https://github.com/mahdizo3181/3x-ui-Subscription-Template
