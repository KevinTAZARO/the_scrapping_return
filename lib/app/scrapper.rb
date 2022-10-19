class Scrapper

    def initialize
        city_name = []
        mail = []
    
        page = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html'))
    
        page.xpath('//a[@class="lientxt"]').each do |row|
          city_name.push(row.text)
          mail.push(Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com' + row['href'].sub('.', ''))).xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text)
        end
    
        @mail_list = city_name.zip(mail).to_h
    end


    def save_json
        File.open("db/emails.json", "w") do |file|
            file.write(JSON.pretty_generate(@mail_list))
        end
    end

    def save_csv
        CSV.open("db/emails.csv", "wb") do |csv|
            csv << ["Index", "Mairie", "Mail"]
            @mail_list.each_with_index do |(name, mail), index|
            csv << [index, name, mail]
            end
        end
    end




end