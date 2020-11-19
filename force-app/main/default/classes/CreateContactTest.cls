@isTest
public with sharing class CreateContactTest {

  @isTest
  public static void createSuccess() {
      
      test.startTest();
      CreateContact.create('John', 'Doe');
    
      test.stopTest();

      System.assertEquals('John Doe', [select Name from Contact Limit 1].Name);

  }
    
}
