<?php

// Helper to run shell commands and output them
function run($cmd) {
    echo "Running: $cmd\n";
    system($cmd, $retval);
    if ($retval !== 0) {
        echo "Command failed: $cmd\n";
        exit($retval);
    }
}

// ------------------------------------
// wp-cli installation
// ------------------------------------

run('curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar');
run('chmod +x wp-cli.phar');
run('mv wp-cli.phar /usr/local/bin/wp');

// ------------------------------------
// WordPress setup
// ------------------------------------

$wordpressDir = '/var/www/wordpress';

if (!is_dir($wordpressDir)) {
    mkdir($wordpressDir, 0755, true);
}

run('chmod -R 755 ' . escapeshellarg($wordpressDir));
run('chown -R www-data:www-data ' . escapeshellarg($wordpressDir));

chdir($wordpressDir);

// Download WordPress core files
run('wp core download --allow-root');

$mysqlDb        = getenv('MYSQL_DATABASE');
$mysqlUser      = getenv('MYSQL_USER');
$mysqlPassword  = getenv('MYSQL_PASSWORD');
$domainName     = getenv('DOMAIN_NAME');
$wpTitle        = getenv('WP_TITLE');
$wpAdminUser    = getenv('WP_ADMIN_USERNAME');
$wpAdminPass    = getenv('WP_ADMIN_PASSWORD');
$wpAdminEmail   = getenv('WP_ADMIN_EMAIL');
$wpUserName     = getenv('WP_USER_USERNAME');
$wpUserEmail    = getenv('WP_USER_EMAIL');
$wpUserPass     = getenv('WP_USER_PASSWORD');
$wpUserRole     = getenv('WP_USER_ROLE');

run("wp core config --dbhost=mariadb:3306 --dbname={$mysqlDb} --dbuser={$mysqlUser} --dbpass={$mysqlPassword} --allow-root");

// Install WordPress
run("wp core install --url={$domainName} --title={$wpTitle} --admin_user={$wpAdminUser} --admin_password={$wpAdminPass} --admin_email={$wpAdminEmail} --allow-root");

// Create additional user
run("wp user create {$wpUserName} {$wpUserEmail} --user_pass={$wpUserPass} --role={$wpUserRole} --allow-root");

// ------------------------------------
// PHP-FPM config
// ------------------------------------

$phpFpmConf = '/etc/php/7.4/fpm/pool.d/www.conf';
if (file_exists($phpFpmConf)) {
    $contents = file_get_contents($phpFpmConf);
    $contents = preg_replace('/^listen = .*/m', 'listen = 9000', $contents);
    file_put_contents($phpFpmConf, $contents);
}

// Create run directory for php-fpm
if (!is_dir('/run/php')) {
    mkdir('/run/php', 0755, true);
}

// Start php-fpm in foreground
run('/usr/sbin/php-fpm7.4 -F');
