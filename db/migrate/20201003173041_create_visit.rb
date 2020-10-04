class CreateVisit < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.integer 'token_id'
      t.string 'ip'
    end
  end
end
