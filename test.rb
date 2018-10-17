

require 'nationbuilder'

client = NationBuilder::Client.new('aycc', ENV['NATIONBUILDER_APIKEY'], retries: 8)

puts "finding peeps step 1"

filter_all = {
  tag: "wants%20to:%20volunteer%202018"
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
 
=begin
filter_all_2 = {
  person_id: "#{tagged_id_all}",
    status: "no_answer",

  }
=end
filter_all_2 = {
  person_id: "#{tagged_id_all}",
    status: "answered",
   method: "phone_call",

  }
  
contacts_1 = client.call(:contacts, :index, filter_all_2)
  contacts_2 = NationBuilder::Paginator.new(client, contacts_1)

  jan_01_18= Date.parse('2018-01-01')
puts "#{tagged_id_all} #{jan_01_18} yep" 

  
contacts_3 = []
  contacts_3 += contacts_2.body['results']

 while contacts_2.next?
  contacts_2 = contacts_2.next
  contacts_3 += contacts_2.body['results']

end  

  contacts_filtered = contacts_3.select do |c|

  Date.parse(c['created_at']) >= jan_01_18
end

puts "#{tagged_id_all} #{contacts_filtered.count} Answered filtered"
  count1= contacts_3.count
  puts "#{tagged_id_all} #{count1} Answered total"

  puts "starting meaningful contact"
  
  
  filter2 = {
  person_id: "#{tagged_id_all}",
  status: "meaningful_interaction",
    method: "phone_call"
    
  }
  
texts_x = client.call(:contacts, :index, filter2)
  texts_y = NationBuilder::Paginator.new(client, texts_x)
  
texts_z = []
  texts_z += texts_y.body['results']

 while texts_y.next?
  texts_y = texts_y.next
  texts_z += texts_y.body['results']

end  

  
donations_filtered123 = texts_z.select do |xyz|

  Date.parse(xyz['created_at']) >= jan_01_18
end

puts "#{tagged_id_all} #{donations_filtered123.count} Meaninful filtered"


   textcountz= texts_z.count


  puts " #{tagged_id_all} #{textcountz} Meaningful Total"
  
totalanswer= contacts_filtered.count+donations_filtered123.count
   puts "#{tagged_id_all} #{totalanswer}"

 filter_all_3 = {
  "person": {
  "answered_18": "#{totalanswer}",
     "id": "#{tagged_id_all}",
  }
}
  
  puts " hello #{tagged_id_all} you answered #{totalanswer} times"
     
contacts_3.each do |contacts_4|
  
  email = contacts_4['email']    
  id4 = contacts_4['person_id']
 
  
puts "#{id4}" 

end
  

  client.call(:people, :push, filter_all_3)




end
puts "thats everyone done"
  

