class AddNullFalseToSimilarQuestion < ActiveRecord::Migration[6.0]
  def change
    change_column_null :question_similars, :similar_word, false
  end
end
