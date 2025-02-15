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

  factory SugarData.fromMap(Map<String, dynamic> json) => SugarData(
        id: json['id'],
        sugarValue: json['sugarValue'],
        date: json['date'],
        time: json['time'],
        measured: json['measured'],
        notes: json['notes'],
      );

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
