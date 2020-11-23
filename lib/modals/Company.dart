class Company {
  String name, type, positon, salary, location, e1o, e12, ebe, desp, docName;

  Company(
      {this.name,
      this.type,
      this.positon,
      this.location,
      this.e1o,
      this.e12,
      this.ebe,
      this.desp,
      this.docName});

  bool operator ==(c) => c is Company && c.name == this.name;

  int get hashCode => name.hashCode;
}
