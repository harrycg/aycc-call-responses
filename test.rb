

require 'nationbuilder'

client = NationBuilder::Client.new('harrycossar', ENV['NATIONBUILDER_APIKEY'], retries: 8)

puts "finding peeps step 1"

filter_all = {
  tag: "another"
  }
  
all_contacts = client.call(:people_tags, :people, filter_all)
all_contacts_2 = NationBuilder::Paginator.new(client, all_contacts)


all_contacts_people = []
  all_contacts_people += all_contacts_2.body['results']
while all_contacts_2.next?
  all_contacts_2 = all_contacts_2.next
  all_contacts_people += all_contacts_2.body['results']
 
end  

all_contacts_people.each do |all_contacts_people|
  tagged_id_all = all_contacts_people['id']
  
filter_all_2 = {
  person_id: "#{tagged_id_all}",
    status: "no_answer",

  }

contacts_1 = client.call(:contacts, :index, filter_all_2)
  contacts_2 = NationBuilder::Paginator.new(client, contacts_1)

  
contacts_3 = []
  contacts_3 += contacts_2.body['results']

 while contacts_2.next?
  contacts_2 = contacts_2.next
  contacts_3 += contacts_2.body['results']

end  

   count1= contacts_3.count
  puts "#{count1} No Answers"
  
  filter_all_3 = {
  "person": {
  "no_answer_no": "#{count1}",
     "id": "#{tagged_id_all}",
  }
}
  
  
  puts " hello#{tagged_id_all}"
     

    
  
contacts_3.each do |contacts_4|
  
  email = contacts_4['email']
    
  id4 = contacts_4['person_id']
 
  
puts "#{id4}" 

end
  
  client.call(:people, :push, filter_all_3)

end

filter = {
  tag: "ONBOARDING%20STEP%202"
  }
  
info = client.call(:people_tags, :people, filter)
info_2 = NationBuilder::Paginator.new(client, info)


tagged_people = []
  tagged_people += info_2.body['results']
while info_2.next?
  info_2 = info_2.next
  tagged_people += info_2.body['results']
 
end  

tagged_people.each do |tagged_person|
  tagged_id = tagged_person['id']
yesterday_1 =  DateTime.now - 1
  
filter = {
  person_id: "#{tagged_id}",
  status: "no_answer"
  }

response = client.call(:contacts, :index, filter)

page = NationBuilder::Paginator.new(client, response)

people = []
  people += page.body['results']

 while page.next?
  page = page.next
  break unless Date.parse(people.last['created_at']) >= yesterday_1
  people += page.body['results']
 
 
end  

people.each do |person|
  if Date.parse(person['created_at']) >= yesterday_1  
  
  email = person['email']
    first_name = person['first_name']
    last_name = person['last_name']
  id = person['person_id']
  status=person['status']
contactedon=person['created_at']
puts "#{first_name} #{id} #{status} on #{contactedon}" 
  
   
    params = {
 id: "#{id}",
  tagging: {
    tag: "ONBOARDING STEP 3"
  }
  
}

    client.call(:people, :tag_person , params)
    
  else  
  id = person['person_id']
 contactedon=person['created_at']
  status=person['status']

puts "too late #{first_name} #{id} #{status} on #{contactedon}" 
    
end

end

end

puts "Onboarding step 2 done"

puts "finding peeps step 1"

filter = {
  tag: "ONBOARDING%20STEP%201"
  }
  
info = client.call(:people_tags, :people, filter)
info_2 = NationBuilder::Paginator.new(client, info)


tagged_people = []
  tagged_people += info_2.body['results']
while info_2.next?
  info_2 = info_2.next
  tagged_people += info_2.body['results']
 
end  

tagged_people.each do |tagged_person|
  tagged_id = tagged_person['id']
yesterday_1 =  DateTime.now - 1
  
filter = {
  person_id: "#{tagged_id}",
  status: "no_answer"
  }

response = client.call(:contacts, :index, filter)

page = NationBuilder::Paginator.new(client, response)

people = []
  people += page.body['results']

 while page.next?
  page = page.next
  break unless Date.parse(people.last['created_at']) >= yesterday_1
  people += page.body['results']
 
 
end  

people.each do |person|
  if Date.parse(person['created_at']) >= yesterday_1  
  
  email = person['email']
    first_name = person['first_name']
    last_name = person['last_name']
  id = person['person_id']
  status=person['status']
contactedon=person['created_at']
puts "#{first_name} #{id} #{status} on #{contactedon}" 
  
   
    params = {
 id: "#{id}",
  tagging: {
    tag: "ONBOARDING STEP 2"
  }
  
}

    client.call(:people, :tag_person , params)
    
  else  
  id = person['person_id']
 contactedon=person['created_at']
  status=person['status']

puts "too late #{first_name} #{id} #{status} on #{contactedon}" 
    
end

end

end

puts "Onboarding step 1 done"

puts "finding peeps step 1"

filter = {
  tag: "another"
  }
  
info = client.call(:people_tags, :people, filter)
info_2 = NationBuilder::Paginator.new(client, info)


tagged_people = []
  tagged_people += info_2.body['results']
while info_2.next?
  info_2 = info_2.next
  tagged_people += info_2.body['results']
 
end  

tagged_people.each do |tagged_person|
  tagged_id = tagged_person['id']
yesterday_1 =  DateTime.now - 1
  
filter = {
  person_id: "#{tagged_id}",
  status: "no_answer"
  }

response = client.call(:contacts, :index, filter)

page = NationBuilder::Paginator.new(client, response)

people = []
  people += page.body['results']

 while page.next?
  page = page.next
  break unless Date.parse(people.last['created_at']) >= yesterday_1
  people += page.body['results']
 
 
end  

people.each do |person|
  if Date.parse(person['created_at']) >= yesterday_1  
  
  email = person['email']
    first_name = person['first_name']
    last_name = person['last_name']
  id = person['person_id']
  status=person['status']
contactedon=person['created_at']
puts "#{first_name} #{id} #{status} on #{contactedon}" 
  
   
    params = {
 id: "#{id}",
  tagging: {
    tag: "ONBOARDING STEP 1"
  }
  
}

    client.call(:people, :tag_person , params)
    
  else  
  id = person['person_id']
 contactedon=person['created_at']
  status=person['status']

puts "too late #{first_name} #{id} #{status} on #{contactedon}" 
    
end

end

end

puts "Onboarding want to vols done"


=begin
yesterday_1 =  DateTime.now - 1
  puts "yesterday_1 was #{yesterday_1}"
  now= DateTime.now
  puts "#{now}"
puts "#{people}"
puts "#{count}"

count= people.count
  count=person.count  

filter = {
  tag: "is:%20awesome%20core%202018"
  }
  
response = client.call(:people_tags, :people, filter)

page = NationBuilder::Paginator.new(client, response)


people = []
  people += page.body['results']
while page.next?
  page = page.next
  people += page.body['results']
 
end  

people.each do |person|
  email = person['email']
    first_name = person['first_name']
    last_name = person['last_name']
  id = person['id']

  
puts "#{email}"


params = {
 id: "#{id}",
  tagging: {
    tag: "is: community 2018"
  }
  
}
  client.call(:people, :bulk_tag_removal , params)

end
end
=begin
    client.call(:people, :tag_person , params3)

=end

=begin
require 'net/http'
    require 'json'

uri = URI.parse('https://slack.com/api/chat.postMessage')
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json',  
          'Authorization' => 'Bearer xoxb-32348558352-376052208487-xpriTUF3hIg0SZE2bfFfh1Ka' })
        req.body = {"channel" => "techteam", "text" => "Hope"}.to_json
        res = http.request(req)
        puts "response #{res.body}"
        puts JSON.parse(res.body)

require 'net/http'
require 'uri'
require 'json'

uri = URI.parse("https://slack.com/api/chat.postMessage")

request = Net::HTTP::Post.new(uri)
request.content_type = 'application/json'
request["Authorization"] = 'Bearer ENV'
request.body= JSON.dump({
  "channel" => "techteam", 
  "text" => "Hope"
  })


puts "It worked, but didn't work"

=end
=begin
require 'nationbuilder'

client = NationBuilder::Client.new('harrycossar', ENV['NATIONBUILDER_APIKEY'], retries: 8)

two_days_ago = Date.today - 2

  puts "Loading donations..."

response = client.call(:donations, :index, limit: 100)
page = NationBuilder::Paginator.new(client, response)

donations = page.body['results']

while page.next?
  donations += page.body['results']
  break unless Date.parse(donations.last['created_at']) >= two_days_ago
  page = page.next
end

  
donations.each do |d|
if d['amount_in_cents'] > 20000
  
    email = d['donor']['email']
  first_name = d['donor']['first_name']
 last_name = d['donor']['last_name']
  amount = d['amount']
  person_id = d['donor']['id']

  
    puts "#{email} donated #{amount}"

else
  email = d['donor']['email']
  first_name = d['donor']['first_name']
 last_name = d['donor']['last_name']
  amount = d['amount']
  person_id = d['donor']['id']
  puts "#{email} LESS THAN 20. the donated #{amount}"
end
end
=end



=begin

if donations['amount_in_cents'] >= 25000
end

response = client.call(:people, :index, limit: 3)

page = NationBuilder::Paginator.new(client, response)

people = []
while page.next?
  people += page.body['results']
  page = page.next
end  


people.each do |person|
  email = person['email']
    first_name = person['first_name']
    last_name = person['last_name']
  id = person['id']
  
    puts "#{email} #{first_name} #{last_name} #{id}"


  params3 = {
 id: "#{id}",
  tagging: {
    tag: "showmethemoney"
  }
  
}
    client.call(:people, :tag_person , params3)

end
=end

=begin
 params = {
  tag: "is:%20awesome%20core%202018"
    
}
response = client.call(:people_tags, :people, filter)
response = client.call(:people_tags, :people, params)
paginated = NationBuilder::Paginator.new(client, response)
page1 = paginated
page2 = page1.next
page3 = page2.next

 people = paginated.body["results"]

 
people.each do |person|
  
  email = person['email']
    first_name = person['first_name']
    last_name = person['last_name']
  id = person['id']
  
    puts "#{email} #{first_name} #{last_name} #{id}"

end
=end

=begin
response = client.call(:people, :index)

page = NationBuilder::Paginator.new(client, response)

people = []
while page.next?
  people= page.body['results']
  page = page.next
end


 
people.each do |person|
if person['tags'].include? 'is: community 2018'
if person['tags'].include? 'is: awesome core 2018' 
  
  email = person['email']
    first_name = person['first_name']
    last_name = person['last_name']
  id = person['id']
  
    puts "#{email} #{first_name} #{last_name} #{id}"


=begin
 params = {
 id: "#{id}",
  tagging: {
    tag: "is: awesome core 2018"
  }
  
}
  client.call(:people, :bulk_tag_removal , params)

=end

=begin
  params2 = {
 id: "#{id}",
  tagging: {
    tag: "test"
  }
  
}
  
  
  client.call(:people, :tag_person , params2)
end
else
people.each do |person|
  
  email = person['email']
    first_name = person['first_name']
    last_name = person['last_name']
  id = person['id']
  
    puts "#{email} #{first_name} #{last_name} #{id}"

  params3 = {
 id: "#{id}",
  tagging: {
    tag: "hellyep"
  }
  
}
    client.call(:people, :tag_person , params3)
end
end
end
=end
