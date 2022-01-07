#!/bin/bash

function nxown(){
clear
    sudo a2ensite nextcloud.conf
    sudo a2enmod rewrite headers env dir mime setenvif ssl
    sudo chmod 775 -R /var/www/$DOMAINNAME/
    sudo chown www-data:www-data /var/www/$DOMAINNAME/ -R
    sudo systemctl restart apache2.service
    echo " ---------------------------------------------------------------------------"
    echo "| Nextcloud folder rights have been configured... (Press ENTER to continue) |"
    echo " ---------------------------------------------------------------------------"
    read ENTER
    menu

}

function ngown(){
clear
    sudo a2ensite nextcloud.conf
    sudo a2enmod rewrite headers env dir mime setenvif ssl
    sudo chmod 775 -R /usr/share/$DOMAINNAME/
    sudo chown www-data:www-data /usr/share/$DOMAINNAME/ -R
    sudo systemctl restart apache2.service
    echo " ---------------------------------------------------------------------------"
    echo "| Nextcloud folder rights have been configured... (Press ENTER to continue) |"
    echo " ---------------------------------------------------------------------------"
    read ENTER
    menu

}

function webs(){
clear
            echo " -------------------------------------------------------------"
            echo "| You have chosen to install a webserver is this right? (y/n) |"
            echo " -------------------------------------------------------------"
            read answer0
       
            if [ "$answer0" != "${answer0#[Yy]}" ] ;then
                webs2
                
            elif [ "$answer0" != "${answer0#[Nn]}" ] ;then
                clear
                echo " ----------------------------------------------------"
                echo "| Installation Canceled (Press enter to continue...) |"
                echo " ----------------------------------------------------"
                read ENTER
                menu
            else
                clear
                echo " ------------------------------------------------"
                echo "| Wrong input given (Press enter to continue...) |"
                echo " ------------------------------------------------"
                read ENTER
                webs
            fi

}

function webs2() {
clear
                
                echo " ---------------------------------------------------"
                echo "| What webserver do you want to use? (Apache/Nginx) |"
                echo " ---------------------------------------------------"
                
                        read answer9
                    	if [ "$answer9" == "Apache" ] ;then
                
                        	   sudo apt install net-tools
                        	   clear
                               sudo apt install apache2 libapache2-mod-php7.4 openssl php-imagick php7.4-common php7.4-curl php7.4-gd php7.4-imap php7.4-intl pmbstring php7.4-mysql php7.4-pgsql php-ssh2 php7.4- sqlite3 php7.4-xml php7.4-zip
                            	   sudo apt install apache2
                            	   sudo apt install php
                            	   sudo apt install mariadb-server
                            	   sudo mysql_secure_installation
                            	clear
                                echo " --------------------------------------------------------------"
                            	echo "| Apache is succesfully installed. (Press ENTER to continue...)|"
                                echo " --------------------------------------------------------------"
                            	read ENTER
                            	menu
                                
                    	elif [ "$answer9" == "Nginx" ] ;then
                        	   clear
                                    sudo apt install imagemagick php-imagick php7.4-common php7.4-mysql php7.4-fpm php7.4-gd php7.4-json php7.4-curl  php7.4-zip php7.4-xml php7.4-mbstring php7.4-bz2 php7.4-intl php7.4-bcmath php7.4-gmp
                                    sudo apt install mariadb-server
                                    sudo mysql_secure_installation
                                    sudo apt install nginx -y
                                    sudo apt install mariadb-server
                                    sudo mysql_secure_installation
                                    sudo systemctl start nginx
                                    sudo systemctl enable nginx
                                echo " --------------------------------------------------------------"
                            	echo "| Nginx is succesfully installed. (Press ENTER to continue...) |"
                                echo " --------------------------------------------------------------"
                               read ENTER
                        	   menu
                    
                    	else:
                        	clear
                            echo " --------------------------------------------------------------------------------"
                        	echo "| You've entered wrong information please try again (Press ENTER to continue...) |"
                            echo " --------------------------------------------------------------------------------"
                        	read ENTER
                        	webs
                        elif [ "$answer9" != "Nginx" ] || [ "$answer9" != "Apache"] ;then
                        clear
                            echo " --------------------------------------------------------------------------------"
                        	echo "| You've entered wrong information please try again (Press ENTER to continue...) |"
                            echo " --------------------------------------------------------------------------------"
                        	read ENTER
                        	webs2
                            fi
}

function confapacheDB() {
clear
            echo " ---------------------------------------"
            echo "| configure Apache MariaDB server (y/n) |'"
            echo " ---------------------------------------"
            read answer3
            
            if [ "$answer3" != "${answer3#[Yy]}" ] ;then
            
                    sudo mysql -u root -p
                    clear
                    echo " ----------------------------------------------------------"
                    echo "| Configuring Apache paste your config into the next file: |"
                    echo "| (Press y to continue)                                    |"
                    echo " ----------------------------------------------------------"
                    
                    read answer6
                    
                    if [ "$answer6" != "${answer6#[Yy]}" ] ;then
                        sudo systemctl stop apache2.service
                        sudo nano /etc/apache2/sites-available/nextcloud.conf
                        sudo a2ensite nextcloud.conf
                        sudo a2enmod rewrite headers env dir mime setenvif ssl
                        sudo chmod 775 -R /var/www/nextcloud/
                        sudo chown www-data:www-data /var/www/nextcloud/ -R
                        sudo systemctl restart apache2.service
                        clear
                        echo " ---------------------------------------------------------"
                        echo '| Apache Server Configurated (press ENTER to continue...) |'
                        echo " ---------------------------------------------------------"
                        read ENTER
                        menu
                        
                            elif [ "$answer6" != "${answer6#[Nn]}" ] ;then
                                menu
                                clear
                                echo " -----------------------------------------------------"
                                echo "| Configuration Canceled (Press enter to continue...) |"
                                echo " -----------------------------------------------------"
                                read ENTER
                                menu
                            else
                                    clear
                                    echo " ------------------------------------------------"
                                    echo "| Wrong input given (Press enter to continue...) |"
                                    echo " ------------------------------------------------"
                                    read ENTER
                                    confapacheDB
                    fi
                    
            elif [ "$answer3" != "${answer3#[Nn]}" ] ;then
                    menu
                    clear
                    echo " -----------------------------------------------------"
                    echo "| Configuration Canceled (Press enter to continue...) |"
                    echo " -----------------------------------------------------"
                    read ENTER
                    menu
            else
                    clear
                    echo " ------------------------------------------------"
                    echo "| Wrong input given (Press enter to continue...) |"
                    echo " ------------------------------------------------"
                    read ENTER
                    confapacheDB
            fi


}

function confnginxSQL() {

clear
            echo " -------------------------------------------"
            echo "| configure MariaDB for Ngnix Server? (y/n) |'"
            echo " -------------------------------------------"
            read answer3
            
            if [ "$answer3" != "${answer3#[Yy]}" ] ;then
                    clear
                    echo " ----------------------------------------------------------"
                    echo "| Configuring Nginx paste your config into the next file:  |"
                    echo "| (Press y to continue)                                    |"
                    echo " ----------------------------------------------------------"
                    
                    read answer6
                    
                    if [ "$answer6" != "${answer6#[Yy]}" ] ;then
                        sudo nano /etc/nginx/conf.d/nextcloud.conf
                        echo " --------------------------------------------------------"
                        echo "| Configure next config file (Press ENTER to continue...) |"
                        echo " --------------------------------------------------------"
                        read ENTER
                        sudo nano /etc/nginx/nginx.conf
                        sudo chown www-data:www-data /usr/share/nginx/nextcloud/ -R
                        echo "--------------------------------------------------------"
                        echo "| Ngnix configure database (Press ENTER to continue...) |"
                        echo "--------------------------------------------------------"
                        read ENTER
                        sudo mysql -u root -p
                        sudo nginx -t
                        echo "---------------------------------------"
                        echo "| Was the Nginx test succesfull? (y/n) |"
                        echo "---------------------------------------"
                        read answer14
                        
                        if [ "$answer14" != "${answer14#[Yy]}" ] ;then
                            sudo systemctl reload nginx
                            clear
                            echo "----------------------------------------------"
                            echo "| Nginx reloaded (Press ENTER to continue...) |"
                            echo "----------------------------------------------"
                            read ENTER
                            menu
                        
                        else
                            clear
                            echo "----------------------------------------------------------------------"
                            echo "| Something went wrong please try again! (Press ENTER to continue...) |"
                            echo "----------------------------------------------------------------------"
                            read ENTER
                            confnginxSQL
                        
                        fi
                        
                        
                        sudo systemctl reload nginx
                        clear
                        echo " ---------------------------------------------------------"
                        echo '| Apache Server Configurated (press ENTER to continue...) |'
                        echo " ---------------------------------------------------------"
                        read ENTER
                        menu
                        
                            elif [ "$answer6" != "${answer6#[Nn]}" ] ;then
                                menu
                                clear
                                echo " -----------------------------------------------------"
                                echo "| Configuration Canceled (Press enter to continue...) |"
                                echo " -----------------------------------------------------"
                                read ENTER
                                menu
                            else3
                                    clear
                                    echo " ------------------------------------------------"
                                    echo "| Wrong input given (Press enter to continue...) |"
                                    echo " ------------------------------------------------"
                                    read ENTER
                                    confnginxSQL
                    fi
                    
            elif [ "$answer3" != "${answer3#[Nn]}" ] ;then
                    menu
                    clear
                    echo " -----------------------------------------------------"
                    echo "| Configuration Canceled (Press enter to continue...) |"
                    echo " -----------------------------------------------------"
                    read ENTER
                    menu
            else
                    clear
                    echo " ------------------------------------------------"
                    echo "| Wrong input given (Press enter to continue...) |"
                    echo " ------------------------------------------------"
                    read ENTER
                    confnginxSQL
            fi


}

function nxapa() {

clear
            echo " ----------------------------------------------------"
            echo "| Do you want to install Nextcloud for Apache? (y/n) |"
            echo " ----------------------------------------------------"
            read answer10
            
                if [ "$answer10" != "${answer10#[Yy]}" ] ;then
                        #What version would you like to use?
                        nxapa2
                        
                        
            
                elif [ "$answer10" != "${answer10#[Nn]}" ] ;then
                clear
                echo " ----------------------------------------------------"
                echo "| Installation Canceled (Press enter to continue...) |"
                echo " ----------------------------------------------------"
                read ENTER
                menu
                
                else
                    clear
                    echo " ------------------------------------------------"
                    echo "| Wrong input given (Press enter to continue...) |"
                    echo " ------------------------------------------------"
                    read ENTER
                    nxapa
                
                fi

}

function nxapa2() {

clear
                        echo " -----------------------------------------------------------------------------"
                        echo "| What version would you like to download and install? (21.0.0/21.0.1/21.0.2) |"
                        echo " -----------------------------------------------------------------------------"
                        read answer11
                        
                        
                        if [ "$answer11" == "21.0.0" ] ;then
                        clear
                        echo " ------------------------------------------------------------------"
                        echo "| Enter your domain name (Leave empty for default install folder): |"
                        echo " ------------------------------------------------------------------"
                                read DOMAINNAME
                                
                                    sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.0.zip
                                    sudo unzip nextcloud-21.0.0.zip -d /var/www/"$DOMAINNAME"/
                                    echo " --------------------------------------------------------------------------------------------------------------------------------------------------------"
                                    echo "| Nextcloud 21.0.0 is succesfully installed at /var/www/nextcloud/ if default was chosen or /var/www/$DOMAINNAME/nextcloud/ (Press ENTER to continue...) |"
                                    echo " --------------------------------------------------------------------------------------------------------------------------------------------------------"
                                    read ENTER
                                    nxown
                        
                        
                        elif [ "$answer11" == "21.0.1" ] ;then
                                clear
                                echo " ------------------------------------------------------------------"
                                echo "| Enter your domain name (Leave empty for default install folder): |"
                                echo " ------------------------------------------------------------------"
                                read DOMAINNAME
                                
                                    sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.1.zip
                                    sudo unzip nextcloud-21.0.1.zip -d /var/www/"$DOMAINNAME"/
                                    echo " --------------------------------------------------------------------------------------------------------------------------------------------------------"
                                    echo "| Nextcloud 21.0.1 is succesfully installed at /var/www/nextcloud/ if default was chosen or /var/www/$DOMAINNAME/nextcloud/ (Press ENTER to continue...) |"
                                    echo " --------------------------------------------------------------------------------------------------------------------------------------------------------"
                                    read ENTER
                                    nxown
                        elif [ "$answer11" == "21.0.2" ] ;then
                        		clear
                                echo " ------------------------------------------------------------------"
                                echo "| Enter your domain name (Leave empty for default install folder): |"
                                echo " ------------------------------------------------------------------"
                                read DOMAINNAME
                                
                                    sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip
                                    sudo unzip nextcloud-21.0.2.zip -d /var/www/"$DOMAINNAME"/
                                    echo " --------------------------------------------------------------------------------------------------------------------------------------------------------"
                                    echo "| Nextcloud 21.0.2 is succesfully installed at /var/www/nextcloud/ if default was chosen or /var/www/$DOMAINNAME/nextcloud/ (Press ENTER to continue...) |"
                                    echo " --------------------------------------------------------------------------------------------------------------------------------------------------------"
                                    read ENTER
                                    nxown
                        
                        else
                            clear
                            echo " ------------------------------------------------"
                            echo "| Wrong input given (Press enter to continue...) |"
                            echo " ------------------------------------------------"
                            read ENTER
                            nxapa2
                        fi

}

function nxngn(){

clear
            echo " ---------------------------------------------------"
            echo "| Do you want to install Nextcloud for Nginx? (y/n) |"
            echo " ---------------------------------------------------"
            read answer10
            
                if [ "$answer10" != "${answer10#[Yy]}" ] ;then
                        #What version would you like to use?
                        nxngn2
                        
                        
            
                elif [ "$answer10" != "${answer10#[Nn]}" ] ;then
                        menu
                        clear
                        echo " ----------------------------------------------------"
                        echo "| Installation Canceled (Press enter to continue...) |"
                        echo " ----------------------------------------------------"
                        read ENTER
                        menu
                else
                    clear
                    echo " ------------------------------------------------"
                    echo "| Wrong input given (Press enter to continue...) |"
                    echo " ------------------------------------------------"
                    read ENTER
                    nxngn
                fi

}

function nxngn2() {

clear
                        echo " -----------------------------------------------------------------------------"
                        echo "| What version would you like to download and install? (21.0.0/21.0.1/21.0.2) |"
                        echo " -----------------------------------------------------------------------------"
                        read answer11
                        
                        
                        if [ "$answer11" == "21.0.0" ] ;then
                        
                        echo " ------------------------------------------------"
                        echo "| Enter your domain name (default? enter nginx): |"
                        echo " ------------------------------------------------"
                                read DOMAINNAME
                                
                                    sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.0.zip
                                    sudo unzip nextcloud-21.0.0.zip -d /usr/share/"$DOMAINNAME"/
                                    echo " -------------------------------------------------------------------------------------------------"
                                    echo "| Nextcloud 21.0.0 is succesfully installed at /var/www/$DOMAINNAME/ (Press ENTER to continue...) |"
                                    echo " -------------------------------------------------------------------------------------------------"
                                    read ENTER
                                    ngown
                        
                        
                        elif [ "$answer11" == "21.0.1" ] ;then
                                #
                                echo " ------------------------------------------------"
                                echo "| Enter your domain name (default? enter nginx): |"
                                echo " ------------------------------------------------"
                                read DOMAINNAME
                                
                                    sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.1.zip
                                    sudo unzip nextcloud-21.0.1.zip -d /usr/share/"$DOMAINNAME"/
                                    echo " -------------------------------------------------------------------------------------------------"
                                    echo "| Nextcloud 21.0.0 is succesfully installed at /var/www/$DOMAINNAME/ (Press ENTER to continue...) |"
                                    echo " -------------------------------------------------------------------------------------------------"
                                    read ENTER
                                    ngown
                        elif [ "$answer11" == "21.0.2" ] ;then
                        
                                echo " ------------------------------------------------"
                                echo "| Enter your domain name (default? enter nginx): |"
                                echo " ------------------------------------------------"
                                read DOMAINNAME
                                
                                    sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip
                                    sudo unzip nextcloud-21.0.2.zip -d /usr/share/"$DOMAINNAME"/
                                    echo " -------------------------------------------------------------------------------------------------"
                                    echo "| Nextcloud 21.0.0 is succesfully installed at /var/www/$DOMAINNAME/ (Press ENTER to continue...) |"
                                    echo " -------------------------------------------------------------------------------------------------"
                                    read ENTER
                                    ngown
                        
                        else
                            clear
                            echo " ------------------------------------------------"
                            echo "| Wrong input given (Press enter to continue...) |"
                            echo " ------------------------------------------------"
                            read ENTER
                            nxngn2
                        fi

}

function ctd() {

                    clear
                    echo " -----------------------------------------------------------------------"
                    echo "| You've selected to configure the trusted domains is this right? (y/n) |"
                    echo " -----------------------------------------------------------------------"
                    read answer12
                    
                    if [ "$answer12" != "${answer12#[Yy]}" ] ;then
                    clear
                    echo " -------------------------------------------------"
                    echo "| Which webserver did you install? (Apache/Nginx) |"
                    echo " -------------------------------------------------"
                    read answer16
                            if [ "$answer16" == "Apache" ] ;then
                                clear
                                echo " ------------------------------------------------"
                                echo "| Enter your domain name (Default is 'nextcloud'): |"
                                echo " ------------------------------------------------"
                                read DOMAINNAME
                                sudo systemctl stop apache2.service
                                sudo nano /var/www/"$DOMAINNAME"/config/config.php
                                sudo systemctl start apache2.service
                                clear
                                    echo " ---------------------------------------------------------------"
                                    echo "| Configuration Succesfully Edited (Press enter to continue...) |"
                                    echo " ---------------------------------------------------------------"
                                        clear
                                        menu
                            elif [ "$answer16" == "Nginx" ] ;then
                                clear
                                echo " --------------------------------------------"
                                echo "| Enter your domain name (Default is 'nginx'): |"
                                echo " --------------------------------------------"
                                read DOMAINNAME
                                sudo systemctl stop nginx.service
                                sudo nano /usr/share/"$DOMAINNAME"/nextcloud/config/config.php
                                sudo systemctl start nginx.service
                                clear
                                    echo " ---------------------------------------------------------------"
                                    echo "| Configuration Succesfully Edited (Press enter to continue...) |"
                                    echo " ---------------------------------------------------------------"
                            fi
            elif [ "$answer12" != "${answer12#[Nn]}"] ;then
                clear
                echo " -----------------------------------------------------"
                echo "| Configuration Canceled (Press enter to continue...) |"
                echo " -----------------------------------------------------"
                READ ENTER
                menu
                    else
                        clear
                        echo " ------------------------------------------------"
                        echo "| Wrong input given (Press enter to continue...) |"
                        echo " ------------------------------------------------"
                        read ENTER
                        ctd
                fi

}

function security(){
    clear
    echo " ---------------------------------------------------------"
    echo "| You've chosen to install or edit security options (y/n) |"
    echo " ---------------------------------------------------------"
    read answer20
        if [ "$answer20" != "${answer20#[Yy]}" ] ;then
        
            security2
                
        elif [ "$answer20" != "${answer20#[Nn]}" ] ;then
        
        clear
            echo " -----------------------------------------------------"
            echo "| Abort Security Config (Press ENTER to continue...) |"
            echo " -----------------------------------------------------"
            read ENTER
			clear
            menu
        
        else
            clear
            echo " ----------------------------------------------------"
            echo "| Something went wrong (Press ENTER to continue...) |"
            echo " ----------------------------------------------------"
            read ENTER
			clear
            security
            fi
}

function security2() {
                        clear
                        echo " --------------------------------"
                        echo "| Choose your option:            |"
                        echo "|--------------------------------|"
                        echo "| 1: Install Fail2ban            |" 
                        echo "| 2: Configure Fail2ban          |"
                        echo "| 3: Install SSL                 |"
                        echo "| 4: Make a Certificate (SSL)    |"  
                        echo "| 5: Install Let's Encrypt (SSL) |"
                        echo "| 6: Exit to Menu                |"
                        echo "|                --============# |"
                        echo " --------------------------------"
                        read answer21
                if [ "$answer21" == "1" ] ;then
                    sudo apt-get install fail2ban
                    #herstel
                    sudo cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
                    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
                    sudo systemctl enable fail2ban
                    sudo systemctl start fail2ban
                    sudo systemctl status fail2ban.service
                    sudo fail2ban-client status
                    sudo fail2ban-client status sshd
                    clear
                        echo " --------------------------------------------------------"
                        echo "| You've installed fail2ban (Press ENTER to continue...) |"
                        echo " --------------------------------------------------------"
                		read ENTER
						security
                elif [ "$answer21" != "${answer21#[2]}" ] ;then
                        clear
                        sudo nano /etc/fail2ban/fail2ban.local
                        sudo nano /etc/fail2ban/jail.local
                        clear
                        echo " ---------------------------------------------------------"
                        echo "| You've configured fail2ban (Press ENTER to continue...) |"
                        echo " ---------------------------------------------------------"
                        read ENTER
                        security

                elif [ "$answer21" != "${answer21#[3]}" ] ;then
                            clear
                            sudo apt-get install openssl
                            clear
                            echo " -------------------------------------------------"
                            echo "| Openssl is installed. (Press ENTER to Continue) |"
                            echo " -------------------------------------------------"
                            read ENTER
                            security
                
                elif [ "$answer21" != "${answer21#[4]}" ] ;then
                                clear
                                sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.key -out /etc/ssl/certs/apache-       selfsigned.crt
                                sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
                                clear
                                echo " -------------------------------------------------------------"
                                echo "| You succesfull made a certificate (Press ENTER to continue) |"
                                echo " -------------------------------------------------------------"
                                read ENTER
                                security
                elif [ "$answer21" == "6" ] ;then
                clear
                menu
                
                elif [ "$answer21" != "${answer21#[5]}" ] ;then
                    clear
                    echo " ------------------------------------------------------------------------"
                    echo "| Do you want to install or configure Let's Encrypt? (install/configure) |"
                    echo " ------------------------------------------------------------------------"
                    read answer23
                    
                    if [ "$answer23" == "install" ] ;then
                        sudo apt-get install certbot
                        sudo ufw allow 80
                        sudo ufw allow 443
                        sudo apt install letsencrypt
                        sudo systemctl status certbot.timer
                        clear
                        echo " ------------------------------------------------------------"
                        echo "| You succesfull installed certbot (Press ENTER to continue) |"
                        echo " ------------------------------------------------------------"
                        read ENTER
                        security
                        
                    elif [ "$answer23" == "configure" ] ;then
                    
                        clear
                        echo " ----------------------------------------------------------"
                        echo "| Do you want to configure Lets Encrypt for (apache/nginx) |"
                        echo " ----------------------------------------------------------"
                        read answer24
                        
                        if [ "$answer24" != "${answer24#[apache]}" ] ;then
                                echo " ---------------------------------------------------"
                                echo "| Enter your domain name (example www.mydomain.com) |"
                                echo " ---------------------------------------------------"
                                read DOMAINNAME2
                                        sudo certbot --apache --agree-tos --preferred-challenges http -d $DOMAINNAME2
                                        sudo certbot --apache
                                        sudo certbot renew
                                        sudo certbot renew --dry-run
                                        sudo certbot certonly --manual --agree-tos --preferred-challenges dns -d $DOMAINNAME2 -d *."$DOMAINNAME2"
                                        echo " ----------------------------------------------------------------------"
                                        echo "| You've configured Let's Encrypt Certbot (Press ENTER to continue...) |"
                                        echo " ----------------------------------------------------------------------"
                                        read ENTER
                                        security
                                
                        elif [ "$answer24" != "${answer24#[nginx]}" ] ;then
                            echo " ----------------------------------------------------"
                            echo "| Enter your domain name (example: www.mydomain.com) |"
                            echo " ----------------------------------------------------"
                            read DOMAINNAME3
                        sudo certbot --nginx --agree-tos --preferred-challenges http -d $DOMAINNAME3
                                sudo certbot --ngnix
                                sudo certbot renew
                                sudo certbot renew --dry-run
                                sudo certbot certonly --manual --agree-tos --preferred-challenges dns -d $DOMAINNAME3 -d *."$DOMAINNAME3"
                                echo " ----------------------------------------------------------------------"
                                echo "| You've configured Let's Encrypt Certbot (Press ENTER to continue...) |"
                                echo " ----------------------------------------------------------------------"
                                read ENTER
                                security
                                
                        else
                            echo " ----------------------------------------------------"
                            echo "| Something went wrong. (Press ENTER to continue...) |"
                            echo " ----------------------------------------------------"
                            read ENTER
                            security
                        fi
            
                else
				clear
                    echo " ----------------------------------------------------"
                    echo "| Something went wrong. (Press ENTER to continue...) |"
                    echo " ----------------------------------------------------"
                    read ENTER
                    security
                fi
    
        elif [ "$answer20" != "${answer20#[Nn]}" ] ;then
        
        clear
            echo " -----------------------------------------------------"
            echo "| Abort Security Config (Press ENTER to continue...) |"
            echo " -----------------------------------------------------"
            read ENTER
			clear
            menu
        
        else
            clear
            echo " ----------------------------------------------------"
            echo "| Something went wrong (Press ENTER to continue...) |"
            echo " ----------------------------------------------------"
            read ENTER
			clear
            security
 
		fi
}

function easter() {
clear
echo " -----"
echo "| Egg |"
echo " -----"
read ENTER
menu

}

function editphp() {
        clear
        echo "---------------------------------"
        echo "| Do you want to edit php? (y/n) |"
        echo "---------------------------------"
        read answer27
    if [ "$answer27" != "${answer27#[Yy]}" ] ;then
        sudo nano /etc/php/7.4/cli/php.ini
		menu
    elif [ "$answer27" != "${answer27#[Nn]}" ] ;then
        menu
    else
        clear
        echo "----------------------------------------------------"
        echo "| Something went wrong (Press ENTER to continue...) |"
        echo "----------------------------------------------------"
        read ENTER
        editphp
    fi
}

function credits() {
clear
echo "
 ____________________
!                    !"
echo "! Special Thanks to  !
!     Niek Brock     !
!____________________!
         !  !
         !  !
         L_ !
        / _)!
       / /__L
 _____/ (____)
        (____)
 _____  (____)
      \_(____)
         !  !
         !  !
         \__/
"     
echo ' '
echo "This tool is created by CodingAlphaWolf a.k.a mr. T."
echo ' ' 
echo "To succesfully complete the Open Source course."
echo ":P"
read ENTER
menu

}

function menu() {
clear
echo '
                          
 __      __      ___.                                           
/  \    /  \ ____\_ |__   ______ ______________  __ ___________ 
\   \/\/   // __ \| __ \ /  ___// __ \_  __ \  \/ // __ \_  __ \
 \        /\  ___/| \_\ \\___ \\  ___/|  | \/\   /\  ___/|  | \/
  \__/\  /  \___  >___  /____  >\___  >__|    \_/  \___  >__|   
       \/       \/    \/     \/     \/                 \/       
.___                 __         .__  .__                        
|   | ____   _______/  |______  |  | |  |                       
|   |/    \ /  ___/\   __\__  \ |  | |  |                       
|   |   |  \\___ \  |  |  / __ \|  |_|  |__                     
|___|___|  /____  > |__| (____  /____/____/                     
         \/     \/            \/                                
___________           .__                                       
\__    ___/___   ____ |  |                                      
  |    | /  _ \ /  _ \|  |                                      
  |    |(  <_> |  <_> )  |__                                    
  |____| \____/ \____/|____/ '
echo ' '
echo 'Welcome to this webserver install tool (by CodingAlphaWolf) v2.4b'
echo ' '
PS4='Please enter your choice: '
options=("Install a Webserver" "Edit PHP" "Install Nextcloud (Apache)" "Install Nextcloud (Nginx)" "Whats my IP" "Configure Apache Mariadb (APS)" "Configure Nginx mysql for (NGS)" "Make an admin account" "Security Options" "Configure Trusted Domains" "Possible page loading fix" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install a Webserver")
                webs
            ;;
        "Whats my IP")
        clear
            echo "|------------------------------------------------------------------------------"
            echo "| Whats my IP, requires some tools to be installed, they are called net-tools. |"
            echo "| Do you want to install this tools? (y/n)                                     |"
            echo "|------------------------------------------------------------------------------"
            read answer18
            
            if [ "$answer18" != "${answer18#[Yy]}" ] ;then
                    sudo apt install net-tools
                    clear
                    echo " ---------------------------------------------------"
                    echo " Your IP Address:"
                            ifconfig | grep broadcast | awk '{print $2}'
                    echo " ---------------------------------------------------"
                    echo " Press ENTER to continue..."
                    read ENTER
                        menu
            else
                    clear
                    echo " ---------------------------------------------------"
                    echo " Your IP Address:"
                            ifconfig | grep broadcast | awk '{print $2}'
                    echo " ---------------------------------------------------"
                    echo " Press ENTER to continue..."
                    read ENTER
                        menu
            
            fi
            
            ;;
        "Configure Apache Mariadb (APS)")
                confapacheDB
            ;;
		"Security Options")
		clear
		security
		;;
            "Configure Nginx mysql for (NGS)")
                confnginxSQL
            ;;
        "Quit")
            exit
            ;;
        "Make an admin account")
            clear
            echo " -------------------------------------------------------------------------------------------------------------------------------"
            echo "| If you want to make an admin account press (Y/y) (if you already have a nextcloud admin account skip this by pressing ENTER.) |"
            echo " -------------------------------------------------------------------------------------------------------------------------------"
	       read answer7
           
		      if [ "$answer7" != "${answer7#[Yy]}" ] ;then
			     clear
			     echo "Open the link in your browser and make an admin account: "
			     echo "link format: ip/nextcloud/"
                 echo " "
			     echo '-------------------------------------------'
			     echo "Your IP Address is: "
			     ifconfig | grep broadcast | awk '{print $2}'
			     echo '-------------------------------------------'
                 echo " "
			     echo "Add an exception to the config file if your server isn't visible"
			     echo "The code can be found in the CONFIG.txt file, press (Y/y) to continue and edit the nextcloud config file."
                 
			     read answer8
                 
				        if [ "$answer8" == "${answer8#[Yy]}" ] ;then
                        
				        sudo systemctl stop apache2.service
				        sudo nano /var/www/nextcloud/config/config.php
				        sudo systemctl restart apache2.service
                        else
                        menu
                        fi
				        clear
				        sudo systemctl restart apache2.service
                        echo " -----------------------------------------------------------------------------------"
				        echo "| Apache2 restarted and installation finished (Press ENTER to go back to the menu.) |"
                        echo " -----------------------------------------------------------------------------------"
                        read ENTER
                        menu

                else
                clear
                menu
                
		      fi
              ;;
        "Install Nextcloud (Apache)")
                nxapa
				;;
        "Edit PHP")
                editphp
            ;;
            
            "Install Nextcloud (Nginx)")
                nxngn
            ;;
            "Configure Trusted Domains")
                ctd    
            ;;
            "Possible page loading fix")
                    clear
                    echo "-----------------------------------------------------------------"
                    echo "| Would you like to apply a possible fix for page loading? (y/n) |"
                    echo "-----------------------------------------------------------------"
                    read answer15
                        if [ "$answer15" != "${answer15#[Yy]}" ] ;then
                        sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
                        sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT
                     
                            echo " ------------------------------------------"
                            echo "| Fix applied (Press ENTER to continue...) |"
                            echo " ------------------------------------------"
                            read ENTER
                            menu
                    else
                        clear
                        menu    
                    
                    fi
            ;;
        *) clear
        echo " ---------------------------------------------------"
        echo "| Invalid input $REPLY (Press ENTER to continue...) |"
        echo " ---------------------------------------------------"
        read ENTER
        if [ "$ENTER" == "easter" ] ;then
            easter
        elif [ "$ENTER" == "credits" ] ;then
            credits
        else
        clear
        menu
        fi
        ;;
    esac
done
}

#Start Menu (Function Menu)
clear
menu
