require 'spec_helper'

describe "Wods" do
  describe "creation" do
    describe "failure" do
      it "should not create a new WOD" do
        lambda do
          visit new_wod_path
          fill_in "wod_name", :with => ""
          fill_in "wod_description", :with => ""
          fill_in "wod_seq", :with => ""
          fill_in "wod_baserep", :with => ""
          click_button 'Create WOD'
          page.should have_content 'errors'
        end.should_not change(Wod, :count)
      end
    end

    describe "success" do
      it "should create a new WOD" do
        lambda do
          visit new_wod_path
          fill_in "wod_name", :with => "Fran"
          fill_in "wod_description", :with => "21-15-9 Thrusters, Pull Ups"
          choose "wod_wod_type_time"
          fill_in "wod_seq", :with => "WG"
          fill_in "wod_baserep", :with => "1"
          click_button 'Create WOD'
           # response.should have_selector("div.flash.success", :content => "New WOD Created")
        end.should change(Wod, :count).by(1)
      end
    end
  end
end
