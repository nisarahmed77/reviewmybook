class AddSectionIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :section_id, :integer
  end
end
