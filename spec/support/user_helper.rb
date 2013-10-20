module UserHelper
  def log_in_admin
    @user = FactoryGirl.create(:user)
    @user.admin = true
    visit signin_path
    fill_in 'session_email', with: 'mhartl@example.com'
    fill_in 'session_password', with: 'foobar'
    click_button 'Sign in'
  end
end