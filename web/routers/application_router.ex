defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn = conn.assign :layout, "application"
    conn.fetch([:cookies, :params])
  end

  # It is common to break your Dynamo in many
  # routers forwarding the requests between them

  get "/" do
    users = EpgPool.sq("SELECT * FROM authors")
    conn = conn.assign(:users, users)
    render conn, "index.html"
  end

  get "/users/:id" do
    user = List.flatten EpgPool.sq("SELECT * FROM authors WHERE id = #{conn.params[:id]}")
    conn = conn.assign(:user, user)

    posts = EpgPool.sq("SELECT * FROM posts WHERE author_id = #{user[:id]}")
    conn = conn.assign(:posts, posts)

    render conn, "user_edit.html"
  end

  get "/users/:author_id/posts/new" do
    user = List.flatten EpgPool.sq("SELECT * FROM authors WHERE id = #{conn.params[:author_id]}")
    conn = conn.assign(:user, user)

    render conn, "posts_new.html"
  end

  get "/users/:author_id/posts/:id/edit" do
    item = List.flatten EpgPool.sq("SELECT * FROM posts WHERE id = #{conn.params[:id]}")
    conn = conn.assign(:item, item)

    render conn, "posts_edit.html"
  end

  post "/users/:user_id/posts" do
    title = conn.params[:title]
    content = conn.params[:content]
    id = conn.params[:user_id]

    query = "INSERT INTO posts (title, content, author_id, created_at, updated_at) VALUES('#{title}', '#{content}', '#{user_id}', now(), now())"
    EpgPool.create(:main_pool, query)

    redirect conn, to: "/users/#{id}", format: :html
  end
end
