class Sales {
  final int Id;
  final String time;
  final String name;
  final String overall_sale;

  Sales({this.Id, this.time,this.name,this.overall_sale});

  factory Sales.fromJson({Map<dynamic, dynamic> json}) {
    return Sales(
        Id: json['sale_id'],
        time:json['normal_time'].toString(),
        name:json['productCategory']['name'].toString(),
        overall_sale:json['overall_sale'].toString()
    );
  }

  static List<Sales> fetchData({List jsonList}) {
    List<Sales> list = [];

    for (int i = 0; i < jsonList.length; i++) {
      list.add(Sales.fromJson(json: jsonList[i]));
    }

    return list;
  }

}