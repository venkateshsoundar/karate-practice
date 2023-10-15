Feature: Create Authorized Token

  @tag1
  Scenario: Create Token
    Given url 'https://api.realworld.io/api/'
    Given path 'users/login'
    And request {"user": {"email": "#(userEmail)","password": "#(userpassword)"}}
    When method POST
    Then status 200
    * def AuthToken = response.user.token
