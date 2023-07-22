import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/select_contacts/repository/select_contact_repository.dart';

final getContactProvider = FutureProvider(
  (ref) {
    final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
    return selectContactRepository.getContacts();
  },
);

final selectContactControllerProvider = Provider(
  (ref) {
    final selectContactRepository = ref.watch(
      selectContactsRepositoryProvider,
    );
    return SelectContactController(
      ref: ref,
      selectContactRepository: selectContactRepository,
    );
  },
);

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  SelectContactController({
    required this.ref,
    required this.selectContactRepository,
  });

  void selectContact(
    BuildContext context,
    Contact selectedContact,
  ) {
    selectContactRepository.selectContact(context, selectedContact);
  }
}
