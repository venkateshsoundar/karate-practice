Feature: New user signup

  Background: Pre-conditions
    * def datagenerator = Java.type('conduitApp.helpers.DataGenerator')
    Given url apiURL


  Scenario: New User Signup
    * def randomemail = datagenerator.getRandomEmail()
    * def randomusername = datagenerator.getRandomUsername()
    * def jsfunction =
      """
      function(){
      var datagenerator= Java.type('conduitApp.helpers.DataGenerator')
      var generator = new datagenerator()
      return generator.getRandomUsername2() 
      }
      """
    * def randomusername2 = call jsfunction
    
    
    Given path 'users'
    And request
      """
            {
      	"user": {
          "email": #(randomemail),
          "password": "2024venkappa",
          "username": #(randomusername2)
              }
      }    
      """
    When method Post
    Then status 201
    And match response ==
      """
      {
      "user": {
          "email": #(randomemail),
          "username": #(randomusername2),
          "bio": "##string",
          "image": "#string",
          "token": "#string"
      }
      }
      """
  @CoderTest
  Scenario Outline: New User Signup Error Message Validation
  
    * def randomemail = datagenerator.getRandomEmail()
    * def randomusername = datagenerator.getRandomUsername()
    Given path 'users'
    And request
      """
            {
      	"user": {
          "email": "<email>",
          "password": "<password>",
          "username": "<username>"
              }
      }    
      """
    When method Post
    Then status 422
    And match response == <errorResponse>

		Examples:
				| email                 | username    			| password    |   errorResponse 																	|
				| #(randomemail)        | venkikarate 			| 1992venkappa|{"errors":{"username":["has already been taken"]}}	|
				| venkikarate@gmail.com | #(randomusername) | 1992venkappa|{"errors":{"email":["has already been taken"]}}		|
				|                				| #(randomusername) | 1992venkappa|{"errors":{"email":["can't be blank"]}}						|
        | #(randomemail)  			|                   | 1992venkappa|{"errors":{"username":["can't be blank"]}}					|
        | #(randomemail) 				| #(randomusername) |       			|{"errors":{"password":["can't be blank"]}}					|