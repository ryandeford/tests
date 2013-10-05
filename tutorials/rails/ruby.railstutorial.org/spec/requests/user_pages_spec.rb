require 'spec_helper'

describe "User pages" do

  subject { page }
 
  describe "signup page" do
    before { visit signup_path }

    it { should have_title('Ryan DeFord | Sign Up') }
    it { should have_content('Sign up') }
  end 
end
