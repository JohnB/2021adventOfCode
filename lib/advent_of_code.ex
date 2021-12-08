defmodule AdventOfCode do
  @moduledoc """
  Helper module for dealing with text input from the AOC puzzles.
  Originally created for the 2021 competition.

  To use from LiveBook:
    IEx.Helpers.c("lib/advent_of_code.ex")
    alias AdventOfCode, as: AOC
  """

  alias Kino

  def as_comma_separated_integers(text) do
    text
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(fn digits ->
      digits
      |> String.trim()
      |> String.to_integer()
    end)
  end

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
    text
    |> String.split(~r/\s+/)
  end

  def delimited_by_colons(text) do
    text
    |> String.split(~r/\:/)
  end

  # -- startup and kino-related functions

end

