import 'package:bloc/bloc.dart';
import '../../data/models/patin_electrico_model.dart';
import '../../data/repository/patin_electrico_repo.dart';
import 'patin_electrico_state.dart';

class PatinCubit extends Cubit<PatinElectricoState> {
  final PatinElectricoRepository patinRepository;

  PatinCubit({required this.patinRepository}) : super(PatinElectricoInitial());

    Future<void> fetchPatinElectricos() async {
        try {
        emit(PatinElectricoLoading());
        final patinElectricos = await patinRepository.fetchPatinElectricos();
        emit(PatinElectricoLoaded(patinElectricos: patinElectricos));
        } catch (e) {
        emit(PatinElectricoError(message: e.toString()));
        }
    }

    Future<void> fetchPatinElectrico(String id) async {
        try {
        emit(PatinElectricoLoading());
        final patinElectrico = await patinRepository.fetchPatinElectrico(id);
        emit(PatinElectricoLoaded(patinElectricos: [patinElectrico]));
        } catch (e) {
        emit(PatinElectricoError(message: e.toString()));
        }
    }

    Future<void> createPatinElectrico(PatinElectricoModel patinElectrico) async {
        try {
        emit(PatinElectricoLoading());
        await patinRepository.createPatinElectrico(patinElectrico);
        final patinElectricos = await patinRepository.fetchPatinElectricos();
        emit(PatinElectricoLoaded(patinElectricos: patinElectricos));
        } catch (e) {
        emit(PatinElectricoError(message: e.toString()));
        }
    }

    Future<void> updatePatinElectrico(PatinElectricoModel patinElectrico) async {
        try {
        emit(PatinElectricoLoading());
        await patinRepository.updatePatinElectrico(patinElectrico);
        final patinElectricos = await patinRepository.fetchPatinElectricos();
        emit(PatinElectricoLoaded(patinElectricos: patinElectricos));
        } catch (e) {
        emit(PatinElectricoError(message: e.toString()));
        }
    }

    Future<void> deletePatinElectrico(String id) async {
        try {
        emit(PatinElectricoLoading());
        await patinRepository.deletePatinElectrico(id);
        final patinElectricos = await patinRepository.fetchPatinElectricos();
        emit(PatinElectricoLoaded(patinElectricos: patinElectricos));
        } catch (e) {
        emit(PatinElectricoError(message: e.toString()));
        }
    }

}