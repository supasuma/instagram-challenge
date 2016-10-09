def sign_up_new_user
  visit new_user_registration_path
  fill_in('Email', with: 'frisbee@4life.com')
  fill_in('Username', with: 'FrisbeeQueen')
  fill_in('Password', with: 'frisbeeFreak')
  fill_in('Password confirmation', with: 'frisbeeFreak')
  click_button('Sign up')
end

def user_login
  visit('/')
  click_link('Login')
  fill_in('Email', with: 'frisbee@4life.com')
  fill_in('Password', with: 'frisbeeFreak')
  click_button('Log in')
end

def new_post
  click_link('New Foto')
  fill_in('Description', with: "FRISBEE")
  attach_file('Image', File.absolute_path("./public/system/posts/images/000/000/002/medium/frisbeeCatch.jpg"))
  click_button("Create Post")
end
