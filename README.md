## url-tracking

##Steps

### Clone the repo
git clone https://github.com/AjayROR/url-tracking.git

bundle install

rake db:drop rake db:create

rake db:migrate

### Run this to create sample user & 5 urls for them.
rake db:seed

### Update the cron tasks & set the environment to development(Assumption)
crontab -r
whenever --update-crontab --set environment='development'

### Start your server
rails s
# Now login with the registered Email ID & be on your dashboard
# Running cronjob will verify the status of added urls in 2 minutes gaph
# And automatically the dashboards will be refreshed when any of the url gets Updated.



###Further notes:
Maximum 10 urls can be added per user basis, this limit can be configured at
 config/initializers/setting.rb
 Current value is set to 10
