class CreateBadFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :bad_feedbacks do |t|
      t.references :prompt_session, null: false, foreign_key: true
      t.string :comment
      t.timestamps
    end
  end
end
