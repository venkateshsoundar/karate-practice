Feature: Tests for Create Article

  Background: Define URL 
      Given url apiURL
    #* def tokenresponse = call read('classpath:conduitApp/helpers/CreateToken.feature') 
    #* def token = tokenresponse.AuthToken
    * def articlerequestbody = read('classpath:conduitApp/json/Input.json') 
    * def datagenerator = Java.type('conduitApp.helpers.DataGenerator')
    * set articlerequestbody.article.title = datagenerator.getRandomArticleValues().title
    * set articlerequestbody.article.description = datagenerator.getRandomArticleValues().description
    * set articlerequestbody.article.body = datagenerator.getRandomArticleValues().body


  Scenario: Create a new article
    #Given header Authorization = 'Token '+ token
    Given path 'articles'
    And request articlerequestbody
    When method POST    
    Then status 201
    * print response.article.title
    And match response.article.title == articlerequestbody.article.title


  Scenario: Create and Delete a new article
    #Given header Authorization = 'Token '+ token
    Given path 'articles'
    And request articlerequestbody
    When method POST
    Then status 201
    And match response.article.title == articlerequestbody.article.title
    * def articleid = response.article.slug
    #Given header Authorization = 'Token '+ token
    Given params {limit: 20,offset: 0 }
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles[0].title == articlerequestbody.article.title
    #Given header Authorization = 'Token '+ token
    Given path 'articles',articleid
    When method DELETE
    Then status 204
    #Given header Authorization = 'Token '+ token
    Given params {limit: 20,offset: 0 }
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles[0].title != articlerequestbody.article.title
