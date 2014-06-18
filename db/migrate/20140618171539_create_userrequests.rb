class CreateUserrequests < ActiveRecord::Migration
  def change
    create_table :userrequests do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
