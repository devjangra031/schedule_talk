inputs = {"Writing Fast Tests Against Enterprise Rails" => "60",
"Overdoing it in Python" => "45",
"Lua for the Masses" => "30",
"Ruby Errors from Mismatched Gem Versions" => "45",
"Common Ruby Errors" => "45",
"Rails for Python Developers" => "60",
"Communicating Over Distance" => "60",
"Accounting-Driven Development" => "45",
"Woah" => "30",
"Sit Down and Write" => "30",
"Pair Programming vs Noise" => "45",
"Rails Magic" => "60",
"Ruby on Rails: Why We Should Move On" => "60",
"Clojure Ate Scala (on my project)" => "45",
"Programming in the Boondocks of Seattle" => "30",
"Ruby vs. Clojure for Back-End Development" => "30",
"Ruby on Rails Legacy App Maintenance" => "60",
"A World Without HackerNews" => "30",
"User Interface CSS in Rails Apps" => "30",
"Networking Event" => "30" }



def schedule_talk_method(inputs)
  schedule_talks = {}
  all_schedule_talks = {}

  lunch_start_time = Time.parse("12:00:00")
  lunch_end_time = Time.parse("13:00:00")
  networking_start_time = Time.parse("17:00:00")

  talk_start_time = Time.parse("09:00")
  talk_end_time = Time.parse("09:00")

  inputs.each do |talk_name, talk_time|
    networking = false
    talk_end_time = (talk_start_time + talk_time.to_i.minutes)

    if (talk_name == "Networking Event")
      networking = true
    end

    if (talk_end_time <= lunch_start_time && !networking)
      schedule_talks[talk_start_time] = talk_name
    elsif (talk_end_time > lunch_start_time && talk_end_time < lunch_end_time && !networking)
      talk_start_time = lunch_end_time
      schedule_talks[lunch_start_time] = "Lunch"
      schedule_talks[talk_start_time] = talk_name
      talk_end_time = (talk_start_time + talk_time.to_i.minutes)

    elsif (talk_end_time >= lunch_end_time && !networking && talk_end_time <= networking_start_time)
      schedule_talks[talk_start_time] = talk_name
    elsif (networking && talk_end_time > networking_start_time)
      schedule_talks[networking_start_time] = talk_name
    elsif (!networking && talk_end_time > networking_start_time)

      all_schedule_talks["track_#{all_schedule_talks.count + 1}"] = schedule_talks

      talk_start_time = Time.parse("09:00")
      talk_end_time = (talk_start_time + talk_time.to_i.minutes)
      schedule_talks = {}

      schedule_talks[talk_start_time] = talk_name
    end

    talk_start_time = talk_end_time
  end

  puts all_schedule_talks
end

schedule_talk_method(inputs)
