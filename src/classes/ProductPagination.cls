public class ProductPagination
{
    private Integer totalRecs = 0;
    
    private Integer OffsetSize = 0;
    
    private Integer LimitSize = 15;
    
    private ChartController controller;
    
    public ProductPagination(ChartController controller) {
        this.controller = controller;
    	totalRecs = [SELECT count() FROM Product2];
    }
    
    public List<ChartController.ProductCaseData> getProductListStats() {
        return controller.getProductStats(LimitSize, OffsetSize);
    }
    
    public void firstPage() {
    	OffsetSize = 0;
    }
    
    public void previous() {
    	OffsetSize -= LimitSize;
    }
    
    public void next() {
    	OffsetSize = OffsetSize + LimitSize;
    }
    
    public void lastPage() {
    	OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
    }
    
    public boolean getPrev() {
        if(OffsetSize == 0) {
        	return true;
        }
        else {
        	return false;
        }
    }
    
    public boolean getNxt() {
        if((OffsetSize + LimitSize) > totalRecs) {
    		return true;
        }
        else {
    		return false;
        }
    }
}