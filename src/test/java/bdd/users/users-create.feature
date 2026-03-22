@users @create
Feature: Usuarios - Registrar usuario

  Background:
    * url baseUrl
    * def utils = call read('classpath:util/users-utils.js')
    * def schemas = read('classpath:responses/users-responses.json')

  @smoke @regression @CP003
  Scenario: POST /usuarios - registrar un nuevo usuario valido
    * def newUser = utils.generateUser(null)

    Given path 'usuarios'
    And request newUser
    When method post
    Then status 201
    And match response == schemas.createUserResponseContract

    * def createdId = response._id
    Given path 'usuarios', createdId
    When method get
    Then status 200
    And match response contains schemas.userContract
    And match response.email == newUser.email

  @negative @regression @CP004
  Scenario: POST /usuarios - registrar usuario duplicado
    * def newUser = utils.generateUser(null)

    Given path 'usuarios'
    And request newUser
    When method post
    Then status 201

    Given path 'usuarios'
    And request newUser
    When method post
    Then status 400
    And match response == schemas.errorMessageContract
    And match response.message contains 'email'

  @negative @regression @CP005
  Scenario: POST /usuarios - registrar usuario sin email
    * def invalidUser = utils.generateUser({ email: null })

    Given path 'usuarios'
    And request invalidUser
    When method post
    Then status 400
    * def errorValues = karate.valuesOf(response)
    And assert errorValues.length > 0
    And match each errorValues == '#string'


