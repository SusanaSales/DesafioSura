require 'selenium-webdriver'

#Autor: Susana Santos Sales
#Data: 07/04/2018
describe('Desafio_Sura') do
    
    before(:all) do
       
        @FirefoxDriver = Selenium::WebDriver.for :firefox
        @FirefoxDriver.navigate.to 'http://opensource.demo.orangehrmlive.com/'

        EfetuarLogin()
    end

    def find_element_byId(elementID)
        begin
            return @FirefoxDriver.find_element(id: elementID)
        rescue => exception
            return "Elemento #{elementID} não identificado"
        end
    end

    def EfetuarLogin
        
        txtUsername = find_element_byId('txtUsername')
        expect(txtUsername.class).to eql Selenium::WebDriver::Element

        txtPassword = find_element_byId('txtPassword')
        expect(txtPassword.class).to eql Selenium::WebDriver::Element

        btnLogin = find_element_byId('btnLogin')
        expect(txtPassword.class).to eql Selenium::WebDriver::Element

        txtUsername.send_keys 'admin'
        txtPassword.send_keys 'admin'
        btnLogin.click
        sleep(3)

    end

    # Verificar se apareceu título personal details, se apareceu foi cadastrado.
    def ObterPdMainContainer 
        begin
            pdMainContainer = @FirefoxDriver.find_element(id: 'pdMainContainer') 
            return 'Empregado cadastrado'
        rescue => exception
            return 'Erro ao cadastrar Empregado'
        end
    end

    it ('Deve Cadastrar um Empregado') do
        
        pimMenu =  find_element_byId('menu_pim_viewPimModule')
        expect(pimMenu.class).to eql Selenium::WebDriver::Element
        pimMenu.click
        sleep(1)

        pimMenuAddEmployee =  find_element_byId('menu_pim_addEmployee')
        expect(pimMenuAddEmployee.class).to eql Selenium::WebDriver::Element
        pimMenuAddEmployee.click
        sleep(1)

        firstName = find_element_byId('firstName')
        expect(firstName.class).to eql Selenium::WebDriver::Element
        firstName.send_keys 'Susana'

        middleName = find_element_byId('middleName')
        expect(middleName.class).to eql Selenium::WebDriver::Element
        middleName.send_keys 'S.'

        lastName = find_element_byId('lastName')
        expect(lastName.class).to eql Selenium::WebDriver::Element
        lastName.send_keys 'Sales'

        btnSave = find_element_byId('btnSave')
        expect(btnSave.class).to eql Selenium::WebDriver::Element
        btnSave.click

        retorno = ObterPdMainContainer()

        expect(retorno).to eql 'Empregado cadastrado'
    end

    it ('Deve Alterar um Empregado') do

        pimMenu =  find_element_byId('menu_pim_viewPimModule')
        expect(pimMenu.class).to eql Selenium::WebDriver::Element
        pimMenu.click
        sleep(1)

        pimMenuViewEmployeeList = find_element_byId('menu_pim_viewEmployeeList')
        expect(pimMenuViewEmployeeList.class).to eql Selenium::WebDriver::Element
        pimMenuViewEmployeeList.click
        sleep(1)
        
        pimMuneuEmpsearch = find_element_byId('empsearch_employee_name_empName')
        expect(pimMuneuEmpsearch.class).to eql Selenium::WebDriver::Element
        pimMuneuEmpsearch.send_keys 'Susana S.'
        sleep(1)

        pimMenuSearchBtn = find_element_byId('searchBtn')
        expect(pimMenuSearchBtn.class).to eql Selenium::WebDriver::Element
        pimMenuSearchBtn.click
        sleep(1)

        linkElement = @FirefoxDriver.find_element(:css, ".left>a")
        expect(linkElement.class).to eql Selenium::WebDriver::Element
        linkElement.click

        btnSave = find_element_byId('btnSave')
        expect(btnSave.class).to eql Selenium::WebDriver::Element
        btnSave.click
        sleep(1)

        personal_optGender_2 = find_element_byId('personal_optGender_2')
        expect(personal_optGender_2.class).to eql Selenium::WebDriver::Element
        personal_optGender_2.click
        sleep(1)

        personal_DOB = find_element_byId('personal_DOB')
        expect(personal_DOB.class).to eql Selenium::WebDriver::Element
        personal_DOB.clear
        personal_DOB.send_keys '1985-02-14'
        sleep(1)

        btnSave = find_element_byId('btnSave')
        expect(btnSave.class).to eql Selenium::WebDriver::Element
        btnSave.click
        sleep(1)   

        personal_optGender_2 = find_element_byId('personal_optGender_2')
        expect(personal_optGender_2.class).to eql Selenium::WebDriver::Element
        checked = personal_optGender_2.attribute("checked")
        expect(checked).to eql 'true'
        
        personal_DOB = find_element_byId('personal_DOB')
        expect(personal_DOB.class).to eql Selenium::WebDriver::Element
        dataNascimento = personal_DOB.attribute("value")
        expect(dataNascimento).to eql '1985-02-14'

    end

    after(:all) do 
        @FirefoxDriver.quit
    end

end
