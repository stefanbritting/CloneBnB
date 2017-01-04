class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    # calling like ReservationJob.perform will queue this job in the overall
    # queue and execute it when its turn
  end
end
