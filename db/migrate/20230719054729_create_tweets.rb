class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.belongs_to :customer, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
