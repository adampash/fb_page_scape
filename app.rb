Dir["./lib/*.rb"].each {|file| require file }
require './db/init'

SECRETS = YAML::load(IO.read('config/secrets.yml'))

@method = ARGV[0]
@token = ARGV[1]
@obj_id = ARGV[2] || "58936949405"

if ARGV.length < 3
  if SECRETS.nil?
    puts "What's your access token?"
    @token = gets.chomp!
  else
    @token = SECRETS['development']['token']
  end

  puts "Would you like to:"
  puts "1. See a list of groups"
  puts "2. Fetch and store all of the posts for a page/group"
  puts "3. Fetch and store all of the comments for the stored posts"
  @method = case gets.chomp!
            when '1' then 'get_groups'
            when '2' then 'fetch_feed'
            when '3' then 'fetch_comments'
            end

  puts "What's the id of the object you're interested in?"
  @obj_id = gets.chomp!

end

def scrape_it_all
  puts "Scrape all of the things"
end

def get_groups
  puts @graph.get_groups
end

def fetch_feed
  puts "Fetching and storing all of the posts"
  feed = @graph.get_group_feed(@obj_id)
  until feed.nil?
    save_posts(feed)
    feed = feed.next_page
  end
end

def fetch_comments
  puts "Fetching and storing all of the comments"
  i = 0
  Post.find_each do |post|
    comments = @graph.get_comments(post.fb_id)
    comments.each do |comment|
      puts "Saving comment ##{i += 1}"
      Comment.create @graph.serialize_comment(comment, post.id)
    end
  end
end

@post_count = 0
def save_posts(posts)
  posts.each do |post|
    puts "Saving post ##{@post_count += 1}"
    Post.create @graph.serialize_post(post)
  end
end

def main
  @graph = FbGraph.new(@token)
  case @method
  when "get_groups"
    get_groups
  when "fetch_feed"
    fetch_feed
  when "fetch_comments"
    fetch_comments
  end
end

main
