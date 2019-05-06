class Organization {
  String organization;
  List<Student> students;
  String prices;

  Organization(this.organization) {
    students = new List();
  }

  String getPrices() {
    if (students == null) {
      return "0.00";
    }
    double allPrice = 0.00;
    students.forEach((student) {
      allPrice += student.prices;
    });
    return allPrice.toString();
  }
}

class Student {
  String name;
  List<String> times;
  double prices;

  Student(this.name, String time, this.prices) {
    if (times == null) {
      times = new List();
    }
    times.add(time.toString());
  }
}
