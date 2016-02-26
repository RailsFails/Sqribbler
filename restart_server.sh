RAILS_ENV=production rake assets:precompile
su root -c "service unicorn restart"
