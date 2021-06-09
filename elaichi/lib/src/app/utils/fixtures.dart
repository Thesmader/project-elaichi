import 'package:elaichi/datamodels.dart';

/// Fake data fixtures for UI and tests.
class Fixtures {
  /// Poster for stories.
  static const String posterLink = 'https://i.ibb.co/bsbBcnc/dt-poster.jpg';

  /// Club logo.
  static const String dtLogoLink = 'https://i.ibb.co/7gqwzGM/dt-logo.png';

  /// Fake story.
  static final story = CurrentStory(
      id: '1',
      club: club,
      event: event,
      assetType: 'picture',
      createdAt: DateTime(2021, 1, 31),
      asset: posterLink,
      description: 'description');

  /// Fake club
  static final club = Club(
    clubName: 'DesignTab',
    id: '1',
    facAd: 'Prof. ABC',
    society: 'Technical Society',
    domain: 'desgintab.com',
    theme: ViewTheme(
      backgroundColor: '2D3077',
      logo: dtLogoLink,
      name: 'DesignTab',
    ),
    contactInfo: [],
    description: '',
    members: [],
  );

  /// Fake event
  static final event = Event(
    organizer: club,
    endDateTime: DateTime.now(),
    otherDescription: '''
The next outstanding show is Monday March 23rd at 8pm.
The Comedy Cabaret offers a Laffy Raffy Raffle.''',
    attendees: userList(7),
    startDateTime: DateTime.now(),
    announcements: '',
    picture: '',
    id: '',
    location: '',
    eventName: '',
    registrationPrice: 0,
    registrationCount: 0,
    link: '',
  );

  /// Fake user
  static final user =
      User(email: 'john@doe.com', name: 'John Doe', userId: '1');

  /// Generates a fake list of [count] users.
  static List<User> userList(int count) =>
      List.generate(count, (index) => user);

  /// Generates a fake list of current stories.
  static List<CurrentStory> storyList(int count) =>
      List.generate(count, (index) => story);

  ///Generates a fake list of events.
  static List<Event> eventList(int count) =>
      List.generate(count, (index) => event);
}
