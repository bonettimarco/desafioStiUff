class CreateDados < ActiveRecord::Migration
  def change
    create_table :dados do |t|
      t.string :nome
      t.string :matricula
      t.string :telefone
      t.string :email
      t.string :uffmail
      t.string :status

      t.timestamps null: false
    end
  end
end
