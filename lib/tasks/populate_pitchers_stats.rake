require 'nokogiri'
require 'open-uri'
task :populate_pitchers_stats => :environment do
	# @pitchers = Pitcher.all
	@pitchers = Pitcher.where("url != ''")
	@pitchers.each do |pitcher|
		url = pitcher.url
		data = Nokogiri::HTML(open(url).read, nil, 'utf-8')
		@pitcher_id = pitcher.id

		#Updating Basic Details
		if(data.css("#info_box span.xx_large_text").present? && data.css("#info_box p")[1].children[7].present? && data.css("#necro-birth").present?)
			@full_name = data.css("#info_box span.xx_large_text").text.to_s		
			@throws    = data.css("#info_box p")[1].children[7].text.gsub(/\n/,'')
			@dob       = data.css("#necro-birth").first.attributes['data-birth'].value
			@age       = (DateTime.now.mjd - DateTime.parse(@dob).mjd) / 365
			result     = pitcher.update(:throws => @throws, :age => @age, :full_name => @full_name)
		else
			next
		end	

		#Seasons Total - Current Year
		@split    = data.css("#total_extra tbody tr")[0].css("td[2]").first.text.to_s
		@W       = data.css("#total_extra tbody tr")[0].css("td[3]").first.text.to_s
		@L       = data.css("#total_extra tbody tr")[0].css("td[4]").first.text.to_s
		@W_L     = data.css("#total_extra tbody tr")[0].css("td[5]").first.text.to_s
		@ERA     = data.css("#total_extra tbody tr")[0].css("td[6]").first.text.to_s
		@G       = data.css("#total_extra tbody tr")[0].css("td[7]").first.text.to_s
		@GS      = data.css("#total_extra tbody tr")[0].css("td[8]").first.text.to_s
		@GF      = data.css("#total_extra tbody tr")[0].css("td[9]").first.text.to_s
		@CG      = data.css("#total_extra tbody tr")[0].css("td[10]").first.text.to_s
		@SHO     = data.css("#total_extra tbody tr")[0].css("td[11]").first.text.to_s
		@SV      = data.css("#total_extra tbody tr")[0].css("td[12]").first.text.to_s
		@IP      = data.css("#total_extra tbody tr")[0].css("td[13]").first.text.to_s
		@H       = data.css("#total_extra tbody tr")[0].css("td[14]").first.text.to_s
		@R       = data.css("#total_extra tbody tr")[0].css("td[15]").first.text.to_s
		@ER      = data.css("#total_extra tbody tr")[0].css("td[16]").first.text.to_s
		@HR      = data.css("#total_extra tbody tr")[0].css("td[17]").first.text.to_s
		@BB      = data.css("#total_extra tbody tr")[0].css("td[18]").first.text.to_s
		@IBB     = data.css("#total_extra tbody tr")[0].css("td[19]").first.text.to_s
		@SO      = data.css("#total_extra tbody tr")[0].css("td[20]").first.text.to_s
		@HBP     = data.css("#total_extra tbody tr")[0].css("td[21]").first.text.to_s
		@BK      = data.css("#total_extra tbody tr")[0].css("td[22]").first.text.to_s
		@WP      = data.css("#total_extra tbody tr")[0].css("td[23]").first.text.to_s
		@BF      = data.css("#total_extra tbody tr")[0].css("td[24]").first.text.to_s
		@WHIP    = data.css("#total_extra tbody tr")[0].css("td[25]").first.text.to_s
		@SOp     = data.css("#total_extra tbody tr")[0].css("td[26]").first.text.to_s
		@PitcherSeasonTotal = PitcherSeasonTotal.where("split=? AND pitcher_id=?",@split,@pitcher_id).first
		if @PitcherSeasonTotal.present?
			result   = @PitcherSeasonTotal.update(:split => @split, :W => @W, :L => @L, :W_L => @W_L, :ERA => @ERA, :G => @G, :GS => @GS, :GF => @GF, :CG => @CG, :SHO => @SHO, :SV => @SV, :IP => @IP, :H => @H, :R => @R, :HR => @HR, :ER => @ER, :BB => @BB, :IBB => @IBB, :SO => @SO, :HBP => @HBP, :BK => @BK, :WP => @WP, :BF => @BF, :WHIP => @WHIP, :SOp => @SOp, :pitcher_id => @pitcher_id)
		else	
			result   = PitcherSeasonTotal.create(:split => @split, :W => @W, :L => @L, :W_L => @W_L, :ERA => @ERA, :G => @G, :GS => @GS, :GF => @GF, :CG => @CG, :SHO => @SHO, :SV => @SV, :IP => @IP, :H => @H, :R => @R, :HR => @HR, :ER => @ER, :BB => @BB, :IBB => @IBB, :SO => @SO, :HBP => @HBP, :BK => @BK, :WP => @WP, :BF => @BF, :WHIP => @WHIP, :SOp => @SOp, :pitcher_id => @pitcher_id)
		end	
		#Seasons Total - Last 7 days
		@split    = data.css("#total_extra tbody tr")[1].css("td[2]").first.text.to_s
		@W       = data.css("#total_extra tbody tr")[1].css("td[3]").first.text.to_s
		@L       = data.css("#total_extra tbody tr")[1].css("td[4]").first.text.to_s
		@W_L     = data.css("#total_extra tbody tr")[1].css("td[5]").first.text.to_s
		@ERA     = data.css("#total_extra tbody tr")[1].css("td[6]").first.text.to_s
		@G       = data.css("#total_extra tbody tr")[1].css("td[7]").first.text.to_s
		@GS      = data.css("#total_extra tbody tr")[1].css("td[8]").first.text.to_s
		@GF      = data.css("#total_extra tbody tr")[1].css("td[9]").first.text.to_s
		@CG      = data.css("#total_extra tbody tr")[1].css("td[10]").first.text.to_s
		@SHO     = data.css("#total_extra tbody tr")[1].css("td[11]").first.text.to_s
		@SV      = data.css("#total_extra tbody tr")[1].css("td[12]").first.text.to_s
		@IP      = data.css("#total_extra tbody tr")[1].css("td[13]").first.text.to_s
		@H       = data.css("#total_extra tbody tr")[1].css("td[14]").first.text.to_s
		@R       = data.css("#total_extra tbody tr")[1].css("td[15]").first.text.to_s
		@ER      = data.css("#total_extra tbody tr")[1].css("td[16]").first.text.to_s
		@HR      = data.css("#total_extra tbody tr")[1].css("td[17]").first.text.to_s
		@BB      = data.css("#total_extra tbody tr")[1].css("td[18]").first.text.to_s
		@IBB     = data.css("#total_extra tbody tr")[1].css("td[19]").first.text.to_s
		@SO      = data.css("#total_extra tbody tr")[1].css("td[20]").first.text.to_s
		@HBP     = data.css("#total_extra tbody tr")[1].css("td[21]").first.text.to_s
		@BK      = data.css("#total_extra tbody tr")[1].css("td[22]").first.text.to_s
		@WP      = data.css("#total_extra tbody tr")[1].css("td[23]").first.text.to_s
		@BF      = data.css("#total_extra tbody tr")[1].css("td[24]").first.text.to_s
		@WHIP    = data.css("#total_extra tbody tr")[1].css("td[25]").first.text.to_s
		@SOp     = data.css("#total_extra tbody tr")[1].css("td[26]").first.text.to_s
		@PitcherSeasonTotal = PitcherSeasonTotal.where("split=? AND pitcher_id=?",@split,@pitcher_id).first
		if @PitcherSeasonTotal.present?
			result   = @PitcherSeasonTotal.update(:split => @split, :W => @W, :L => @L, :W_L => @W_L, :ERA => @ERA, :G => @G, :GS => @GS, :GF => @GF, :CG => @CG, :SHO => @SHO, :SV => @SV, :IP => @IP, :H => @H, :R => @R, :HR => @HR, :ER => @ER, :BB => @BB, :IBB => @IBB, :SO => @SO, :HBP => @HBP, :BK => @BK, :WP => @WP, :BF => @BF, :WHIP => @WHIP, :SOp => @SOp, :pitcher_id => @pitcher_id)
		else	
			result   = PitcherSeasonTotal.create(:split => @split, :W => @W, :L => @L, :W_L => @W_L, :ERA => @ERA, :G => @G, :GS => @GS, :GF => @GF, :CG => @CG, :SHO => @SHO, :SV => @SV, :IP => @IP, :H => @H, :R => @R, :HR => @HR, :ER => @ER, :BB => @BB, :IBB => @IBB, :SO => @SO, :HBP => @HBP, :BK => @BK, :WP => @WP, :BF => @BF, :WHIP => @WHIP, :SOp => @SOp, :pitcher_id => @pitcher_id)
		end	

		#Seasons Total - Last 28 days
		@split    = data.css("#total_extra tbody tr")[3].css("td[2]").first.text.to_s
		@W       = data.css("#total_extra tbody tr")[3].css("td[3]").first.text.to_s
		@L       = data.css("#total_extra tbody tr")[3].css("td[4]").first.text.to_s
		@W_L     = data.css("#total_extra tbody tr")[3].css("td[5]").first.text.to_s
		@ERA     = data.css("#total_extra tbody tr")[3].css("td[6]").first.text.to_s
		@G       = data.css("#total_extra tbody tr")[3].css("td[7]").first.text.to_s
		@GS      = data.css("#total_extra tbody tr")[3].css("td[8]").first.text.to_s
		@GF      = data.css("#total_extra tbody tr")[3].css("td[9]").first.text.to_s
		@CG      = data.css("#total_extra tbody tr")[3].css("td[10]").first.text.to_s
		@SHO     = data.css("#total_extra tbody tr")[3].css("td[11]").first.text.to_s
		@SV      = data.css("#total_extra tbody tr")[3].css("td[12]").first.text.to_s
		@IP      = data.css("#total_extra tbody tr")[3].css("td[13]").first.text.to_s
		@H       = data.css("#total_extra tbody tr")[3].css("td[14]").first.text.to_s
		@R       = data.css("#total_extra tbody tr")[3].css("td[15]").first.text.to_s
		@ER      = data.css("#total_extra tbody tr")[3].css("td[16]").first.text.to_s
		@HR      = data.css("#total_extra tbody tr")[3].css("td[17]").first.text.to_s
		@BB      = data.css("#total_extra tbody tr")[3].css("td[18]").first.text.to_s
		@IBB     = data.css("#total_extra tbody tr")[3].css("td[19]").first.text.to_s
		@SO      = data.css("#total_extra tbody tr")[3].css("td[20]").first.text.to_s
		@HBP     = data.css("#total_extra tbody tr")[3].css("td[21]").first.text.to_s
		@BK      = data.css("#total_extra tbody tr")[3].css("td[22]").first.text.to_s
		@WP      = data.css("#total_extra tbody tr")[3].css("td[23]").first.text.to_s
		@BF      = data.css("#total_extra tbody tr")[3].css("td[24]").first.text.to_s
		@WHIP    = data.css("#total_extra tbody tr")[3].css("td[25]").first.text.to_s
		@SOp     = data.css("#total_extra tbody tr")[3].css("td[26]").first.text.to_s
		@PitcherSeasonTotal = PitcherSeasonTotal.where("split=? AND pitcher_id=?",@split,@pitcher_id).first
		if @PitcherSeasonTotal.present?
			result   = @PitcherSeasonTotal.update(:split => @split, :W => @W, :L => @L, :W_L => @W_L, :ERA => @ERA, :G => @G, :GS => @GS, :GF => @GF, :CG => @CG, :SHO => @SHO, :SV => @SV, :IP => @IP, :H => @H, :R => @R, :HR => @HR, :ER => @ER, :BB => @BB, :IBB => @IBB, :SO => @SO, :HBP => @HBP, :BK => @BK, :WP => @WP, :BF => @BF, :WHIP => @WHIP, :SOp => @SOp, :pitcher_id => @pitcher_id)
		else	
			result   = PitcherSeasonTotal.create(:split => @split, :W => @W, :L => @L, :W_L => @W_L, :ERA => @ERA, :G => @G, :GS => @GS, :GF => @GF, :CG => @CG, :SHO => @SHO, :SV => @SV, :IP => @IP, :H => @H, :R => @R, :HR => @HR, :ER => @ER, :BB => @BB, :IBB => @IBB, :SO => @SO, :HBP => @HBP, :BK => @BK, :WP => @WP, :BF => @BF, :WHIP => @WHIP, :SOp => @SOp, :pitcher_id => @pitcher_id)
		end	
		
		#Ploatoon Splits - vs RHB
		@split    = data.css("#plato tbody tr")[0].css("td[1]").first.text.to_s
		@BA       = data.css("#plato tbody tr")[0].css("td[16]").first.text.to_s
		@PitcherPlatoonSplit = PitcherPlatoonSplit.where("split=? AND pitcher_id=?",@split,@pitcher_id).first
		if @PitcherPlatoonSplit.present?
			result    = @PitcherPlatoonSplit.update(:split => @split, :BA => @BA, :pitcher_id => @pitcher_id)
		else	
			result    = PitcherPlatoonSplit.create(:split => @split, :BA => @BA, :pitcher_id => @pitcher_id)
		end	

		#Ploatoon Splits - vs LHB
		@split    = data.css("#plato tbody tr")[1].css("td[1]").first.text.to_s
		@BA       = data.css("#plato tbody tr")[1].css("td[16]").first.text.to_s
		@PitcherPlatoonSplit = PitcherPlatoonSplit.where("split=? AND pitcher_id=?",@split,@pitcher_id).first
		if @PitcherPlatoonSplit.present?
			result    = @PitcherPlatoonSplit.update(:split => @split, :BA => @BA, :pitcher_id => @pitcher_id)
		else	
			result    = PitcherPlatoonSplit.create(:split => @split, :BA => @BA, :pitcher_id => @pitcher_id)
		end	

		#Home/Away Section Scraping - Home
		@split    = data.css("#hmvis_extra tbody tr")[0].css("td[2]").first.text.to_s if data.css("#hmvis_extra tbody tr")[0].present?
		@W        = data.css("#hmvis_extra tbody tr")[0].css("td[4]").first.text.to_s if data.css("#hmvis_extra tbody tr")[0].present?
		@L        = data.css("#hmvis_extra tbody tr")[0].css("td[5]").first.text.to_s if data.css("#hmvis_extra tbody tr")[0].present?
		@ERA      = data.css("#hmvis_extra tbody tr")[0].css("td[7]").first.text.to_s if data.css("#hmvis_extra tbody tr")[0].present?
		@GS       = data.css("#hmvis_extra tbody tr")[0].css("td[9]").first.text.to_s if data.css("#hmvis_extra tbody tr")[0].present?
		@WHIP     = data.css("#hmvis_extra tbody tr")[0].css("td[26]").first.text.to_s if data.css("#hmvis_extra tbody tr")[0].present?
		@pitcherHomeAway = PitcherHomeAway.where("split=? AND pitcher_id=?",@split,@pitcher_id).first
		if @pitcherHomeAway.present?
			result = @pitcherHomeAway.update(:split => @split, :W => @W, :L => @L, :ERA => @ERA, :GS => @GS, :WHIP => @WHIP, :pitcher_id => @pitcher_id)
		else	
			result = PitcherHomeAway.create(:split => @split, :W => @W, :L => @L, :ERA => @ERA, :GS => @GS, :WHIP => @WHIP, :pitcher_id => @pitcher_id)
		end
			
		#Home/Away Section Scraping - Away
		@split    = data.css("#hmvis_extra tbody tr")[1].css("td[2]").first.text.to_s if data.css("#hmvis_extra tbody tr")[1].present?
		@W        = data.css("#hmvis_extra tbody tr")[1].css("td[4]").first.text.to_s if data.css("#hmvis_extra tbody tr")[1].present?
		@L        = data.css("#hmvis_extra tbody tr")[1].css("td[5]").first.text.to_s if data.css("#hmvis_extra tbody tr")[1].present?
		@ERA      = data.css("#hmvis_extra tbody tr")[1].css("td[7]").first.text.to_s if data.css("#hmvis_extra tbody tr")[1].present?
		@GS       = data.css("#hmvis_extra tbody tr")[1].css("td[9]").first.text.to_s if data.css("#hmvis_extra tbody tr")[1].present? 
		@WHIP     = data.css("#hmvis_extra tbody tr")[1].css("td[26]").first.text.to_s if data.css("#hmvis_extra tbody tr")[1].present?
		@pitcherHomeAway = PitcherHomeAway.where("split=? AND pitcher_id=?",@split,@pitcher_id).first
		if @pitcherHomeAway.present?
			result = @pitcherHomeAway.update(:split => @split, :W => @W, :L => @L, :ERA => @ERA, :GS => @GS, :WHIP => @WHIP, :pitcher_id => @pitcher_id)
		else	
			result = PitcherHomeAway.create(:split => @split, :W => @W, :L => @L, :ERA => @ERA, :GS => @GS, :WHIP => @WHIP, :pitcher_id => @pitcher_id)
		end

		puts "#{pitcher.id}. #{pitcher.name} Stats have been scraped succesfully"					
	end	
end