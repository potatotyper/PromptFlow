class CreatePromptSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :prompt_sessions do |t|
      t.string :uid
      t.string :system_prompt
      t.integer :like_count
      t.integer :dislike_count
      t.text :good_feedback
      t.text :bad_feedback

      t.timestamps
    end
    add_index :prompt_sessions, :uid, unique: true
  end
end
