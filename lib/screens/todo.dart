import 'package:flutter/material.dart';
import 'package:rest_api_app/constants/enum.dart';
import 'package:rest_api_app/helpers/snak_bar_helper.dart';
import 'package:rest_api_app/models/todo.dart';
import 'package:rest_api_app/services/todo_api.dart';

class TodoPage extends StatefulWidget {
  final Todo? todo;
  final int? index;
  const TodoPage({super.key, this.todo, this.index});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController titleInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      titleInput.text = widget.todo!.title;
      descriptionInput.text = widget.todo!.description!;
      isEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleAppBar(isEdit: isEdit),
        actions: [
          PopMenu(),
        ],
        leading: IconButton(
            onPressed: () async {
              if (isEdit) {
                await updateData();
              } else {
                await submitData();
              }
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Hero(
      tag: 'task_${widget.index}',
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: titleInput,
                decoration: InputDecoration(
                    hintText: 'Tiêu đề', border: InputBorder.none),
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: descriptionInput,
                decoration: InputDecoration(
                    hintText: 'Ghi chú', border: InputBorder.none),
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: 16,
              ),
              SizedBox(
                height: 20,
              ),
              //ElevatedButton(onPressed: submitData, child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateData() async {
    if (titleInput.text == '') {
      SnackBarHelper.showErrorMessage(
          context, 'Tiêu đề trống.\nKhongo thể cập nhật.');

      return;
    }
    final result = await TodoApi.putApi(todo: widget.todo);
    if (mounted) {
      switch (result.status) {
        case SubmitStatus.success:
          SnackBarHelper.showSuccessMessage(context, result.message);
          break;
        case SubmitStatus.validationError:
          SnackBarHelper.showErrorMessage(context, result.message);
          break;
        case SubmitStatus.serverError:
          SnackBarHelper.showErrorMessage(context, result.message);
          break;
        case SubmitStatus.networkError:
          SnackBarHelper.showErrorMessage(context, result.message);
          break;
        case SubmitStatus.unknownError:
          SnackBarHelper.showErrorMessage(context, result.message);
          break;
      }
    }
  }

  Future<void> submitData() async {
    if (titleInput.text == '' && descriptionInput.text == '') return;
    final result = await TodoApi.postApi(
        title: titleInput.text, description: descriptionInput.text);
    if (mounted) {
      switch (result.status) {
        case SubmitStatus.success:
          SnackBarHelper.showSuccessMessage(context, result.message);
          break;
        case SubmitStatus.validationError:
          SnackBarHelper.showErrorMessage(context, result.message);
          break;
        case SubmitStatus.serverError:
          SnackBarHelper.showErrorMessage(context, result.message);
          break;
        case SubmitStatus.networkError:
          SnackBarHelper.showErrorMessage(context, result.message);
          break;
        case SubmitStatus.unknownError:
          SnackBarHelper.showErrorMessage(context, result.message);
          break;
      }
    }
  }
}

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({
    super.key,
    required this.isEdit,
  });

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Text(isEdit ? 'Chỉnh sửa' : 'Thêm');
  }
}

class PopMenu extends StatelessWidget {
  const PopMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (value) {
        // Xử lý khi người dùng chọn một mục trong PopupMenu
        if (value == 1) {
          print("Chọn Edit");
        } else if (value == 2) {
          print("Chọn Delete");
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 8),
              Text('Xóa'),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.copy,
              ),
              SizedBox(width: 8),
              Text('Tạo bản sao'),
            ],
          ),
        ),
      ],
    );
  }
}
