# This class provides a service for interacting with the GitHub API.
class GithubService
  include HTTParty

  base_uri 'https://api.github.com'

  # Initializes a new instance of the GithubService class.
  # @param username [String] The GitHub username.
  def initialize(username)
    @username = username
  end

  # Retrieves the repositories for the specified GitHub user.
  # @return [HTTParty::Response] The response containing the user's repositories.
  def get_repos
    self.class.get("/users/#{@username}/repos")
  end
end

##docs generated with copilot
