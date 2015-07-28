namespace :flights do
  desc "Start worker that updating flights statuses"
  task start_worker: :environment do
    FlightsStatusWorker.perform_async
  end

end
