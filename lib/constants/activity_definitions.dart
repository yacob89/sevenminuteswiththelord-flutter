import '../models/activity_data.dart';

class ActivityDefinitions {
  static List<ActivityData> getActivities() {
    return [
      ActivityData(
        id: 'calling',
        title: 'Calling',
        description: 'Calling on the Name of the Lord to set our mind on the spirit – 1 Cor.12:3; Rom. 8:6; 10:12-13',
        durationInSeconds: 30,
      ),
      ActivityData(
        id: 'praying',
        title: 'Praying',
        description: 'Opening our heart, softening our heart and emptying ourselves. Telling Him that we love Him – 2 Cor. 3:16; Psa. 62:8',
        durationInSeconds: 60,
      ),
      ActivityData(
        id: 'prayReading',
        title: 'Pray-reading',
        description: 'Using our exercised spirit to pray over a verse or two. Turning the verses into a personal prayer – Eph. 6:17-18; 2 Tim. 3:16',
        durationInSeconds: 150,
      ),
      ActivityData(
        id: 'confession',
        title: 'Confession',
        description: 'Confessing the sins and offenses on our conscience and removing all blockages to fellowship. Asking for forgiveness and cleansing – 1 John 1:7, 9; Psa. 66:18; Isa. 59:1-2',
        durationInSeconds: 60,
      ),
      ActivityData(
        id: 'consecration',
        title: 'Consecration',
        description: 'Presenting ourselves to the Lord afresh, giving Him the full ground in us – Rom. 12:1-2; 6:13,19; Mark 12:30',
        durationInSeconds: 30,
      ),
      ActivityData(
        id: 'thanksgiving',
        title: 'Thanksgiving',
        description: 'Giving thanks for all things; for all the persons, situations and things in your life and praising Him – Eph. 5:20; 1 Thes. 5:18',
        durationInSeconds: 30,
      ),
      ActivityData(
        id: 'petition',
        title: 'Petition',
        description: 'Asking the Lord for needs, growth and persons that need salvation – 1 Tim. 2:1: Eph. 6:18; Matt. 7:7; Psa. 143:8',
        durationInSeconds: 60,
      ),
    ];
  }
}