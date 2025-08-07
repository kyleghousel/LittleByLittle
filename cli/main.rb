#!/usr/bin/env ruby

require "rest-client"
require "json"

require_relative "api_client"

require_relative "interface/base"
require_relative "interface/menus"

require_relative "interface/actions/view"
require_relative "interface/actions/create"
require_relative "interface/actions/update"
require_relative "interface/actions/delete"

require_relative "interface/helpers/display"
require_relative "interface/helpers/spinner"

class CLIInterface < Menus
  include ViewActions
  include CreateActions
  include UpdateActions
  include DeleteActions

  def initialize
    super
    @api_client = APIClient.new
  end

  def run

    ascii_art = <<~'ASCII'
       _      _  _    _    _       ______         _      _  _    _    _
      | |    (_)| |  | |  | |      | ___ \       | |    (_)| |  | |  | |        _       .,
      | |     _ | |_ | |_ | |  ___ | |_/ / _   _ | |     _ | |_ | |_ | |  ___   `\.____|_\
      | |    | || __|| __|| | / _ \| ___ \| | | || |    | || __|| __|| | / _ \    \______/
      | |____| || |_ | |_ | ||  __/| |_/ /| |_| || |____| || |_ | |_ | ||  __/     (_)(_)
      \_____/|_| \__| \__||_| \___|\____/  \__, |\_____/|_| \__| \__||_| \___|
                                            __/ |
                                           |___/
    ASCII

    puts "\nWelcome to \e[1;35mLittleByLittle CLI\e[0m 🍼"
    puts "Make sure your API server is running on http://localhost:9292"
    puts
    puts rainbow_block(ascii_art)
    puts "Log your child's developmental milestones!"

    loop do
      display_main_menu
      choice = gets.chomp.downcase
      handle_quit(choice)

      case choice
      when "1" then view_menu
      when "2" then create_menu
      when "3" then update_menu
      when "4" then delete_menu
      else puts "Invalid choice. Please try again."
      end
    end
  end
end

CLIInterface.new.run if __FILE__ == $PROGRAM_NAME
