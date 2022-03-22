defmodule Spaceflightnewsapi.Event do
    use Ecto.Schema
    import Ecto.Changeset

    alias Spaceflightnewsapi.Article

    @fields [:provider, :article_id]
    @derive {Jason.Encoder, only: [:id, :provider]}

    schema "events" do
        field :provider, :string
        belongs_to :article, Article, on_replace: :update
    end

    def changeset(struct \\ %__MODULE__{}, params) do
        struct
        |> cast(params, @fields)
    end
end
