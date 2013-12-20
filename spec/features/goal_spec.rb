require 'spec_helper'

describe "creating a goal" do
  before(:each) { sign_up("test_user") }

  it "has a creation page" do
    visit(goals_url)
    click_on "Create goal!"
    expect(page).to have_content("New goal!")
  end

  describe "creating private goals" do
    before(:each) do
      make_goal(true)
    end

    it "can create private goals" do
      expect(page).to have_content("Goal Page: test_goal")
    end

    it "is private" do
      sign_up("other_user")
      visit goals_url
      expect(page).to have_no_content("test_goal")
    end
  end

  describe "creating public goals" do
    before(:each) do
      make_goal(false)
    end

    it "can create public goals" do
      expect(page).to have_content("Goal Page: test_goal")
    end

    it "is not private" do
      sign_up("other_user")
      visit goals_url
      expect(page).to have_content("test_goal")
    end
  end
end

