# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Card.destroy_all
Hand.destroy_all

ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
suits = [ "hearts", "spades", "clubs", "diamonds" ]

def build_deck ranks, suits
  ranks.each do |rank|
    suits.each do |suit|
      Card.create!(value: rank, suit: suit, img: "#{suit[0]}0#{rank}.png")
    end
  end
end

build_deck ranks, suits
