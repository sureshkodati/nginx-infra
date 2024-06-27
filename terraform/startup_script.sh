# Script to install IIS (replace with actual commands)
set -x
echo "Testing"
# Update package lists
sudo apt update

# Install Nginx
sudo apt install -y nginx


# Downloading sites and nginx configuration from GCS
gsutil cp gs://backend-dev-project-426703/sites.tar .
gsutil cp gs://backend-dev-project-426703/default .

# Untaring sites content
tar -xvf sites.tar 

# Moving sites and configuration into location
sudo mkdir  /var/www/html/site
sudo cp Sites/* /var/www/html/site -r  
sudo rm /etc/nginx/sites-available/default
sudo mv default /etc/nginx/sites-available/default

# Removing tar file
sudo rm -f sites.tar

# Creating main index file
sudo touch /var/www/html/site/index.html
sudo cat << EOF >> "/var/www/html/site/index.html"
<h1> Sites </h1>
<h2> <a href="/Infosys">Infosys</a> </h2>
<h2> <a href="/Welsforgo">Welsforgo</a> </h2>
<h2> <a href="/Microsoft">Microsoft</a> </h2>
EOF

# Providing permission to user to access site content
sudo chown -R www-data:www-data /var/www/html/site

# Restarting nginx service
sudo systemctl restart nginx