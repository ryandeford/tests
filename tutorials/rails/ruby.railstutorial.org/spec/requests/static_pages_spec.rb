require 'spec_helper'

describe 'Static pages' do

  subject { page }

  let(:title_prefix) { 'Ryan DeFord | ' }

  describe 'Home page' do
    before { visit root_path }

    it { should have_title(title_prefix + 'Home') }
    it { should have_content('Sample App') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe 'Help page' do
    before { visit help_path }

    it { should have_title(title_prefix + 'Help') }
    it { should have_content('Help') }
  end

  describe 'About page' do
    before { visit about_path }

    it { should have_title(title_prefix + 'About Us') }
    it { should have_content('About Us') }
  end

  describe 'Contact page' do
    before { visit contact_path }

    it { should have_title(title_prefix + 'Contact') }
    it { should have_selector('h1', text: 'Contact') }
  end

  it 'should have the right links on the layout' do
    visit root_path
    click_link 'About'
    expect(page).to have_title(title_prefix + 'About Us')
    click_link 'Help'
    expect(page).to have_title(title_prefix + 'Help')
    click_link 'Contact'
    expect(page).to have_title(title_prefix + 'Contact')
    click_link 'Home'
    expect(page).to have_title(title_prefix + 'Home')
    click_link 'Sign up now!'
    expect(page).to have_title(title_prefix + 'Sign Up')
    click_link 'sample app'
    expect(page).to have_title(title_prefix + 'Home')
  end
end
