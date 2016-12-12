module ListingsHelper
  def find_similar(listing)
    final = []
    listing.ambiances.each do |ambiance|
      Listing.all.select {|l| l.ambiances.include?(ambiance)}.each do |result|
        final << result unless final.include?(result) || result == listing
      end
    end
    return final
  end
end
