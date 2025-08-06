#!/usr/bin/env ruby

require "rest-client"
require "json"
require "pry"

class APIClient
  def initialize(base_url = "http://localhost:9292")
    @base_url = base_url
  end

  def parse_response(response)
    body = response.body.strip
    body.empty? ? {} : JSON.parse(body)
  end

  def get_children
    response = RestClient.get("#{@base_url}/children")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to fetch children: #{e.message}" }
  end

  def get_child(id)
    response = RestClient.get("#{@base_url}/children/#{id}")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to fetch child: #{e.message}" }
  end

  def create_child(data)
    response = RestClient.post("#{@base_url}/children", data.to_json, content_type: :json)
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to create child: #{e.message}" }
  end

  def update_child(id, data)
    response = RestClient.patch("#{@base_url}/children/#{id}", data.to_json, content_type: :json)
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to update child: #{e.message}" }
  end

  def delete_child(id)
    response = RestClient.delete("#{@base_url}/children/#{id}")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to delete child: #{e.message}" }
  end

  def get_entries
    response = RestClient.get("#{@base_url}/entries")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to fetch entries: #{e.message}" }
  end

  def get_entry(id)
    response = RestClient.get("#{@base_url}/entries/#{id}")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to fetch entry: #{e.message}" }
  end

  def get_entries_by_child(id)
    response = RestClient.get("#{@base_url}/children/#{id}/entries")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to fetch entry: #{e.message}" }
  end

  def get_entries_by_milestone(id)
    response = RestClient.get("#{@base_url}/milestones/#{id}/entries")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to fetch entry: #{e.message}" }
  end

  def get_milestones_by_child(id)
    response = RestClient.get("#{@base_url}/children/#{id}/milestones")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to fetch child: #{e.message}" }
  end

  def create_entry(data)
    response = RestClient.post("#{@base_url}/entries", data.to_json, content_type: :json)
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to create entry: #{e.message}" }
  end

  def update_entry(id, data)
    response = RestClient.patch("#{@base_url}/entries/#{id}", data.to_json, content_type: :json)
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to update entry: #{e.message}" }
  end

  def delete_entry(id)
    response = RestClient.delete("#{@base_url}/entries/#{id}")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to delete entry: #{e.message}" }
  end

  def get_milestones
    response = RestClient.get("#{@base_url}/milestones")
    parse_response(response) unless response.body.strip.empty?
  rescue RestClient::Exception => e
    { error: "Failed to fetch milestones: #{e.message}" }
  end

  def create_milestone(data)
    response = RestClient.post("#{@base_url}/milestones", data.to_json, content_type: :json)
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to create milestone: #{e.message}" }
  end

  def update_milestone(id, data)
    response = RestClient.patch("#{@base_url}/milestones/#{id}", data.to_json, content_type: :json)
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to update milestone: #{e.message}" }
  end

  def delete_milestone(id)
    response = RestClient.delete("#{@base_url}/milestones/#{id}")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to delete milestone: #{e.message}" }
  end
end

class CLIInterface
  def initialize
    @api_client = APIClient.new
  end

  def run
    puts "Welcome to LittleByLittle CLI!"
    puts "Make sure your API server is running on http://localhost:9292"
    puts
    puts <<~'ASCII'


       _      _  _    _    _       ______         _      _  _    _    _
      | |    (_)| |  | |  | |      | ___ \       | |    (_)| |  | |  | |        _       .,
      | |     _ | |_ | |_ | |  ___ | |_/ / _   _ | |     _ | |_ | |_ | |  ___   `\.____|_\
      | |    | || __|| __|| | / _ \| ___ \| | | || |    | || __|| __|| | / _ \    \______/
      | |____| || |_ | |_ | ||  __/| |_/ /| |_| || |____| || |_ | |_ | ||  __/     (_)(_)
      \_____/|_| \__| \__||_| \___|\____/  \__, |\_____/|_| \__| \__||_| \___|
                                            __/ |
                                           |___/
    ASCII
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

  def handle_quit(choice)
    return unless %w[q quit exit].include?(choice)

    puts "Goodbye!"
    exit

  end

  def display_main_menu
    puts "\n=== Main Menu ==="
    puts "1. View data"
    puts "2. Create new record"
    puts "3. Update record"
    puts "4. Delete record"
    puts "q. Quit"
    print "\nEnter your choice: "
  end

  def view_menu
    loop do
      puts "\n--- View Menu ---"
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

      case choice
      when "1" then view_all_children
      when "2" then view_all_entries
      when "3" then view_all_milestones
      when "4" then view_entries_by_child
      when "5" then view_entries_by_milestone
      when "6" then view_milestones_by_child
      when "b" then break
      else puts "Invalid choice. Try again."
      end
    end
  end

  def create_menu
    loop do
      puts "\n--- Create Menu ---"
      puts "1. Create a new child"
      puts "2. Create a new entry"
      puts "3. Create a new milestone"
      puts "b. Back to main menu | q. Quit"
      print "\nEnter your choice: "

      choice = gets.chomp.downcase
      handle_quit(choice)

      case choice
      when "1" then create_child
      when "2" then create_entry
      when "3" then create_milestone
      when "b" then break
      else puts "Invalid choice. Try again."
      end
    end
  end

  def update_menu
    loop do
      puts "\n--- Update Menu ---"
      puts "1. Update a child"
      puts "2. Update an entry"
      puts "3. Update a milestone"
      puts "b. Back to main menu | q. Quit"
      print "\nEnter your choice: "

      choice = gets.chomp.downcase
      handle_quit(choice)

      case choice
      when "1" then update_child
      when "2" then update_entry
      when "3" then update_milestone
      when "b" then break
      else puts "Invalid choice. Try again."
      end
    end
  end

  def delete_menu
    loop do
      puts "\n--- Delete Menu ---"
      puts "1. Delete a child (legally)"
      puts "2. Delete an entry"
      puts "3. Delete a milestone"
      puts "b. Back to main menu | q. Quit"
      print "\nEnter your choice: "

      choice = gets.chomp.downcase
      handle_quit(choice)

      case choice
      when "1" then delete_child
      when "2" then delete_entry
      when "3" then delete_milestone
      when "b" then break
      else puts "Invalid choice. Try again."
      end
    end
  end

  private

  def view_all_children
    puts "\n=== All Children ==="
    response = @api_client.get_children

    if response.is_a?(Array)
      if response.empty?
        puts "No children found."
      else
        response.each do |child|
          display_child(child)
          puts "-" * 50
        end
      end
    else
      puts "Error: #{response[:error]}"
    end
  end

  def view_all_entries
    puts "\n=== All Entries ==="
    response = @api_client.get_entries

    if response.is_a?(Array)
      if response.empty?
        puts "No entries found."
      else
        response.each do |entry|
          display_entry(entry)
          puts "-" * 50
        end
      end
    else
      puts "Error: #{response[:error]}"
    end
  end

  def view_all_milestones
    puts "\n=== All Milestones ==="
    response = @api_client.get_milestones

    if response.is_a?(Array)
      if response.empty?
        puts "No milestones found."
      else
        response.each do |milestone|
          display_milestone(milestone)
          puts "-" * 50
        end
      end
    else
      puts "Error: #{response[:error]}"
    end
  end

  def view_entries_by_child
    view_all_children
    puts "\n Enter a Child ID to see the entries for that Child."
    print "ID: "
    id = gets.chomp
    response = @api_client.get_entries_by_child(id)

    if response.is_a?(Array)
      if response.empty?
        puts "No entries found."
      else
        response.each do |entry|
          display_entry(entry)
          puts "-" * 50
        end
      end
    else
      puts "Error: #{response[:error]}"
    end
  end

  def view_entries_by_milestone
    view_all_milestones
    puts "\n Enter a Milestone ID to see the entries for that Milestone."
    print "ID: "
    id = gets.chomp
    response = @api_client.get_entries_by_milestone(id)

    if response.is_a?(Array)
      if response.empty?
        puts "No entries found."
      else
        response.each do |entry|
          display_entry(entry)
          puts "-" * 50
        end
      end
    else
      puts "Error: #{response[:error]}"
    end
  end

  def view_milestones_by_child
    view_all_children
    puts "\n Enter a Child ID to see the milestones achieved by that Child."
    print "ID: "
    id = gets.chomp
    response = @api_client.get_milestones_by_child(id)

    if response.is_a?(Array)
      if response.empty?
        puts "No milestones found :("
      else
        response.each do |milestone|
          display_milestone(milestone)
          puts "-" * 50
        end
      end
    else
      puts "Error: #{response[:error]}"
    end
  end

  def create_child
    puts "\n=== Create New Child ==="

    print "Name: "
    name = gets.chomp

    print "Birthdate (YYYY-MM-DD): "
    birthdate = gets.chomp

    data = { name: name, birthdate: birthdate }

    response = @api_client.create_child(data)

    if response[:error]
      puts "Error: #{response[:error]}"
    else
      puts "Child created successfully!"
      display_child(response)
    end
  end

  def create_entry
    puts "\n=== Create New Entry ==="

    children_response = @api_client.get_children
    if children_response.is_a?(Array) && !children_response.empty?
      puts "\n Available children:"
      children_response.each { |child| puts "#{child['id']}. #{child['name']}" }
    else
      puts "No children available. Please create a child first."
      return
    end

    print "Child ID: "
    child_id = gets.chomp.to_i

    milestones_response = @api_client.get_milestones
    if milestones_response.is_a?(Array) && !milestones_response.empty?
      puts "\n Available milestones:"
      milestones_response.each do |milestone|
        puts "#{milestone['id']}. #{milestone['title']}. | #{milestone['milestone_type']}"
      end
    else
      puts "No milestones available. Please create a milestone first."
      return
    end

    print "Milestone ID: "
    milestone_id = gets.chomp.to_i

    print "Date: "
    date = gets.chomp

    print "Age (Months): "
    age_months = gets.chomp.to_i

    print "Note: "
    note = gets.chomp

    data = { date: date, age_months: age_months, note: note, child_id: child_id,
             milestone_id: milestone_id, }

    response = @api_client.create_entry(data)

    if response[:error]
      puts "Error: #{response[:error]}"
    else
      puts "Entry created successfully!"
      display_entry(response)
    end
  end

  def create_milestone
    puts "\n=== Create New Milestone ==="

    print "Milestone Title: "
    title = gets.chomp

    print "Milestone Type: "
    milestone_type = gets.chomp

    data = { title: title, milestone_type: milestone_type }

    response = @api_client.create_milestone(data)

    if response[:error]
      puts "Error: #{response[:error]}"
    else
      puts "Milestone created successfully!"
      display_milestone(response)
    end
  end

  def update_child
    view_all_children
    print "\nEnter the ID of the child to update: "
    id = gets.chomp.to_i

    current_child = @api_client.get_child(id)
    if current_child[:error]
      puts "Error: #{current_child[:error]}"
      return
    end

    puts "\nCurrent child data:"
    display_child(current_child)

    puts "\nEnter new values (press Enter to keep current value):"

    print "Name (#{current_child['name']}): "
    name = gets.chomp
    name = current_child["name"] if name.empty?

    print "Birthdate (YYYY-MM-DD) (#{current_child['birthdate']}): "
    birthdate = gets.chomp
    birthdate = current_child["birthdate"] if birhdate.empty?

    data = { name: name, birthdate: birthdate }

    response = @api_client.update_owner(id, data)

    if response[:error]
      puts "Error: #{response[:error]}"
    else
      puts "Child updated successfully!"
      display_child(response)
    end
  end

  def update_entry
    view_entries_by_child
    puts
    print "\nEnter the ID of the entry to update: "
    id = gets.chomp.to_i

    current_entry = @api_client.get_entry(id)
    if current_entry[:error]
      puts "Error: #{current_entry[:error]}"
      return
    end

    puts "\nCurrent entry data:"
    display_entry(current_entry)

    puts "\nEnter new values (press Enter to keep current value):"

    print "Note (#{current_entry['note']}): "
    note = gets.chomp
    note = current_entry["note"] if note.empty?

    print "Date (#{current_entry['date']}): "
    date_string = gets.chomp
    date = date.nil? ? current_entry["date"] : date_string

    print "Age (#{current_entry['age_months']}): "
    age_input = gets.chomp
    age_months = age_input.empty? ? current_entry["age_months"] : age_input.to_i

    print "Child ID (#{current_entry['child_id']}): "
    child_id = gets.chomp
    child_id = child_id.empty? ? current_entry["child_id"] : child_id.to_i

    print "Milestone ID (#{current_entry['milestone_id']}): "
    milestone_id = gets.chomp
    milestone_id = current_entry["milestone_id"] if milestone_id.empty?

    data = { note: note, date: date, age_months: age_months, child_id: child_id,
             milestone_id: milestone_id, }

    response = @api_client.update_entry(id, data)

    if response[:error]
      puts "Error: #{response[:error]}"
    else
      puts "Entry updated successfully!"
      display_entry(response)
    end
  end

  def update_milestone
    view_all_milestones
    print "\nEnter the ID of the milestone you wish to update: "
    id = gets.chomp.to_i

    current_milestone = @api_client.get_milestone(id)
    if current_milestone[:error]
      puts "Error: #{current_milestone[:error]}"
      return
    end

    puts "\nCurrent milestone data:"
    display_milestone(current_milestone)

    puts "\nEnter new values (press Enter to keep current value):"

    print "Title (#{current_milestone['title']}): "
    title = gets.chomp
    title = current_milestone["title"] if title.empty?

    print "Milestone Type (#{current_milestone['milestone_type']}): "
    milestone_type = gets.chomp
    milestone_type = current_milestone["milestone_type"] if milestone_type.empty?

    data = { title: title, milestone_type: milestone_type }

    response = @api_client.update_milestone(id, data)

    if response[:error]
      puts "Error: #{response[:error]}"
    else
      puts "Milestone updated successfully!"
      display_milestone(response)
    end

  end

  def delete_child
    view_all_children
    print "\nEnter the ID of the child to delete (RIP?): "
    id = gets.chomp.to_i

    print "Are you sure you want to delete this child? (y/n): "
    confirmation = gets.chomp.downcase

    if %w[y yes].include?(confirmation)
      response = @api_client.delete_child(id)

      if response[:error]
        puts "Error: #{response[:error]}"
      else
        puts "Child deleted successfully!"
      end
    else
      puts "Deletion cancelled."
    end
  end

  def delete_entry
    view_all_entries
    print "\nEnter the ID of the entry to delete: "
    id = gets.chomp.to_i

    print "Are you sure you want to delete this entry? (y/n): "
    confirmation = gets.chomp.downcase

    if %w[y yes].include?(confirmation)
      response = @api_client.delete_entry(id)

      if response[:error]
        puts "Error: #{response[:error]}"
      else
        puts "Entry deleted successfully!"
      end
    else
      puts "Deletion cancelled."
    end
  end

  def delete_milestone
    view_all_milestones
    print "\nEnter the ID of the milestone to delete: "
    id = gets.chomp.to_i

    print "Are you sure you want to delete this milestone? (y/n): "
    confirmation = gets.chomp.downcase

    if %w[y yes].include?(confirmation)
      response = @api_client.delete_milestone(id)

      if response[:error]
        puts "Error: #{response[:error]}"
      else
        puts "Milestone deleted successfully!"
      end
    else
      puts "Deletion cancelled."
    end
  end

  def display_child(child)
    puts "ID: #{child['id']}"
    puts "Name: #{child['name']}"
    puts "Birthdate: #{child['birthdate']}"

    if child["entries"] && !child["entries"].empty?
      puts "Entries:"
      child["entries"].each { |entry| puts "  - #{entry['date']} (#{entry['note']})" }
    else
      puts "Entries: None"
    end
  end

  def display_entry(entry)
    puts "ID: #{entry['id']}"
    puts "Date: #{entry['date']}"
    puts "Note: #{entry['note']}"
    puts "Age: #{entry['age_months']}"

    return unless entry["child"]

    puts "Child: #{entry['child']['name']} (ID: #{entry['child']['id']})"

  end

  def display_milestone(milestone)
    puts "ID: #{milestone['id']}"
    puts "Title: #{milestone['title']}"
    puts "Type: #{milestone['milestone_type']}"

    nil
  end
end

CLIInterface.new.run if __FILE__ == $0
