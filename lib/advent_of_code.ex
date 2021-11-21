defmodule Livebook.AdventOfCode do
  @moduledoc """
  Helper module for dealing with text input from the AOC puzzles.
  Originally created for the 2021 competition.
  """

  def as_single_lines(multiline_text) do
    multiline_text
    |> String.split("\n", trim: true)
  end

  def as_doublespaced_paragraphs(multiline_text) do
    multiline_text
    |> String.split("\n\n")
  end

  def as_paragraph_lines(paragraph) do
    as_single_lines(paragraph)
  end

  def delimited_by_spaces(text) do
    String.split(~r/\s+/)
  end

  def delimited_by_colons(text) do
    String.split(~r/\:/)
  end

end

