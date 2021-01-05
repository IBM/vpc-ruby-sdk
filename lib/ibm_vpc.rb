require "ibm_vpc/version"
require "ibm_cloud_sdk_core"

module IbmVpc
  ApiException = IBMCloudSdkCore::ApiException
  DetailedResponse = IBMCloudSdkCore::DetailedResponse

  require_relative "./ibm_vpc/authenticators.rb"
  require_relative "./ibm_vpc/common.rb"
  require_relative "./ibm_vpc/vpc_v1.rb"
end
