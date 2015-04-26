namespace :url_tracker do

  desc "TODO"
  task check_health: :environment do
    Url.verify_status
  end

end