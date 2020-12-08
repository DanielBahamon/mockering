class AddNolistedToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :unlist, :boolean, default: false
  end
end
