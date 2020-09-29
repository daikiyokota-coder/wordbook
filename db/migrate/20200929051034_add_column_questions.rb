class AddColumnQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :question, :string
    add_column :questions, :description, :text
  end
end
