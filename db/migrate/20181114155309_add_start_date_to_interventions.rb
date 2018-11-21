class AddStartDateToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_column :interventions, :start_date, :date
  end
end
