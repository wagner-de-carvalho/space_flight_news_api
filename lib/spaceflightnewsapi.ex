defmodule Spaceflightnewsapi do
  alias Spaceflightnewsapi.Articles.Create, as: ArticleCreate
  alias Spaceflightnewsapi.Articles.Delete, as: ArticleDelete
  alias Spaceflightnewsapi.Articles.Get, as: ArticleGet
  alias Spaceflightnewsapi.Articles.Show, as: ArticleShowAll
  alias Spaceflightnewsapi.Articles.Update, as: ArticleUpdate

  defdelegate create_article(params) , to: ArticleCreate, as: :call
  defdelegate delete_article(id) , to: ArticleDelete, as: :call
  defdelegate find_by_id(id), to: ArticleGet, as: :by_id
  defdelegate show_all(params), to: ArticleShowAll, as: :call
  defdelegate update_article(params) , to: ArticleUpdate, as: :call
end
