public class ChartController {
    public List<Data> getProductData() {
        List<Data> data = new List<Data>();

        Integer active = [SELECT count()
                          FROM Product2
                          WHERE isActive = true];
        Integer inactive = [SELECT count()
                          FROM Product2
                          WHERE isActive = false];

        data.add(new Data('Active products', active));
        data.add(new Data('Inactive products', inactive));
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

    public class Data {

        public String name { get; set; }
        public Integer data { get; set; }

        public Data(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }

}