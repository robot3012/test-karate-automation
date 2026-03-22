@users @read
Feature: Usuarios - Buscar por id

  Background:
    * url baseUrl
    * def utils = call read('classpath:util/users-utils.js')
    * def schemas = read('classpath:responses/users-responses.json')

  @smoke @regression @CP006
  Scenario: GET /usuarios/{_id} - buscar usuario existente
    * def newUser = utils.generateUser(null)

    Given path 'usuarios'
    And request newUser
    When method post
    Then status 201
    * def createdId = response._id

    Given path 'usuarios', createdId
    When method get
    Then status 200
    And match response contains schemas.userContract
    And match response._id == createdId
    And match response.email == newUser.email

  @negative @regression @CP007
  Scenario: GET /usuarios/{_id} - usuario inexistente
    * def fakeId = 'non-existent-' + utils.randomId()

    Given path 'usuarios', fakeId
    When method get
    Then assert responseStatus == 400 || responseStatus == 404
    * def errorValues = karate.valuesOf(response)
    And assert errorValues.length > 0
    And match each errorValues == '#string'


