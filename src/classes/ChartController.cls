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

    public static List<Data> getCaseData() {
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

    public static List<CaseData> getChartData() {
        List<CaseData> data = new List<CaseData>();
        data.add(new CaseData('Jan', 30, 90, 55));
        data.add(new CaseData('Feb', 44, 15, 65));
        data.add(new CaseData('Mar', 25, 32, 75));
        data.add(new CaseData('Apr', 74, 28, 85));
        data.add(new CaseData('May', 65, 51, 95));
        data.add(new CaseData('Jun', 33, 45, 99));
        data.add(new CaseData('Jul', 92, 82, 30));
        data.add(new CaseData('Aug', 87, 73, 45));
        data.add(new CaseData('Sep', 34, 65, 55));
        data.add(new CaseData('Oct', 78, 66, 56));
        data.add(new CaseData('Nov', 80, 67, 53));
        data.add(new CaseData('Dec', 17, 70, 70));
        return data;
    }
    
    public class CaseData {
        public String name { get; set; }
        public Integer data1 { get; set; }
        public Integer data2 { get; set; }
        public Integer data3 { get; set; }
        public CaseData(String name, Integer data1, Integer data2, Integer data3) {
            this.name = name;
            this.data1 = data1;
            this.data2 = data2;
            this.data3 = data3;
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