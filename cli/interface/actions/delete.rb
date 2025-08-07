# cli/interface/actions/delete.rb

module DeleteActions
  def delete_child
    view_all_children
    print "\nEnter the ID of the child to delete (RIP?): "
    id = gets.chomp.to_i

    print "Are you sure you want to delete this child? (y/n): "
    confirmation = gets.chomp.downcase

    if %w[y yes].include?(confirmation)
      response = @api_client.delete_child(id)

      with_spinner("Deleting...")

      if response[:error]
        puts "\n❌ Error: #{response[:error]}"
      else
        puts "\n👶 Child deleted successfully!"
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

      with_spinner("Deleting...")

      if response[:error]
        puts "\n❌ Error: #{response[:error]}"
      else
        puts "\n📝 Entry deleted successfully!"
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

      with_spinner("Deleting...")

      if response[:error]
        puts "\n❌ Error: #{response[:error]}"
      else
        puts "\n📈 Milestone deleted successfully!"
      end
    else
      puts "Deletion cancelled."
    end
  end
end
