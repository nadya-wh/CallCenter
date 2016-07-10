public class ChartControllerHelper {
    public static final String PRODUCT_COMPLAINT = 'Product_Complaint';
    
    public static final String SERVICE_COMPLAINT = 'Service_Complaint';
    
    public static final String PRODUCT_INQUIRY = 'Product_Inquiry';
    
    public static final String FEEDBACK = 'Feedback';
    
    
	public static List<String> getCaseStatuses() {
		List<String> statuses = new List<String>();
	        
	  	Schema.DescribeFieldResult fieldResult =
	   			Case.Status.getDescribe();
	    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	        
	    for( Schema.PicklistEntry f : ple)
	    {
	    	statuses.add(f.getLabel());
	    }       

	   return statuses;
	}

	public static void addCaseStatsToProductCaseData(List<ChartController.ProductCaseData> productCaseDatas) {
		for(ChartController.ProductCaseData pcd : productCaseDatas) {
			Double productComplaint = 0;
			Double serviceComplaint = 0;
			Double productInquiry = 0;
			Double fback = 0;

			Double caseStatSize = pcd.productCases.size();
            
			for(Case_Product__c cp : pcd.productCases) {
                String name = cp.Case__r.RecordType.DeveloperName;
                
                if(name.contains(PRODUCT_COMPLAINT)) {
                    productComplaint++;
                }
                else if(name.contains(SERVICE_COMPLAINT)) {
                    serviceComplaint++;
                } 
                else if(name.contains(PRODUCT_INQUIRY)) {
                    productInquiry++;
                }
                else if(name.contains(FEEDBACK)) {
                    fback++;
                }
			}
         
			
            if(caseStatSize != 0) {
                productComplaint = productComplaint*100 / caseStatSize;
                serviceComplaint = serviceComplaint*100 / caseStatSize;
                productInquiry = productInquiry*100 / caseStatSize;
                fback = fback*100 / caseStatSize;
                
            }

			List<ChartController.CaseStat> caseStats = new List<ChartController.CaseStat>();
			caseStats.add(new ChartController.CaseStat(PRODUCT_COMPLAINT, productComplaint.round()));
			caseStats.add(new ChartController.CaseStat(SERVICE_COMPLAINT, serviceComplaint.round()));
			caseStats.add(new ChartController.CaseStat(PRODUCT_INQUIRY, productInquiry.round()));
			caseStats.add(new ChartController.CaseStat(FEEDBACK, fback.round()));
			
			pcd.caseStats = caseStats;
		}
	}

}