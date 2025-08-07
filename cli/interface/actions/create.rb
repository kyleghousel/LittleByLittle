# cli/interface/actions/create.rb
module CreateActions
  def create_child
    puts "\n=== Create New Child ==="

    print "Name: "
    name = gets.chomp

    print "Birthdate (YYYY-MM-DD): "
    birthdate = gets.chomp

    data = { name: name, birthdate: birthdate }

    response = @api_client.create_child(data)

    with_spinner("Creating child...")

    if response[:error]
      puts "❌ Error: #{response[:error]}"
    else
      puts "\n👶 Child created successfully!"
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

    with_spinner("Creating entry...")

    if response[:error]
      puts "\n❌ Error: #{response[:error]}"
    else
      puts "\n📝 Entry created successfully!"
      display_entry(response)
    end
  end

  def create_milestone
    puts "\n=== Create New Milestone ==="

    print "Milestone Title: "
    title = gets.chomp

    print "Milestone Type: "
    milestone_type = gets.chomp

    if title.strip.empty? || milestone_type.strip.empty?
      puts "\n❌ Error: Title and Type cannot be blank."
      return
    end

    data = { title: title, milestone_type: milestone_type }

    response = @api_client.create_milestone(data)

    with_spinner("Creating milestone...")

    if response[:error]
      puts "\n❌ Error: #{response[:error]}"
    else
      puts "\n📈 Milestone created successfully!"
      display_milestone(response)
    end
  end
end
