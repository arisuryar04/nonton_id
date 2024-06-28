import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/assets.dart';
import '../../../core/constant/color.dart';
import '../../../core/extension/context_ext.dart';
import '../../../domain/entities/user.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';
import 'methods/avatar_update_profile.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late final _nameController = TextEditingController();
  late final _emailController = TextEditingController();
  late final _createdAtController = TextEditingController();

  XFile? _imagePicker;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserBloc>().state.user;
    _nameController.text = user!.name!;
    _emailController.text = user.email!;
    _createdAtController.text =
        DateFormat('EEEE, d MMMM y', 'id-ID').format(user.createdAt!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCustom(
              title: 'Perbarui Profile',
              rightChild: Image.asset(
                Assets.user,
                height: 24,
                width: 24,
                color: white,
              ),
            ),
            avatarUpdateProfile(
              imagePicker: _imagePicker,
              onTap: () async {
                final selected =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                selected != null
                    ? setState(() {
                        _imagePicker = selected;
                      })
                    : null;
              },
            ),
            verticalSpace(48),
            TextFieldEdited(
              controller: _nameController,
              label: 'Nama',
              isEnabled: true,
            ),
            verticalSpace(25),
            TextFieldEdited(
              controller: _emailController,
              label: 'Email',
            ),
            verticalSpace(25),
            TextFieldEdited(
              controller: _createdAtController,
              label: 'Di buat',
            ),
            verticalSpace(50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state.status == StatusUser.success) {
                    setState(() {
                      _imagePicker = null;
                    });
                    context.showSnackbar('Berhasil di perbarui');
                  } else if (state.status == StatusUser.failed) {
                    context.showSnackbar(state.message ?? '');
                  }
                },
                builder: (context, state) {
                  final user = state.user;
                  return ButtonCustom(
                    title: state.status == StatusUser.loading
                        ? 'Tunggu...'
                        : 'Perbarui',
                    onPressed: state.status == StatusUser.loading
                        ? null
                        : () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_nameController.text != state.user?.name &&
                                RegExp(r"\s").hasMatch(_nameController.text)) {
                              context.read<UserBloc>().add(
                                    OnUpdateProfileUser(User(
                                        uid: user?.uid,
                                        balance: user?.balance,
                                        createdAt: user?.createdAt,
                                        email: user?.email,
                                        name: _nameController.text,
                                        photoUrl: user?.photoUrl)),
                                  );
                            } else if (_imagePicker != null) {
                              context.read<UserBloc>().add(
                                    OnUploadProfilePicture(
                                      state.user!.uid!,
                                      File(_imagePicker!.path),
                                      _nameController.text,
                                    ),
                                  );
                            } else {
                              context.showSnackbar('Tidak ada yang di update');
                            }
                          },
                  );
                },
              ),
            ),
            verticalSpace(25),
          ],
        ),
      ),
    );
  }
}
