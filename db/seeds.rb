puts "🌱 Seeding data..."

Entry.destroy_all
Milestone.destroy_all
Child.destroy_all

milestones = [
  { title: "First Smile", milestone_type: "Emotional" },
  { title: "First Steps", milestone_type: "Physical" },
  { title: "First Word", milestone_type: "Language" },
  { title: "Rolled Over", milestone_type: "Physical" },
  { title: "Slept Through Night", milestone_type: "Sleep" },
  { title: "First Solid Food", milestone_type: "Feeding" },
  { title: "Crawled", milestone_type: "Physical" },
  { title: "Sat Up", milestone_type: "Physical" },
  { title: "First Tooth", milestone_type: "Health" },
  { title: "Started Daycare", milestone_type: "Social" },
].map { |data| Milestone.create!(data) }

children = [
  { name: "Lincoln", birthdate: "2023-09-15" },
  { name: "Sage", birthdate: "2022-12-04" },
  { name: "Rowan", birthdate: "2021-06-23" },
  { name: "Avery", birthdate: "2020-11-10" },
  { name: "Kai", birthdate: "2024-02-28" },
  { name: "Zion", birthdate: "2023-03-19" },
  { name: "Juniper", birthdate: "2022-05-30" },
  { name: "River", birthdate: "2021-08-12" },
  { name: "Ellis", birthdate: "2020-01-05" },
  { name: "Wren", birthdate: "2019-10-16" },
  { name: "Oakley", birthdate: "2022-09-03" },
  { name: "Finley", birthdate: "2021-03-21" },
].map { |data| Child.create!(data) }

entry_notes = [
  "Giggled for the first time while playing peekaboo!",
  "Pulled up to stand by the couch — so proud!",
  "Said 'mama' today 🥹",
  "Ate mashed avocado and made a hilarious face.",
  "Rolled over completely unassisted!",
  "Woke up smiling and talking to the mobile.",
  "Held bottle independently.",
  "Waved bye-bye at grandma!",
  "Bit sibling with new tooth (oops)",
  "Slept through the night for 6 hours!",
  "Said 'uh-oh' and meant it.",
  "Stacked blocks on their own!",
  "Clapped during a song!",
  "Gave first intentional hug 💕",
  "Started crawling today!",
  "Tried banana for the first time",
  "Took two wobbly steps between the couch and table!",
  "Said 'doggy' while pointing at ours",
  "First day at daycare went smoothly!",
  "Sat up in crib when we walked in this morning.",
  "Had a fever but handled it like a champ",
  "Grabbed a spoon and tried to feed themself!",
  "Learned to blow kisses 💋",
  "Recognized self in mirror",
  "Pointed at the moon and said 'ball!'",
]

entries = entry_notes.each_with_index.map do |note, i|
  child = children.sample
  milestone = milestones.sample

  Entry.create!(
    note: note,
    date: (child.birthdate.to_date + rand(60..500).days),
    age_months: rand(2..24),
    child_id: child.id,
    milestone_id: milestone.id
  )
end

puts "✅ Done seeding!"
