@users @update
Feature: Usuarios - Actualizar usuario

  Background:
    * url baseUrl
    * def utils = call read('classpath:util/users-utils.js')
    * def schemas = read('classpath:responses/users-responses.json')

  @smoke @regression @CP008
  Scenario: PUT /usuarios/{_id} - actualizar usuario existente
    * def newUser = utils.generateUser(null)

    Given path 'usuarios'
    And request newUser
    When method post
    Then status 201
    * def createdId = response._id

    * def updatedUser = newUser
    * set updatedUser.nome = 'QA Test Updated'

    Given path 'usuarios', createdId
    And request updatedUser
    When method put
    Then status 200
    And match response == schemas.successMessageContract

    Given path 'usuarios', createdId
    When method get
    Then status 200
    And match response.nome == 'QA Test Updated'
    And match response contains schemas.userContract

  @negative @regression @CP009
  Scenario: PUT /usuarios/{_id} - actualizar con datos invalidos
    * def newUser = utils.generateUser(null)

    Given path 'usuarios'
    And request newUser
    When method post
    Then status 201
    * def createdId = response._id

    * def invalidPayload = { email: newUser.email, password: 'Pwd@1234', administrador: 'false' }

    Given path 'usuarios', createdId
    And request invalidPayload
    When method put
    Then status 400
    * def errorValues = karate.valuesOf(response)
    And assert errorValues.length > 0
    And match each errorValues == '#string'


