json.extract! comment, :id, :post, :user, :body, :image_path, :created_at, :updated_at
json.url comment_url(comment, format: :json)
