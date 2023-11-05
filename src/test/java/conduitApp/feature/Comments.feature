Feature: Comments Article

  Background: Define URL
    Given url apiURL
    * def timeValidator = read('classpath:conduitApp/helpers/timevalidator.js')


  Scenario: Comments Article
    Given params {limit: 20,offset: 0 }
    Given path 'articles'
    When method GET
    Then status 200
    * def slugid = response.articles[0].slug
    Given path 'articles/' + slugid + '/comments'
    When method GET
    Then status 200
    * def comments = response.comments
    * def initialcommentcount = comments.length
    Given path 'articles/' + slugid + '/comments'
    And request {comment: {body: "Test Comment"}}
    When method POST
    Then status 200
    And match response.comment ==
      """
            {
           "id": "#number",
        "createdAt": "#? timeValidator(_)",
        "updatedAt": "#? timeValidator(_)",
        "body": "#string",
        "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string",
            "following": '#boolean'
        }
        }
      """
    * def commentid = response.comment.id
    Given path 'articles/' + slugid + '/comments'
    When method GET
    Then status 200
    And match karate.sizeOf(karate.jsonPath(response, "$..comments[*]")) == initialcommentcount + 1
    Given path 'articles/' + slugid + '/comments/' + commentid
    When method DELETE
    Then status 200
    Given path 'articles/' + slugid + '/comments'
    When method GET
    Then status 200
    And match karate.sizeOf(karate.jsonPath(response, "$..comments[*]")) == initialcommentcount
