require 'spec_helper'

describe Bio do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'has the correct association' do
    @bio = @user.build_bio(weight: 178)
    @bio.save
    expect(@user.bio.weight).to eq 178
  end
end

