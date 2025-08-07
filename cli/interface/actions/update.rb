# cli/interface/actions/update.rb

module UpdateActions
  def update_child
    view_all_children
    print "\nEnter the ID of the child to update: "
    id = gets.chomp.to_i

    current_child = @api_client.get_child(id)
    if current_child[:error]
      puts "\n❌ Error: #{current_child[:error]}"
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
    birthdate = current_child["birthdate"] if birthdate.empty?

    data = { name: name, birthdate: birthdate }

    response = @api_client.update_child(id, data)

    with_spinner("Updating child...")

    if response[:error]
      puts "\n❌ Error: #{response[:error]}"
    else
      puts "\n👶 Child updated successfully!"
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
      puts "\n❌ Error: #{current_entry[:error]}"
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

    with_spinner("Updating entry...")

    if response[:error]
      puts "\n❌ Error: #{response[:error]}"
    else
      puts "\n📝 Entry updated successfully!"
      display_entry(response)
    end
  end

  def update_milestone
    view_all_milestones
    print "\nEnter the ID of the milestone you wish to update: "
    id = gets.chomp.to_i

    current_milestone = @api_client.get_milestone(id)
    if current_milestone[:error]
      puts "\n❌ Error: #{current_milestone[:error]}"
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

    with_spinner("Updating milestone...")

    if response[:error]
      puts "\n❌ Error: #{response[:error]}"
    else
      puts "\n📈 Milestone updated successfully!"
      display_milestone(response)
    end

  end
end
