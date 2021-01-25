# frozen_string_literal: true

require_relative "../test_helper.rb"
require "minitest/hooks/test"
require "ibm_cloud_sdk_core"

if ENV["VPC_APIKEY"] && ENV["VPC_URL"]
  class VpcV1Test < Minitest::Test
    include Minitest::Hooks
    attr_accessor :service

    def before_all
      authenticator = IbmVpc::Authenticators::ConfigBasedAuthenticatorFactory.new.get_authenticator(service_name: "vpc")
      self.service = IbmVpc::VpcV1.new(authenticator: authenticator)
    end

    def test_list_vpcs
      service_response = service.list_vpcs
      assert((200..299).cover?(service_response.status))
    end

    def test_get_vpc
      service_response = service.get_vpc(vpc_id: ENV["VPC_VPC_ID"])
      assert((200..299).cover?(service_response.status))
    end
  end
else
  class VpcV1Test < Minitest::Test
    def test_missing_credentials_skip_integration
      skip "Skip VPC integration tests because credentials have not been provided"
    end
  end
end
