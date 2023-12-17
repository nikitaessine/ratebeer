class AddConfirmedToMemberships < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :confirmed, :boolean, default: false
  end
end