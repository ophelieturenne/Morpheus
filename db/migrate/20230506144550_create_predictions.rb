class CreatePredictions < ActiveRecord::Migration[7.0]
  def change
    create_table :predictions do |t|
      t.references :user, null: false, foreign_key: true
      t.text :dream
      t.text :prediction

      t.timestamps
    end
  end
end
