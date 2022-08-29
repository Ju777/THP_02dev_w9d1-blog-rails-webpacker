class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.references :articles, :user, index: true

      t.timestamps
    end
  end
end
