#Migration file that creates the faqs table and its columns.
class CreateFaqs < ActiveRecord::Migration
  def self.up
    create_table :faqs do |t|
      t.column :question, :text, :null => false
      t.column :answer, :text
      t.column :creator, :text
    end
  end

  def self.down
    drop_table :faqs
  end
end
