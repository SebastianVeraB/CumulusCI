public with sharing class CreateContact {

    public static void create(String aFirstName, String aLastName) {

        insert new Contact(firstName = aFirstName, lastName = aLastName);

    } 
}
