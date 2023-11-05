@parallel=false
@CoderTest
Feature: Hooks
  I want to practice this template for my feature file

  Background: Hooks
    #* def result = callonce read('classpath:conduitApp/helpers/Dummy.feature')
    #* def username = result.username
    #afterhooks
    #* configure afterFeature = function(){karate.call('classpath:conduitApp/helpers/Dummy.feature')}
    * configure afterScenario = function(){karate.call('classpath:conduitApp/helpers/Dummy.feature')}
    * configure afterFeature =
      """
      function(){
      karate.log('After Feature Test');
      }
      """

  Scenario: First Scenario
    * print 'This is my first Testcase'

  #* print username
  Scenario: Second Scenario
    * print 'This is my second Testcase'
    #* print username
