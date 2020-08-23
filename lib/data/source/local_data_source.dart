/// This class provides access to data stored locally in the device.
/// For now, all available data is cached in memory.
class LocalDataSource {
  LocalDataSource._();

  // TODO: Treat strange names, ponctuations, long names, null, and empty value.
  /// Returns a cached list of dummy contacts
  static const List<String> contacts = [
    'Adi Shamir',
    'Alan Kay',
    'Andrew Yao',
    'Barbara Liskov',
    'Kristen Nygaard',
    'Leonard Adleman',
    'Leslie Lamport',
    'Ole-Johan Dahl',
    'Peter Naur',
    'Robert E. Kahn',
    'Ronald L. Rivest',
    'Vinton G. Cerf',
  ];
}
