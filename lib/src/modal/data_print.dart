class Header{
  List<String> from = [];
  List<String> to =[];
  String logo = "";
}

class PrintResponseModal {
  List<Map<String, dynamic>> columns = [];
  List<Map<String, dynamic>> data = [];
  Header header = new Header();
  List<Map<String, dynamic>> footer = [];
  Map<String, dynamic> getValue() {
    Map<String, dynamic> v = {};
    v.putIfAbsent('header', () => this.header);
    v.putIfAbsent('data', () => this.data);
    v.putIfAbsent('columns', () => this.columns);
    v.putIfAbsent('footer', () => this.footer);
    return v;
  }
}
