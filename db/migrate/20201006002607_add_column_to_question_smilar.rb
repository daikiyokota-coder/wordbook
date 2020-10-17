class AddColumnToQuestionSmilar < ActiveRecord::Migration[6.0]
  def change
    add_reference :question_similars, :question, foreign_key: true
  end
end
