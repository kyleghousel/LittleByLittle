# cli/interface/actions/view.rb
require "pry"

module ViewActions
  def view_all_children
    puts "\n=== All Children ==="
    response = @api_client.get_children

    if response.is_a?(Array)
      if response.empty?
        puts "No children found."
        false
      else
        response.each do |child|
          display_child(child)
          puts "-" * 50
        end
        true
      end
    else
      puts "❌ Error: #{response[:error]}"
      false
    end
  end

  def view_all_entries
    puts "\n=== All Entries ==="
    response = @api_client.get_entries

    if response.is_a?(Array)
      if response.empty?
        puts "No entries found."
        false
      else
        response.each do |entry|
          display_entry(entry)
          puts "-" * 50
        end
        true
      end
    else
      puts "❌ Error: #{response[:error]}"
      false
    end
  end

  def view_all_milestones
    puts "\n=== All Milestones ==="
    response = @api_client.get_milestones

    if response.is_a?(Array)
      if response.empty?
        puts "No milestones found."
        false
      else
        response.each do |milestone|
          display_milestone(milestone)
          puts "-" * 50
        end
        true
      end
    else
      puts "❌ Error: #{response[:error]}"
      false
    end
  end

  def view_entries_by_child
    return unless view_all_children

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
      puts "❌ Error: #{response[:error]}"
    end
  end

  def view_entries_by_milestone
    return unless view_all_milestones

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
      puts "❌ Error: #{response[:error]}"
    end
  end

  def view_milestones_by_child
    return unless view_all_children == true

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
      puts "❌ Error: #{response[:error]}"
    end
  end
end
