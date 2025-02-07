class SugarData {
  int? id;
  double? sugarValue;
  String? date;
  String? time;
  String? measured; //conditions
  String? notes;

  SugarData({
    this.id,
    this.sugarValue,
    this.date,
    this.time,
    this.measured,
    this.notes,
  });

  SugarData.fromJson(Map<String, dynamic> json) {
    json['id'] = id;
    json['sugarValue'] = sugarValue;
    json['date'] = date;
    json['time'] = time;
    json['measured'] = measured;
    json['notes'] = notes;
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'sugarValue': sugarValue,
        'date': date,
        'time': time,
        'measured': measured,
        'notes': notes,
      };
}
