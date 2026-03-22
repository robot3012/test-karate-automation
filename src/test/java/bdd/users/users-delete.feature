@users @delete
Feature: Usuarios - Eliminar usuario

  Background:
    * url baseUrl
    * def utils = call read('classpath:util/users-utils.js')
    * def schemas = read('classpath:responses/users-responses.json')

  @smoke @regression @CP010
  Scenario: DELETE /usuarios/{_id} - eliminar usuario existente
    * def newUser = utils.generateUser(null)

    Given path 'usuarios'
    And request newUser
    When method post
    Then status 201
    * def createdId = response._id

    Given path 'usuarios', createdId
    When method delete
    Then status 200
    And match response == schemas.successMessageContract

    Given path 'usuarios', createdId
    When method get
    Then assert responseStatus == 400 || responseStatus == 404
    And match response == schemas.errorMessageContract

  @negative @regression @CP011
  Scenario: DELETE /usuarios/{_id} - usuario inexistente
    * def fakeId = 'non-existent-' + utils.randomId()

    Given path 'usuarios', fakeId
    When method delete
    Then status 200
    And match response == schemas.successMessageContract

