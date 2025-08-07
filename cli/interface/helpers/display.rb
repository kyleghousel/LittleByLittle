# cli/interface/helpers/display.rb

module DisplayHelper
  def display_child(child)
    puts "\nChild ID: #{child['id']}"
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
    puts "\nEntry ID: #{entry['id']}"
    puts "Date: #{entry['date']}"
    puts "Note: #{entry['note']}"
    puts "Age: #{entry['age_months']}"

    return unless entry["child"]

    puts "Child: #{entry['child']['name']} (ID: #{entry['child']['id']})"

  end

  def display_milestone(milestone)
    puts "\nMilestone ID: #{milestone['id']}"
    puts "Title: #{milestone['title']}"
    puts "Type: #{milestone['milestone_type']}"

    nil
  end
end
