# snappymail-installer
Unofficial installation script for SnappyMail. Works with the latest version!

![GitHub Created At](https://img.shields.io/github/created-at/nlimeres/snappymail-installer) ![GitHub License](https://img.shields.io/github/license/nlimeres/snappymail-installer) ![GitHub Repo stars](https://img.shields.io/github/stars/nlimeres/snappymail-installer)

Read more about [SnappyMail](https://snappymail.eu) here. This script is not associated with the official SnappyMail Project.

## ✨ Features

- **Zero-Configuration Installation:** Automatically detects your installed PHP version and configures the Nginx socket for you.
- **Performance Optimized: Configure** to run on Nginx and PHP-FPM, consuming minimal resources on your server.
- **Enhanced Security:** blocking of access to the data folder and disabling hidden files, strict file and folder permission management.
- **Lightweight:** Includes no unnecessary dependencies, keeping your Debian system as clean as possible.
- **PHP 8.x Compatible:** Full support for the latest PHP versions and their extensions

## ⚙️ Requirements

- Server running **Debian** 11/12 (Clean installation recommended).
- Root or sudo access.
- An A DNS record pointing to your server's IP address (e.g., mail.nlimeres.com).

| Operating System | Version | Supported          | PHP Version |
| ---------------- | ------- | ------------------ | ----------- |
| Debian           | 8       | 🔴                 |             |
|                  | 9       | 🔴                 |             |
|                  | 10      | 🔴                 |             |
|                  | 11      | ✅                 | 8.3         |
|                  | 12      | ✅                 | 8.3         |
|                  | 13      | ✅                 | 8.3         |
| Rocky Linux      | 8       | ✅                 | 8.3         |
|                  | 9       | ✅                 | 8.3         |
| AlmaLinux        | 8       | ✅                 | 8.3         |
|                  | 9       | ✅                 | 8.3         |


## 🚀 Instalation

```bash
wget https://snappymail-installer.nlimeres.com && chmod +x install.sh && sudo ./install.sh
```
or
```bash
wget https://raw.githubusercontent.com/nlimeres/snappymail-installer/refs/heads/main/install.sh && chmod +x install.sh && sudo ./install.sh
```

## 🔐 Access to the Administration Panel

SnappyMail does not have a default password for security reasons. Follow these steps after running the script:
  1. Open your browser and go to the **administrative URL**: http://your-domain.com/?admin
  2. When the page loads, the server will generate a **unique password.**
  3. Obtain this password by running this command in your terminal:
  ```bash
cat /var/www/snappymail/data/_data_/_default_/admin_password.txt
```
4. Log in with the admin username and the password you just saw
5. IMPORTANT: Go to the Security tab, **change the username, and set a new password.** The temporary file will be deleted automatically.

snappymail-installer script tutorial [![snappymail-installer tutorial](https://www.youtube.com/s/desktop/aaaab8bf/img/favicon.ico)](https://www.youtube.com/watch?v=QiO-mktKQGc) [⇱ link]([https://snappymail.eu](https://youtu.be/QiO-mktKQGc?si=Nr7Sgq4EVzhBOkIe))


## 🤝 Contributions
Copyright (C) 2026, nlimeres, <hello@nlimeres.com>

- Created by [nlimeres](https://github.com/nlimeres)
- ![GitHub contributors](https://img.shields.io/github/contributors/nlimeres/snappymail-installer)


If you find any errors or want to add any improvements, feel free to open an issue or send a pull request.

## 📄 License
![GitHub License](https://img.shields.io/github/license/nlimeres/snappymail-installer)
