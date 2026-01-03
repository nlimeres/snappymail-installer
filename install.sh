#!/bin/bash

# =================================================================
# SnappyMail Automatic Installation Script for Debian
# Created by: nlimeres                nlimeres.com
# =================================================================

# Adding colors to make it easier to find errors and success messages
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' #∅ color

echo -e "${GREEN}Starting SnappyMail installation...${NC}"

# 1. System update
echo "Updating repositories..."
apt update && apt upgrade -y

# 2. Installing dependencies (Without php-sodium to avoid an error)
echo "Installing Nginx, PHP, and necessary extensions..."
apt install nginx unzip curl wget php-fpm php-cli php-common php-mbstring \
php-xml php-curl php-zip php-gd php-intl php-bcmath php-gmp php-imap \
php-tidy -y

# 3. Detect the installed PHP version to configure the Socket correctly
PHP_VERSION=$(php -v | head -n 1 | cut -d " " -f 2 | cut -d "." -f 1,2)
PHP_SOCKET="/run/php/php${PHP_VERSION}-fpm.sock"

if [ -z "$PHP_VERSION" ]; then
    echo -e "${RED}Error: PHP version could not be detected.${NC}"
    exit 1
fi

echo -e "${GREEN}>>> PHP $PHP_VERSION detected. Configuring socket: $PHP_SOCKET${NC}"

# 4. Prepare directory and download SnappyMail
echo "Downloading SnappyMail..."
mkdir -p /var/www/snappymail
cd /var/www/snappymail
wget https://snappymail.eu/repository/latest.tar.gz
tar -xzf latest.tar.gz
rm latest.tar.gz

# 5. Configure Permissions
echo "Setting permissions..."
find /var/www/snappymail -type d -exec chmod 755 {} \;
find /var/www/snappymail -type f -exec chmod 644 {} \;
chown -R www-data:www-data /var/www/snappymail

# 6. Interactive Domain Configuration
echo -e "${GREEN}>>> CNetwork configuration${NC}"
read -p "Enter the domain or subdomain (e.g., mail.nlimeres.com). If you don't have one, press [ENTER] to use the IP address: " USER_DOMAIN

# If you do not enter anything, the default value is "_"
if [ -z "$USER_DOMAIN" ]; then
    USER_DOMAIN="_"
    echo -e "Configured for access via IP."
else
    echo -e "Configured domain: $USER_DOMAIN"
fi

echo "Creating an Nginx configuration file..."

# We use the $USER_DOMAIN variable within the heredoc block (cat <<EOF)
cat <<EOF > /etc/nginx/sites-available/snappymail
server {
    listen 80;
    listen [::]:80;
    server_name $USER_DOMAIN;

    root /var/www/snappymail;
    index index.php index.html;

    client_max_body_size 50M;

    # Security: Blocking hidden files and access to the data folder
    location ~ (^|/)\. { 
        return 403; 
    }
    
    location ~ ^/data/ { 
        deny all; 
    }

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:$PHP_SOCKET;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }
}
EOF

# 7. Activate site and clean
echo "Activating the new Virtual Host..."
ln -sf /etc/nginx/sites-available/snappymail /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# 8. Restart services to apply changes
echo "Restarting Nginx and PHP-FPM..."
systemctl restart nginx
systemctl restart php${PHP_VERSION}-fpm

echo -e "${GREEN}==================================================${NC}"
echo -e "${GREEN}INSTALLATION SUCCESSFULLY COMPLETED!${NC}"
if [ "$USER_DOMAIN" == "_" ]; then
    echo -e "Access: http://server-ip/?admin"
else
    echo -e "Access: http://$USER_DOMAIN/?admin"
fi
echo -e "Your temporary password is in:"
echo -e "${GREEN}cat /var/www/snappymail/data/_data_/_default_/admin_password.txt${NC}"
echo -e "${GREEN}==================================================${NC}"
