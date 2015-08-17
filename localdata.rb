require "rubygems"
require "sinatra/base"
require "data_mapper"

# An in-memory Sqlite3 connection:
DataMapper.setup(:default, 'sqlite::memory:')

class Post
  include DataMapper::Resource

  property :id,    Serial
  property :title, String
  property :body,       Text      # A text block, for longer string data.
  property :created_at, DateTime  # A DateTime, for any date you might like.
  
end

DataMapper.finalize

DataMapper.auto_migrate!

@post = Post.create(
  :title      => "My first DataMapper post",
  :body       => "A lot of text ...",
  :created_at => Time.now
)

class SampleApp < Sinatra::Base
  
  get "/" do
    "Hello world!"
  end

  get "/:post" do |post|
    Post.get(post).title
  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
  
end