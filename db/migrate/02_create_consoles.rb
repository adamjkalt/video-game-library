class CreateConsoles < ActiveRecord::Migration
  def change
    create_table :consoles do |t|
      t.string :name
    end
  end
end
