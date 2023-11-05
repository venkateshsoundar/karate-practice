Feature: Favourites Article

  Background: Define URL
    Given url apiURL
    * def timeValidator = read('classpath:conduitApp/helpers/timevalidator.js')


  Scenario: Favourites Article
    Given params {limit: 20,offset: 0 }
    Given path 'articles'
    When method GET
    Then status 200
    * def slugid = response.articles[0].slug
    * def initialfavcount = response.articles[0].favoritesCount
    Given path 'articles/' + slugid + '/favorite'
    When method POST
    Then status 200
    And match response.article ==
      """
       {
        "id": "#number",
        "slug": "#string",
        "title": "#string",
        "description": "#string",
        "body": "#string",
        "createdAt": "#? timeValidator(_)",
        "updatedAt": "#? timeValidator(_)",
        "authorId": "#number",
        "tagList": [
            "#string"
        ],
        "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string",
            
            
            "following": '#boolean'
        },
        "favoritedBy": [
            {
                "id": "#number",
                "email": "#string",
                "username": "#string",
                "password": "#string",
                "image": "#string",
                "bio": "##string",
                "demo": '#boolean'
            }
        ],
        "favorited": '#boolean',
        "favoritesCount": "#number"
      }
      """
    And match response.article.favoritesCount == initialfavcount + 1
    Given path 'articles'
    Given params {favorited: "venkikarate"}    
    When method GET
    Then status 200
    And match each response.articles ==
      """
            {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": [
                "#string"
            ],
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": '#boolean',
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": '#boolean'
            }
        }
      """
    And match response.articles[*].slug contains slugid
