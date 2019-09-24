defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  コマンドラインからコマンドをパースして
  いろいろな関数からgithubのissueをtableにして出力する
  """

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  github user name, project name, and option
  return a tuple of {user, project, count} or :help
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                      aliases: [ h: :help ])

    case parse do
      { [ help: true ], _, _ } -> :help
      { _, [user, project, count ], _ } -> { user, project, String.to_integer(count) }
      { _, [ user, project ], _ }       -> { user, project, @default_count }
      _ -> :help
    end
  end
end
