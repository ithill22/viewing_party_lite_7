RSpec.describe 'landing page' do
  let!(:user_1) { User.create!(name: "Angel Byun", email: "angelbyun@turing.edu", password: "test_password", password_confirmation: "test_password") }
  let!(:user_2) { User.create!(name: "Isaac Thill", email: "isaacthill@turing.edu", password: "test_password", password_confirmation: "test_password") }
  let!(:user_3) { User.create!(name: "Scott Le", email: "scottle@gmail.com", password: "test_password", password_confirmation: "test_password") }
  let!(:user_4) { User.create!(name: "Megan Hinricher", email: "hinmeg@gmail.com", password: "test_password", password_confirmation: "test_password") }

  it 'displays the landing page header' do
    visit root_path
    expect(page).to have_content("Landing Page")
  end

  it 'displays a button to create a new user' do
    visit root_path
    expect(page).to have_button("New User")
    click_button("New User")
    expect(current_path).to eq("/register")
  end

  it 'displays a list of existing user emails if the user is logged in' do
    login_user(user_1.email, user_1.password)
    visit root_path

    within "#user-#{user_1.id}" do
      expect(page).to have_content(user_1.email)
    end

    within "#user-#{user_2.id}" do
      expect(page).to have_content(user_2.email)
    end

    within "#user-#{user_3.id}" do
      expect(page).to have_content(user_3.email)
    end

    within "#user-#{user_4.id}" do
      expect(page).to have_content(user_4.email)
    end
  end

  it 'displays a link to go back to the landing page' do
    visit root_path

    expect(page).to have_link("Home")
    click_link("Home")
    expect(current_path).to eq(root_path)
  end

  describe 'when a user is logged in' do
    let!(:logged_in_user) { User.create!(name: "John Doe", email: "johndoe@example.com", password: "test_password", password_confirmation: "test_password") }

    before do
      visit login_path
      fill_in "Email", with: logged_in_user.email
      fill_in "Password", with: logged_in_user.password
      click_button "Log In"
    end

    it 'displays a button to log out' do
      visit root_path

      expect(page).to have_button("Log Out")
      click_button("Log Out")
      expect(current_path).to eq(root_path)
    end

    it 'does not display buttons to log in or create an account' do
      visit root_path

      expect(page).not_to have_button("Log In")
    end

    it 'does not display the list of existing users if not logged in' do
      visit root_path
      click_button("Log Out")

      expect(current_path).to eq(root_path)
      expect(page).not_to have_content(user_1.name)
      expect(page).not_to have_content(user_2.name)
      expect(page).not_to have_content(user_3.name)
      expect(page).not_to have_content(user_4.name)
    end

  end
  it 'if I am not logged in and attempt to visit my dashboard it will not allow me' do
    visit dashboard_path(user_1)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You must be logged in to access this page.")
  end
end
     
