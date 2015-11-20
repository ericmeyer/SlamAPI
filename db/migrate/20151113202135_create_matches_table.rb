class CreateMatchesTable < ActiveRecord::Migration
  def change
    create_table :matches, id: :uuid do |t|
      t.string :player_one
      t.string :player_two
    end
  end
end
