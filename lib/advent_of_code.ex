defmodule AdventOfCode do
  @moduledoc """
  Helper module for dealing with text input from the AOC puzzles.
  Originally created for the 2021 competition.

  To use from LiveBook:
    IEx.Helpers.c("lib/advent_of_code.ex")
    alias AdventOfCode, as: AOC
  """

  alias Kino

  # Grid-based helpers

  def as_grid(multiline_text) do
    [line0 | _] = lines = as_single_lines(multiline_text)
    grid_width = String.length(line0)
    grid_height = Enum.count(lines)

    lines
    |> Enum.join("")
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Map.new(fn {character, index} -> {index, character} end)
    |> Map.merge(%{
      grid_width: grid_width,
      grid_height: grid_height,
      last_cell: grid_height * grid_width - 1
    })
  end

  def as_grid_of_digits(multiline_text) do
    as_grid(multiline_text)
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      Map.put(acc, key, is_integer(value) && value || String.to_integer(value))
    end)
  end

  # We only want 4 neighbors, not 8
  def neighbors4(grid, index) do
    [
      index - grid.grid_width,
      index - 1,
      index + 1,
      index + grid.grid_width,
    ]
    |> Enum.filter(fn neighbor -> grid[neighbor] end) #off-board
    |> Enum.filter(fn neighbor ->
      # must be on the same row or column to ensure we don't go side-to-side
      div(neighbor, grid.grid_width) == div(index, grid.grid_width) ||
        rem(neighbor, grid.grid_width) == rem(index, grid.grid_width)
    end)
  end

  # We only want all 8 neighbors
  def neighbors8(grid, index) do
    x = rem(index, grid.grid_width)
    # only worry about going off the sides - the top and bottom
    # excursions will be off-board and removed when they return nil.
    positions =
      [index - grid.grid_width, index + grid.grid_width] ++
      if x > 0 do
        [index - grid.grid_width - 1, index - 1, index + grid.grid_width - 1]
      else
        []
      end ++
      if x == (grid.grid_width - 1) do
        []
      else
        [index - grid.grid_width + 1, index + 1, index + grid.grid_width + 1]
      end

    positions
    |> Enum.filter(fn neighbor -> grid[neighbor] end) #off-board
  end

  @ascii_zero 48
  @max_display 40
  def display_grid(grid, text) do
    IO.puts("--- #{text}")
    (0..grid.last_cell)
    |> Enum.chunk_every(grid.grid_width)
    |> Enum.map(fn indexes ->
      indexes
      |> Enum.map(fn index ->
        (grid[index] >= @max_display) && "." || (@ascii_zero + grid[index])
      end)
      |> IO.puts()
    end)
    grid
  end

  # Paragraph-based helpers
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

  # Line-based helpers
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

