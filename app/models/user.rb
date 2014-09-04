class User < ActiveRecord::Base
  GENDERS = %w[Male Female]
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :email,  presence: true, format: { with: EMAIL_REGEX, allow_nil: true }
  validates :name,   presence: true
  # TODO: if error message is
  # ["can't be blank", "is not included in the list"]
  # show only the first one
  # if we do not have `presence: true` then even for no gender
  # specified we get a `is not included in the list`
  validates :gender, presence: true, inclusion: { in: GENDERS }
  validates :street_address, length: 1..50
end
