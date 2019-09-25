defmodule Issues.GithubIssues do
  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get
    |> handle_response
  end

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response({ :ok, %{status_code: 200 , body: body }}) do
    { :ok, Poison.Parser.parse! body }
  end

  def handle_response({ _, %{status_code: _ , body: body }}) do
    { :error, Poison.Parser.parse! body }
  end
end
