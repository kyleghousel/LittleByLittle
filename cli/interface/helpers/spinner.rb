# cli/interface/helpers/spinner.rb

module SpinnerHelper
  def with_spinner(message = "Loading", duration: 1.0, interval: 0.1)
    spinner = %w[| / - \\]
    total_frames = (duration / interval).to_i

    total_frames.times do |i|
      print "\r#{message} #{spinner[i % spinner.length]}"
      sleep(interval)
    end

    print "\r#{message}\n"
  end
end
