# frozen_string_literal: true

json.extract! user_resource, :id, :name, :desc, :created_at, :updated_at
json.url user_resource_url(user_resource, format: :json)
