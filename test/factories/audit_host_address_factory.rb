FactoryGirl.define do
  factory :audit_host_address, class: Audit::HostAddress do
    audit_transaction
    audit_operation AuditOperation::INSERT_OPERATION
    host_name 'ns5.domains.ph'
    ip 'v4'
    address '123.123.123.001'

    after :create do |o|
      host = create :audit_host, audit_transaction: o.audit_transaction

      o.update host_name: host.name
    end

    factory :create_host_address do
      audit_operation AuditOperation::INSERT_OPERATION
    end

    factory :delete_host_address do
      audit_operation AuditOperation::DELETE_OPERATION
    end
  end
end
