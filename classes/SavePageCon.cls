public with sharing class SavePageCon{

    public PageReference handleOnLoad(){
        String actionURI = ApexPages.currentPage().getParameters().get('actionURI');
        
        String[] tokens = actionURI.split('_');
        Id entityId = tokens[0];
        String relatedList = tokens[1];
        
        if(entityId.getSObjectType() == Opportunity.sObjectType){
            if(relatedList == 'Contact Roles')
                handleOpportunityContactRole(entityId);
            else if(relatedList == 'Opportunity Team')
                handleOpportunityTeam(entityId);
                
        }
        else if(entityId.getSObjectType() == Account.sObjectType){
            if(relatedList == 'Contact Roles')
                handleAccountContactRole(entityId);
            else if(relatedList == 'Account Team')
                handleAccountTeam(entityId);
                
        }
        
        return new PageReference('/'+ entityId);
        
    
    }
    
    public void handleOpportunityContactRole(Id opportunityId){
        update (new Opportunity(Id= opportunityId, Contact_Roles_Changed__c = true));
    }
    
    public void handleOpportunityTeam(Id opportunityId){
        update (new Opportunity(Id= opportunityId));
    }
    
    public void handleAccountContactRole(Id accountId){
        update (new Account(Id= accountId, Contact_Roles_Changed__c = true));
    }
    
    public void handleAccountTeam(Id accountId){
        update (new Account(Id= accountId, Team_Changed__c = true));
    }
}