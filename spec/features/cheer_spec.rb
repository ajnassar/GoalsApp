require 'spec_helper'

describe "cheering public goal" do
  before(:each) do
    sign_up("user1")
    @public_goal_url = make_goal(false)
  end

  context "user1 tries to click cheer button" do
    it "should not allow user1 to cheer" do
      visit(@public_goal_url)
      expect(page).to have_no_button("Cheer!")
    end
  end

  context "user2 tries to cheer" do
    before(:each) do
      sign_up("user2")
      visit(@public_goal_url)
    end

    it "should allow user2 to click cheer button" do
      expect(page).to have_button("Cheer!")
    end

    context "user2 clicks cheer" do
      before(:each) { click_on "Cheer!" }

      it "should afterwards display cheer" do
        expect(page).to have_content("You cheered!")
      end

      it "should after cheering not display cheer button anymore" do
        expect(page).to have_no_button("Cheer!")
      end

      it "should afterwards display cheer to others" do
        sign_up("user3")
        visit(@public_goal_url)
        expect(page).to have_content("user2 cheered!")
      end
    end
  end
end

describe "cheer limitations" do
  it "should not let a user cheer more than five times" do
    cheer_limit = 5

    sign_up("user1")
    goals = Array.new(cheer_limit + 1) { make_goal(false) }

    sign_up("user2")
    goals[0...cheer_limit].each do |goal|
      visit(goal)
      click_on "Cheer!"
      expect(page).to have_content("You cheered!")
    end

    visit(goals.last)
    expect(page).to have_no_button("Cheer!")
  end
end