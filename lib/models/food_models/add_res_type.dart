class AddResType {
  final String id;
  final String name;
  AddResType({required this.name, required this.id});
  Map<String, dynamic> toJson() {
    return {
      "restype_id": id,
      'name': name,
    };
  }
}
