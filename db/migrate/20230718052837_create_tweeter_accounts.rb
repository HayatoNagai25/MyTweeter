class CreateTweeterAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :tweeter_accounts do |t|

      t.timestamps
    end
  end
end
