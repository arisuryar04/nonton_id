import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constant/assets.dart';
import '../../../../core/constant/color.dart';
import '../../../../domain/entities/user.dart';
import '../../../bloc/bloc.dart';

Widget avatarUpdateProfile({
  void Function()? onTap,
  XFile? imagePicker,
}) {
  return BlocSelector<UserBloc, UserState, User>(
    selector: (state) {
      return state.user!;
    },
    builder: (context, state) {
      return GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 60,
          backgroundImage: imagePicker != null
              ? FileImage(File(imagePicker.path))
              : state.photoUrl != null
                  ? NetworkImage(state.photoUrl!)
                  : const AssetImage(Assets.profilePlaceholder),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: black.withOpacity(0.5),
              ),
              const Center(
                child: Text(
                  'Sentuh untuk\npilih foto',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
