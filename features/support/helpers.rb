AUTHORIZATIONS_PATH = /#{Rails.configuration.x.registry_url}\/authorizations/
ORDERS_PATH         = /#{Rails.configuration.x.registry_url}\/orders/
CONTACTS_PATH       = /#{Rails.configuration.x.registry_url}\/contacts/
HOSTS_PATH          = /#{Rails.configuration.x.registry_url}\/hosts/
HOST_ADDRESS_PATH   = /#{Rails.configuration.x.registry_url}\/hosts\/.*\/addresses/
DOMAIN_PATH         = /#{Rails.configuration.x.registry_url}\/domains\/.*/
DOMAIN_HOST_PATH    = /#{Rails.configuration.x.registry_url}\/domains\/.*\/hosts/
CONTACT_PATH        = /#{Rails.configuration.x.registry_url}\/contacts\/.*/

EXCLUDED_PARTNER = 'excluded'
EXCLUDED_IP = '999.999.999.999'
PARTNER = 'alpha'

def exclude_partners
  FactoryGirl.create :excluded_partner
  FactoryGirl.create :excluded_partner, name: 'other_excluded'
end

def registry_response on:, with:, request: :post, body: nil
  response = { status: with }
  response[:body] = body.to_json if body

  stub_request(request, on).to_return(response)
end

def run_sync
  SyncLog.create  since: '2015-01-01 00:00'.in_time_zone,
                  until: '2015-01-01 00:00'.in_time_zone

  begin
    Sync.run
  rescue
    @exception_thrown = true
  end
end

def default_headers
  {
    'Content-Type'  =>  'application/json',
    'Accept'        =>  'application/json',
    'Authorization' =>  'Token token=1234567890ABCDEF'
  }
end

def error_params
  {
    message: 'ERROR MESSAGE'
  }
end

def url path
  "#{Rails.configuration.x.registry_url}#{path}"
end
