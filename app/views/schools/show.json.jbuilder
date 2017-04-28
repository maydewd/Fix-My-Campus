json.partial! @school, include_url: false
json.posts @posts, partial: 'posts/post', as: :post, locals: {include_url: true}
json.page params[:page] || 1