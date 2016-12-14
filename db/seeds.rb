# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ambiances = Ambiance.create([
  { name: 'Bedroom', photo: 'http://img11.hostingpics.net/pics/265176bedroom.jpg' },
  { name: 'Living Room', photo: 'http://img11.hostingpics.net/pics/179811livingroom.jpg ' },
  { name: 'Kitchen', photo: 'http://img11.hostingpics.net/pics/761874kitchen.jpg ' },
  { name: 'Bathroom', photo: 'http://img11.hostingpics.net/pics/540540bathroom.jpg' },
  { name: 'Dining Room', photo: 'http://img11.hostingpics.net/pics/280674diningroom.jpg  ' },
  { name: 'Children', photo: 'https://images.pexels.com/photos/205323/pexels-photo-205323.png?w=940&h=650&auto=compress&cs=tinysrgb' },
  { name: 'Study', photo: 'http://img11.hostingpics.net/pics/578580study.jpg' },
  { name: 'Appliances', photo: 'https://images.pexels.com/photos/213162/pexels-photo-213162.jpeg?w=940&h=650&auto=compress&cs=tinysrgb'  },
  { name: 'Outdoor', photo: 'https://images.pexels.com/photos/197129/pexels-photo-197129.jpeg?w=940&h=650&auto=compress&cs=tinysrgb' },
  { name: 'Other', photo: 'https://images.pexels.com/photos/246327/pexels-photo-246327.jpeg?w=940&h=650&auto=compress&cs=tinysrgb' }
  ])
