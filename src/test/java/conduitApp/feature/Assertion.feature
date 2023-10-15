Feature: Tests for Home Page

  Background: Define URL
    Given url apiURL
    * def tokenresponse = call read('classpath:conduitApp/helpers/CreateToken.feature')
    * def token = tokenresponse.AuthToken

  Scenario: Get All Tags
    Given path 'tags'
    When method GET
    Then status 200
    And match response.tags contains ['codebaseShow']
    And match response.tags !contains ['quil']
    And match response.tags == "#array"
    And match each response.tags == "#string"

  Scenario: Get 10 Articles from the page
    Given param limit = 10
    Given param offset = 0
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles == '#[10]'


  Scenario: Get 20 Articles from the page
    Given header Authorization = 'Token '+ token
    * def timeValidator = read('classpath:conduitApp/helpers/timevalidator.js')
    Given params {limit: 20,offset: 0 }
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles == '#[20]'
    And match response.articlesCount == 209
    And match response.articlesCount != 197
    And match response == {"articles": "#array" ,"articlesCount": 209}
    And match response.articles[0].createdAt contains '2023'
    And match response.articles[*].favoritesCount contains 0
    And match response..bio contains null
    And match each response..following == false
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#number'
    And match each response..bio == '##string'
    And match each response.articles ==
      """
      {
                "slug": "#string",
                "title": "#string",
                "description": "#string",
                "body": "#string",
                "tagList": "#array",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "favorited": '#boolean',
                "favoritesCount": '#number',
                "author": {
                    "username": "#string",
                    "bio": "#string",
                    "image": "#string",
                    "following": '#boolean'
                }
            }		
      """
