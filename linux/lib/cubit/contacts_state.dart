part of 'contacts_cubit.dart';

class ContactsState extends AppState {
  final List<Userdata>? user;

  ContactsState({
    required bool isLoading,
    required bool isInitialize,
    required this.user,
  }) : super(isLoading: isLoading, isInitialize: isInitialize);

  copyWith({bool? isLoading, bool? isInitialize, List<Userdata>? user}) {
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

  popUpMessage({bool? isLoading}) => MessageDialogState(
      isInitialize: isInitialize,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user);
}

class ConfirmationDialogState extends ContactsState {
  ConfirmationDialogState({
    required List<Userdata>? user,
    required bool isLoading,
    required bool isInitialize,
  }) : super(user: user, isLoading: isLoading, isInitialize: isInitialize);
}

class MessageDialogState extends ContactsState {
  MessageDialogState({
    required List<Userdata>? user,
    required bool isLoading,
    required bool isInitialize,
  }) : super(user: user, isLoading: isLoading, isInitialize: isInitialize);
}
