require 'spec_helper'

describe "the signup process" do
  before(:each) { visit(new_user_url) }

  it "has a new user page" do
    expect(page).to have_content("Sign up!")
  end

  it "should sign up" do
    fill_in "user_username", :with => "testing_username"
    fill_in "user_password", :with => "biscuits"
    click_on "Sign up!"
    expect(page).to have_content("testing_username's user page!")
  end

  it "should complain about a lack of input" do
    click_on "Sign up!"
    expect(page).to have_content("Username can't be blank")
  end
end

describe "the sign in process" do

  before(:each) do
    sign_up("test_user")
    visit(new_session_url)
  end

  it  "has a sign in page" do
    expect(page).to have_content("Sign in!")
  end

  it "should sign in" do
    fill_in "user_username", :with => "test_user"
    fill_in "user_password", :with => "password"
    click_on "Sign in!"
    expect(page).to have_content("Welcome, test_user")
  end

  it "should complain about wrong credentials" do
    fill_in "user_username", :with => "test_user"
    fill_in "user_password", :with => "passwordds==sdj"
    click_on "Sign in!"
    expect(page).to have_content("Sign in!")
  end
end

describe "the sign out process" do

  before(:each) do
    sign_up("test_user")
  end

  it "should have a sign out button" do
    expect(page).to have_button("Sign out!")
  end

  it "should sign you out when you press the button" do
    click_on "Sign out!"
    expect(page).to have_content("Sign in!")
  end
end