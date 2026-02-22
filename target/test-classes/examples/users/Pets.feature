
Feature: Automatizar el backend de Pet Store

  Background:
    * url 'https://petstore.swagger.io/v2'

    @Test-3
  Scenario: Añadir una nueva mascota a la tienda
    *def newMacota =
    """
    {
      "id": 0,
      "category": {
        "id": 0,
        "name": "string"
      },
      "name": "doggie",
      "photoUrls": [
        "string"
      ],
      "tags": [
        {
          "id": 0,
          "name": "string"
        }
      ],
      "status": "available"
    }
    """
    Given path 'pet'
    And request newMascota
    When method post
    Then status 200