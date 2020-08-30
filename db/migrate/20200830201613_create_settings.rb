class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.boolean :enable_sms, default: true
      t.boolean :enable_email, default: true
      t.string :mocker_id

      t.timestamps
    end

    Mocker.find_each do |mocker|
    	Setting.create(mocker_id: mocker.id, enable_email: true, enable_sms: true)
    end
  end
end
