# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb
require 'faker'

# Custom basketball court names
BASKETBALL_COURT_NAMES = [
  'Main Street Court',
  'Riverside Park Court',
  'Downtown Arena',
  'Central Hoops',
  'Sunset Heights Gym'
].freeze

# Custom Biographies/Descriptions for players
PLAYER_BIOGRAPHIES = [
  "Looking to make some friends and play some ball!",
  "I like to play volleyball in my free time",
  "If you see me around playing, feel free to join",
  "Spiking and smiling my way through life!",
  "Passion for volleyball and positive vibes",
  "Sun, sand, and spike – that's my kind of day",
  "Serving up smiles on and off the court",
  "Bumping and setting my way to happiness",
  "Volleyball enthusiast seeking fellow players",
  "Hitting the court with energy and enthusiasm",
  "Diving for the ball and diving into fun",
  "Volleyball is my escape from the daily hustle",
  "Loving the game and the camaraderie it brings",
  "Setting, spiking, and savoring every moment",
  "Chasing the perfect serve and the perfect day",
  "Volleyball is my therapy and my passion",
  "Living for that perfect dig and that winning point",
  "Casual player with a competitive spirit",
  "Spike it like it's hot! Volleyball lover here",
  "Digging the game, spiking the fun",
  "Volleyball and laughter – my two constants",
  "Just a friendly player in love with the game",
  "Ace-ing serves and making memories",
  "Life's a game, and volleyball is my favorite level",
  "Serving up aces and good times",
  "Hitting the court with all my heart",
  "Passionate about volleyball and positivity",
  "Jumping, diving, and playing with heart",
  "Finding joy in every bump, set, and spike",
  "Embracing the net and the friendships it brings",
  "Volleyball is more than a game – it's a lifestyle",
  "Playing hard, laughing harder – that's my motto",
  "Spiking my way through challenges, on and off court",
  "Hustle, hit, repeat – volleyball life",
  "Serving up happiness, one match at a time",
  "Diving into every opportunity the game offers",
  "Hitting the sand or the court – count me in!",
  "Bumping, setting, and spreading good vibes",
  "Spike enthusiast with a passion for play",
  "Volleyball: where sweat and smiles meet",
  "Volleyball addict seeking more teammates",
  "Setting, spiking, and seizing the day",
  "Life is better with a volleyball in hand",
  "Chasing dreams and chasing after volleyballs",
  "Casual player, serious fun-seeker",
  "Digging the game and blocking out negativity",
  "Volleyball and good times – my priorities",
  "Playing with heart and a whole lot of hustle",
  "Ace-ing serves and making lifelong memories",
  "Diving for success on and off the court",
  "Volleyball: the game that sets me free",
  "Spike enthusiast and all-around good sport",
  "Passionate about diving for every ball and spreading positivity on the court.",
  "Spiking my way through challenges, one game at a time.",
  "Setting, serving, and savoring the thrill of competition.",
  "Bumping and blocking with a smile – that's how I roll!",
  "Digging the game, setting my goals high, and serving up my best.",
  "Jumping into every match with enthusiasm and a love for the game.",
  "Determined to bring my A-game to every serve, set, and spike.",
  "Hustle, teamwork, and a whole lot of heart on and off the court.",
  "Living for those intense rallies and the friendships they create.",
  "Serving up good vibes and great sportsmanship, one point at a time."
]

TEAM_NAMES = [
  "Spike Squad",
  "Sunset Spikers",
  "Joyful Diggers",
  "Smash Brothers",
  "Set and Smile",
  "Courtyard Champions",
  "Happy Hitters",
  "Net Ninjas",
  "Ace Dream Team",
  "Volleyball Ventures"
]

TEAM_DESCRIPTIONS = [
  "We're a bunch of volleyball enthusiasts who love playing and laughing together.",
  "Our team is all about spreading positive vibes and spiking our way to victory.",
  "Friends on and off the court, we're here to have a blast and make memories.",
  "We may be competitive, but our camaraderie is what truly sets us apart.",
  "Diversity, teamwork, and a love for the game define our close-knit squad.",
  "From serves to high fives, we bring energy and fun to every match we play.",
  "Teamwork makes the dream work, and we're living that dream with every set and spike.",
  "On this team, it's not just about winning; it's about enjoying every moment together.",
  "We're a team of dedicated players who are all about playing hard and supporting one another.",
  "Our team is a mix of skills, smiles, and sportsmanship, making every game a win-win."
]

PLAY_AREA_DESCRIPTIONS = [
  "Our volleyball court is a sandy paradise where players gather to bump, set, and spike their way to fun.",
  "Nestled in a scenic spot, our volleyball court is where friendships are formed and games are won.",
  "Welcome to our vibrant volleyball court, where the sun, sand, and serves create a perfect play environment.",
  "Step onto our well-maintained volleyball court where the excitement of the game meets the beauty of the outdoors.",
  "Our volleyball court is a hub of energy and enthusiasm, where players of all levels come together to enjoy the sport."
]

# Seed Players
players = []
60.times do
  players << Player.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    avatar_picture: Faker::LoremFlickr.image,
    description: PLAYER_BIOGRAPHIES.pop,
    elo_rating: Faker::Number.between(from: 1000, to: 2500)
  )
end

# Seed Teams
teams = []
# 5.times do
#   teams << Team.create!(
#     name: Faker::Sports::Football.team,
#     picture: Faker::LoremFlickr.image,
#     description: Faker::Lorem.paragraph
#   )
# end
10.times do
  teams << Team.create!(
    name: TEAM_NAMES.pop,
    picture: Faker::LoremFlickr.image,
    description: TEAM_DESCRIPTIONS.pop
  )
end

# Seed PlayAreas
play_areas = []
embedLinks = ['https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d166720.69967542592!2d-122.95311368575074!3d49.23828193350067!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x54867f24e780bc05%3A0xc828436e5100e4ee!2sRotary%20Centennial%20Beach%20Volleyball%20Courts%20(6)!5e0!3m2!1sen!2sca!4v1692045556052!5m2!1sen!2sca',
  'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d166752.48105471488!2d-123.05954373946165!3d49.22886629665694!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x5485dbdb3563485d%3A0x2e54d5f14a69a3f5!2sVolleyball%20Courts!5e0!3m2!1sen!2sca!4v1692045617133!5m2!1sen!2sca',
  'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d166747.9407624939!2d-123.14400113692257!3d49.23021149751479!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x5486715381c97bad%3A0x9aaeffa12000003a!2sMahon%20Park%20Beach%20Volleyball%20Court!5e0!3m2!1sen!2sca!4v1692045672421!5m2!1sen!2sca',
  'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d166769.12906401663!2d-123.22090543379758!3d49.2239335801419!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x548674e580398cd3%3A0x831d6a83b8692802!2sMarpole%20Public%20Beach%20Volleyball%20Courts!5e0!3m2!1sen!2sca!4v1692045689102!5m2!1sen!2sca',
  'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d166720.69967542592!2d-122.95311368575074!3d49.23828193350067!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x54867f24e780bc05%3A0xc828436e5100e4ee!2sRotary%20Centennial%20Beach%20Volleyball%20Courts%20(6)!5e0!3m2!1sen!2sca!4v1692045556052!5m2!1sen!2sca'
]
BASKETBALL_COURT_NAMES.each do |court_name|
  play_areas << PlayArea.create!(
    name: court_name,
    description: PLAY_AREA_DESCRIPTIONS.pop,
    image: Faker::LoremFlickr.image,
    num_courts: Faker::Number.between(from: 1, to: 5),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    net_height: Faker::Number.between(from: 0, to: 2),
    embedLink: embedLinks.pop,
    is_lined: [0,1].sample,
    is_public: [0,1].sample,
    has_rentals: [0,1].sample,
    has_restrooms: [0,1].sample,
  )
end

# Seed RosterRecords
players_for_roster = players.clone
teams.each do |team|
  # players.sample(5).each do |player|
  #   RosterRecord.create!(
  #     team: team,
  #     player: player,
  #     joined_at: Faker::Time.between(from: 2.years.ago, to: 1.year.ago),
  #     # left_at: [nil, Faker::Time.between(from: 1.year.ago, to: Date.today)].sample,
  #     left_at: nil,
  #     is_active: Faker::Boolean.boolean
  #   )
  # end
  5.times do
    this_player = players_for_roster.pop
      RosterRecord.create!(
        team: team,
        player: this_player,
        joined_at: Faker::Time.between(from: 2.years.ago, to: 1.year.ago),
        left_at: nil,
        is_active: Faker::Boolean.boolean
    )
  end
  retired_player = players_for_roster.pop
  RosterRecord.create!(
    team: team,
    player: retired_player,
    joined_at: Faker::Time.between(from: 2.years.ago, to: 1.year.ago),
    left_at: Faker::Time.between(from: 1.year.ago, to: Date.today),
    is_active: false
  )
end

# Method to create MatchRosters for a match
def create_match_rosters(match)
  match.winner_team.players.each do |player|
    MatchRoster.create!(
      match: match,
      team: match.winner_team,
      player: player
    )
  end
  match.other_team.players.each do |player|
    MatchRoster.create!(
      match: match,
      team: match.other_team,
      player: player
    )
  end
end

# Seed Matches
matches = 100.times.map do
  winner_team = teams.sample
  other_team = (teams - [winner_team]).sample
  {
    winner_team: winner_team,
    other_team: other_team,
    play_area: play_areas.sample,
    created_at: Faker::Time.between(from: 30.days.ago, to: Date.today),
    is_validated: Faker::Boolean.boolean,
    created_by: (winner_team.players + other_team.players).sample
  }
end

matches = Match.create!(matches)

# Seed MatchRosters for each match
matches.each do |match|
  create_match_rosters(match)
end

# Seed captains for each team
Team.all.each do |team|
  # Set captain_id for each team. Just using the first player of a team.
  captain = team.players.first
  team.update(captain: captain) if captain
end

# Demo-day specific setup.
# Add player_id 1 to some teams
RosterRecord.create!(
  team: Team.find_by_id(2),
  player: Player.first,
  joined_at: Faker::Time.between(from: 2.years.ago, to: 1.year.ago),
  left_at: nil,
  is_active: Faker::Boolean.boolean
)
RosterRecord.create!(
  team: Team.find_by_id(3),
  player: Player.first,
  joined_at: Faker::Time.between(from: 2.years.ago, to: 1.year.ago),
  left_at: nil,
  is_active: Faker::Boolean.boolean
)
RosterRecord.create!(
  team: Team.find_by_id(4),
  player: Player.first,
  joined_at: Faker::Time.between(from: 2.years.ago, to: 1.year.ago),
  left_at: nil,
  is_active: Faker::Boolean.boolean
)
RosterRecord.create!(
  team: Team.find_by_id(5),
  player: Player.first,
  joined_at: Faker::Time.between(from: 2.years.ago, to: 1.year.ago),
  left_at: nil,
  is_active: Faker::Boolean.boolean
)
Team.find_by_id(2).update(captain: Player.first)