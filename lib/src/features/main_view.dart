import 'package:flu_fire_auth/src/features/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/features/sample_feature/sample_item_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'bottom_navigation/controller/bottom_navigation_cubit.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  static const String routeName = "/main_view";

  static Page page() => const MaterialPage<void>(child: MainView());

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: Colors.white,
        navigationBar: const CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text('iOS13 Modal Presentation'),
        ),
        child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
          builder: (context, state) {
            if (state is PageOneLoaded) {
              return const SampleItemListView();
            }
            if (state is PageTwoLoaded) {
              return Container();
            }
            if (state is PageThreeLoaded) {
              return Container();
            }
            if (state is PageFourLoaded) {
              return Container();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            context.select((BottomNavigationCubit bloc) => bloc.currentIndex),
        onTap: (index) {
          context.read<BottomNavigationCubit>().pageTapped(index, context);
        },
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        selectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(TablerIcons.home_2),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(TablerIcons.notebook),
              ),
              label: "Book"),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(TablerIcons.heart_broken),
            ),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(TablerIcons.menu_2),
            ),
            label: "More",
          ),
        ],
      ),
    );
  }
}


class ModalWithNavigator extends StatelessWidget {
  const ModalWithNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context2) => Builder(
            builder: (context) => CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                leading: Container(),
                middle: const Text('More Option'),
              ),
              child: SafeArea(
                bottom: false,
                child: NestedScrollView(
                  controller: ScrollController(),
                  physics: const ScrollPhysics(parent: PageScrollPhysics()),
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(height: 300, color: Colors.blue),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: ListView(
                    shrinkWrap: true,
                    controller: ModalScrollController.of(context),
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            context.read<AuthenticationCubit>().logoutRequested();
                            // Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
