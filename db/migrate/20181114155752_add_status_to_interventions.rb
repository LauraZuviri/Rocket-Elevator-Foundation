class AddStatusToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_column :interventions, :status, :string
  end
end
