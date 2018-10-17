require 'rails_helper'

RSpec.describe User, type: :model do

  describe "when a user is built" do

    let(:user) { FactoryBot.create(:user) }

    it "should be valid" do
      expect(user.valid?).to be true
    end

    it "shouldn't have an empty name" do
      user.name = "      "
      user.valid?
      expect(user.errors).to include(:name)
    end

    it "shouldn't have an empty email" do
      user.email = "      "
      user.valid?
      expect(user.errors).to include(:email)
    end

    it "shouldn't have an empty password" do
      user.password = "      "
      user.valid?
      expect(user.errors).to include(:password)
    end

    it "shouldn't have a username longer than 50 chars" do
      user.name = "a" * 51
      user.valid?
      expect(user.errors).to include(:name)
    end

    it "shouldn't have an email longer than 255 chars" do
      user.email = "a" * 244 + "@example.com"
      user.valid?
      expect(user.errors).to include(:email)
    end

    it "shouldn't have a password longer than 50 chars" do
      user.password = "a" * 51
      user.valid?
      expect(user.errors).to include(:password)
    end

    it "shouldn't have an existing email" do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      duplicate_user.valid?
      expect(duplicate_user.errors).to include(:email)
    end

    it "should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user.valid?).to be(true), "#{valid_address.inspect} should be valid"
      end
    end

    it "should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user.valid?).not_to be(true), "#{invalid_address.inspect} should be invalid"
      end
    end
  end
end
