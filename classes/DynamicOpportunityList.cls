public class DynamicOpportunityList {

    private ApexPages.StandardController controller;
    private PageReference savePage;
    public Id objId { get; set; }
    
    public DynamicOpportunityList() {
        init();
    }

    public DynamicOpportunityList(ApexPages.StandardController con) {
        this.controller = con;
        init();
    }

    private void init() {
        savePage = null;
        objId =  controller.getRecord().Id;
    }
    
    
    public PageReference show() {
        savePage = Page.dynVFOpportunity;
        savePage.getParameters().put('id', objId);
        return savePage;
    }
    
    public List<String> relations { 
    
        get {
            Schema.DescribeSObjectResult R;
            if(objId.getSObjectType() == Opportunity.sObjectType)
                R = Opportunity.SObjectType.getDescribe();
            else if(objId.getSObjectType() == Account.sObjectType)
                R = Account.SObjectType.getDescribe();
                
            List<Schema.ChildRelationship> C = R.getChildRelationships(); 
            List<String> relations = new List<String>();
            
            for (Schema.ChildRelationship cr: C) {
                String relName = cr.getRelationshipName();
                // We're only interested in some relationships
                if (relName != null && (relName.contains('Role') || relName.contains('Team')) ) {
                    relations.add(relName);
                }
            }
            return relations;
        }
    }

    
    public Component.Apex.OutputPanel getOpportunityRelatedLists() {
        Component.Apex.OutputPanel dynOutPanel= new Component.Apex.OutputPanel();
        
        for(String id: relations) {
           Component.Apex.RelatedList dynRelList = new Component.Apex.RelatedList();
           dynRelList.list = id;
           dynOutPanel.childComponents.add(dynRelList);
        }
        
        return dynOutPanel;
    }
   
   
}