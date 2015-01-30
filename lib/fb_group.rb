require 'koala'

class FbGroup
  def initialize(access_token)
    @client = Koala::Facebook::API.new(access_token)
    # require 'pry'; binding.pry
  end

  def get_groups
    @client.get_connections('me', 'groups')
  end

  def get_group_feed(id)
    @client.get_connection(id, 'feed')
    # @client.get_object(name)
  end

  def get_user(id)
    @client.get_object(id)
  end

  def get_post(id)
    @client.get_object(id)
  end

  def get_comments(id)
    @client.get_connection(id, 'comments')
  end

  def get_photos(id)
    @client.get_connection(id, 'photos')
  end

  def serialize_post(post)
    {
      fb_id:        post["id"],
      title:        post["title"],
      from_id:      post["from"]["id"],
      from_name:    post["from"]["name"],
      to_id:        post["to"]["data"].first["id"],
      to_name:      post["to"]["data"].first["name"],
      message:      post["message"],
      post_type:         post["type"],
      picture:      post["picture"],
      link:         post["link"],
      name:         post["name"],
      caption:      post["caption"],
      description:  post["description"],
      url:          post["actions"].first["link"],
      created_time: post["created_time"],
      updated_time: post["updated_time"],
    }
  end

end
