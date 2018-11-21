class AddEndDateToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_column :interventions, :end_date, :date
  end
end
