require_relative '../../lib/fb_group'
require_relative '../spec_helper'

describe FbGroup do

  token = SECRETS["test"]["token"]

  before :each do
    @graph = FbGroup.new(token)
  end

  it "instantiates a client" do
    @graph = FbGroup.new(token)
  end

  it "fetches groups" do
    groups = @graph.get_groups

    expect(groups.length).to eq 7
  end

  it "fetches the feed from a group" do
    feed = @graph.get_group_feed(58936949405)
    expect(feed.length).to eq 25
  end

  it "fetches specific posts" do
    feed = @graph.get_group_feed(58936949405)
    post = @graph.get_post(feed.first["id"])
    # expect(post["id"]).to be_a String
    expect(post).to eq feed.first
  end

  it "fetches specific users" do
    feed = @graph.get_group_feed(58936949405)
    user = @graph.get_user(feed.first["from"]["id"])
    expect(user["first_name"]).to be_a String
  end

  it "fetches the comments from a specific post" do
    feed = @graph.get_group_feed(58936949405)
    post = feed.first
    comments = @graph.get_comments(post["id"])
    expect(comments).to be_an Array
  end

  it "fetches photos from a specific post" do
    feed = @graph.get_group_feed(58936949405)
    post = feed.first
    photos = @graph.get_photos(post["id"])
    expect(photos).to be_an Array
  end

  it "serializes a post to store in the db" do
    feed = @graph.get_group_feed(58936949405)
    post = feed.first
    serialized_post = @graph.serialize_post(post)
    expect(serialized_post).to be_a Hash
    expect(serialized_post[:fb_id]).to be_a String
  end

end
