require 'link_thumbnailer'
require 'securerandom'
class HomeController < ApplicationController
  def index
    @items=Item.all
  end
  
  def write
    @items=Item.all
    object = LinkThumbnailer.generate('http://wantknow.tistory.com/')
  end
  
  def create
    memberAry = []
    i = 1
    while params["member#{i}"] != "" do
      memberAry.push(params["member#{i}"])
      i += 1
    end
    Item.create(name: params[:name],url: params[:url], teamName: params[:teamName], member: memberAry)
    redirect_to :back
  end
  
  def count
    like=Like.find_or_create_by(user: cookies['id'], item_id: params[:id])
    redirect_to :back
  end
  
  def splash
     cookies['id'] = SecureRandom.hex if cookies['id']==nil
  end

    @items=Item.all
  
  def look
    id=params[:id]
    @item=Item.find(id)
  end
  
  def ajax
    @items=Item.all
    respond_to do |format|
      format.js
    end
  end
  
  

end
