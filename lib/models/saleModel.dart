class Sales {
  final int Id;
  final DateTime time;
  final String name;

  Sales({this.Id, this.time,this.name});
  var dateUtc = DateTime.now().toLocal();

  factory Sales.fromJson({Map<dynamic, dynamic> json}) {
    final DateTime timeStamp = DateTime.fromMillisecondsSinceEpoch(json['time']);
    return Sales(
        Id: json['sale_id'],
        time:timeStamp,
        name:json['productCategory']['name'].toString()
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