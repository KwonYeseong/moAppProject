class IntroItem {
  IntroItem({
    this.title,
    this.category,
    this.imageUrl,
    this.description,
    this.renttype,

  });

  final String title;
  final String category;
  final String imageUrl;
  final String description;
  final int renttype;
}

final sampleItems = <IntroItem>[
  new IntroItem(title: 'Writing things together is what we do best!', renttype : 0, category: 'Short Term', description: '1day~1month', imageUrl: 'https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-projects-1541923105131_WE.jpg/1536/none',),
  new IntroItem(title: 'Occasionally wearing pants is a good idea.', renttype : 1, category: 'Long Term', description: '1month~',imageUrl: 'https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-1542689856158_bsyCpl.jpg/1700/1700',),
  new IntroItem(title: 'We might have the best team spirit ever.', renttype : 2, category: 'Tranfer room', description: '집 양도',imageUrl: 'https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-1542621980_107096_1.jpg/1700/1700',),
];