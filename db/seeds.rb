
# File.expand_path("app/assets/images/filename", __dir__)
# carrots = Category.create(title: "carrots", created_at: Time.now, image: "https://placekitten.com/200/200")
charms = Category.create(title: "Charms", created_at: Time.now, image: "luck-shamrock-horseshoe.png")
potions = Category.create(title: "Potions", created_at: Time.now, image: "felix_felicis.jpg")
clothes = Category.create(title: "Clothes", created_at: Time.now, image: "lucky_shirt.jpg")
weather = Category.create(title: "Weather", created_at: Time.now, image: "sunshine.png")

# Item.create(title: "carrots", description: "crunchy and orange", price: 999 , image: "https://s3.amazonaws.com/lucky2/cartoon_penny.png", categories: [Category.find_by(title: "carrots")])
Item.create(title: "Lucky Penny", description: "A shiny heads-up penny you found in the road!", price: 999 , image: "https://s3.amazonaws.com/lucky2/cartoon_penny.png", categories: [Category.find_by(title: "Charms")])

Item.create(title: "Horseshoe", description: "Keep the open side pointed up so the luck doesn't drain out!", price: 1499, image: "https://s3.amazonaws.com/lucky2/horseshoe.png", categories: [Category.find_by(title: "Charms")])

Item.create(title: "Maneki-Neko", description: "So lucky!", price: 999, image: "https://s3.amazonaws.com/lucky2/lucky_cat.png", categories: [Category.find_by(title: "Charms")])

Item.create(title: "Felix Felicis", description: "A luck-potion so powerful even it's placebo effects make you a better keeper!", price: 9999, image: "https://s3.amazonaws.com/lucky2/felix_felicis.jpg", categories: [Category.find_by(title: "Potions")])

Item.create(title: "Love Potion #9", description: "It won't force anyone to fall in love with you, that would be creepy, but it will make you luckier in love (if you're not creepy). 9th try at the formula. We're pretty sure we've got it right this time.", price: 9999, image: "https://s3.amazonaws.com/lucky2/love_potion_9.jpg", categories: [Category.find_by(title: "Potions")])

Item.create(title: "And the Crowd Goes Mild!", description: "Sometimes you just want to be able to make that shot with the wadded up paper in the trash can across the room. You won't make big bucks off this one, but you'll probably get chuckles of approval.", price: 4999, image: "https://s3.amazonaws.com/lucky2/mild_luck_potion.jpg", categories: [Category.find_by(title: "Potions")])

Item.create(title: "Lucky Pat Wey Jersey", description: "A game worn jersey from former NHL player, Pat Wey!", price: 29999 , image: "https://s3.amazonaws.com/lucky2/pat_wey_jersey.jpg", categories: [Category.find_by(title: "Clothes")])

Item.create(title: "Game Day Sock", description: "Worn by one fan during every home game played on a Thursday in the month of September, but only for night games - and his team won EVERY(both) TIME!", price: 1099, image: "https://s3.amazonaws.com/lucky2/lucky_game_socks.jpg", categories: [Category.find_by(title: "Clothes")])

Item.create(title: "Peyton Manning Tighty Whities", description: "We're not really sure how these were obtained. They sure smell like they were game-worn. Gotta be lucky, right?", price: 99999, image: "https://s3.amazonaws.com/lucky2/tighty_whities.jpg", categories: [Category.find_by(title: "Clothes")])

Item.create(title: "Uncatchable Leprechaun", description: "You're not having luck with the weather, but if you're inside, try to nab this little guy and get his gold!", price: 9999, image: "https://s3.amazonaws.com/lucky2/leprechaun_face.png", categories: [Category.find_by(title: "Weather")])

Item.create(title: "Pot O' Gold", description: "After a good rain, you were lucky enough to find the pot of gold at the end of the rainbow!", price: 99999, image: "https://s3.amazonaws.com/lucky2/pot_o_gold.png", categories: [Category.find_by(title: "Weather")])

Item.create(title: "Four-Leaf Clover", description: "The sun is shining so brightly that spotting this little guy wasn't a matter of luck!", price: 999, image: "https://s3.amazonaws.com/lucky2/four-leaf-clover.png", categories: [Category.find_by(title: "Weather")])

User.create(username: "johndoe", password: "password", role: 0, first_name: "John", last_name: "Doe", address: "1510 Blake Street")
User.create(username: "janedoe", password: "password", role: 0, first_name: "Jane", last_name: "Doe", address: "1511 Blake Street")
User.create(username: "user", password: "password", role: 0, first_name: "Tim", last_name: "Finnigan", address: "1234 Walker Street")
User.create(username: "admin", password: "password", role: 1, first_name: "Anon", last_name: "Ymous", address: "The cloud")
