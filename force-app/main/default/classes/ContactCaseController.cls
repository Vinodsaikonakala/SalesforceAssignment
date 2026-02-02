public with sharing class ContactCaseController {

    @AuraEnabled
    public static Case createContactAndCase(
        String firstName,
        String lastName,
        String email,
        String subject,
        String description
    ) {

        // Create Contact
        Contact con = new Contact(
            FirstName = firstName,
            LastName = lastName,
            Email = email
        );
        insert con;

        // Create Case
        Case cs = new Case(
            Subject = subject,
            Description = description,
            ContactId = con.Id,
            Status = 'New',
            Origin = 'Web'
        );
        insert cs;

        return cs;
    }
}