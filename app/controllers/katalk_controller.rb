class KatalkController < ApplicationController
    
    
  def keyboard
    require 'json'
    
    autobot = {
    "type" => "buttons",
    "buttons" => ["사이트 접속하기", "투표하기","개발자 정보"]
    }
    
    render json: autobot
    
  end
  
  def message
    msg = params[:content].to_s 
     
    if msg == "사이트 접속하기"
        answer = {message: { text: "어서오세요! Produce LION 입니다!",
                    message_button: {label: "사이트 접속", url: "https://sinchon-hackerthon-jomno.c9users.io"}},
                    keyboard: { "type"=> "buttons", "buttons"=> ["돌아가기", "투표하기"]
                    }
        }
    elsif msg == "투표하기"
        itemAry = []
        Item.all.each do |item|
            itemAry.push(item.name+"-"+item.teamName)
            # itemAry.push(item.id)
        end
        
        answer = {message: { text: "투표하고 싶은 팀을 골라주세요!"},
                    keyboard: { "type"=> "buttons", "buttons"=> itemAry + ["돌아가기"]
                }
        }
        
    elsif msg == "돌아가기"
        answer = {
            message: { text: "돌아갑니당~"},
            keyboard: { "type"=> "buttons", "buttons"=> ["사이트 접속하기", "투표하기","개발자 정보"]
            }
        }
    elsif msg == "개발자 정보"
        answer = {
            message: { text: "프로듀스 라이언 개발자 정보입니다."},
            keyboard: { "type"=> "buttons", "buttons"=> ["노종원", "안민준","이우경","나상준"]
            }
        }
    elsif msg == "노종원"
        answer = {message: { text: "개발자 노종원 블로그입니다.",
                    message_button: {label: "사이트 접속", url: "http://wantknow.tistory.com/"}},
                    keyboard: { "type"=> "buttons", "buttons"=> ["돌아가기"]
                    }
        }
    elsif msg == "나상준"
        answer = {message: { text: "개발자 나상준 페이스북입니다.",
                    message_button: {label: "사이트 접속", url: "https://www.facebook.com/ip6040?fref=ts"}},
                    keyboard: { "type"=> "buttons", "buttons"=> ["돌아가기"]
                    }
        }
    elsif msg == "이우경"
        answer = {message: { text: "개발자 이우경 인스타그램입니다.",
                    message_button: {label: "사이트 접속", url: "https://www.instagram.com/fcjyct/"}},
                    keyboard: { "type"=> "buttons", "buttons"=> ["돌아가기"]
                    }
        }
    elsif msg == "안민준"
        answer = {message: { text: "개발자 안민준 페이스북입니다.",
                    message_button: {label: "사이트 접속", url: "https://www.facebook.com/profile.php?id=100006265753691"}},
                    keyboard: { "type"=> "buttons", "buttons"=> ["돌아가기"]
                    }
        }
    else
        cut = msg.split("-").first
        key = params[:user_key]
        item = Item.find_by_name(cut)
        check = Like.find_by_user(key)
        
        if check.present?
        answer = {message: { text: "이미 투표하셨습니다! 결과를 확인해 보세요!", message_button: {label: "사이트 접속", url: "https://sinchon-hackerthon-jomno.c9users.io"}},
                
                keyboard: { "type"=> "buttons", "buttons"=> ["돌아가기"]
                }
        } 
        
        else
            
        Like.create(:user => key ,:item_id => item.id)
        
        
        answer = {message: { text: "투표 완료! 결과를 확인하세요! ", message_button: {label: "사이트 접속", url: "https://sinchon-hackerthon-jomno.c9users.io"}},
                
                keyboard: { "type"=> "buttons", "buttons"=> ["돌아가기"]
                }
        }    
        
        end
    end
    
    render json: answer
    
    
  end
  
  
  
end
