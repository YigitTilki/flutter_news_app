import 'package:flutter/material.dart';
import 'package:flutter_news_app/feature/home_create/home_logic.dart';
import 'package:flutter_news_app/product/enum/widget_size.dart';
import 'package:flutter_news_app/product/models/category_model.dart';
import 'package:kartal/kartal.dart';

class HomeCreateView extends StatefulWidget {
  const HomeCreateView({super.key});
  @override
  State<HomeCreateView> createState() => _HomeCreateViewState();
}

class _HomeCreateViewState extends State<HomeCreateView> with Loading {
  late final HomeLogic _homeLogic;
  @override
  void initState() {
    super.initState();
    _homeLogic = HomeLogic();
    _fetchInitialCategory();
  }

  Future<void> _fetchInitialCategory() async {
    await _homeLogic.fetchAllCategory();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _homeLogic.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
        centerTitle: false,
        actions: [
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
        ],
      ),
      body: Form(
        key: _homeLogic.formKey,
        onChanged: () {
          _homeLogic.checkValidateAndSave(
            (value) {
              setState(() {});
            },
          );
        },
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: context.padding.low,
          child: ListView(
            children: [
              _HomeCategoryDropDown(
                categories: _homeLogic.categories,
                onSelected: _homeLogic.updateCategory,
              ),
              const _EmptySizeBox(),
              TextFormField(
                controller: _homeLogic.titleController,
                validator: (value) => value!.isEmpty ? 'Not empty' : null,
                decoration: const InputDecoration(
                  hintText: 'Add Item',
                  border: OutlineInputBorder(),
                ),
              ),
              const _EmptySizeBox(),
              InkWell(
                onTap: () async {
                  await _homeLogic.pickAndCheck(
                    (value) {
                      setState(() {});
                    },
                  );
                },
                child: SizedBox(
                  height: context.sized.dynamicHeight(0.2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.greenAccent,
                      ),
                    ),
                    child: _homeLogic.selectedFileBytes != null
                        ? Image.memory(_homeLogic.selectedFileBytes!)
                        : const Icon(Icons.add_a_photo_outlined),
                  ),
                ),
              ),
              const _EmptySizeBox(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize:
                      Size.fromHeight(WidgetSize.buttonNormal.value.toDouble()),
                ),
                onPressed: !_homeLogic.isValidateAllForm
                    ? null
                    : () async {
                        changeLoading();
                        final response = await _homeLogic.save();
                        changeLoading();
                        if (!mounted) return;
                        await context.route.pop<bool>(response);
                      },
                icon: const Icon(Icons.send),
                label: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySizeBox extends StatelessWidget {
  const _EmptySizeBox();

  @override
  Widget build(BuildContext context) {
    return context.sized.emptySizedHeightBoxLow;
  }
}

class _HomeCategoryDropDown extends StatelessWidget {
  const _HomeCategoryDropDown({
    required this.categories,
    required this.onSelected,
  });
  final List<CategoryModel> categories;
  final ValueSetter<CategoryModel> onSelected;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryModel>(
      validator: (value) => value == null ? 'Not empty' : null,
      items: categories.map((e) {
        return DropdownMenuItem<CategoryModel>(
          value: e,
          child: Text(e.name ?? ''),
        );
      }).toList(),
      hint: const Text('Select Category'),
      onChanged: (value) {
        if (value == null) return;
        onSelected.call(value);
      },
    );
  }
}

mixin Loading on State<HomeCreateView> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
