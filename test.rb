

require 'nationbuilder'

client = NationBuilder::Client.new('aycc', ENV['NATIONBUILDER_APIKEY'], retries: 8)

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
