import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/boarding_model.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/boarding/boarding_state.dart';
import 'package:ibn_khaldun/core/app_path.dart';
import 'package:translator/translator.dart';

class BoardingCubit extends Cubit<BoardingState> {
  BoardingCubit() : super(InitialBoardingState()) {
    circleValue = 1 / boardings.length;
  }

  List<BoardingModel> boardings = [
    BoardingModel(
      image: AppPath.boardImage1,
      title: 'Online Study is the',
      subtitle: 'Best choice for everyone.',
    ),
    BoardingModel(
      image: AppPath.boardImage2,
      title: 'Best platform for both',
      subtitle: 'Teachers & Learners',
    ),
    BoardingModel(
      image: AppPath.boardImage3,
      title: 'Learn Anytime, Anywhere.',
      subtitle: 'Accelerate Your Future and beyond.',
    ),
  ];
  double circleValue = 0;
  int currentIndex = 0;

  void trans() async {
    var translator = GoogleTranslator();
    for (int i = 0; i < boardings.length; i++) {
      BoardingModel model = boardings[i];
      var title = await translator.translate(model.title, from: 'en', to: 'ar');
      var subtitle =
          await translator.translate(model.subtitle, from: 'en', to: 'ar');
      boardings[i] = BoardingModel(
          image: model.image, title: title.text, subtitle: subtitle.text);
    }
    emit(TransBoardingState());
  }

  void next() {
    if (currentIndex == boardings.length - 1) {
      emit(EndBoardingState());
      return;
    }
    emit(NextBoardingState());
  }

  void changeValue(int index) {
    currentIndex = index;
    circleValue = (index + 1) / boardings.length;
    emit(ChangeValueBoardingState());
  }
}
