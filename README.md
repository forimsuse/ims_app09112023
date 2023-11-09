# repoWD


09112023: 
* renamed file battery.page as home_page
* renamed file home.page as devices_page
* created pages directory
* moved home_page and devices_page to pages directory
* renamed class HomePage as DevicesPage
* renamed class BatteryPage as HomePage
* updated route /battery to /home
* got rid of fonts in pubspec.yaml
* deleted every reference to 'fontFamily'
* deleted fonts directory, commented in pubspec
* changed app_colors to different colors
* changed splash picture, android->app->src->main->res->drawable is where the files sit.
  img_1 is logo, splash is BOO.
  the file where you define these things is v31\style.xml.
* did not touch anything ios related
