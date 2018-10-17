

require 'nationbuilder'

client = NationBuilder::Client.new('aycc', ENV['NATIONBUILDER_APIKEY'], retries: 8)

puts "finding wants to vols"

filter_wants_to_vol = {
  tag: "wants%20to:%20volunteer%202018"
  }
  
wants_to_vol = client.call(:people_tags, :people, filter_wants_to_vol)
wants_to_vol_2 = NationBuilder::Paginator.new(client, wants_to_vol)


wants_to_vol_3 = []
  wants_to_vol_3 += wants_to_vol_2.body['results']
while wants_to_vol_2.next?
  wants_to_vol_2 = wants_to_vol_2.next
  wants_to_vol_3 += wants_to_vol_2.body['results']
 
end  

wants_to_vol_3.each do |wants_to_vol_4|
  person_id_wants_to_vol = wants_to_vol_4['id']
 

  #ANSWERED PHONE CALL
answered_phone_call = {
  person_id: "#{person_id_wants_to_vol}",
    status: "answered",
   method: "phone_call",

  }
  
answered_phone_call_1 = client.call(:contacts, :index, answered_phone_call)
  answered_phone_call_2 = NationBuilder::Paginator.new(client, answered_phone_call_1)

  jan_01_18= Date.parse('2018-01-01')
puts "#{person_id_wants_to_vol} #{jan_01_18} yep" 

  
answered_phone_call_3 = []
  answered_phone_call_3 += answered_phone_call_2.body['results']

 while answered_phone_call_2.next?
  answered_phone_call_2 = answered_phone_call_2.next
  answered_phone_call_3 += answered_phone_call_2.body['results']

end  

  answered_phone_call_after_jan = answered_phone_call_3.select do |c|

  Date.parse(c['created_at']) >= jan_01_18
end

  #Prints just phone calls after 01/01/2018
puts "#{person_id_wants_to_vol} #{answered_phone_call_after_jan.count} Answered filtered"
   #Prints phone calls across time
  answered_phone_call_count_total=  answered_phone_call_3.count
  puts "#{person_id_wants_to_vol} #{answered_phone_call_count_total} Answered total"

  
  #Meaningful phone calls
  puts "starting meaningful contact"
  
  
  meaningful_phone_call = {
  person_id: "#{person_id_wants_to_vol}",
  status: "meaningful_interaction",
    method: "phone_call"
    
  }
  
meaningful_phone_call_1 = client.call(:contacts, :index, meaningful_phone_call)
  meaningful_phone_call_2 = NationBuilder::Paginator.new(client, meaningful_phone_call_1)
  
meaningful_phone_call_3 = []
  meaningful_phone_call_3 += meaningful_phone_call_2.body['results']

 while meaningful_phone_call_2.next?
  meaningful_phone_call_2 = meaningful_phone_call_2.next
  meaningful_phone_call_3 += meaningful_phone_call_2.body['results']

end  

  
meaningful_phone_call_filtered = meaningful_phone_call_3.select do |xyz|

  Date.parse(xyz['created_at']) >= jan_01_18
end

puts "#{person_id_wants_to_vol} #{meaningful_phone_call_filtered.count} Meaninful filtered"

#Total meaningful calls - all time
   meaningful_phone_call_total= meaningful_phone_call_3.count
  puts " #{person_id_wants_to_vol} #{meaningful_phone_call_total} Meaningful Total"
  

#Total PICK UPS - INCLUDING ALL TYPES OF PICK UPS
total_pick_ups= meaningful_phone_call_filtered.count+answered_phone_call_after_jan.count

   puts "#{person_id_wants_to_vol} #{total_pick_ups}"

 custom_fields_to_be_added = {
  "person": {
  "answered_18": "#{total_pick_ups}",
     "id": "#{person_id_wants_to_vol}",
  }
}
  
  client.call(:people, :push, custom_fields_to_be_added)


end
puts "thats everyone done"
  


    
#contacts_3.each do |contacts_4|
  
 # email = contacts_4['email']    
  #id4 = contacts_4['person_id']
   
#puts "#{id4}" 

#end
