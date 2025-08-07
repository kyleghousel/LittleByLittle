class ApplicationController < Sinatra::Base
  set :default_content_type, "application/json"

  get "/" do
    {
      message: "🚀 LittleByLittle API is running!",
      available_endpoints: [
        "/children",
        "/entries",
        "/milestones",
        "/children/:id/entries",
        "/milestones/:id/entries",
        "/children/:child_id/milestones",
      ],
    }.to_json
  end
end
