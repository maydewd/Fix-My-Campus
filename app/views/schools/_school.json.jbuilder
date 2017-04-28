json.extract! school, :name, :nickname
json.url school_url(school, format: :json) if include_url