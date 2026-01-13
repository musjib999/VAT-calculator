import 'package:get_it/get_it.dart';
import '../../features/calculator/data/repositories/calculator_repository_impl.dart';
import '../../features/calculator/domain/repositories/calculator_repository.dart';
import '../../features/calculator/domain/usecases/calculate_vat_usecase.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<CalculatorRepository>(
    () => CalculatorRepositoryImpl(),
  );

  locator.registerLazySingleton<CalculateVatUseCase>(
    () => CalculateVatUseCase(locator<CalculatorRepository>()),
  );
}
