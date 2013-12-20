require 'spec_helper'

describe "cheering public goal" do
  before(:each) do
    sign_up("user1")
    @public_goal_url = make_goal(false)
  end

  context "user1 tries to cheer" do
    it "should not allow user1 to cheer" do
      visit(@public_goal_url)
      expect(page).to have_no_content("Cheer!")
    end
  end

  context "user2 tries to cheer" do
    before(:each) do
      sign_up("user2")
      visit(@public_goal_url)
    end

    it "should allow user2 to cheer" do
      expect(page).to have_content("Cheer!")
    end

    it "should display cheer" do
      click_on "Cheer!"
      expect(page).to have_content("user2 cheered!")
    end

    it "should not display cheer button anymore" do
      click_on "Cheer!"
      expect(page).to have_no_content("Cheer!")
    end
  end
end

describe "cheer limitations" do
  it "should not let a user cheer more than five times" do
    sign_up("user1")
    goals = Array.new(6) { make_goal(false) }

    sign_up("user2")
    goals[0..4].each do |goal|
      visit(goal)
      click_on "Cheer!"
      expect(page).to have_content("user2 cheered!")
    end

    visit(goals.last)
    expect(page).to have_no_content("Cheer!")
  end
end