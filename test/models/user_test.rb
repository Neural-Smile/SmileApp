require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Dummy", email: "dummy@gmail.com", password: "foofoofoo", password_confirmation: "foofoofoo")
  end

  test "users should have email" do
    assert @user.valid?

    no_email = @user.dup
    no_email.email = nil
    assert_not no_email.valid?
  end

  test "users should have name" do
    assert @user.valid?

    no_name = @user.dup
    no_name.name = nil
    assert_not no_name.valid?
  end

  test "user password test" do
    @user.save

    assert !!@user.authenticate("foofoofoo")
    assert_not !!@user.authenticate("dummy")
  end

  test "users should have password" do
    assert @user.valid?

    no_password = @user.dup
    no_password.password = nil
    no_password.password_confirmation = nil

    assert_not no_password.valid?
  end

  test "users should have long password" do
    assert @user.valid?

    short_password = @user.dup
    short_password.password = "a" * 7
    short_password.password_confirmation = "a" * 7

    assert_not short_password.valid?
  end

  test "email addresses should be unique" do
    @user.save

    dup = @user.dup
    dup.email = dup.email.upcase

    assert_not dup.valid?
  end

  test "email is saved in lower case" do
    dup = @user.dup

    e = dup.email.downcase
    dup.email = e.upcase

    assert dup.save

    dup.reload
    assert_equal e, dup.email
  end
end
