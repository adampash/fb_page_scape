require_relative '../spec_helper'
require_relative '../../lib/post'
require_relative '../../lib/fb_graph'

describe Post do

  after :each do
    Post.destroy_all
  end

  token = SECRETS["test"]["token"]

  it "saves an object" do
    @graph = FbGraph.new(token)
    feed = @graph.get_group_feed(58936949405)
    post = Post.create @graph.serialize_post(feed.first)
    expect(post.id).to be_an Integer
  end

end
