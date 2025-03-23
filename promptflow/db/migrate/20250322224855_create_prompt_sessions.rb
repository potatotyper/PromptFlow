class CreatePromptSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :prompt_sessions do |t|
      t.integer :uid
      t.string :system_prompt
      t.integer :like_count
      t.integer :dislike_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
