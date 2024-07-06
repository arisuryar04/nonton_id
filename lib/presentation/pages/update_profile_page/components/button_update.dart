import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../../domain/entities/entities.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';

Widget buttonUpdate({
  required String name,
  required XFile? imagePicker,
  void Function()? resetImagePicker,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == StatusUser.success) {
          resetImagePicker?.call();
          context.showSnackbar('Berhasil di perbarui');
        } else if (state.status == StatusUser.failed) {
          context.showSnackbar(state.message ?? '');
        }
      },
      builder: (context, state) {
        final user = state.user;
        return ButtonCustom(
          title: state.status == StatusUser.loading ? 'Tunggu...' : 'Perbarui',
          onPressed: state.status == StatusUser.loading
              ? null
              : () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (name != state.user?.name &&
                      RegExp(r"\s").hasMatch(name)) {
                    context.read<UserBloc>().add(
                          OnUpdateProfileUser(User(
                              uid: user?.uid,
                              balance: user?.balance,
                              createdAt: user?.createdAt,
                              email: user?.email,
                              name: name,
                              photoUrl: user?.photoUrl)),
                        );
                  } else if (imagePicker != null) {
                    context.read<UserBloc>().add(
                          OnUploadProfilePicture(
                            state.user!.uid!,
                            File(imagePicker.path),
                            name,
                          ),
                        );
                  } else {
                    context.showSnackbar('Tidak ada yang di update');
                  }
                },
        );
      },
    ),
  );
}
