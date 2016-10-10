require 'rails_helper'

feature 'commenting' do
  before do
    sign_up_new_user
    new_post
  end

  scenario 'allows users to comment on fotos using a form' do
    visit posts_path
    click_link 'Add a Comment'
    fill_in "Comment", with: 'Hilarious'
    click_button 'Leave Comment'
    expect(page).to have_content('Success!')
    expect(page).to have_content('Hilarious')
  end

  scenario 'does not allow users to leave empty comment' do
    visit posts_path
    click_link 'Add a Comment'
    fill_in "Comment", with: ''
    click_button 'Leave Comment'
    expect(page).to have_content('Comment is too short (minimum is 1 character)')
  end

  scenario 'user can remove their own comment' do
    visit posts_path
    click_link 'Add a Comment'
    fill_in "Comment", with: 'Hilarious'
    click_button 'Leave Comment'
    visit posts_path
    click_link 'Delete Comment'
    expect(page).to_not have_content('Hilarious')
  end

end
