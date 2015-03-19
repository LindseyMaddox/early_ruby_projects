class CreateWhenToVisits < ActiveRecord::Migration
  def change
    create_table :when_to_visits do |t|
      t.string :location_id
      t.string :integer
      t.string :month_id
      t.string :integer

      t.timestamps
    end
  end
end
