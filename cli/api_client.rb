# cli/api_client.rb
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
    { error: "Failed to fetch entries: #{e.message}" }
  end

  def get_entries_by_milestone(id)
    response = RestClient.get("#{@base_url}/milestones/#{id}/entries")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to fetch entries: #{e.message}" }
  end

  def get_milestones_by_child(id)
    response = RestClient.get("#{@base_url}/children/#{id}/milestones")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to fetch milestones: #{e.message}" }
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

  def get_milestone(id)
    response = RestClient.get("#{@base_url}/milestones/#{id}")
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to fetch milestone: #{e.message}" }
  end

  def create_milestone(data)
    response = RestClient.post("#{@base_url}/milestones", data.to_json, content_type: :json)
    parse_response(response)
  rescue RestClient::Exception => e
    { error: "Failed to create milestone: #{e.message}" }
  end

  def update_milestone(id, data)
    response = RestClient.patch("#{@base_url}/milestones/#{id}", data.to_json,
                                content_type: :json)
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
