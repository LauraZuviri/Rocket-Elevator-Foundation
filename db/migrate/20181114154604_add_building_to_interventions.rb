class AddBuildingToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_reference :interventions, :building, foreign_key: true
  end
end
