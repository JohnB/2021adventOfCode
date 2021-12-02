defmodule AdventOfCode do
  @moduledoc """
  Helper module for dealing with text input from the AOC puzzles.
  Originally created for the 2021 competition.

  To use from LiveBook:
    IEx.Helpers.c("lib/advent_of_code.ex")
    alias AdventOfCode, as: AOC
  """

  alias Kino

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

  # Being a multi-line input element, this gets all of it (within reason).
  def get_kino_textarea(inputname) do
    IO.getn(inputname, 1_000_000)
  end

  # Being a multi-line input element, this gets all of it (within reason).
  def get_kino_integer(inputname) do
    IO.gets(inputname)
    |> String.trim()
    |> String.to_integer()
  end

  def link_to_day() do
    day = day_of_advent()
    Kino.Markdown.new("[2021 Day #{day} Puzzle](https://adventofcode.com/2021/day/#{day})
    Day#{day}Part1 Day#{day}Part2
    ")
  end

  def day_of_advent(), do: get_kino_integer("Day of Advent:")
  def part1example(), do: get_kino_textarea("Part 1 Example: ")
  def part1input(), do: get_kino_textarea("Part 1 Puzzle Input: ")
  def p1data(), do: (IO.gets("Part 1 Input Data") =~ "example" && part1example()) || part1input()

  def part2example(), do: get_kino_textarea("Part 2 Example: ")
  def part2input(), do: get_kino_textarea("Part 2 Puzzle Input: ")
  def p2data(), do: (IO.gets("Part 2 Input Data") =~ "example" && part2example()) || part2input()

  # Return the P2 data, unless it is empty so we return P1 data
  def p2orp1data() do
    is_example = (IO.gets("Part 2 Input Data") =~ "example")
    p2text = (is_example && part2example()) || part2input()

    # use p1 data if p2 is only whitespace
    (p2text  =~ ~r{^\W*$} && p1data()) || p2text
  end
end

