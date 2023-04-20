void main() {
  var list = ["0", "1", "2", "3"];
  var index = list.indexWhere((element) => element == "0");
  print(index);
  var newtask = list[index];
  newtask = "salam";
  list[index] = newtask;
  print(list[0]);
}
