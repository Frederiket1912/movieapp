class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :release_year
      t.string :img_url
      t.string :genre
      t.string :runtime
      t.text :comment

      t.timestamps
    end
  end
end
