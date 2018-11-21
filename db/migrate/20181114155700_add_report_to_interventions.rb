class AddReportToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_column :interventions, :report, :text
  end
end
