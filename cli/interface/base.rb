# cli/interface/base.rb
require_relative "../api_client"
require_relative "helpers/display"
require_relative "helpers/spinner"
require_relative "actions/view"
require_relative "actions/create"
require_relative "actions/update"
require_relative "actions/delete"

class BaseInterface
  include DisplayHelper
  include SpinnerHelper

  def initialize
    @api_client = APIClient.new
  end

  def rainbow_block(text)
    colors = [31, 33, 32, 36, 34, 35]
    lines = text.lines.map.with_index do |line, i|
      "\e[1;#{colors[i % colors.length]}m#{line.chomp}\e[0m"
    end
    puts lines.join("\n")
  end

  def handle_quit(choice)
    return unless %w[q quit exit].include?(choice)

    puts "Say bye-bye!"
    exit

  end

  def handle_back(choice)
    if %w[b back <<].include?(choice)
      puts "\n<<\n"
      return :back
    end

    nil
  end

  def play_sound_async(path)
    pid = spawn("afplay", path)
    Process.detach(pid)
  end
end
