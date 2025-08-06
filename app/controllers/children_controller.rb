class ChildrenController < ApplicationController
  get "/children" do
    Child.all.to_json(include: { entries: { include: :milestone } })
  end

  get "/children/:id" do
    child = Child.find_by(id: params[:id])
    if child
      child.to_json(include: { entries: { include: :milestone } })
    else
      status 404
      { error: "Child not found" }.to_json
    end
  end

  get "/children/:id/milestones" do
    child = Child.find_by(id: params[:id])
    if child.nil?
      status 404
      return { error: "Child not found" }.to_json
    end

    milestones = child.entries.includes(:milestone).map(&:milestone).uniq
    milestones.to_json
  end

  post "/children" do
    begin
      parsed_birthdate = Date.parse(params[:birthdate])
    rescue ArgumentError
      status 400
      return { error: "Invalid birthdate format. Use YYYY-MM-DD." }.to_json
    end

    new_child = Child.create(
      name: params[:name],
      birthdate: parsed_birthdate
    )

    status 201
    new_child.to_json
  end

  patch "/children/:id" do
    child = Child.find_by(id: params[:id])

    if child.nil?
      status 404
      return { error: "Child not found" }.to_json
    end
    begin
      parsed_birthdate = Date.parse(params[:birthdate])
    rescue ArgumentError
      status 400
      return { error: "Invalid birthdate format. Please use YYYY-MM-DD." }.to_json
    end

    child.update(
      name: params[:name],
      birthdate: parsed_birthdate
    )

    child.to_json
  end

  delete "/children/:id" do
    child = Child.find_by(id: params[:id])

    if child.nil?
      status 404
      return { error: "Child not found" }.to_json
    end

    child.destroy

    child.to_json
  end
end
