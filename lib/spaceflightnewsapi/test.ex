defmodule Test do
    alias Spaceflightnewsapi.Articles.Show
    def test do
        Show.paginated_call()
        # Show.call()
    end
end
