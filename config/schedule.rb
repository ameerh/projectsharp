# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

every 10.minutes do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  rake "populate"
end

every 18.hours do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  rake "update_next_day_games"
end

every 12.hours do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  rake "populate_teams_stats_p"
end

every 12.hours do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  rake "populate_pitchers_stats"
end
# Learn more: http://github.com/javan/whenever
