class TransferDomainJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform partner, record
    json_request = {
      currency_code:  'USD',
      ordered_at:      record[:ordered_at],
      order_details:  [
        {
          type:               'transfer_domain',
          domain:             record[:domain],
          registrant_handle:  record[:registrant_handle]
        }
      ]
    }

    execute :post, partner: partner, path: "#{URL}/orders", body: json_request
  end
end
