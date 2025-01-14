import 'package:flutter/material.dart';
import 'package:rest_api_app/helpers/snak_bar_helper.dart';
import 'package:rest_api_app/models/todo.dart';
import 'package:rest_api_app/models/todonavi.dart';
import 'package:rest_api_app/services/todo_api.dart';

class TodoPage extends StatefulWidget {
  final Todo? todo;
  final int? index;
  final String? heroTag;
  const TodoPage({super.key, this.todo, this.index, this.heroTag});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController titleInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  bool isEdit = false;
  Todo? newTodo;
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
        actions: [isEdit ? PopMenu(widget: widget) : Container()],
        leading: IconButton(
            onPressed: () async {
              if (isEdit) {
                final result = await updateData();
                if (result) {
                  onEditSuccess(); // Gọi hàm xử lý khi cập nhật thành công
                } else {
                  onEditFailure(); // Gọi hàm xử lý khi cập nhật thất bại
                }
              } else {
                await submitData();
                onSubmitSuccess(); // Gọi hàm xử lý khi gửi dữ liệu thành công
              }
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Hero(
      tag: widget.heroTag!,
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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

  Future<bool> updateData() async {
    if (titleInput.text == '') {
      showErrorMessage(message: 'Tiêu đề trống.\nKhongo thể cập nhật.');
      return false;
    }
    newTodo = widget.todo!.copyWith(
      title: titleInput.text,
      description: descriptionInput.text,
    );
    final result = await TodoApi.putApi(todo: newTodo);
    return result;
  }

  void onEditSuccess() {
    showSuccessMessage(message: 'Cập nhật thành công.');
    Navigator.pop(context, Todonavi(x: 1, todo: newTodo!));
  }

  void onEditFailure() {
    showErrorMessage(message: 'Cập nhật thất bại');
  }

  void onSubmitSuccess() {
    Navigator.pop(context, [0, newTodo]);
  }

  Future<void> submitData() async {
    if (titleInput.text == '' && descriptionInput.text == '') {
      showErrorMessage(message: 'Thêm thất bại');
      return;
    }
    final result = await TodoApi.postApi(
        title: titleInput.text, description: descriptionInput.text);
    if (result) {
      showSuccessMessage(message: 'Thêm thành công.');
    } else {
      showErrorMessage(message: 'Thêm thất bại');
    }
  }
}

class PopMenu extends StatefulWidget {
  const PopMenu({
    super.key,
    required this.widget,
  });

  final TodoPage widget;

  @override
  State<PopMenu> createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (value) async {
        // Xử lý khi người dùng chọn một mục trong PopupMenu
        if (value == 2) {
          await TodoApi.postApi(
              title: widget.widget.todo!.title,
              description: widget.widget.todo!.description);
          naviTodo(Todonavi(x: 0, todo: widget.widget.todo!));
        } else if (value == 1) {
          await TodoApi.deleteApiById(widget.widget.todo!.sId);
          naviTodo(Todonavi(x: 0, todo: widget.widget.todo!));
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

  void naviTodo(Todonavi todonavi) {
    Navigator.pop(context, todonavi);
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
