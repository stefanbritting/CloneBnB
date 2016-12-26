class ChangePasswordRequiredForUsers < ActiveRecord::Migration
  def change
    change_column_null :users, :encrypted_password, true
    change_column_null :users, :remember_token, true
  end
end
