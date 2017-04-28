json.partial! 'devise/user', user: @user, include_url: false

json.posts @user.posts, partial: 'posts/post', as: :post, locals: {include_url: true}