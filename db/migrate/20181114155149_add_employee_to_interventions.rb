class AddEmployeeToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_reference :interventions, :employee, foreign_key: true
  end
end
