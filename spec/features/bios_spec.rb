require 'spec_helper'

describe Bio do
	before(:each) do
		@bio = FactoryGirl.create(:bio)
		@user = @bio.user
	end

	describe 'inputting data' do
		before(:each) do
			visit user_path(@user)
			click_link 'Edit Bio'
		end

		context 'with valid attributes' do
			it 'updates the bio' do
				fill_in 'bio_feet', with: '5'	
				fill_in 'bio_inches', with: '9'	
				fill_in 'bio_weight', with: '180'	
				fill_in 'bio_experience', with: "I'm a winner"
				click_button 'Update Bio'
			  page.should have_content '180'
			end
		end
	end
end
