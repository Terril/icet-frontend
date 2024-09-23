
enum Rating {
  pass("pass"), fail("fail"), unsure("unsure"), mediocre("mediocre"), na("not applicable");

  final String name;
  const Rating(this.name);
}
