class AddPublishedToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :privated, :boolean, default: false
  end
end
