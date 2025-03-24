require 'json'
require 'net/http'

class GitHubApi
    BASE_URL = "https://api.github.com"
    
    def self.fetch_user_events(username)
        url = URI("#{BASE_URL}/users/#{username}/events")
        response = Net::HTTP.get_response(url)
        handle_response(response)
    end

    def self.handle_response(response)
        parsed_response = JSON.parse(response.body)
        if response.code.to_i != 200
            puts "Status: #{response.code}\tMessage: #{response.message}"
            nil
        elsif parsed_response.empty?
            puts "No events found for this user"
            nil
        else
            parsed_response
        end
    end
end