# General vars
ENV_FILE="~/.env"

# Ask project name
echo "${BOLDYELLOW}Project name in lowercase (without spaces or special characters):${TXTRESET} "
read -e PROJECTNAME

# Check if local .env found
if [ ! -f ~/.env_createproject ]; then
  # Ask Credentials
  echo "${BOLDYELLOW}What is your MySQL root password (asked only first time):${TXTRESET} "
  read -e MYSQL_ROOT_PASSWORD

  echo "${BOLDYELLOW}What is the admin user you want to login to wp-admin by default (asked only first time):${TXTRESET} "
  read -e WP_ADMIN_USER

  echo "${BOLDYELLOW}What is the password you want to use with your wp-admin admin user by default (asked only first time):${TXTRESET} "
  read -e WP_ADMIN_USER_PASSWORD

  echo "${BOLDYELLOW}What is the email address you want to use with your wp-admin admin user by default (asked only first time):${TXTRESET} "
  read -e WP_ADMIN_USER_EMAIL

  # Add Credentials to .env under HOME dir
  touch $ENV_FILE
  echo -e "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}" >> $ENV_FILE
  echo -e "WP_ADMIN_USER=${WP_ADMIN_USER}" >> $ENV_FILE
  echo -e "WP_ADMIN_USER_PASSWORD=${WP_ADMIN_USER_PASSWORD}" >> $ENV_FILE
  echo -e "WP_ADMIN_USER_EMAIL=${WP_ADMIN_USER_EMAIL}" >> $ENV_FILE
fi

# Do we use GitHub settings or not
read -p "${boldyellow}Do you want to use automatic GitHub organisation repositories for your projects? (y/n)${txtreset} " yngithub
  if [ "$yngithub" = "y" ]; then

    # GitHub username
    if grep -Fxq "GITHUB_COMPANY_USERNAME" $ENV_FILE
    then
      # If found
      echo ""
    else
      # If not found
      echo "${boldyellow}GitHub company username (this is used for repo url):${txtreset} "
      read -e GITHUB_COMPANY_USERNAME >> $ENV_FILE
    fi

    # GitHub access token
    if grep -Fxq "GITHUB_ACCESS_TOKEN" $ENV_FILE
    then
      # If found
      echo ""
    else
      # If not found
      echo "${boldyellow}GitHub access token (Tutorial: https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/):${txtreset} "
      read -e GITHUB_ACCESS_TOKEN >> $ENV_FILE
    fi
  fi

# Asked vars in env
MYSQL_ROOT_PASSWORD_ENV=$(grep MYSQL_ROOT_PASSWORD $ENV_FILE | cut -d '=' -f2)
WP_ADMIN_USER_ENV=$(grep WP_ADMIN_USER $ENV_FILE | cut -d '=' -f2)
WP_ADMIN_USER_PASSWORD_ENV=$(grep WP_ADMIN_USER_PASSWORD $ENV_FILE | cut -d '=' -f2)
WP_ADMIN_USER_EMAIL_ENV=$(grep WP_ADMIN_USER_EMAIL $ENV_FILE | cut -d '=' -f2)
GITHUB_ACCESS_TOKEN_ENV=$(grep GITHUB_ACCESS_TOKEN $ENV_FILE | cut -d '=' -f2)
GITHUB_COMPANY_USERNAME_ENV=$(grep GITHUB_COMPANY_USERNAME $ENV_FILE | cut -d '=' -f2)
