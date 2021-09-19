import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../main_view.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(PageLoading());

  int currentIndex = 0;

  void pageTapped(int index, BuildContext context) async {
    currentIndex = index;
    print('current index::::::: ==> $currentIndex');
    if (index == 0) {
      emit(PageOneLoaded());
    } else if (index == 1) {
      emit(PageTwoLoaded());
    } else if (index == 2) {
      emit(PageThreeLoaded());
    } else {
      emit(PageFourLoaded());
    }
  }
}
