public class ChartController {

    private static final String INACTIVE_PRODUCTS= String.format(Label.Inactive_products, 
                                                                 new String[]{});
                                                                 
    private static final String ACTIVE_PRODUCTS= String.format(Label.Active_products, 
                                                               new String[]{});
                                                                 
    public List<Data> getProductData() {
        List<Data> data = new List<Data>();

        Integer active = [SELECT count()
                          FROM Product2
                          WHERE isActive = true];
        Integer inactive = [SELECT count()
                          FROM Product2
                          WHERE isActive = false];

        data.add(new Data(ACTIVE_PRODUCTS, active));
        data.add(new Data(INACTIVE_PRODUCTS, inactive));
        return data;
    }

    public List<Data> getCaseData() {
        List<Data> data = new List<Data>();
        List<String> statuses = ChartControllerHelper.getCaseStatuses();

        for(String statusName : statuses) {
            Integer amount = [SELECT count()
                              FROM Case
                              WHERE Status = :statusName];
            data.add(new Data(statusName, amount));
        }

        return data;
    }
    
  public List<ProductCaseData> getProductStats(Integer lim, Integer offset) {
        List<ProductCaseData> productCaseData = new List<ProductCaseData>();

        List<Product2> products = [SELECT Id, Name, Price__c
                                   FROM Product2
                                   ORDER BY Name ASC
                                   LIMIT :lim
                                   OFFSET :offset];

        for(Product2 p : products) {
            List<Case_Product__c> productCases = [SELECT Case__c, Case__r.RecordType.DeveloperName
                                                  FROM Case_Product__c
                                                  WHERE Product__c = :p.Id];

            ProductCaseData pcd = new ProductCaseData(p, productCases);
            productCaseData.add(pcd);
        }

        ChartControllerHelper.addCaseStatsToProductCaseData(productCaseData);
        return productCaseData;
    }

    public class ProductCaseData {
        public Product2 product { get; set; }

        public List<Case_Product__c> productCases { get; set; }

        public List<CaseStat> caseStats { get; set; }

        public ProductCaseData(Product2 product, List<Case_Product__c> productCases) {
            this.product = product;
            this.productCases = productCases;
        }
    }

    public class CaseStat {
        public String name { get; set; }

        public Long percent { get; set; }

        public CaseStat(String name, Long percent) {
            this.name = name;
            this.percent = percent;
        }
    }

    public class Data {

        public String name { get; set; }
        public Integer data { get; set; }

        public Data(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }

}