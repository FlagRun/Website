namespace :unread do
  desc 'Cleanup Unread markers'
  task mark_all_read: :environment do
    Forum::Forum.cleanup_read_marks!
  end

end
