import 'package:flutter/material.dart';
import 'package:nonton_id/presentation/bloc/bloc.dart';

import '../../../core/constant/assets.dart';
import '../../../core/constant/color.dart';
import '../../widgets/navbar_custom.dart';
import '../user_page/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNavbar = 0;
  List itemNavbar = [
    {
      'title': 'Home',
      'icon': Assets.home,
      'selected': Assets.homeSelected,
      'page': const Center(
        child: Text(
          'Movie',
          style: TextStyle(color: white),
        ),
      ),
    },
    {
      'title': 'Favorite',
      'icon': Assets.watchlist,
      'selected': Assets.watchlistSelected,
      'page': const Center(
        child: Text(
          'Favorite',
          style: TextStyle(color: white),
        ),
      ),
    },
    {
      'title': 'Ticket',
      'icon': Assets.ticket,
      'selected': Assets.ticketSelected,
      'page': const Center(
        child: Text(
          'Ticket',
          style: TextStyle(color: white),
        ),
      ),
    },
    {
      'title': 'Akun',
      'icon': Assets.user,
      'selected': Assets.userSelected,
      'page': const UserPage(),
    },
  ];

  @override
  void initState() {
    final uid = context.read<LoginBloc>().state.uid;
    context.read<UserBloc>().add(OnGetUser(uid!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          itemNavbar[_selectedNavbar]['page'],
          NavbarCustom(
            itemNavbar: itemNavbar,
            selectedItem: _selectedNavbar,
            onTap: (index) => setState(() {
              _selectedNavbar = index;
            }),
          ),
        ],
      ),
    );
  }
}
