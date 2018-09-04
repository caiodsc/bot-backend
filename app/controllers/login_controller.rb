class LoginController < ApplicationController
  def login
    client_data = {}
    call_rfc('ZCHATBOT_VENDAS_CLIENTE', {:IM_CPF => params["cpf"].gsub('.','').gsub('-',''), :IM_DT_NASCTO => params["birthdate"].split('/').reverse.join}).tap do |response|
      client_data =  response
      h_img = (call_rfc('ZIMG_GETFOTOCLIENTE', {:I_CLIENTE => response["EX_KUNNR"]}))["OBJ_ATU"].inject(""){|img, n| img + n["LINE"]}
      client_data = client_data.merge({"EX_AVATAR" => "data:image/jpeg;base64, " +[[h_img.gsub("0x","")].pack("H*")].pack("m").strip.gsub("\n",'')})
      client_data["EX_CPF"] = params["cpf"].gsub('.','').gsub('-','')
      client_data["EX_BIRTHDATE"] = params["birthdate"].split('/').reverse.join
      client_data["EX_NAME"] = client_data["EX_NAME"].gsub(/\w+/, &:capitalize)
    end
    puts client_data
    render status: 200, json: client_data.to_json
  end
end
#{:IM_CPF => "66078601253", :IM_DT_NASCTO => "19820315"}