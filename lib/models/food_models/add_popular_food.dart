class AddPopularFood {
  final String id;
  final String name;
  AddPopularFood({required this.name, required this.id});
  Map<String,dynamic> toJson(){
    return{
      "food_name":name,
      "food_id":id,
    };
  }
}
