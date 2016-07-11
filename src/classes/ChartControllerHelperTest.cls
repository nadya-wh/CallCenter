@isTest
public class ChartControllerHelperTest {
    private testmethod static void testCaseStatuses() {
        List<String> statuses = ChartControllerHelper.getCaseStatuses();
        System.assert(!statuses.isEmpty());
    }
    
    private testmethod static void testAddCaseStatsToProductCaseData() {
        Product2 prod = new Product2(Name = 'testProd', Price__c = 123);
        insert prod;
        
        List<Case_Product__c> productCases = [SELECT Case__c, Case__r.RecordType.DeveloperName
                                                  FROM Case_Product__c
                                                  WHERE Product__c = :prod.Id];
        
        ChartController.ProductCaseData pcd = new ChartController.ProductCaseData(prod, productCases);
        
        System.assert(pcd != null);
        ChartControllerHelper.addCaseStatsToProductCaseData(
            new List<ChartController.ProductCaseData>{pcd});
        
        System.assert(!pcd.caseStats.isEmpty());
    }
}