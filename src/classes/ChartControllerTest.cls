@isTest
public class ChartControllerTest {
	@isTest
	private static void testGetProductData() {
		ChartController controller = new ChartController();

		List<ChartController.Data> dataList = controller.getProductData();

		System.assert(!dataList.isEmpty());
	}

	@isTest
	private static void testGetCaseData() {
		ChartController controller = new ChartController();

		List<ChartController.Data> dataList = controller.getCaseData();

		System.assert(!dataList.isEmpty());
	}
    
    @isTest
	private static void testGetProduct() {
		ChartController controller = new ChartController();
		Integer countProducts = [SELECT count() FROM Product2];
        
		List<ChartController.ProductCaseData> dataList = controller.getProductStats(10, 1);

		System.assert(countProducts >= dataList.size());
	}
}