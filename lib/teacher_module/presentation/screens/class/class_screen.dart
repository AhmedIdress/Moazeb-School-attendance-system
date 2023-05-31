import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/app_path.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/extensions_helper.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/children_screen/child_screen/child_screen.dart';
import 'package:ibn_khaldun/teacher_module/presentation/controllers/classes_cubit/classes_cubit.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key, required this.className}) : super(key: key);
  final String className;

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ClassesCubit>(context);
    cubit.getData(widget.className);

    return BlocConsumer<ClassesCubit, ClassesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ClassesInitialState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: getLang(context, 'search'),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return cubit.children.data != null
                      ? cubit.children.data!.where((item) => item.name
                          .toLowerCase()
                          .contains(pattern.toLowerCase()))
                      : cubit.children.data ??
                          cubit.children.data!.where((item) => item.name
                              .toLowerCase()
                              .contains(pattern.toLowerCase()));
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.name),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  context.push(ChildScreen(id: suggestion.id));
                },
              ),
            ),
            body: ListView.separated(
              itemCount: cubit.children.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    context.push(
                        ChildScreen(id: cubit.children.data?[index].id ?? ''));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(AppPath.hima),
                    ),
                    title: Text(cubit.children.data?[index].name ?? ''),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s16w),
                  child: const Divider(),
                );
              },
            ),
          );
        }
      },
    );
  }
}
