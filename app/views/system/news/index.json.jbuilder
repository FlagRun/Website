json.array!(@system_news) do |system_news|
  json.extract! system_news, :id, :title, :user_id, :oline, :published_at, :tags, :body
  json.url system_news_url(system_news, format: :json)
end
