require 'json'

file = JSON.parse(File.read('./poly_test/jsonf2022-09-29-15:15:46+0000.json'))


token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MjY0Mzk2NzcsImlzcyI6Imh0dHA6XC9cLzE5Mi4xNjguMTAwLjEwMFwvc2loX2hkYlwvYXBwXC9hcGlcLyIsImRhdGEiOnsiaWQiOiIxNTIiLCJmaXJzdG5hbWUiOiJDZXJ0ZXNfbGFibyIsImxhc3RuYW1lIjoiQ2VydGVzIiwibG9naW4iOiJjX2FkbWluIiwicGVybWlzc2lvbiI6InZpZXcubGFibyxsYWJfcGFyYW1ldHJhZ2UucmVzaCxsYWJfdHlwZV9hbmFseXNlLmxpc3RlLnJlc2gsbGFiX2FuYWx5c2UubGlzdGUucmVzaCxsYWJfcHJvdmVuYW5jZS5saXN0ZS5yZXNoIn19.gzMsLUfeHPPpRXfsA0tCofu4vAIl6btB0gnEoMvYooI"
bench_number = nil
new_results_hash = Hash.new

patients = file["@patients"]
#puts "PATIENTS: #{patients}"

patients.each do |patient|
	#puts "PATIENT: #{patient}"
	orders = patient["orders"]
	
	puts "ORDERS: #{orders}"


	#orders.each do  |order|
		#bench_number = order["id"]

		#results = order["results"]
		#key = results.keys[0]
		#analyse = results.values[0]
		#puts "RESULTS KEY: #{key}"
		#puts "RESULTS VALUE: #{analyse}"
		#new_results_hash[key] = {value: analyse["value"], um: analyse["units"]}
	#end

	

	orders.each do  |order|
		bench_number = order["id"]

		results = order["results"]

		results.each do |result|
			#puts "------CURRENT RESULT: #{result}"
			real_result = result[1]
			#puts "-------RESULT: #{real_result} "
			puts "-------NAME: #{real_result["name"]}, VALUE: #{real_result["value"]}, UNIT: #{real_result[""]} "

			test_name = real_result["name"]
			test_value = real_result["value"]
			test_unit = real_result["units"]
			#analyse = results.values[0]
			#puts "RESULTS KEY: #{key}"
			#puts "RESULTS VALUE: #{analyse}"
			#new_results_hash[key] = {value: analyse["value"], um: analyse["units"]}
			new_results_hash[test_name] = {value: test_value, um: test_unit}
		end

		puts "NEW TEST RESULTS HASH: #{new_results_hash}"
		#key = results.keys[0]
		#analyse = results.values[0]
		#puts "RESULTS KEY: #{key}"
		#puts "RESULTS VALUE: #{analyse}"
		#new_results_hash[key] = {value: analyse["value"], um: analyse["units"]}
	end

end

final_results_hash = Hash.new 
final_results_hash["token"] = token
final_results_hash["bench_number"] = bench_number
final_results_hash["automate_name"] = ""
final_results_hash["automate_ip"] =  ""
final_results_hash["analyzes"] = new_results_hash
puts "NEW RESULTS HASH: #{final_results_hash}"

puts "NEW RESULTS HASH TO: #{final_results_hash.to_json}"