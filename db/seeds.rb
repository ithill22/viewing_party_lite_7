# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all

@user_1 = User.create!(name: 'Billy Bob Thornton', email: 'billybob@turing.edu')
@user_2 = User.create!(name: 'Sandra Bullock', email: 'sandy@turing.edu')
@user_3 = User.create!(name: 'Tom Hanks', email: 'tom@turing.edu')
@user_4 = User.create!(name: 'Will Smith', email: 'will@turing.edu')