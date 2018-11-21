class AddBatteryToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_reference :interventions, :battery, foreign_key: true
  end
end
