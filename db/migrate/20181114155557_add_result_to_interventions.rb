class AddResultToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_column :interventions, :result, :string
  end
end
