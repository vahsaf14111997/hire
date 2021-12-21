# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create({ name: "Admin", email: "admin@example.com", mobile: "8524321285", password: "spritle123", user_type: "admin" })

tags = [{
  question_tag: "numerical_reasoning",
  count: 10
}, {
  question_tag: "attention_to_details",
  count: 10
}, {
  question_tag: "critical_thinking",
  count: 10
}, {
  question_tag: "verbal_reasoning",
  count: 10
}]

Test.create({
  name: "Test Name 1",
  total_time: 1,
  tags: tags.to_json,
  status: "active"
})
