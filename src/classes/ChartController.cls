public class ChartController {
    public List<ProductData> getProductData() {
        List<ProductData> data = new List<ProductData>();

        Integer active = [SELECT count()
                          FROM Product2
                          WHERE isActive = true];
        Integer inactive = [SELECT count()
                          FROM Product2
                          WHERE isActive = false];

        data.add(new ProductData('Active products', active));
        data.add(new ProductData('Inactive products', inactive));
        return data;
    }

    public class ProductData {

        public String name { get; set; }
        public Integer data { get; set; }

        public ProductData(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
}