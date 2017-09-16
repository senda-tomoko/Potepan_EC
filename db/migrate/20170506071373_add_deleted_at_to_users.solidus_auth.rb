# This migration comes from solidus_auth (originally 20140904000425)
class AddDeletedAtToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_users, :deleted_at, :datetime
    add_index :spree_users, :deleted_at
  end
end
