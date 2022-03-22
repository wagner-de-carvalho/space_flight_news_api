defmodule Spaceflightnewsapi.Article do
    use Ecto.Schema
    import Ecto.Changeset

    alias Spaceflightnewsapi.{Event, Launch}

    @required [:title, :summary]
    @fields [:featured, :title, :url, :image_url, :news_site, :summary, :published_at]
    @derive {Jason.Encoder, only: @fields ++ [:id, :events, :launches]}

    schema "articles" do
        field :featured, :boolean
        field :title, :string
        field :url, :string
        field :image_url, :string
        field :news_site, :string
        field :summary, :string
        field :published_at, :utc_datetime

        has_many :events, Event
        has_many :launches, Launch

        timestamps()
    end

    def changeset(struct \\ %__MODULE__{}, params) do
        struct
        |> cast(put_change(params), @fields)
        |> validate_required(@required)
        |> validate_length(:title, min: 6)
        |> validate_length(:summary, min: 10)
        |> cast_assoc(:events)
        |> cast_assoc(:launches)
    end

    defp put_change(params) do
        date = DateTime.utc_now()
        |> DateTime.truncate(:second)
        case Map.has_key?(params, "published_at") do
            true -> Map.put(params, "published_at", date)
            false -> Map.put_new(params, "published_at", date)
        end
    end
end
