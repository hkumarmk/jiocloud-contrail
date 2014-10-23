## This provider need curb
require 'json'
require 'curb'
class Puppet::Provider::Contrail < Puppet::Provider

  ##
  #
  ##

  def self.getUrlData(url)
    json_data =  Curl::Easy.perform(url).body_str
    JSON.parse(json_data)
    #return hash_data
  end

  def getObject(url,type)
    hash_data=self.class.getUrlData(url)
    @contrail_object={}
    case type
    when 'linklocal'
      hash_data['global-vrouter-configs'].each do |i|
        vrouterconfig_url = i['href']
        vrouterconfig_json =  Curl::Easy.perform(vrouterconfig_url).body_str
        vrouterconfig_hash = JSON.parse(vrouterconfig_json)
        if vrouterconfig_hash['global-vrouter-config']['linklocal_services']
          vrouterconfig_hash['global-vrouter-config']['linklocal_services']['linklocal_service_entry'].each do  |ll_service|
            if ll_service['linklocal_service_name'].eql?resource[:name]
              @contrail_object = ll_service
            end
          end
        end
      end
    when 'control','router'
      hash_data['bgp-routers'].each do |i|
        bgprouter_url = i['href']
        bgprouter_json =  Curl::Easy.perform(bgprouter_url).body_str
        bgprouter_hash = JSON.parse(bgprouter_json)
        if bgprouter_hash['bgp-router']['fq_name'].include?(resource[:name])
          @contrail_object = bgprouter_hash['bgp-router']
        end
      end
    end
#    return @contrail_object
  end

  def getElement(name,parent=false)
    if parent
      return @contrail_object[parent][name]
    else
      return @contrail_object[name]
    end
  end

end
