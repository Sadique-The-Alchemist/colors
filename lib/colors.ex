defmodule Colors do
  @moduledoc """
  Project colors-> project to generate hexcodes of dark and light versions of a given color by mixing dark and light respectively
  """

  import CssColors
  @ranges [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
  @doc """
  it expects a string of hexcode of a color and it delegates to_black and to_white functions map of black and white
  variations
  """
  def b_w_variations(color) do
    Map.put(%{}, :black, to_dark(color))
    |> Map.put(:light, to_light(color))
  end

  defp to_dark(color) do
    pcolor = parse!(color)

    Stream.map(@ranges, &darken(pcolor, &1))
    |> Stream.map(&rgb(&1))
    |> Stream.map(&to_string(&1))
    |> Stream.with_index()
    |> Enum.reduce(%{}, fn {v, k}, acc -> Map.put(acc, k, v) end)
  end

  defp to_light(color) do
    pcolor = parse!(color)

    Stream.map(@ranges, &lighten(pcolor, &1))
    |> Stream.map(&rgb(&1))
    |> Stream.map(&to_string(&1))
    |> Stream.with_index()
    |> Enum.reduce(%{}, fn {v, k}, acc -> Map.put(acc, k, v) end)
  end
end
