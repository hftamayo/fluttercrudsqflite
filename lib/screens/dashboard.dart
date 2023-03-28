import 'package:flutter/material.dart';
import 'package:fluttercrudsqflite/services/db.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Map<String, dynamic>> _allData = [];

  bool _isLoading = true;

  void _refreshData() async {
    final data = await SQLService.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Future<void> _addData() async {
    await SQLService.createData(_titleController.text, _descController.text);
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLService.updateData(
        id, _titleController.text, _descController.text);
    _refreshData();
  }

  void _deleteData(int id) async {
    await SQLService.deleteData(id);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Data deleted")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
