require 'spec_helper'
describe "web" do
  before(:all) do
    Capybara.current_driver = :selenium
  end
  feature "General" do
  	before :each do
  		user = User.find_by email: "user@example.com"
  		if user != nil
  			User.destroy user.id
  			puts 5
  		end
  	end
  	scenario "register" do
  		visit '/'
  		click_on 'Registrarse'
  		fill_in 'Email', :with => "user@example.com"
    		fill_in 'Password', :with => 'password'
    		fill_in 'Password confirmation', :with => 'password'
    		click_button 'Registrarse'
    		expect(page).to have_content 'Welcome! You have signed up successfully.'
  	end
  	scenario "login and logout" do
  		User.create(:email => 'admin@example.com', :password => 'password', "role" => 1)
  		visit '/'
    		click_on "Autenticarse"
    		expect(page).to have_content 'Autenticarse'
    		fill_in 'Email', :with => "admin@example.com"
    		fill_in 'Password', :with => 'password'
    		check "Remember me"
    		click_button 'Log in'
    		expect(page).to have_content 'Signed in successfully.'
    		click_on 'Desconectarse'
    		expect(page).to have_content 'Signed out successfully.'
  	end
  end
  feature "Admin Features" do
    before :each do
      User.create(:email => 'admin@example.com', :password => 'password', "role" => 1)
      visit '/'
    	click_on "Autenticarse"
    	expect(page).to have_content 'Autenticarse'
    	fill_in 'Email', :with => "admin@example.com"
    	fill_in 'Password', :with => 'password'
    	check "Remember me"
    	click_button 'Log in'
    	expect(page).to have_content 'Signed in successfully.'
    end

    scenario 'Download ddbb' do
    	visit '/'
    	click_on "Descargar Base de Datos"
    	expect(page).to have_content 'La Base de Datos ha sido cargada desde la API'
    end

    scenario 'Do assignation' do
    	visit '/'
    	click_on 'Asignar Cursos'
    	expect(page).to have_content 'La Asignación de cursos a las salas se ha realizado con éxito'
    end

    scenario 'check assignations' do
    	visit '/'
    	click_on 'Salas Asignadas'
    	expect(page).to have_content 'Salas Asignadas'
    	expect(page).not_to have_css "table tr", :count=> 1
    end
  end

  feature "User Features" do
  	before :each do
      User.create(:email => 'user@example.com', :password => 'password')
      visit '/'
    	click_on "Autenticarse"
    	expect(page).to have_content 'Autenticarse'
    	fill_in 'Email', :with => "user@example.com"
    	fill_in 'Password', :with => 'password'
    	check "Remember me"
    	click_button 'Log in'
    	expect(page).to have_content 'Signed in successfully.'
    end

    scenario 'Dont have Admin features' do
    	visit '/'
    	expect(page).not_to have_content 'Asignar Cursos'
    	expect(page).not_to have_content 'Descargar Base de Datos'
    	visit '/asignaciones/generar'
    	expect(page).to have_content 'not authorized'
    	visit '/json/databaseLoad'
    	expect(page).to have_content 'NotAuthorizedError'
    end

    scenario 'check assignations' do
    	visit '/'
    	click_on 'Salas Asignadas'
    	expect(page).to have_content 'Salas Asignadas'
    end
  end
  after(:all) do
    Capybara.use_default_driver
  end
end