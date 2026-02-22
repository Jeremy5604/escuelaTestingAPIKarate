@regresion
Feature: Automatizar el backend de Pet Store

  Background:
    * url apiPetStore
    * def jsonCrearMascota = read('classpath:examples/JsonData/crearMascota.json')
    * def jsonActualizarMascota = read('classpath:examples/JsonData/actualizarMascota.json')


  @Test-1 @happypath @crearMascota
  Scenario: Añadir una nueva mascota a la tienda
    Given path 'pet'
    And request jsonCrearMascota
    And print jsonCrearMascota
    When method post
    Then status 200
    And match response.id == 14
    And match response.name == 'Max'
    And match response.status == 'available'
    * def idPetNew = response.id
    And print idPetNew
  #And print response

@Test-2 @happypath
Scenario: Actualizar una mascota existente
  Given path 'pet'
  * set jsonActualizarMascota.id = "3"
  * set jsonActualizarMascota.name = "Tobyyyyy"
  * set jsonActualizarMascota.status = "sold"
  And request jsonActualizarMascota
  When method put
  Then status 200





    @Test-3 @happypath
  Scenario: Encontrar mascotas por estado
    Given path 'pet','findByStatus'
    And param status = 'available'
    When method GET
    Then status 200
    And print response


  @Test-4 @happypath
  Scenario: Encontrar mascotas por estado
    Given path 'pet','findByStatus'
    And param status = 'pending'
    When method GET
    Then status 200
    And print response



  @Test-5 @happypath
  Scenario: Encontrar mascotas por estado
    Given path 'pet','findByStatus'
    And param status = 'sold'
    When method GET
    Then status 200
    And print response


  @Test-3-4-5 @happypath
  Scenario Outline: Encontrar mascotas por estado
    Given path 'pet', 'findByStatus'
    And param status = '<status>'
    When method GET
    Then status 200
    And print response

    Examples:
      | status     |
      | available  |
      | pending    |
      | sold       |

  # mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @TEST-1" -Dkarate.env=cert






  @Test-6 @happypath
  Scenario: Encontrar una mascota por ID
    * def MascotaPrev = call read('classpath:examples/users/users.feature@crearMascota')
    Given path 'pet', MascotaPrev.idPetNew
    When method GET
    Then status 200
    And print response

  @Test-6-A @happypath
  Scenario Outline: Encontrar mascotas por ID
    Given path 'pet', <ID>
    When method GET
    Then status 200
    And print response
    Examples:
      | ID     |
      | 1  |
      | 2    |
      | 3      |


  @Test-7 @happypath
  Scenario: Actualizar una mascota en la tienda con los datos
      * def petId = 1
      Given path 'pet',petId
      And param petId = petId
      And param name = "Betoven"
      And param status = 'Status available'
      When method post
      Then status 405
      And print response


  @Test-8 @happypath
  Scenario Outline: Eliminar una mascota
        Given path 'pet',<ID>
        And param api_key = ''
        And headers Authorization = '1234567'
        And param petId = petId
        When method delete
        Then status 200
        And print response
        Examples:
        | ID     |
        | 1  |
        | 2    |
        | 3      |
