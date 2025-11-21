import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/purchase/blocs/get_purchase/get_purchase_event.dart';
import 'package:oss_frontend/features/purchase/blocs/get_purchase/get_purchase_state.dart';
import 'package:oss_frontend/features/purchase/models/res/add_purchase_response_model.dart';
import 'package:oss_frontend/features/purchase/repositories/get_purchase_remote_repository.dart';

class GetPurchaseBloc extends Bloc<GetPurchaseEvent, GetPurchaseState> {
  final GetPurchaseRemoteRepository _getPurchaseRemoteRepository;

  List<PurchaseData> _allPurchases = [];
  int _currentPage = 1;
  int _totalPages = 1;
  String? _currentSearch;
  bool _isLoadingMore = false;

  GetPurchaseBloc(this._getPurchaseRemoteRepository)
    : super(GetPurchaseInitialState()) {
    on<GetPurchaseSubmittedEvent>((event, emit) async {
      emit(GetPurchaseLoadingState());
      try {
        _currentPage = 1;
        _currentSearch = event.search;
        _allPurchases = [];

        final response = await _getPurchaseRemoteRepository.getPurchases(
          search: event.search,
          page: _currentPage,
        );

        _allPurchases = response.purchases;
        _totalPages = response.totalPages;
        _currentPage = response.currentPage;

        emit(GetPurchaseSuccessState(_allPurchases));
      } catch (e) {
        emit(
          GetPurchaseFailureState(
            ErrorResponseModel(
              success: false,
              error: e.toString().replaceAll('Exception: ', ''),
            ),
          ),
        );
      }
    });

    on<GetPurchaseLoadMoreEvent>((event, emit) async {
      if (_isLoadingMore || _currentPage >= _totalPages) {
        return;
      }

      _isLoadingMore = true;
      emit(GetPurchaseMoreLoadingState(_allPurchases));

      try {
        final response = await _getPurchaseRemoteRepository.getPurchases(
          search: _currentSearch,
          page: _currentPage + 1,
        );

        _allPurchases.addAll(response.purchases);
        _currentPage = response.currentPage;
        _totalPages = response.totalPages;

        emit(GetPurchaseSuccessState(_allPurchases));
      } catch (e) {
        emit(GetPurchaseSuccessState(_allPurchases));
      } finally {
        _isLoadingMore = false;
      }
    });
  }
}
