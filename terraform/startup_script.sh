# Script to install IIS (replace with actual commands)
set -x
echo "Testing"
# Update package lists
sudo apt update

# Install Nginx
sudo apt install -y nginx


# Copying sites and nginx configuration from GCS
gsutil cp gs://backend-dev-project-426703/sites.tar .
gsutil cp gs://backend-dev-project-426703/default .

# Creating main index file
sudo mkdir  /var/www/html/site
tar -xvf sites.tar 
sudo touch /var/www/html/site/index.html
sudo cat << EOF >> "/var/www/html/site/index.html"
<h1> Sites </h1>
<h2> <a href="/Infosys">Infosys</a> </h2>
<h2> <a href="/Welsforgo">Welsforgo</a> </h2>
<h2> <a href="/Microsoft">Infosys</a> </h2>
EOF

# Moving sites into location
sudo cp Sites/* /var/www/html/site -r  
sudo rm /etc/nginx/sites-available/default
sudo cp default /etc/nginx/sites-available/default

sudo chown -R www-data:www-data /var/www/html/site
sudo systemctl restart nginx