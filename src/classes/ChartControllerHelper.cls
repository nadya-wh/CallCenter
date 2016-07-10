public class ChartControllerHelper {
    private static final String STATUS_NEW = 'New';

	private static final String STATUS_CLOSED = 'Closed';
	
	private static final String STATUS_IN_PROGRESS = 'In Progress';
	
	private static final String STATUS_ON_HOLD = 'On Hold';
	
	private static final String STATUS_CANCELED = 'Canceled';
    
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
			Double sNew = 0;
			Double sClosed = 0;
			Double sInProgress = 0;
			Double sOnHold = 0;
			Double sCanceled = 0;

			Double caseStatSize = pcd.productCases.size();
			map<String, Integer> caseStatsMap = new map<String, Integer>();
            caseStatsMap.put(STATUS_NEW, 0);
            caseStatsMap.put(STATUS_CLOSED, 0);
            caseStatsMap.put(STATUS_IN_PROGRESS, 0);      
            caseStatsMap.put(STATUS_ON_HOLD, 0);
            caseStatsMap.put(STATUS_CANCELED, 0);
            
            
			for(Case_Product__c cp : pcd.productCases) {
				Integer val = caseStatsMap.get(cp.Case__r.Status);
				caseStatsMap.put(cp.Case__r.Status, ++val);
			}
			
            if(caseStatSize != 0) {
                sNew = caseStatsMap.get(STATUS_NEW) * 100 / caseStatSize;
                sClosed = caseStatsMap.get(STATUS_CLOSED) * 100 / caseStatSize;
                sInProgress = caseStatsMap.get(STATUS_IN_PROGRESS) * 100 / caseStatSize;
                sOnHold = caseStatsMap.get(STATUS_ON_HOLD) * 100 / caseStatSize;
                sCanceled = caseStatsMap.get(STATUS_CANCELED) * 100 / caseStatSize;
            }

			List<ChartController.CaseStat> caseStats = new List<ChartController.CaseStat>();
			caseStats.add(new ChartController.CaseStat(STATUS_NEW, sNew.round()));
			caseStats.add(new ChartController.CaseStat(STATUS_CLOSED, sClosed.round()));
			caseStats.add(new ChartController.CaseStat(STATUS_IN_PROGRESS, sInProgress.round()));
			caseStats.add(new ChartController.CaseStat(STATUS_ON_HOLD, sOnHold.round()));
			caseStats.add(new ChartController.CaseStat(STATUS_CANCELED, sCanceled.round()));
			
			pcd.caseStats = caseStats;
		}
	}

}