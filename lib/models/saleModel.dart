class Sales {
  final String Id;
  final String time;
  final String name;

  Sales({this.Id, this.time,this.name});
  var dateUtc = DateTime.now().toLocal();

  factory Sales.fromJson({Map<String, dynamic> json}) {
    return Sales(
        Id: json['id'].toString(),
        time:json['time'].toString(),
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