require_relative '../spec_helper'
require_relative '../../lib/post'
require_relative '../../lib/comment'
require_relative '../../lib/fb_group'

describe Comment do

  after :each do
    Comment.destroy_all
    Post.destroy_all
  end

  token = SECRETS["test"]["token"]

  it "saves an object" do
    @graph = FbGroup.new(token)
    feed = @graph.get_group_feed(58936949405)
    comment = nil
    i = 0
    until !comment.nil?
      unless feed[i]["comments"].nil?
        post = feed[i]
        comment = post["comments"]["data"].first
      end
      i += 1
    end
    post = Post.create @graph.serialize_post(post)
    comment = Comment.create @graph.serialize_comment(comment, post.id)
    expect(comment.id).to be_an Integer
  end

end

