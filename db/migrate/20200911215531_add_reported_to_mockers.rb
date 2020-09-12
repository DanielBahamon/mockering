class AddReportedToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :reported, :boolean, default: false
  end
end
