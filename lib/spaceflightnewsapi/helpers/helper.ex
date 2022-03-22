defmodule Spaceflightnewsapi.Helpers.Helper do

    def encode_list(list), do: Jason.encode!(list)

    def format_keys(value) do
        value
        |> Enum.to_list()
        |> Stream.map(fn {key, value} -> {format(key), value}  end)
        |> Enum.into(%{})
    end

    defp format(word) do
        pattern = Regex.run(~r/[A-Z]/, word)
        case is_nil(pattern) do
            true -> word
            false ->
                new_word = List.first(pattern) |> String.downcase()
                String.replace(word, List.first(pattern), "_#{new_word}")
        end
    end
end
