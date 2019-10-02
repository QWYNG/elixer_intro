defmodule Issues.GithubIssues do
  require Logger
  @github_url "https://api.github.com"

  def fetch(user, project) do
    Logger.info("Fetching user #{user}'s #{project}")
    issues_url(user, project)
    |> HTTPoison.get
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({ :ok, %{status_code: 200 , body: body }}) do
    Logger.info("Success!")
    { :ok, Poison.Parser.parse! body }
  end

  def handle_response({ _, %{status_code: status_code , body: body }}) do
    Logger.error("Error #{status_code}")
    { :error, Poison.Parser.parse! body }
  end
end
