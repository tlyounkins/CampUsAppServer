class AddSchoolToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :school, :string
  end
end
