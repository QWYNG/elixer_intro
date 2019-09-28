defmodule Issues.GithubIssues do
  @github_url "https://api.github.com"

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({ :ok, %{status_code: 200 , body: body }}) do
    { :ok, Poison.Parser.parse! body }
  end

  def handle_response({ _, %{status_code: _ , body: body }}) do
    { :error, Poison.Parser.parse! body }
  end
end
