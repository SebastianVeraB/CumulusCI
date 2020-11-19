public with sharing class CreateContact {

    public static Contact create(String aFirstName, String aLastName) {

        insert new Contact(firstName = aFirstName, lastName = aLastName);

    } 
}
