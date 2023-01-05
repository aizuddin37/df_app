part of 'contacts_cubit.dart';

class ContactsState extends AppState {
  final List<User>? user;

  ContactsState({
    required bool isLoading,
    required bool isInitialize,
    required this.user,
  }) : super(isLoading: isLoading, isInitialize: isInitialize);

  copyWith({bool? isLoading, bool? isInitialize, List<User>? user}) {
    return ContactsState(
        isLoading: isLoading ?? this.isLoading,
        isInitialize: isInitialize ?? this.isInitialize,
        user: user ?? this.user);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, isInitialize, user];
  popUpDialog({bool? isLoading}) => ConfirmationDialogState(
      isInitialize: isInitialize,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user);
}

class ConfirmationDialogState extends ContactsState {
  ConfirmationDialogState({
    required List<User>? user,
    required bool isLoading,
    required bool isInitialize,
  }) : super(user: user, isLoading: isLoading, isInitialize: isInitialize);
}
