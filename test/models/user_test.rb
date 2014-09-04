require 'test_helper'

describe User do
  def setup
    @name   = 'somename'
    @email  = "somename@example.com"
    @gender = 'Male'
    @street_address = "AB-1, some street"
  end

  describe "validate email" do
    let(:user) do
      User.new(name: @name,
               gender: @gender,
               street_address: @street_address)
    end

    it "is invalid without an email" do
      refute user.valid?, "Can't be valid without email"
      assert_equal ["can't be blank"], user.errors[:email]
    end

    it "is invalid with an incorrent email" do
      user.email = "no-such-email"

      refute user.valid?, "Can't be valid without email"
      assert_equal ["is invalid"], user.errors[:email]
    end

    it "is valid with an email" do
      user.email = @email
      assert user.valid?, "Is valid with an email"
      assert user.errors.empty?
    end
  end

  describe "validate name" do
    let(:user) do
      User.new(email: @email,
               gender: @gender,
               street_address: @street_address)
    end

    it "is invalid without a name" do
      refute user.valid?, "Can't be valid without name"
      assert_equal ["can't be blank"], user.errors[:name]
    end

    it "is valid with a name" do
      user.name = @name
      assert user.valid?, "Should we valid with a name"
      assert user.errors.empty?
    end
  end

  describe "validate gender" do
    let(:user) do
      User.new(name: @name,
               email: @email,
               street_address: @street_address)
    end

    let(:male_user) do
      User.new(gender: 'Male',
               name: @name,
               email: @email,
               street_address: @street_address)
    end

    let(:female_user) do
      User.new(gender: 'Female',
               name: @name,
               email: @email,
               street_address: @street_address)
    end

    it "is valid if gender is Male" do
      assert male_user.valid?, "Should be valid if gender is Male"
      assert user.errors.empty?
    end

    it "is valid if gender is Female" do
      assert female_user.valid?, "Should be valid if gender is Female"
      assert user.errors.empty?
    end

    it "is invalid if gender is blank" do
      refute user.valid?, "Can't be valid without gender"
      assert_equal ["can't be blank", "is not included in the list"], user.errors[:gender]
    end
  end

  describe "validate street address" do
    let(:user) do
      User.new(name: @name,
               email: @email,
               gender: @gender,
               street_address: @street_address)
    end

    let(:user_with_no_address) do
      User.new(name: @name,
               email: @email,
               gender: @gender)
    end

    let(:user_with_long_address) do
      User.new(name: @name,
               email: @email,
               gender: @gender,
               street_address: ('a' * 55))
    end

    it "is valid if street address is present" do
      assert user.valid?
    end

    it "is invalid if no street address" do
      refute user_with_no_address.valid?, "user is invalid if no street address given"
      assert_equal ["is too short (minimum is 1 characters)"], user_with_no_address.errors[:street_address]
    end

    it "is invalid if no street address is too long" do
      refute user_with_long_address.valid?, "user is invalid if street address is more than 50 characters"
      assert_equal ["is too long (maximum is 50 characters)"], user_with_long_address.errors[:street_address]
    end
  end
end
