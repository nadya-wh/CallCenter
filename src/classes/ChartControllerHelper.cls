public class ChartControllerHelper {
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
}