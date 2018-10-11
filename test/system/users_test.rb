require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  Capybara.add_selector(:row) do
    xpath { |num| ".//tbody/tr[#{num}]" }
  end

  setup do
    @user = users(:one)
  end

  test 'add_selector' do
    visit users_url

    pp find(:row, 3)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Name", with: @user.name

    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
