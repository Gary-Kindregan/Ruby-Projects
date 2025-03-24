require './githubApiClass.rb'

def formatEvent(event)
    event_type = event['type']
    repo_name = event['repo']['name']
  
    case event_type
    when 'PushEvent'
      commits = event['payload']['commits']
      "Pushed #{commits.length} commit(s) to #{repo_name}"
    when 'IssuesEvent'
      action = event['payload']['action']
      issue_number = event['payload']['issue']['number']
      "#{action.capitalize} issue ##{issue_number} in #{repo_name}"
    when 'PullRequestEvent'
      action = event['payload']['action']
      pr_number = event['payload']['pull_request']['number']
      "#{action.capitalize} pull request ##{pr_number} in #{repo_name}"
    when 'CreateEvent'
      ref_type = event['payload']['ref_type']
      "Created #{ref_type} in #{repo_name}"
    when 'DeleteEvent'
      ref_type = event['payload']['ref_type']
      "Deleted #{ref_type} in #{repo_name}"
    when 'WatchEvent'
      "Starred #{repo_name}"
    else
      "Event type not supported : #{event_type}"
    end
end

def printGithubActivity(events, username)
    puts "Recent GitHub activity for #{username}:"
    events.each { |event| puts formatEvent(event) }
end

username = ARGV[0]
api_response = GitHubApi.fetch_user_events(username)
printGithubActivity(api_response, username) unless api_response == nil;