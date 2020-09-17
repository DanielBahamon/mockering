class AddAgerestrictedToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :age_restricted, :boolean, default: false
  end
end
