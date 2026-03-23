@users @list
Feature: Usuarios - Listar usuarios

  Background:
    * url baseUrl
    * def schemas = read('classpath:responses/users-responses.json')

  @smoke @regression @CP001
  Scenario: GET /usuarios - listar todos los usuarios
    Given path 'usuarios'
    When method get
    Then status 200
    And match response contains { quantidade: '#number', usuarios: '#[]' }
    And match each response.usuarios contains schemas.userContract

  @negative @regression @CP002
  Scenario: GET /usuarios con limite invalido retorna error de validacion
    Given path 'usuarios'
    And param limite = -1
    When method get
    Then status 400
    And match response contains { limite: '#string' }


