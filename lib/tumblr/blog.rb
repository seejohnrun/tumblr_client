module Tumblr
  class Client
    module Blog
      
      @@standard_options = [:type, :id, :tag, :limit, :offset, :reblog_info, :notes_info, :filter]
      #
      #Gets the info about the blog
      #
      def blog_info(blog_name)
        get("v2/blog/#{blog_name}/info", {:api_key => Tumblr::consumer_key})
      end

      #
      # Gets the avatar URL of specified size
      #
      def avatar(blog_name, size = nil)
        response = get_response("v2/blog/#{blog_name}/avatar", :size => size)
        if response.status == 301
          response.headers['Location']
        end
      end

      #
      # Gets the list of followers for the blog
      #
      def followers(blog_name, options={})
        if valid_options([:limit, :offset], options)
           get("v2/blog/#{blog_name}/followers", options)
        end
      end
      
      #
      # Gets the list of likes for the blog
      #
      def blog_likes(blog_name, options={})
        if valid_options([:limit, :offset], options)
          url = "v2/blog/#{blog_name}/likes"
          params = {:api_key => Tumblr::consumer_key}
          unless options.empty?
            params.merge!(options)
          end
          get(url, params)
        end
      end

      def posts(blog_name, options={})
        url = "v2/blog/#{blog_name}/posts"
        
        if options.has_key?(:type)
          url = "#{url}/#{options[:type]}"
        end
        
        params = {:api_key => Tumblr::consumer_key}
        unless options.empty?
          params.merge!(options)
        end
        get(url, params)
      end

      def queue(blog_name)
        get("v2/blog/#{blog_name}/posts/queue", {})
      end
      
      def draft(blog_name)
        get("v2/blog/#{blog_name}/posts/draft", {})
      end
        
      def submissions(blog_name)
        get("v2/blog/#{blog_name}/posts/submission", {})
      end
    end
  end
end
