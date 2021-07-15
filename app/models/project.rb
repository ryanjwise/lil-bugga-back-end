class Project < ApplicationRecord
  belongs_to :user
  has_many :project_users
  has_many :tickets
  # Project details will be deleted when projects are deleted
  has_one :project_detail, dependent: :destroy
  # Accept project details through the project controller, do not create if not params are passed
  # and allow patch methods on project details throught the project controller
  accepts_nested_attributes_for :project_detail, reject_if: :all_blank, update_only: true

  # Allows integer to represent ticket status with :open? and :closed? method checks
  # Add more to array as more status' are required. NB: order matters, append only unless db will be dropped
  enum status: [:open, :closed]
  attribute :status, default: 0 # Default ticket to open unless specified

  # Set min and max values for status integer. Increment `less_than_or_equal_to:` if more status' are added 
  validates :status, numericality:
    {greater_than_or_equal_to: 0, less_than_or_equal_to: 1}
end
