Feature: Dummy
  I want to use this template for my feature file

  Scenario: Dummy
    * def datagenerator = Java.type('conduitApp.helpers.DataGenerator')
    * def username = datagenerator.getRandomUsername()
    * print username
