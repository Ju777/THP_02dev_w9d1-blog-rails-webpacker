class RemoveWrongArticleIdsColumnFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :articles_id, :integer
  end
end
