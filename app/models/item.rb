require 'link_thumbnailer'
class Item < ActiveRecord::Base
    has_many :likes
    serialize :member, Array
    before_save :urlSave
    
    def getRank
        id=self.id
        rankHash=Hash.new
        Item.all.each do |i|
            rankHash[i.id]=i.likes.count
        end
        rank=rankHash.sort_by {|_key, value| value}.reverse.to_h
        rankKeys=rank.keys
        
        return rankKeys.index(id)+1
    end
    def urlSave
        object = LinkThumbnailer.generate(self.url)
        self.img = object.images.first.src.to_s unless object.images.first.nil?
    end
end
