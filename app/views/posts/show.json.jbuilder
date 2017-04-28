json.partial! @post, include_url: false
json.comments @post.comments, partial: 'comments/comment', as: :comment