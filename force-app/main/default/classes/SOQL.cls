/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Christie Martin
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> GetAllLeads(){
    try{
            List<Lead> allLeads= [SELECT Id, LastName, Company, Phone, Email FROM Lead WITH USER_MODE];    
        
                if(allLeads.IsEmpty()){
                return null;
                }
            return allLeads;
            }

        catch (exception e){
            System.debug('Error while fetching leads: ' + e.getMessage());
            return null;
        }
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> GetContactsByFirstName(){
    try{
        List<Contact> johnContacts = [SELECT Id, FirstName, Name FROM CONTACT WHERE FirstName = 'John'];
            if(johnContacts.isEmpty()){
                return null;
            }
        return johnContacts;
        }  catch(exception e){
            System.debug('Problem with Contacts by first name John' +e.getMessage());
            return null;
        }  
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> GetContactIdsByLastName () {
try{
    List<Contact> lastNamesContact = [SELECT Id, Name, LastName FROM Contact WHERE LastName = 'Smith' OR LastName = 'Jones' ];
    if(lastNamesContact.isEmpty()){
        return null;
        }
        List<Id> contactIds = new List<Id>();

            for(Contact eachContact : lastNamesContact){
            Id eachContactId = eachContact.Id;
            contactIds.add(eachContactId);
        }
        return contactIds;
    } catch(exception e){
    System.debug('Problem with Contacts by first name John' +e.getMessage());
    return null;
    }  
}    


    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> GetClosedWonOpportunityCountByAccount (Id AccountId) {
        try{
            List<Opportunity> myOppsList = [SELECT ID, Name, Amount, StageName, CloseDate, AccountId FROM Opportunity WHERE StageName = 'Closed Won' AND AccountId = :AccountId];
                if(myOppsList.isEmpty()){
                return null;
                }    
        return myOppsList;
        
        }catch(exception e){
        System.debug('Problem with Get Closed Won Opps Count by Account' +e.getMessage());
        return null;
        }  
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer GetAccountCount (Integer numAccounts) {
        numAccounts = [SELECT COUNT() FROM Account WITH USER_MODE];
        
        return numAccounts;
        }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task>  GetTasksDueNextWeek () {
        Map<Id, Task> taskMap = new Map<Id, Task>([SELECT Id FROM Task WHERE ActivityDate = NEXT_N_DAYS:7 WITH USER_MODE]);
            if(taskMap.isEmpty()){
                return null;
            }
        return taskMap;   
        }  

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> GetContactsByEmailDomain(String emailDomain) {
        emailDomain = 'example.com';
        List<Contact> contacts = [SELECT Id, Name, FirstName, LastName, Email FROM Contact WHERE Email LIKE :('%@' + emailDomain) WITH USER_MODE];
        if(contacts.isEmpty()){
            return null;
        }    
        
        return contacts;
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        List<Opportunity> myOpps = [SELECT Id, Name, StageName FROM Opportunity WHERE Name LIKE :('%'+ keyword + '%') WITH USER_MODE];
        return myOpps; 
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        List<Case> myCases = [SELECT Id, Origin FROM Case WHERE Origin != null AND Origin NOT IN ('Email', 'Web') WITH USER_MODE];
            if(myCases.isEmpty()){
            return null;
        }
        return myCases; // Replace null with the variable you used to store the result
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> GetLeadsBySourceOrTitle (String leadSource, String keyword) {
        List<Lead> myLeads = [SELECT Id, Company, Email, Phone, LeadSource, Title, LastName, Name FROM Lead WHERE Title LIKE :('%'+ keyword + '%') OR LeadSource = :leadSource WITH USER_MODE];
            if(myLeads.isEmpty()){
            return null;
        }
        return myLeads;
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        List<Contact> contacts = [SELECT Id, LastName FROM Contact WHERE AccountId = :accountId WITH USER_MODE];// Query the Contacts
            List<String> lastNames = new List<String>();  
                if(contacts != null){
                for(Contact eachContact : contacts){                    // Loop through each Contact and add the LastName to the list
                lastNames.add(eachContact.LastName);
                } 
            }                          
        return lastNames; 
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10,000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        AggregateResult[] totRevenue = [SELECT SUM(Amount) totalAmount FROM Opportunity WHERE StageName =:stage OR Amount > 10000 WITH USER_MODE];// Use AggregateQuery to get the total revenue
        Decimal sumR;
                if(!totRevenue.isEmpty()){    
                String sumofResults = String.valueOf(totRevenue[0].get('totalAmount'));
                sumR = decimal.valueOf(sumofResults);
                }
                return sumR;
             // Return 0 if no matching opportunities
        }
        
    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        List<Account> firstTen = [SELECT Name FROM Account WITH USER_MODE ORDER BY Name LIMIT 10 ];
            if(firstTen.isEmpty()){    
                return null;
            }   
        return firstTen; 
        }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        List<Opportunity> myOppsList = [SELECT Name, Id, Amount, CloseDate, StageName FROM Opportunity WHERE Amount > 100000 WITH USER_MODE ORDER BY CloseDate LIMIT 5];
            if(myOppsList.isEmpty()){    
            return null;
            }  
        return myOppsList; 
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
    List<Contact> threeContacts = [SELECT Id, Name, BirthDate FROM Contact WHERE BirthDate != null WITH USER_MODE ORDER BY BirthDate DESC LIMIT 3];
        if(threeContacts.isEmpty()){    
        return null;
        }  
        return threeContacts; 
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        List<Case> tenCases = [SELECT Id, Status, Subject, CreatedDate FROM Case WHERE Status = 'Open' WITH USER_MODE ORDER BY CreatedDate ASC LIMIT 10 OFFSET 5];
        if(tenCases.isEmpty()){    
            return null;
        }  
        return tenCases; 
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        List<Case> myCases = [SELECT Id, Subject, AccountId FROM Case WHERE AccountId= :accountId WITH USER_MODE];  // Query the Cases
            Set<Id> caseIdentifiers = new Set<Id>();         // Create a set to hold the Case Ids
            if(!myCases.isEmpty()){    
                for(Case eachCase : myCases){                // Loop through each Case and add the Id to the set
                caseIdentifiers.add(eachCase.Id);
                }
            }
        return caseIdentifiers;                           // Replace null with the variable you used to store the result
    }    

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        Map<Id, String> accountIdsToNames = new Map<Id, String>();// Create a map to hold the Account Ids to Account Names
        List<Account> accountsToAdd = [SELECT Id, Name FROM Account WHERE BillingCountry != :country WITH USER_MODE];// Query the Accounts
            if(!accountsToAdd.isEmpty()){
                for(Account eachAccount : accountsToAdd){
                accountIdsToNames.put(eachAccount.Id, eachAccount.Name);// Loop through each Account and add the Id and Name to the map
                }  
            }
        return accountIdsToNames; 
        }
    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        Contact contactRecord = [SELECT Account.Name FROM Contact WHERE Id = :contactId WITH USER_MODE LIMIT 1];
        
        return contactRecord.Account != null ? contactRecord.Account.Name : null; // Replace null with the variable you used to store the result
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities./** */
    
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
        Account accountWithOpps = [SELECT Id, Name, (SELECT Id, Name, StageName, Amount FROM Opportunities) FROM Account WHERE Id = :accountId WITH USER_MODE LIMIT 1];
            if(accountWithOpps == null){
                return null;
            }
        return accountWithOpps; // Replace null with the variable you used to store the result
    }


    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        Account accountState = [SELECT BillingState, Id FROM Account WHERE Id = :accountId WITH USER_MODE];     // Query the Account
        String accountsBillingState = accountState.BillingState;        // Store the Account's BillingState
            List<Contact> contactsOnAccount = [SELECT Id, MailingState, Name FROM Contact WHERE MailingState LIKE :('%'+ accountsBillingState +'%')];     // Query the Contacts
        
        return contactsOnAccount; 
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        List<Lead> myLeads = [SELECT Id, Email FROM Lead WHERE Id IN :leadIds WITH USER_MODE];
        
        // Create a set of email domains from the Leads
        Set<String> leadDomains = new Set<String>();
        
        // Loop through each Lead
        for(Lead eachlead : myLeads){
            If(eachLead.Email != null && eachLead.Email.contains('@')){
                String domain = eachLead.Email.split('@')[1];
                leadDomains.add(domain.toLowerCase());
            } 
        }
        List<Account> allAccounts = [SELECT Id, Website FROM Account  WHERE Website !=null WITH USER_MODE];
        Map<String, List<Account>> accountMap = new Map<String, List<Account>>();
            for(Account eachAccount : allAccounts){
                String webDomain;
                if(eachAccount.website != null && eachAccount.website.startsWith('www.')){
                    webDomain = eachAccount.website.substring(4);
                    }
                if (!accountMap.containsKey(webDomain)) {
                accountMap.put(webDomain, new List<Account>());
                }
                accountMap.get(webDomain).add(eachAccount);
            }
            
            List<Account> matchingAccounts = new List<Account>();
                for (String leadDomain : leadDomains) {
                    if (accountMap.containsKey(leadDomain)){ 
                    matchingAccounts.addAll(accountMap.get(leadDomain));
                }  
            }          
            return matchingAccounts;
        }


    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> origOppLineItems = [SELECT OpportunityId,Product2Id,PricebookEntryId, Name, Quantity, Description, ProductCode, UnitPrice FROM OpportunityLineItem WHERE OpportunityId = :origOppId];
        
        // Create a list to hold the new line items
        List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
        
        // Generate a random number between 1 and 3
        Integer randomInt = Integer.valueof((Math.random()*3)+1);
        
        // Loop through each cloned Opportunity Id
        if(!origOppLineItems.IsEmpty()){
                for (Id eachOppId : cloneOppIds){
            
                //Loop thru each orig line item
            
                for(OpportunityLineItem origLineItem : origOppLineItems ){
                    OpportunityLineItem clonedLineItem = (OpportunityLineItem)origLineItem.clone(false,true,false,false);// Clone the original line item and add the random number to the quantity
                        clonedLineItem.OpportunityId = eachOppId;
                        clonedLineItem.Quantity += randomInt;
                newLineItems.add(clonedLineItem);
                }
            } 
        }      
        // Insert the new line items
        database.insert(newLineItems);
    }          
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {        
        List<Opportunity> myOpps = [SELECT Name, Account.Name, Owner.Name FROM Opportunity WHERE StageName = 'Closed Won'AND Account.Name != null];
            
        return myOpps; 
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        List<Opportunity> listOppsForPrimC = SOQL.getOpportunityDetailsForClosedWon();//Use the getOpportunityDetailsForClosedWon() method to get the Opportunities

        // Create a set of Account Ids from the Opportunities
            Set<Id> accountIds = new Set<Id>();
                for (opportunity opp : listOppsForPrimC) {
                    accountIds.add(opp.AccountId);
                }
        // Query the Contacts
        List<Contact> contactsonAccount = [SELECT Id, AccountId, FirstName, LastName FROM Contact WHERE AccountId IN :accountIds ORDER BY AccountId, LastName ASC];
        Map<Id, Contact> contactMap = new Map<Id, Contact>();// Loop through each Contact and add the Account Id and Contact to the map

                for(Contact eachCon : contactsonAccount ){
                    if (!contactMap.containsKey(eachCon.AccountId)){
                    contactMap.put(eachCon.AccountId, eachCon);
                }
            }
// Loop through each Opportunity
                for(Opportunity eachOpp : listOppsForPrimC){
                    if (eachopp.AccountId != null && contactMap.containsKey(eachopp.AccountId)){
                        eachOpp.Primary_Contact__c = contactMap.get(eachOpp.AccountId).Id;
                }     
            }   // Update the Opportunity primary contact from accountToContactMap
        database.update(listOppsForPrimC);    // Update the Opportunities      
    }      
}        
    

