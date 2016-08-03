#!/bin/ruby
 
# 


def myp(str)
	File.open('out.htm', 'a') do |file|
    	file.write str
  	end
end

okons = {}
verbs = {}
# to parse a tab-separated line of text
IO.foreach('source.txt') do |line|
	splits = line.chomp.split("\t")

	col1, col2, col3 = splits

	verb, okon = col2.split(" ",2)

	verb.chomp!
	okon.chomp!

	okons[okon] = 1
	verbs[verb] = {} if verbs[verb].nil?
	verbs[verb][okon] = { title: col3, freq: col1 }

	p "#{verb} #{okon} #{verbs[verb][okon][:title]}"

end




myp '<html><head><meta charset="utf-8"><style>td {border: 1px solid #CCC}</style></head><body><table>'

myp '<tr><td></td><td></td>'
okons.each do |kokon, okon|
	myp "<td>#{kokon}</td>"
end
myp '</tr>'

verbs.each do |kverb, verb|

	myp "<tr><td>#{kverb}<td>"
	okons.each do |kokon, okon|

		myp "<td style='background:rgb(#{verbs[kverb][kokon] ? 255-verbs[kverb][kokon][:freq].to_i : 255},255,255)'>"
		if verbs[kverb][kokon] 
			myp verbs[kverb][kokon][:title]
		end
		myp "</td>"
	end
	myp "</tr>"
end
myp '</table></body></html>'