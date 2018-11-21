class AddColumnToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_reference :interventions, :column, foreign_key: true
  end
end
