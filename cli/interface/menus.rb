# cli/interface/menus.rb
class Menus < BaseInterface
  def display_main_menu
    puts "\n\e[1m=== Main Menu ===\e[0m"
    puts "\e[1;34m1. View data"
    puts "\e[1;32m2. Create new record\e[0m"
    puts "\e[1;33m3. Update record\e[0m"
    puts "\e[1;31m4. Delete record\e[0m"
    puts "\e[1mq. Quit\e[0m"
    print "\nEnter your choice: "
  end

  def view_menu
    loop do
      puts "\n\e[1;34m--- View Menu ---\e[0m"
      puts "1. View all children"
      puts "2. View all entries"
      puts "3. View all milestones"
      puts "4. View entries by child"
      puts "5. View entries by milestone"
      puts "6. View milestones by child"
      puts "b. Back to main menu | q. Quit"
      print "\nEnter your choice: "

      choice = gets.chomp.downcase
      handle_quit(choice)
      break if handle_back(choice) == :back

      case choice
      when "1" then view_all_children
      when "2" then view_all_entries
      when "3" then view_all_milestones
      when "4" then view_entries_by_child
      when "5" then view_entries_by_milestone
      when "6" then view_milestones_by_child
      else puts "Invalid choice. Try again."
      end
    end
  end

  def create_menu
    loop do
      puts "\n\e[4;32m--- Create Menu ---\e[0m"
      puts "1. Create a new child"
      puts "2. Create a new entry"
      puts "3. Create a new milestone"
      puts "b. Back to main menu | q. Quit"
      print "\nEnter your choice: "

      choice = gets.chomp.downcase
      handle_quit(choice)
      break if handle_back(choice) == :back

      case choice
      when "1" then create_child
      when "2" then create_entry
      when "3" then create_milestone
      else puts "Invalid choice. Try again."
      end
    end
  end

  def update_menu
    loop do
      puts "\n\e[4;33m--- Update Menu ---\e[0m"
      puts "1. Update a child"
      puts "2. Update an entry"
      puts "3. Update a milestone"
      puts "b. Back to main menu | q. Quit"
      print "\nEnter your choice: "

      choice = gets.chomp.downcase
      handle_quit(choice)
      break if handle_back(choice) == :back

      case choice
      when "1" then update_child
      when "2" then update_entry
      when "3" then update_milestone
      else puts "Invalid choice. Try again."
      end
    end
  end

  def delete_menu
    loop do
      puts "\n\e[4;31m--- Delete Menu ---\e[0m"
      puts "1. Delete a child (legally)"
      puts "2. Delete an entry"
      puts "3. Delete a milestone"
      puts "b. Back to main menu | q. Quit"
      print "\nEnter your choice: "

      choice = gets.chomp.downcase
      handle_quit(choice)
      break if handle_back(choice) == :back

      case choice
      when "1" then delete_child
      when "2" then delete_entry
      when "3" then delete_milestone
      else puts "Invalid choice. Try again."
      end
    end
  end
end
