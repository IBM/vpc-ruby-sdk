require "ibm_vpc/version"
require "ibm_cloud_sdk_core"

module IbmVpc
  ApiException = IBMCloudSdkCore::ApiException
  DetailedResponse = IBMCloudSdkCore::DetailedResponse

  require_relative "./ibm_vpc/common.rb"
end
