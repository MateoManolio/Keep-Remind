import 'data_status.dart';

class DataState<T> {
  final T? data;
  final String? error;
  final DataStatus status;

  DataState({this.data, this.error, required this.status});

  factory DataState.initial() => DataState(status: DataStatus.initial);
  factory DataState.loading() => DataState(status: DataStatus.loading);
  factory DataState.success(T? data) =>
      DataState(data: data, status: DataStatus.success);
  factory DataState.error(String? error) =>
      DataState(error: error, status: DataStatus.error);
  factory DataState.empty() => DataState(status: DataStatus.empty);
}
