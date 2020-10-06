class RemoveColumnFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :question_similars, :question_id
  end
end
