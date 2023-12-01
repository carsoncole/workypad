class AddResponseToFeedbacks < ActiveRecord::Migration[7.1]
  def change
    add_column :feedbacks, :response, :string
  end
end
