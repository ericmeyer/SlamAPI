class CreateMatchesTable < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :player_one
      t.string :player_two
    end
  end
end
