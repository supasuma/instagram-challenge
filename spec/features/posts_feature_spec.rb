require 'rails_helper'

feature 'posts' do

  scenario 'no posts have been added' do
    visit '/posts'
    expect(page).to have_content 'No Fotos yet'
  end

  context 'a user makes a new post' do
    before do
      sign_up_new_user
      new_post
    end

      scenario 'caption and image are displayed' do
        expect(page).to have_css("img[src*='frisbeeCatch.jpg']")
        expect(page).to have_content("FRISBEE")
        expect(page).not_to have_content("No Fotos yet")
      end

      scenario 'user can remove their own post' do
        visit '/posts'
        click_link 'Delete Foto'
        expect(page).to have_content('Foto deleted successfully')
      end

      scenario 'user can edit their own post' do
        visit '/posts'
        click_link 'Edit Foto'
        fill_in('Description', with: "FRISBEE IS AWESOME")
        expect(page).to have_content('FRISBEE IS AWESOME')
      end
    end

    scenario 'a post cannot be added without a description' do
      sign_up_new_user
      click_link('New Foto')
      fill_in('Description', with: "")
      attach_file('Image', File.absolute_path("./public/system/posts/images/000/000/002/medium/frisbeeCatch.jpg"))
      click_button("Create Post")
      expect(page).to have_content('Description is too short (minimum is 1 character)')
    end


end
