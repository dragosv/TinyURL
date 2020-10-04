class CreateToken < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :url
      t.string :token
    end
  end
end
