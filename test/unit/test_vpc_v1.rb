# frozen_string_literal: true

# (C) Copyright IBM Corp. 2021.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "json"
require_relative "../test_helper"
require "webmock/minitest"

#########################
#
#########################
class VpcV1Test < Minitest::Test
  include Minitest::Hooks
  attr_accessor :service

  def before_all
    authenticator = IbmVpc::Authenticators::NoAuthAuthenticator.new
    self.service = IbmVpc::VpcV1.new(authenticator: authenticator)
  end

  def test_list_vpcs
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs?limit=50" }, "limit" => 50,
                         "total_count" => 2, "vpcs" => [{ "classic_access" => false, "created_at" => "2019-01-25T12:28:30Z", "crn" => "crn:[...]", "default_network_acl" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d", "id" => "3217cb8b-5368-452a-9399-a84f14fb539d", "name" => "my-network-acl" }, "default_routing_table" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/882a7764-5f0e-43b5-b276-0d1c39189488/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840", "id" => "6885e83f-03b2-4603-8a86-db2a0f55c840", "name" => "my-routing-table", "resource_type" => "routing_table" }, "default_security_group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/a929f12d-fb45-4e5e-9864-95e171ae3589", "id" => "a929f12d-fb45-4e5e-9864-95e171ae3589", "name" => "my-security-group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339", "id" => "882a7764-5f0e-43b5-b276-0d1c39189488", "name" => "my-vpc-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "available" }, { "classic_access" => false, "created_at" => "2019-01-27T14:39:40Z", "crn" => "crn:[...]", "default_network_acl" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/dcfd9b64-9119-48ea-8697-23f9f5fb6bd6", "id" => "dcfd9b64-9119-48ea-8697-23f9f5fb6bd6", "name" => "my-network-acl" }, "default_routing_table" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/2a842e76-1302-45ad-8b1f-cc7eb0f3868b/routing_tables/f4e65793-1b51-4548-b0c5-769e18d64775", "id" => "f4e65793-1b51-4548-b0c5-769e18d64775", "name" => "my-routing-table", "resource_type" => "routing_table" }, "default_security_group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/95770f87-81f3-4164-8f6d-9f54a3f3a459", "id" => "95770f87-81f3-4164-8f6d-9f54a3f3a459", "name" => "my-security-group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339", "id" => "2a842e76-1302-45ad-8b1f-cc7eb0f3868b", "name" => "my-vpc-2", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "available" }] }

    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs?generation=2&version=2022-03-29")
      .with(
        headers: {
          "Accept" => "application/json"
        }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpcs

    assert_equal(message_response, service_response.result)
  end

  def test_create_vpc
    message_response = { "classic_access" => false, "created_at" => "2019-01-27T14:39:40Z", "crn" => "crn:[...]",
                         "default_network_acl" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/dcfd9b64-9119-48ea-8697-23f9f5fb6bd6", "id" => "dcfd9b64-9119-48ea-8697-23f9f5fb6bd6", "name" => "my-network-acl" }, "default_routing_table" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/2a842e76-1302-45ad-8b1f-cc7eb0f3868b/routing_tables/f4e65793-1b51-4548-b0c5-769e18d64775", "id" => "f4e65793-1b51-4548-b0c5-769e18d64775", "name" => "my-routing-table", "resource_type" => "routing_table" }, "default_security_group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/95770f87-81f3-4164-8f6d-9f54a3f3a459", "id" => "95770f87-81f3-4164-8f6d-9f54a3f3a459", "name" => "my-security-group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339", "id" => "2a842e76-1302-45ad-8b1f-cc7eb0f3868b", "name" => "my-vpc-2", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "available" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/vpcs?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_vpc

    assert_equal(message_response, service_response.result)
  end

  def test_delete_vpc
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339?generation=2&version=2022-03-29")
      .with(
        headers: { "Host" => "us-south.iaas.cloud.ibm.com" }
      )
      .to_return(status: 204, body: message_response.to_json, headers: headers)

    service.delete_vpc(id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339")
  end

  def test_get_vpc
    message_response = {
      "classic_access" => false,
      "created_at" => "2019-01-27T14:39:40Z",
      "crn" => "crn:[...]",
      "default_network_acl" => {
        "crn" => "crn:[...]",
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/dcfd9b64-9119-48ea-8697-23f9f5fb6bd6",
        "f64efe74-a5a2-45c7-b37d-5071d2dd6339" => "dcfd9b64-9119-48ea-8697-23f9f5fb6bd6",
        "name" => "my-network-acl"
      },
      "default_routing_table" => {
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/2a842e76-1302-45ad-8b1f-cc7eb0f3868b/routing_tables/f4e65793-1b51-4548-b0c5-769e18d64775", "id" => "f4e65793-1b51-4548-b0c5-769e18d64775", "name" => "my-routing-table", "resource_type" => "routing_table"
      }, "default_security_group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/95770f87-81f3-4164-8f6d-9f54a3f3a459",
                                       "id" => "95770f87-81f3-4164-8f6d-9f54a3f3a459",
                                       "name" => "my-security-group" },
      "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339",
      "id" => "2a842e76-1302-45ad-8b1f-cc7eb0f3868b",
      "name" => "my-vpc-2",
      "resource_group" => {
        "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21",
        "id" => "4bbce614c13444cd8fc5e7e878ef8e21",
        "name" => "Default"
      },
      "status" => "available"
    }

    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)

    service_response = service.get_vpc(id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339")

    assert_equal(message_response, service_response.result)
  end

  def test_update_vpc
    message_response = { "classic_access" => false, "created_at" => "2019-01-27T14:39:40Z", "crn" => "crn:[...]",
                         "default_network_acl" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/dcfd9b64-9119-48ea-8697-23f9f5fb6bd6", "id" => "dcfd9b64-9119-48ea-8697-23f9f5fb6bd6", "name" => "my-network-acl" }, "default_routing_table" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/2a842e76-1302-45ad-8b1f-cc7eb0f3868b/routing_tables/f4e65793-1b51-4548-b0c5-769e18d64775", "id" => "f4e65793-1b51-4548-b0c5-769e18d64775", "name" => "my-routing-table", "resource_type" => "routing_table" }, "default_security_group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/95770f87-81f3-4164-8f6d-9f54a3f3a459", "id" => "95770f87-81f3-4164-8f6d-9f54a3f3a459", "name" => "my-security-group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339", "id" => "2a842e76-1302-45ad-8b1f-cc7eb0f3868b", "name" => "my-vpc-2-updated", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "available" }

    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_vpc(id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339",
                                          vpc_patch: { name: "my-vpc-2-updated" })

    assert_equal(message_response, service_response.result)
  end

  def test_get_vpc_default_network_acl
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/default_network_acl?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpc_default_network_acl(id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339")

    assert_equal(message_response, service_response.result)
  end

  def test_get_vpc_default_routing_table
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/default_routing_table?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpc_default_routing_table(id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339")

    assert_equal(message_response, service_response.result)
  end

  def test_get_vpc_default_security_group
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/default_security_group?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpc_default_security_group(id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339")

    assert_equal(message_response, service_response.result)
  end

  def test_list_vpc_address_prefixes
    message_response = {
      "address_prefixes" => [
        { "cidr" => "10.1.0.0/16", "created_at" => "2019-01-07T16:56:54Z", "has_subnets" => false,
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/address_prefixes/df760133-3513-47e7-b980-26cca666561b", "id" => "df760133-3513-47e7-b980-26cca666561b", "is_default" => true, "name" => "my-vpc-address-prefix-1", "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }, { "cidr" => "10.1.0.0/16", "created_at" => "2019-01-03T17:36:24Z", "has_subnets" => true, "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/address_prefixes/df760133-3513-47e7-b980-26cca666561b", "id" => "df760133-3513-47e7-b980-26cca666561b", "is_default" => true, "name" => "my-vpc-address-prefix-2", "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
      ], "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/address_prefixes?limit=50" }, "limit" => 50, "total_count" => 2
    }

    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/address_prefixes?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpc_address_prefixes(vpc_id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339")

    assert_equal(message_response, service_response.result)
  end

  def test_create_vpc_address_prefix
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/address_prefixes?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" },
        body: { "cidr" => "10.1.0.0/16",
                "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1",
                            "name" => "us-south-1" } }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)

    service_response = service.create_vpc_address_prefix(
      vpc_id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339",
      cidr: "10.1.0.0/16",
      zone: {
        "href": "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1",
        "name": "us-south-1"
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_vpc_address_prefix
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/address_prefixes/df760133-3513-47e7-b980-26cca666561b?generation=2&version=2022-03-29")
      .with(
        headers: { "Host" => "us-south.iaas.cloud.ibm.com" }
      )
      .to_return(status: 204, body: message_response.to_json, headers: headers)

    service.delete_vpc_address_prefix(
      vpc_id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339",
      id: "df760133-3513-47e7-b980-26cca666561b"
    )
  end

  def test_get_vpc_address_prefix
    message_response = { "cidr" => "10.1.0.0/16", "created_at" => "2019-01-07T16:56:54Z", "has_subnets" => false,
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/address_prefixes/df760133-3513-47e7-b980-26cca666561b", "id" => "df760133-3513-47e7-b980-26cca666561b", "is_default" => false, "name" => "my-vpc-address-prefix-1", "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/address_prefixes/df760133-3513-47e7-b980-26cca666561b?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpc_address_prefix(
      vpc_id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339",
      id: "df760133-3513-47e7-b980-26cca666561b"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_vpc_address_prefix
    message_response = { "cidr" => "10.1.0.0/16", "created_at" => "2019-01-07T16:56:54Z", "has_subnets" => false,
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/address_prefixes/df760133-3513-47e7-b980-26cca666561b?generation=2&version=2022-03-29", "id" => "df760133-3513-47e7-b980-26cca666561b", "is_default" => false, "name" => "my-vpc-address-prefix-1-updated", "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/address_prefixes/df760133-3513-47e7-b980-26cca666561b?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_vpc_address_prefix(
      vpc_id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339",
      id: "df760133-3513-47e7-b980-26cca666561b",
      address_prefix_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_vpc_routes
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f64efe74-a5a2-45c7-b37d-5071d2dd6339/routes?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpc_routes(
      vpc_id: "f64efe74-a5a2-45c7-b37d-5071d2dd6339"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_vpc_route
    message_response = { "action" => "deliver", "created_at" => "2019-08-19T04:42:42Z", "destination" => "192.168.32.0/26",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "id" => "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "lifecycle_state" => "stable", "name" => "my-vpc-route", "next_hop" => { "address" => "192.168.64.9" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routes?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_vpc_route(
      vpc_id: "128c1fcf-79bc-40d0-88a1-b7c58f05cf5b",
      destination: "192.168.32.0/26",
      next_hop: { "address" => "192.168.64.9" },
      zone: {
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2",
        "name" => "us-south-2"
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_vpc_route
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19?generation=2&version=2022-03-29")
      .with(
        headers: { "Host" => "us-south.iaas.cloud.ibm.com" }
      )
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_vpc_route(
      vpc_id: "128c1fcf-79bc-40d0-88a1-b7c58f05cf5b",
      id: "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19"
    )
  end

  def test_get_vpc_route
    message_response = { "action" => "deliver", "created_at" => "2019-08-19T04:42:42Z", "destination" => "192.168.32.0/26",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "id" => "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "lifecycle_state" => "stable", "name" => "my-vpc-route", "next_hop" => { "address" => "192.168.64.9" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpc_route(
      vpc_id: "128c1fcf-79bc-40d0-88a1-b7c58f05cf5b",
      id: "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_vpc_route
    message_response = { "action" => "deliver", "created_at" => "2019-08-19T04:42:42Z", "destination" => "192.168.32.0/26",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "id" => "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "lifecycle_state" => "stable", "name" => "my-vpc-route-2", "next_hop" => { "address" => "192.168.64.9" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_vpc_route(
      vpc_id: "128c1fcf-79bc-40d0-88a1-b7c58f05cf5b",
      id: "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19",
      route_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_vpc_routing_tables
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routing_tables?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpc_routing_tables(
      vpc_id: "128c1fcf-79bc-40d0-88a1-b7c58f05cf5b"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_vpc_routing_table
    message_response = { "created_at" => "2019-01-03T17:36:24Z",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/eee6e0f4-ff31-41b4-8584-3cdd50b8fffe", "id" => "eee6e0f4-ff31-41b4-8584-3cdd50b8fffe", "is_default" => false, "lifecycle_state" => "stable", "name" => "my-routing-table", "resource_type" => "routing_table", "route_direct_link_ingress" => false, "route_transit_gateway_ingress" => false, "route_vpc_zone_ingress" => false, "routes" => [], "subnets" => [] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routing_tables?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_vpc_routing_table(
      vpc_id: "128c1fcf-79bc-40d0-88a1-b7c58f05cf5b"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_vpc_routing_table
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/eee6e0f4-ff31-41b4-8584-3cdd50b8fffe?generation=2&version=2022-03-29")
      .with(
        headers: { "Host" => "us-south.iaas.cloud.ibm.com" }
      )
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_vpc_routing_table(
      vpc_id: "982d72b7-db1b-4606-afb2-ed6bd4b0bed1",
      id: "eee6e0f4-ff31-41b4-8584-3cdd50b8fffe"
    )
  end

  def test_get_vpc_routing_table
    message_response = { "created_at" => "2019-01-03T17:36:24Z",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/eee6e0f4-ff31-41b4-8584-3cdd50b8fffe", "id" => "eee6e0f4-ff31-41b4-8584-3cdd50b8fffe", "is_default" => false, "lifecycle_state" => "stable", "name" => "my-routing-table", "resource_type" => "routing_table", "route_direct_link_ingress" => false, "route_transit_gateway_ingress" => false, "route_vpc_zone_ingress" => false, "routes" => [], "subnets" => [] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/eee6e0f4-ff31-41b4-8584-3cdd50b8fffe?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpc_routing_table(
      vpc_id: "982d72b7-db1b-4606-afb2-ed6bd4b0bed1",
      id: "eee6e0f4-ff31-41b4-8584-3cdd50b8fffe"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_vpc_routing_table
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/eee6e0f4-ff31-41b4-8584-3cdd50b8fffe?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_vpc_routing_table(
      vpc_id: "982d72b7-db1b-4606-afb2-ed6bd4b0bed1",
      id: "eee6e0f4-ff31-41b4-8584-3cdd50b8fffe",
      routing_table_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_vpc_routing_table_routes
    message_response = {
      "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/ebdc5374-2050-4f9e-a357-27b5a1a664cf/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes?limit=50" }, "limit" => 50, "routes" => [
        { "action" => "deliver", "created_at" => "2019-08-22T05:08:10Z", "destination" => "192.0.2.1/26",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/ebdc5374-2050-4f9e-a357-27b5a1a664cf/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes/f100dde3-a112-4fa8-a90c-100d4dad4889", "id" => "f100dde3-a112-4fa8-a90c-100d4dad4889", "lifecycle_state" => "stable", "name" => "my-vpc-route-1", "next_hop" => { "address" => "192.0.2.4" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }, { "action" => "deliver", "created_at" => "2019-08-19T04:42:42Z", "destination" => "192.0.2.5/26", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "id" => "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "lifecycle_state" => "stable", "name" => "my-vpc-route-2", "next_hop" => { "address" => "192.0.2.6" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
      ], "total_count" => 2
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/eee6e0f4-ff31-41b4-8584-3cdd50b8fffe/routes?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpc_routing_table_routes(
      vpc_id: "982d72b7-db1b-4606-afb2-ed6bd4b0bed1",
      routing_table_id: "eee6e0f4-ff31-41b4-8584-3cdd50b8fffe"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_vpc_routing_table_route
    message_response = { "action" => "deliver", "created_at" => "2019-08-19T04:42:42Z", "destination" => "192.168.32.0/26",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "id" => "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "lifecycle_state" => "stable", "name" => "my-vpc-route", "next_hop" => { "address" => "192.168.64.9" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/eee6e0f4-ff31-41b4-8584-3cdd50b8fffe/routes?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_vpc_routing_table_route(
      vpc_id: "982d72b7-db1b-4606-afb2-ed6bd4b0bed1",
      routing_table_id: "eee6e0f4-ff31-41b4-8584-3cdd50b8fffe",
      destination: "192.168.32.0/26",
      next_hop: { "address" => "192.168.64.9" },
      zone: {
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2",
        "name" => "us-south-2"
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_vpc_routing_table_route
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19?generation=2&version=2022-03-29")
      .with(
        headers: { "Host" => "us-south.iaas.cloud.ibm.com" }
      )
      .to_return(status: 204, body: message_response.to_json, headers: headers)

    service.delete_vpc_routing_table_route(
      vpc_id: "128c1fcf-79bc-40d0-88a1-b7c58f05cf5b",
      routing_table_id: "6885e83f-03b2-4603-8a86-db2a0f55c840",
      id: "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19"
    )
  end

  def test_get_vpc_routing_table_route
    message_response = { "action" => "deliver", "created_at" => "2019-08-19T04:42:42Z", "destination" => "192.168.32.0/26",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "id" => "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "lifecycle_state" => "stable", "name" => "my-vpc-route", "next_hop" => { "address" => "192.168.64.9" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpc_routing_table_route(
      vpc_id: "128c1fcf-79bc-40d0-88a1-b7c58f05cf5b",
      routing_table_id: "6885e83f-03b2-4603-8a86-db2a0f55c840",
      id: "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_vpc_routing_table_route
    message_response = { "action" => "deliver", "created_at" => "2019-08-19T04:42:42Z", "destination" => "192.168.32.0/26",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "id" => "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19", "lifecycle_state" => "stable", "name" => "my-vpc-route-updated", "next_hop" => { "address" => "192.168.64.9" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/vpcs/128c1fcf-79bc-40d0-88a1-b7c58f05cf5b/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes/9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_vpc_routing_table_route(
      vpc_id: "128c1fcf-79bc-40d0-88a1-b7c58f05cf5b",
      routing_table_id: "6885e83f-03b2-4603-8a86-db2a0f55c840",
      id: "9cdddd42-8ce1-4ca9-ba65-06ffd4d6cf19",
      route_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_subnets
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets?limit=50" }, "limit" => 50,
                         "subnets" => [{ "available_ipv4_address_count" => 251, "created_at" => "2019-01-28T11:59:46Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959", "id" => "8722d01c-9c78-4555-82b5-53ad1266f959", "ip_version" => "ipv4", "ipv4_cidr_block" => "10.0.1.0/24", "name" => "my-subnet-1", "network_acl" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d", "id" => "3217cb8b-5368-452a-9399-a84f14fb539d", "name" => "my-network-acl" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "routing_table" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840", "id" => "6885e83f-03b2-4603-8a86-db2a0f55c840", "name" => "my-routing-table", "resource_type" => "routing_table" }, "status" => "pending", "total_ipv4_address_count" => 256, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }, { "available_ipv4_address_count" => 251, "created_at" => "2019-01-29T10:53:46Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/10a4a88a-f20f-4d3e-9582-499ea21bbaf3", "id" => "10a4a88a-f20f-4d3e-9582-499ea21bbaf3", "ip_version" => "ipv4", "ipv4_cidr_block" => "10.0.2.0/24", "name" => "my-subnet-2", "network_acl" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d", "id" => "3217cb8b-5368-452a-9399-a84f14fb539d", "name" => "my-network-acl" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "routing_table" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840", "id" => "6885e83f-03b2-4603-8a86-db2a0f55c840", "name" => "my-routing-table", "resource_type" => "routing_table" }, "status" => "pending", "total_ipv4_address_count" => 256, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }], "total_count" => 2 }

    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/subnets?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_subnets

    assert_equal(message_response, service_response.result)
  end

  def test_create_subnet
    message_response = { "available_ipv4_address_count" => 251, "created_at" => "2019-01-28T11:59:46Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959", "id" => "8722d01c-9c78-4555-82b5-53ad1266f959", "ip_version" => "ipv4", "ipv4_cidr_block" => "10.0.1.0/24", "name" => "my-subnet-1", "network_acl" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d", "id" => "3217cb8b-5368-452a-9399-a84f14fb539d", "name" => "my-network-acl" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "routing_table" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840", "id" => "6885e83f-03b2-4603-8a86-db2a0f55c840", "name" => "my-routing-table", "resource_type" => "routing_table" }, "status" => "pending", "total_ipv4_address_count" => 256, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/subnets?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_subnet(
      subnet_prototype: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_subnet
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959?generation=2&version=2022-03-29")
      .with(
        headers: { "Host" => "us-south.iaas.cloud.ibm.com" }
      )
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_subnet(
      id: "8722d01c-9c78-4555-82b5-53ad1266f959"
    )
  end

  def test_get_subnet
    message_response = { "available_ipv4_address_count" => 251, "created_at" => "2019-01-28T11:59:46Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/1dfeccef-3ad6-4760-8653-a202bc795db4", "id" => "1dfeccef-3ad6-4760-8653-a202bc795db4", "ip_version" => "ipv4", "ipv4_cidr_block" => "10.0.1.0/24", "name" => "my-subnet-1", "network_acl" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d", "id" => "3217cb8b-5368-452a-9399-a84f14fb539d", "name" => "my-network-acl" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "routing_table" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840", "id" => "6885e83f-03b2-4603-8a86-db2a0f55c840", "name" => "my-routing-table", "resource_type" => "routing_table" }, "status" => "pending", "total_ipv4_address_count" => 256, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_subnet(
      id: "8722d01c-9c78-4555-82b5-53ad1266f959"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_subnet
    message_response = { "available_ipv4_address_count" => 251, "created_at" => "2019-01-28T11:59:46Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/1dfeccef-3ad6-4760-8653-a202bc795db4", "id" => "1dfeccef-3ad6-4760-8653-a202bc795db4", "ip_version" => "ipv4", "ipv4_cidr_block" => "10.0.1.0/24", "name" => "my-subnet-1-modified", "network_acl" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d", "id" => "3217cb8b-5368-452a-9399-a84f14fb539d", "name" => "my-network-acl" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "routing_table" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840", "id" => "6885e83f-03b2-4603-8a86-db2a0f55c840", "name" => "my-routing-table", "resource_type" => "routing_table" }, "status" => "pending", "total_ipv4_address_count" => 256, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_subnet(
      id: "8722d01c-9c78-4555-82b5-53ad1266f959",
      subnet_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_get_subnet_network_acl
    message_response = { "created_at" => "2019-01-29T07:21:17Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/e9d38838-7531-4383-bd01-662e10527f29", "id" => "e9d38838-7531-4383-bd01-662e10527f29", "name" => "my-network-acl-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "action" => "allow", "created_at" => "2019-01-29T07:21:17Z", "destination" => "0.0.0.0/0", "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee", "id" => "cb19f11d-0e25-4650-a8ab-f4539da563ee", "ip_version" => "ipv4", "name" => "my-allow-all-inbound-rule", "protocol" => "all", "source" => "0.0.0.0/0" }, { "action" => "allow", "created_at" => "2019-01-29T07:21:17Z", "destination" => "0.0.0.0/0", "direction" => "outbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/2c46afc9-b30a-4453-8897-1096383fb053", "id" => "2c46afc9-b30a-4453-8897-1096383fb053", "ip_version" => "ipv4", "name" => "my-allow-all-outbound-rule", "protocol" => "all", "source" => "0.0.0.0/0" }], "subnets" => [{ "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "id" => "3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "name" => "subnet-1" }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959/network_acl?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_subnet_network_acl(
      id: "8722d01c-9c78-4555-82b5-53ad1266f959"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_replace_subnet_network_acl
    message_response = { "created_at" => "2019-01-29T07:21:17Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/8ec3e730-f2b0-4855-a1a5-88be30024658", "id" => "8ec3e730-f2b0-4855-a1a5-88be30024658", "name" => "my-network-acl-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "action" => "allow", "created_at" => "2019-01-29T07:21:17Z", "destination" => "0.0.0.0/0", "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/8ec3e730-f2b0-4855-a1a5-88be30024658/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee", "id" => "cb19f11d-0e25-4650-a8ab-f4539da563ee", "ip_version" => "ipv4", "name" => "my-allow-all-inbound-rule", "protocol" => "all", "source" => "0.0.0.0/0" }, { "action" => "allow", "created_at" => "2019-01-29T07:21:17Z", "destination" => "0.0.0.0/0", "direction" => "outbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/8ec3e730-f2b0-4855-a1a5-88be30024658/rules/2c46afc9-b30a-4453-8897-1096383fb053", "id" => "2c46afc9-b30a-4453-8897-1096383fb053", "ip_version" => "ipv4", "name" => "my-allow-all-outbound-rule", "protocol" => "all", "source" => "0.0.0.0/0" }], "subnets" => [{ "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "id" => "3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "name" => "subnet-1" }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:put, "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959/network_acl?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.replace_subnet_network_acl(
      id: "8722d01c-9c78-4555-82b5-53ad1266f959",
      network_acl_identity: ""
    )

    assert_equal(message_response, service_response.result)
  end

  def test_unset_subnet_public_gateway
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959/public_gateway?generation=2&version=2022-03-29")
      .with(
        headers: { "Host" => "us-south.iaas.cloud.ibm.com" }
      )
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.unset_subnet_public_gateway(
      id: "8722d01c-9c78-4555-82b5-53ad1266f959"
    )
  end

  def test_get_subnet_public_gateway
    message_response = { "created_at" => "2019-01-27T06:47:20Z", "crn" => "crn:[...]",
                         "floating_ip" => { "address" => "192.0.2.2", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "f5380e82-cba3-4efa-b17c-ef0993936e05", "name" => "my-floating-ip-1" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/public_gateways/d4d3ef82-bebb-446e-bbe4-038bc82f6776", "id" => "ba1b3bf9-27ab-498d-8aac-c30b09b5555b", "name" => "my-public-gateway-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "public_gateway", "status" => "available", "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc-1" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/subnets/d4d3ef82-bebb-446e-bbe4-038bc82f6776/public_gateway?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_subnet_public_gateway(
      id: "d4d3ef82-bebb-446e-bbe4-038bc82f6776"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_set_subnet_public_gateway
    message_response = { "created_at" => "2019-01-27T06:47:20Z", "crn" => "crn:[...]",
                         "floating_ip" => { "address" => "192.0.2.2", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "f5380e82-cba3-4efa-b17c-ef0993936e05", "name" => "my-floating-ip-1" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/public_gateways/4fd00a61-fe63-4186-81c9-f7253b5c1cd7", "id" => "4fd00a61-fe63-4186-81c9-f7253b5c1cd7", "name" => "my-public-gateway-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "public_gateway", "status" => "available", "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc-1" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:put, "https://us-south.iaas.cloud.ibm.com/v1/subnets/4fd00a61-fe63-4186-81c9-f7253b5c1cd7/public_gateway?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.set_subnet_public_gateway(
      id: "4fd00a61-fe63-4186-81c9-f7253b5c1cd7",
      public_gateway_identity: ""
    )

    assert_equal(message_response, service_response.result)
  end

  def test_get_subnet_routing_table
    message_response = { "created_at" => "2019-01-07T16:56:54Z",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840", "id" => "6885e83f-03b2-4603-8a86-db2a0f55c840", "is_default" => false, "lifecycle_state" => "stable", "name" => "minty-electric-energy-modeling", "resource_type" => "routing_table", "route_direct_link_ingress" => false, "route_transit_gateway_ingress" => false, "route_vpc_zone_ingress" => false, "routes" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes/ae54c371-56be-4306-91bd-bb64df239d69", "id" => "ae54c371-56be-4306-91bd-bb64df239d69", "name" => "my-route-1" }], "subnets" => [{ "crn" => "crn:v1:bluemix:public:is:us-south-1:a/123456::subnet:8722d01c-9c78-4555-82b5-53ad1266f959", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959", "id" => "8722d01c-9c78-4555-82b5-53ad1266f959", "name" => "my-subnet-1" }, { "crn" => "crn:v1:bluemix:public:is:us-south-1:a/123456::subnet:7ec86020-1c6e-4889-b3f0-a15f2e50f87e", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7ec86020-1c6e-4889-b3f0-a15f2e50f87e", "id" => "7ec86020-1c6e-4889-b3f0-a15f2e50f87e", "name" => "my-subnet-2" }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/subnets/6885e83f-03b2-4603-8a86-db2a0f55c840/routing_table?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_subnet_routing_table(
      id: "6885e83f-03b2-4603-8a86-db2a0f55c840"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_replace_subnet_routing_table
    message_response = { "created_at" => "2019-01-07T16:56:54Z",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840", "id" => "6885e83f-03b2-4603-8a86-db2a0f55c840", "is_default" => false, "lifecycle_state" => "stable", "name" => "minty-electric-energy-modeling", "resource_type" => "routing_table", "route_direct_link_ingress" => false, "route_transit_gateway_ingress" => false, "route_vpc_zone_ingress" => false, "routes" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/982d72b7-db1b-4606-afb2-ed6bd4b0bed1/routing_tables/6885e83f-03b2-4603-8a86-db2a0f55c840/routes/ae54c371-56be-4306-91bd-bb64df239d69", "id" => "ae54c371-56be-4306-91bd-bb64df239d69", "name" => "my-route-1" }], "subnets" => [{ "crn" => "crn:v1:bluemix:public:is:us-south-1:a/123456::subnet:8722d01c-9c78-4555-82b5-53ad1266f959", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959", "id" => "8722d01c-9c78-4555-82b5-53ad1266f959", "name" => "my-subnet-1" }, { "crn" => "crn:v1:bluemix:public:is:us-south-1:a/123456::subnet:7ec86020-1c6e-4889-b3f0-a15f2e50f87e", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7ec86020-1c6e-4889-b3f0-a15f2e50f87e", "id" => "7ec86020-1c6e-4889-b3f0-a15f2e50f87e", "name" => "my-subnet-2" }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:put, "https://us-south.iaas.cloud.ibm.com/v1/subnets/6885e83f-03b2-4603-8a86-db2a0f55c840/routing_table?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.replace_subnet_routing_table(
      id: "6885e83f-03b2-4603-8a86-db2a0f55c840",
      routing_table_identity: ""
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_subnet_reserved_ips
    message_response = {
      "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips?limit=50" }, "limit" => 50, "reserved_ips" => [
        { "address" => "10.240.0.6", "auto_delete" => false, "created_at" => "2020-07-24T19:52:13Z",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5", "id" => "0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5", "name" => "my-reserved-ip-1", "owner" => "user", "resource_type" => "subnet_reserved_ip" }, { "address" => "10.240.0.7", "auto_delete" => false, "created_at" => "2020-07-24T19:52:18Z", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-9faf2f32-8528-4180-a14d-c1f6c5c83292", "id" => "0716-9faf2f32-8528-4180-a14d-c1f6c5c83292", "name" => "my-reserved-ip-2", "owner" => "user", "resource_type" => "subnet_reserved_ip" }
      ], "total_count" => 2
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_subnet_reserved_ips(
      subnet_id: "0716-b28a7e6d-a66b-4de7-8713-15dcffdce401"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_subnet_reserved_ip
    message_response = { "address" => "10.240.0.6", "auto_delete" => false, "created_at" => "2020-07-24T19:52:13Z",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5", "id" => "0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5", "name" => "my-reserved-ip-1", "owner" => "user", "resource_type" => "subnet_reserved_ip" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_subnet_reserved_ip(
      subnet_id: "0716-b28a7e6d-a66b-4de7-8713-15dcffdce401"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_subnet_reserved_ip
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_subnet_reserved_ip(
      subnet_id: "0716-b28a7e6d-a66b-4de7-8713-15dcffdce401",
      id: "0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5"
    )
  end

  def test_get_subnet_reserved_ip
    message_response = { "address" => "10.240.0.6", "auto_delete" => false, "created_at" => "2020-07-24T19:52:13Z",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5", "id" => "0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5", "name" => "my-reserved-ip-1", "owner" => "user", "resource_type" => "subnet_reserved_ip" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_subnet_reserved_ip(
      subnet_id: "0716-b28a7e6d-a66b-4de7-8713-15dcffdce401",
      id: "0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_subnet_reserved_ip
    message_response = { "address" => "10.240.0.6", "auto_delete" => false, "created_at" => "2020-07-24T19:52:13Z",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5", "id" => "0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5", "name" => "my-reserved-ip-1-modified", "owner" => "user", "resource_type" => "subnet_reserved_ip" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_subnet_reserved_ip(
      subnet_id: "0716-b28a7e6d-a66b-4de7-8713-15dcffdce401",
      id: "0716-7768a27e-cd6c-4a13-a9e6-d67a964e54a5",
      reserved_ip_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_images
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/images?limit=50" },
                         "images" => [{ "created_at" => "2019-03-15T21:31:37Z", "crn" => "crn:[...]", "encryption" => "none", "file" => {}, "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/5ccbc579-dc22-0def-46a8-9c2e9b502d37", "id" => "5ccbc579-dc22-0def-46a8-9c2e9b502d37", "minimum_provisioned_size" => 100, "name" => "windows-2016-amd64", "operating_system" => { "architecture" => "amd64", "display_name" => "Windows Server 2016 Standard Edition (amd64)", "family" => "Windows Server", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/windows-2016-amd64", "name" => "windows-2016-amd64", "vendor" => "Microsoft", "version" => "2016 Standard Edition" }, "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "status" => "available", "status_reasons" => [], "visibility" => "public" }, { "created_at" => "2018-10-04T04:04:25Z", "crn" => "crn:[...]", "encryption" => "none", "file" => {}, "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/e15b69f1-c701-f621-e752-70eda3df5695", "id" => "e15b69f1-c701-f621-e752-70eda3df5695", "minimum_provisioned_size" => 100, "name" => "debian-9-amd64", "operating_system" => { "architecture" => "amd64", "display_name" => "Debian GNU/Linux 9.x Stretch/Stable - Minimal Install (amd64)", "family" => "Debian GNU/Linux", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/debian-9-amd64", "name" => "debian-9-amd64", "vendor" => "Debian", "version" => "9.x Stretch/Stable - Minimal Install" }, "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "status" => "available", "status_reasons" => [], "visibility" => "public" }, { "created_at" => "2018-12-12T18:22:51Z", "crn" => "crn:[...]", "encryption" => "none", "file" => {}, "href" => "https://eu-de.iaas.cloud.ibm.com/v1/images/7eb4e35b-4257-56f8-d7da-326d85452591", "id" => "7eb4e35b-4257-56f8-d7da-326d85452591", "minimum_provisioned_size" => 100, "name" => "my-image", "operating_system" => { "architecture" => "amd64", "display_name" => "Ubuntu Linux 16.04 LTS Xenial Xerus Minimal Install (amd64)", "family" => "Ubuntu Linux", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/ubuntu-16-04-amd64", "name" => "ubuntu-16-04-amd64", "vendor" => "Canonical", "version" => "16.04 LTS Xenial Xerus Minimal Install" }, "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "status" => "available", "status_reasons" => [], "visibility" => "public" }], "limit" => 50 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/images?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_images

    assert_equal(message_response, service_response.result)
  end

  def test_create_image
    message_response = { "created_at" => "2019-06-26T00:05:13.873893Z", "crn" => "crn:[...]", "encryption" => "none",
                         "file" => {}, "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/72251a2e-d6c5-42b4-97b0-b5f8e8d1f479", "id" => "72251a2e-d6c5-42b4-97b0-b5f8e8d1f479", "name" => "my-image", "operating_system" => { "architecture" => "amd64", "display_name" => "Debian GNU/Linux 9.x Stretch/Stable - Minimal Install (amd64)", "family" => "Debian GNU/Linux", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/debian-9-amd64", "name" => "debian-9-amd64", "vendor" => "Debian", "version" => "9.x Stretch/Stable - Minimal Install" }, "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "status" => "pending", "status_reasons" => [], "visibility" => "private" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/images?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_image(
      image_prototype: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_image
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/images/72251a2e-d6c5-42b4-97b0-b5f8e8d1f479?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_image(
      id: "72251a2e-d6c5-42b4-97b0-b5f8e8d1f479"
    )
  end

  def test_get_image
    message_response = { "created_at" => "2019-06-26T00:05:13.873893Z", "crn" => "crn:[...]", "encryption" => "none",
                         "file" => { "size" => 10 }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/72251a2e-d6c5-42b4-97b0-b5f8e8d1f479", "id" => "72251a2e-d6c5-42b4-97b0-b5f8e8d1f479", "minimum_provisioned_size" => 100, "name" => "my-image", "operating_system" => { "architecture" => "amd64", "display_name" => "Debian GNU/Linux 9.x Stretch/Stable - Minimal Install (amd64)", "family" => "Debian GNU/Linux", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/debian-9-amd64", "name" => "debian-9-amd64", "vendor" => "Debian", "version" => "9.x Stretch/Stable - Minimal Install" }, "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "status" => "available", "status_reasons" => [], "visibility" => "private" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/images/72251a2e-d6c5-42b4-97b0-b5f8e8d1f479?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_image(
      id: "72251a2e-d6c5-42b4-97b0-b5f8e8d1f479"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_image
    message_response = { "created_at" => "2019-06-24T21:34:08.39622Z", "crn" => "crn:[...]", "encryption" => "none",
                         "file" => { "size" => 10 }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/f2ecdc05-452b-4b9a-ab18-7e129f730c15", "id" => "f2ecdc05-452b-4b9a-ab18-7e129f730c15", "minimum_provisioned_size" => 100, "name" => "my-image-patched", "operating_system" => { "architecture" => "amd64", "display_name" => "Debian GNU/Linux 9.x Stretch/Stable - Minimal Install (amd64)", "family" => "Debian GNU/Linux", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/debian-9-amd64", "name" => "debian-9-amd64", "vendor" => "Debian", "version" => "9.x Stretch/Stable - Minimal Install" }, "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "status" => "available", "status_reasons" => [], "visibility" => "private" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/images/72251a2e-d6c5-42b4-97b0-b5f8e8d1f479?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_image(
      id: "72251a2e-d6c5-42b4-97b0-b5f8e8d1f479",
      image_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_operating_systems
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems?limit=50" },
                         "limit" => 50, "operating_systems" => [{ "architecture" => "amd64", "display_name" => "CentOS 7.x - Minimal Install (amd64)", "family" => "CentOS", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/centos-7-amd64", "name" => "centos-7-amd64", "vendor" => "CentOS", "version" => "7.x - Minimal Install" }, { "architecture" => "amd64", "display_name" => "Debian GNU/Linux 8.x jessie/Stable - Minimal Install (amd64)", "family" => "Debian GNU/Linux", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/debian-8-amd64", "name" => "debian-8-amd64", "vendor" => "Debian", "version" => "8.x jessie/Stable - Minimal Install" }, { "architecture" => "amd64", "display_name" => "Debian GNU/Linux 9.x Stretch/Stable - Minimal Install (amd64)", "family" => "Debian GNU/Linux", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/debian-9-amd64", "name" => "debian-9-amd64", "vendor" => "Debian", "version" => "9.x Stretch/Stable - Minimal Install" }, { "architecture" => "amd64", "display_name" => "Red Hat Enterprise Linux 7.x - Minimal Install (amd64)", "family" => "Red Hat Enterprise Linux", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/red-7-amd64", "name" => "red-7-amd64", "vendor" => "Red Hat", "version" => "7.x - Minimal Install" }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/operating_systems?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_operating_systems

    assert_equal(message_response, service_response.result)
  end

  def test_get_operating_system
    message_response = { "architecture" => "amd64",
                         "display_name" => "Red Hat Enterprise Linux 7.x - Minimal Install (amd64)", "family" => "Red Hat Enterprise Linux", "href" => "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/red-7-amd64", "name" => "red-7-amd64", "vendor" => "Red Hat", "version" => "7.x - Minimal Install" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/operating_systems/red-7-amd64?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_operating_system(
      name: "red-7-amd64"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_placement_groups
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/placement_groups?limit=50" },
                         "placement_groups" => [{ "created_at" => "2019-01-29T03:48:11.000Z", "crn" => "crn:[...]", "fingerprint" => "SHA256:RJ+YWs2kupwFGiJuLqY85twmcdLOUcjIc9cA6IR8n8E", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/82679077-ac3b-4c10-be16-63e9c21f0f45", "id" => "82679077-ac3b-4c10-be16-63e9c21f0f45", "length" => 2048, "name" => "my-key-1", "public_key" => "ssh-rsa AAAAB...n", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "type" => "rsa" }, { "created_at" => "2019-01-21T01:28:11.000Z", "crn" => "crn:[...]", "fingerprint" => "SHA256:XgUFJWiZbPehNHl706+mJbZdPDmSJh8G2ycvCYR2t5U", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/a9f3ae27-4769-43e3-b5a3-a2856fbad468", "id" => "a9f3ae27-4769-43e3-b5a3-a2856fbad468", "length" => 2048, "name" => "my-key-2", "public_key" => "ssh-rsa BBBBC...n", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "type" => "rsa" }], "limit" => 50, "total_count" => 2 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/placement_groups?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_placement_groups

    assert_equal(message_response, service_response.result)
  end

  def test_create_placement_group
    message_response = { "created_at" => "2019-01-29T03:48:11.000Z", "crn" => "crn:[...]",
                         "fingerprint" => "SHA256:RJ+YWs2kupwFGiJuLqY85twmcdLOUcjIc9cA6IR8n8E", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/82679077-ac3b-4c10-be16-63e9c21f0f45", "id" => "82679077-ac3b-4c10-be16-63e9c21f0f45", "length" => 2048, "name" => "my-key-1", "public_key" => "ssh-rsa AAAAB...n", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "type" => "rsa" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/placement_groups?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_placement_group(
      strategy: "host_spread"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_placement_group
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/placement_groups/3fad3f2204eb4998c3964d254ffcd771?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_placement_group(
      id: "3fad3f2204eb4998c3964d254ffcd771"
    )
  end

  def test_get_placement_group
    message_response = { "created_at" => "2019-01-29T03:48:11.000Z", "crn" => "crn:[...]",
                         "fingerprint" => "SHA256:RJ+YWs2kupwFGiJuLqY85twmcdLOUcjIc9cA6IR8n8E", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/82679077-ac3b-4c10-be16-63e9c21f0f45", "id" => "82679077-ac3b-4c10-be16-63e9c21f0f45", "length" => 2048, "name" => "my-key-1", "public_key" => "ssh-rsa AAAAB...n", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "type" => "rsa" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/placement_groups/3fad3f2204eb4998c3964d254ffcd771?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_placement_group(
      id: "3fad3f2204eb4998c3964d254ffcd771"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_placement_group
    message_response = { "created_at" => "2019-01-29T03:48:11.000Z", "crn" => "crn:[...]",
                         "fingerprint" => "SHA256:RJ+YWs2kupwFGiJuLqY85twmcdLOUcjIc9cA6IR8n8E", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/82679077-ac3b-4c10-be16-63e9c21f0f45", "id" => "82679077-ac3b-4c10-be16-63e9c21f0f45", "length" => 2048, "name" => "my-key-1", "public_key" => "ssh-rsa AAAAB...n", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "type" => "rsa" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/placement_groups/3fad3f2204eb4998c3964d254ffcd771?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_placement_group(
      id: "3fad3f2204eb4998c3964d254ffcd771",
      placement_group_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_keys
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys?limit=50" },
                         "keys" => [{ "created_at" => "2019-01-29T03:48:11.000Z", "crn" => "crn:[...]", "fingerprint" => "SHA256:RJ+YWs2kupwFGiJuLqY85twmcdLOUcjIc9cA6IR8n8E", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/82679077-ac3b-4c10-be16-63e9c21f0f45", "id" => "82679077-ac3b-4c10-be16-63e9c21f0f45", "length" => 2048, "name" => "my-key-1", "public_key" => "ssh-rsa AAAAB...n", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "type" => "rsa" }, { "created_at" => "2019-01-21T01:28:11.000Z", "crn" => "crn:[...]", "fingerprint" => "SHA256:XgUFJWiZbPehNHl706+mJbZdPDmSJh8G2ycvCYR2t5U", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/a9f3ae27-4769-43e3-b5a3-a2856fbad468", "id" => "a9f3ae27-4769-43e3-b5a3-a2856fbad468", "length" => 2048, "name" => "my-key-2", "public_key" => "ssh-rsa BBBBC...n", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "type" => "rsa" }], "limit" => 50, "total_count" => 2 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/keys?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_keys

    assert_equal(message_response, service_response.result)
  end

  def test_create_key
    message_response = { "created_at" => "2019-01-29T03:48:11.000Z", "crn" => "crn:[...]",
                         "fingerprint" => "SHA256:RJ+YWs2kupwFGiJuLqY85twmcdLOUcjIc9cA6IR8n8E", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/82679077-ac3b-4c10-be16-63e9c21f0f45", "id" => "82679077-ac3b-4c10-be16-63e9c21f0f45", "length" => 2048, "name" => "my-key-1", "public_key" => "ssh-rsa AAAAB...n", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "type" => "rsa" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/keys?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_key(
      public_key: "ssh-rsa AAAAB...n"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_key
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/keys/3fad3f2204eb4998c3964d254ffcd771?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_key(
      id: "3fad3f2204eb4998c3964d254ffcd771"
    )
  end

  def test_get_key
    message_response = { "created_at" => "2019-01-29T03:48:11.000Z", "crn" => "crn:[...]",
                         "fingerprint" => "SHA256:RJ+YWs2kupwFGiJuLqY85twmcdLOUcjIc9cA6IR8n8E", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/82679077-ac3b-4c10-be16-63e9c21f0f45", "id" => "82679077-ac3b-4c10-be16-63e9c21f0f45", "length" => 2048, "name" => "my-key-1", "public_key" => "ssh-rsa AAAAB...n", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "type" => "rsa" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/keys/3fad3f2204eb4998c3964d254ffcd771?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_key(
      id: "3fad3f2204eb4998c3964d254ffcd771"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_key
    message_response = { "created_at" => "2019-01-29T03:48:11.000Z", "crn" => "crn:[...]",
                         "fingerprint" => "SHA256:RJ+YWs2kupwFGiJuLqY85twmcdLOUcjIc9cA6IR8n8E", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/82679077-ac3b-4c10-be16-63e9c21f0f45", "id" => "82679077-ac3b-4c10-be16-63e9c21f0f45", "length" => 2048, "name" => "my-key-1", "public_key" => "ssh-rsa AAAAB...n", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "type" => "rsa" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/keys/3fad3f2204eb4998c3964d254ffcd771?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_key(
      id: "3fad3f2204eb4998c3964d254ffcd771",
      key_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_instance_profiles
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles?limit=3" },
                         "limit" => 3, "profiles" => [{ "bandwidth" => { "type" => "fixed", "value" => 4000 }, "family" => "balanced", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "memory" => { "type" => "fixed", "value" => 8 }, "name" => "bx2-2x8", "os_architecture" => { "default" => "amd64", "type" => "enum", "values" => ["amd64"] }, "port_speed" => { "type" => "fixed", "value" => 16_000 }, "vcpu_architecture" => { "type" => "fixed", "value" => "amd64" }, "vcpu_count" => { "type" => "fixed", "value" => 2 } }, { "bandwidth" => { "type" => "fixed", "value" => 8000 }, "family" => "balanced", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-4x16", "memory" => { "type" => "fixed", "value" => 16 }, "name" => "bx2-4x16", "os_architecture" => { "default" => "amd64", "type" => "enum", "values" => ["amd64"] }, "port_speed" => { "type" => "fixed", "value" => 16_000 }, "vcpu_architecture" => { "type" => "fixed", "value" => "amd64" }, "vcpu_count" => { "type" => "fixed", "value" => 4 } }, { "bandwidth" => { "type" => "fixed", "value" => 16_000 }, "family" => "balanced", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-8x32", "memory" => { "type" => "fixed", "value" => 32 }, "name" => "bx2-8x32", "os_architecture" => { "default" => "amd64", "type" => "enum", "values" => ["amd64"] }, "port_speed" => { "type" => "fixed", "value" => 16_000 }, "vcpu_architecture" => { "type" => "fixed", "value" => "amd64" }, "vcpu_count" => { "type" => "fixed", "value" => 8 } }], "total_count" => 3 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_profiles

    assert_equal(message_response, service_response.result)
  end

  def test_get_instance_profile
    message_response = { "bandwidth" => { "type" => "fixed", "value" => 16_000 }, "family" => "balanced",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-8x32", "memory" => { "type" => "fixed", "value" => 32 }, "name" => "bx2-8x32", "os_architecture" => { "default" => "amd64", "type" => "enum", "values" => ["amd64"] }, "port_speed" => { "type" => "fixed", "value" => 16_000 }, "vcpu_architecture" => { "type" => "fixed", "value" => "amd64" }, "vcpu_count" => { "type" => "fixed", "value" => 8 } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-8x32?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_profile(
      name: "bx2-8x32"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_instance_templates
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/templates?limit=50" },
                         "limit" => 50, "templates" => [{ "boot_volume_attachment" => { "delete_volume_on_instance_delete" => false, "name" => "volume-attachment", "volume" => { "capacity" => 100, "name" => "my-instance-template-2-boot", "profile" => { "name" => "general-purpose" } } }, "created_at" => "2020-10-01T13:37:00Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/templates/07a7-3eb3a95b-997c-4108-a108-8f68f30f1d21", "id" => "07a7-3eb3a95b-997c-4108-a108-8f68f30f1d21", "image" => { "id" => "r018-6f153a5d-6a9a-496d-8063-5c39932f6ded" }, "keys" => [{ "id" => "r018-176f38a6-5d21-4cfb-ac20-f20d90d9e888" }], "name" => "my-instance-template-2", "primary_network_interface" => { "security_groups" => [{ "id" => "r018-f4793b96-4fc1-4a57-a18d-ff50d8001566" }], "subnet" => { "id" => "07a7-3162c0fc-178f-46da-b4ca-d9448824056c" } }, "profile" => { "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "vpc" => { "id" => "r018-d6979555-bf41-4755-ab78-f1f753a939e0" }, "zone" => { "name" => "us-south-3" } }], "total_count" => 1 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance/templates?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_templates

    assert_equal(message_response, service_response.result)
  end

  def test_create_instance_template
    message_response = {
      "boot_volume_attachment" => { "delete_volume_on_instance_delete" => true, "name" => "volume-attachment",
                                    "volume" => { "capacity" => 100, "name" => "my-instance-template-boot", "profile" => { "name" => "general-purpose" } } }, "created_at" => "2020-10-01T13:37:00Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "image" => { "id" => "r018-6f153a5d-6a9a-496d-8063-5c39932f6ded" }, "keys" => [{ "id" => "r018-176f38a6-5d21-4cfb-ac20-f20d90d9e888" }], "name" => "my-instance-template", "primary_network_interface" => { "security_groups" => [{ "id" => "r018-f4793b96-4fc1-4a57-a18d-ff50d8001566" }], "subnet" => { "id" => "07a7-3162c0fc-178f-46da-b4ca-d9448824056c" } }, "profile" => { "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "vpc" => { "id" => "r018-d6979555-bf41-4755-ab78-f1f753a939e0" }, "zone" => { "name" => "us-south-3" }
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/instance/templates?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" },
        body: '{"image":{"id":"3f9a2d96-830e-4100-9b4c-663225a3f872"},"keys":[{"id":"363f6d70-0000-0001-0000-00000013b96c"}],"name":"my-instance-template","primary_network_interface":{"subnet":{"id":"0d933c75-492a-4756-9832-1200585dfa79"}},"profile":{"name":"bx2-2x8"},"vpc":{"id":"dc201ab2-8536-4904-86a8-084d84582133"},"zone":{"name":"us-south-1"}}'
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_instance_template(
      instance_template_prototype: {
        "image": {
          "id": "3f9a2d96-830e-4100-9b4c-663225a3f872"
        },
        "keys": [
          {
            "id": "363f6d70-0000-0001-0000-00000013b96c"
          }
        ],
        "name": "my-instance-template",
        "primary_network_interface": {
          "subnet": {
            "id": "0d933c75-492a-4756-9832-1200585dfa79"
          }
        },
        "profile": {
          "name": "bx2-2x8"
        },
        "vpc": {
          "id": "dc201ab2-8536-4904-86a8-084d84582133"
        },
        "zone": {
          "name": "us-south-1"
        }
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance_template
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instance/templates/3f9a2d96-830e-4100-9b4c-663225a3f872?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_instance_template(
      id: "3f9a2d96-830e-4100-9b4c-663225a3f872"
    )
  end

  def test_get_instance_template
    message_response = {
      "boot_volume_attachment" => { "delete_volume_on_instance_delete" => true, "name" => "volume-attachment",
                                    "volume" => { "capacity" => 100, "name" => "my-instance-template-boot", "profile" => { "name" => "general-purpose" } } }, "created_at" => "2020-10-01T13:37:00Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "image" => { "id" => "r018-6f153a5d-6a9a-496d-8063-5c39932f6ded" }, "keys" => [{ "id" => "r018-176f38a6-5d21-4cfb-ac20-f20d90d9e888" }], "name" => "my-instance-template", "primary_network_interface" => { "security_groups" => [{ "id" => "r018-f4793b96-4fc1-4a57-a18d-ff50d8001566" }], "subnet" => { "id" => "07a7-3162c0fc-178f-46da-b4ca-d9448824056c" } }, "profile" => { "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "vpc" => { "id" => "r018-d6979555-bf41-4755-ab78-f1f753a939e0" }, "zone" => { "name" => "us-south-3" }
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance/templates/3f9a2d96-830e-4100-9b4c-663225a3f872?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_template(
      id: "3f9a2d96-830e-4100-9b4c-663225a3f872"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_instance_template
    message_response = {
      "boot_volume_attachment" => { "delete_volume_on_instance_delete" => true, "name" => "volume-attachment",
                                    "volume" => { "capacity" => 100, "name" => "my-instance-template-boot", "profile" => { "name" => "general-purpose" } } }, "created_at" => "2020-10-01T13:37:00Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "image" => { "id" => "r018-6f153a5d-6a9a-496d-8063-5c39932f6ded" }, "keys" => [{ "id" => "r018-176f38a6-5d21-4cfb-ac20-f20d90d9e888" }], "name" => "my-instance-template", "primary_network_interface" => { "name" => "eth0", "security_groups" => [{ "id" => "r018-f4793b96-4fc1-4a57-a18d-ff50d8001566" }], "subnet" => { "id" => "07a7-3162c0fc-178f-46da-b4ca-d9448824056c" } }, "profile" => { "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "vpc" => { "id" => "r018-d6979555-bf41-4755-ab78-f1f753a939e0" }, "zone" => { "name" => "us-south-3" }
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/instance/templates/3f9a2d96-830e-4100-9b4c-663225a3f872?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_instance_template(
      id: "3f9a2d96-830e-4100-9b4c-663225a3f872",
      instance_template_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_instances
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances?limit=50" },
                         "instances" => [{ "bandwidth" => 4000, "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }], "limit" => 50, "total_count" => 1 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instances

    assert_equal(message_response, service_response.result)
  end

  def test_create_instance
    message_response = { "bandwidth" => 4000,
                         "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/instances?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_instance(
      instance_prototype: {
        "boot_volume_attachment": {
          "volume": {
            "encryption_key": {
              "crn": "crn:[...]"
            },
            "name": "my-boot-volume",
            "profile": {
              "name": "general-purpose"
            }
          }
        },
        "image": {
          "id": "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366"
        },
        "keys": [
          {
            "id": "363f6d70-0000-0001-0000-00000013b96c"
          }
        ],
        "name": "my-instance",
        "placement_target": {
          "id": "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221"
        },
        "primary_network_interface": {
          "name": "my-network-interface",
          "subnet": {
            "id": "bea6a632-5e13-42a4-b4b8-31dc877abfe4"
          }
        },
        "profile": {
          "name": "bx2-2x8"
        },
        "volume_attachments": [
          {
            "volume": {
              "capacity": 1000,
              "encryption_key": {
                "crn": "crn:[...]"
              },
              "name": "my-data-volume",
              "profile": {
                "name": "5iops-tier"
              }
            }
          }
        ],
        "vpc": {
          "id": "f0aae929-7047-46d1-92e1-9102b07a7f6f"
        },
        "zone": {
          "name": "us-south-1"
        }
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_instance(
      id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0"
    )
  end

  def test_get_instance
    message_response = { "bandwidth" => 4000,
                         "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance(
      id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_instance
    message_response = { "bandwidth" => 4000,
                         "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_instance(
      id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      instance_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_instance_disks
    message_response = { "bandwidth" => 4000,
                         "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/disks?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_disks(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_get_instance_disk
    message_response = { "bandwidth" => 4000,
                         "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/disks/eb1b7391-2ca2-4ab5-84a8-b92157a633b0?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_disk(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_instance_disk
    message_response = { "bandwidth" => 4000,
                         "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/disks/eb1b7391-2ca2-4ab5-84a8-b92157a633b0?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_instance_disk(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      instance_disk_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_get_instance_initialization
    message_response = { "keys" => [{ "crn" => "crn:[...]",
                                      "fingerprint" => "SHA256:RJ+YWs2kupwFGiJuLqY85twmcdLOUcjIc9cA6IR8n8E", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/82679077-ac3b-4c10-be16-63e9c21f0f45", "id" => "82679077-ac3b-4c10-be16-63e9c21f0f45", "name" => "my-key-1" }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/initialization?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_initialization(
      id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_instance_console_access_token
    message_response = { "keys" => [{ "crn" => "crn:[...]",
                                      "fingerprint" => "SHA256:RJ+YWs2kupwFGiJuLqY85twmcdLOUcjIc9cA6IR8n8E", "href" => "https://us-south.iaas.cloud.ibm.com/v1/keys/82679077-ac3b-4c10-be16-63e9c21f0f45", "id" => "82679077-ac3b-4c10-be16-63e9c21f0f45", "name" => "my-key-1" }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/console_access_token?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_instance_console_access_token(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      console_type: "serial"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_instance_action
    message_response = { "completed_at" => "2019-01-31T09:02:30.639Z", "created_at" => "2019-01-31T09:02:18.653Z",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/abd870d3-c55f-0342-0899-c74082c16579/actions/d6c3902d-1ecf-3a2c-b7ab-eb9143581000", "id" => "d6c3902d-1ecf-3a2c-b7ab-eb9143581000", "started_at" => "2019-01-31T09:02:18.653Z", "status" => "running", "type" => "stop" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/actions?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_instance_action(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      type: ""
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_instance_network_interfaces
    message_response = { "network_interfaces" => [{ "allow_ip_spoofing" => false, "created_at" => "2019-01-31T03:42:32.993Z",
                                                    "floating_ips" => [{ "address" => "192.0.2.2", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/181b8670-52bf-47af-a5ca-7aff7f3824d1", "id" => "181b8670-52bf-47af-a5ca-7aff7f3824d1", "name" => "my-floating-ip" }], "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/123a490a-9e64-4254-a93b-9a3af3ede270/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20", "id" => "35bd3f19-bdd4-434b-ad6a-5e9358d65e20", "name" => "molecule-find-wild-name-dictionary-trench", "port_speed" => 1000, "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "security_groups" => [{ "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/a929f12d-fb45-4e5e-9864-95e171ae3589", "id" => "a929f12d-fb45-4e5e-9864-95e171ae3589", "name" => "before-entrance-mountain-paralegal-photo-uninstall" }], "status" => "available", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/9270d819-c05e-4352-99e4-80c4680cdb7c", "id" => "9270d819-c05e-4352-99e4-80c4680cdb7c", "name" => "my-subnet" }, "type" => "primary" }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/network_interfaces?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_network_interfaces(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_instance_network_interface
    message_response = {
      "allow_ip_spoofing" => false,
      "created_at" => "2019-01-31T03:42:32.993Z",
      "floating_ips" => [
        {
          "address" => "192.0.2.3",
          "crn" => "crn:[...]",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/181b8670-52bf-47af-a5ca-7aff7f3824d1",
          "id" => "181b8670-52bf-47af-a5ca-7aff7f3824d1",
          "name" => "my-floating-ip"
        }
      ],
      "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/123a490a-9e64-4254-a93b-9a3af3ede270/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20",
      "id" => "35bd3f19-bdd4-434b-ad6a-5e9358d65e20",
      "name" => "my-network-interface-2",
      "port_speed" => 1000,
      "primary_ipv4_address" => "10.0.0.33",
      "resource_type" => "network_interface",
      "security_groups" => [
        {
          "crn" => "crn:[...]",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/a929f12d-fb45-4e5e-9864-95e171ae3589",
          "id" => "a929f12d-fb45-4e5e-9864-95e171ae3589",
          "name" => "before-entrance-mountain-paralegal-photo-uninstall"
        }
      ],
      "status" => "available",
      "subnet" => {
        "crn" => "crn:[...]",
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/9270d819-c05e-4352-99e4-80c4680cdb7c",
        "id" => "9270d819-c05e-4352-99e4-80c4680cdb7c",
        "name" => "my-subnet"
      },
      "type" => "secondary"
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/network_interfaces?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_instance_network_interface(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      subnet: {
        "crn": "crn:[...]",
        "href": "https://us-south.iaas.cloud.ibm.com/v1/subnets/9270d819-c05e-4352-99e4-80c4680cdb7c",
        "id": "9270d819-c05e-4352-99e4-80c4680cdb7c",
        "name": "my-subnet"
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance_network_interface
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_instance_network_interface(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      id: "35bd3f19-bdd4-434b-ad6a-5e9358d65e20"
    )
  end

  def test_get_instance_network_interface
    message_response = {
      "allow_ip_spoofing" => false,
      "created_at" => "2019-01-31T03:42:32.993Z",
      "floating_ips" => [
        {
          "address" => "192.0.2.3",
          "crn" => "crn:[...]",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/181b8670-52bf-47af-a5ca-7aff7f3824d1",
          "id" => "181b8670-52bf-47af-a5ca-7aff7f3824d1",
          "name" => "my-floating-ip"
        }
      ],
      "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/123a490a-9e64-4254-a93b-9a3af3ede270/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20",
      "id" => "35bd3f19-bdd4-434b-ad6a-5e9358d65e20",
      "name" => "my-network-interface-2",
      "port_speed" => 1000,
      "primary_ipv4_address" => "10.0.0.33",
      "resource_type" => "network_interface",
      "security_groups" => [
        {
          "crn" => "crn:[...]",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/a929f12d-fb45-4e5e-9864-95e171ae3589",
          "id" => "a929f12d-fb45-4e5e-9864-95e171ae3589",
          "name" => "before-entrance-mountain-paralegal-photo-uninstall"
        }
      ],
      "status" => "available",
      "subnet" => {
        "crn" => "crn:[...]",
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/9270d819-c05e-4352-99e4-80c4680cdb7c",
        "id" => "9270d819-c05e-4352-99e4-80c4680cdb7c",
        "name" => "my-subnet"
      },
      "type" => "secondary"
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_network_interface(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      id: "35bd3f19-bdd4-434b-ad6a-5e9358d65e20"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_instance_network_interface
    message_response = {
      "allow_ip_spoofing" => false,
      "created_at" => "2019-01-31T03:42:32.993Z",
      "floating_ips" => [
        {
          "address" => "192.0.2.3",
          "crn" => "crn:[...]",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/181b8670-52bf-47af-a5ca-7aff7f3824d1",
          "id" => "181b8670-52bf-47af-a5ca-7aff7f3824d1",
          "name" => "my-floating-ip"
        }
      ],
      "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/123a490a-9e64-4254-a93b-9a3af3ede270/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20",
      "id" => "35bd3f19-bdd4-434b-ad6a-5e9358d65e20",
      "name" => "my-network-interface-2",
      "port_speed" => 1000,
      "primary_ipv4_address" => "10.0.0.33",
      "resource_type" => "network_interface",
      "security_groups" => [
        {
          "crn" => "crn:[...]",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/a929f12d-fb45-4e5e-9864-95e171ae3589",
          "id" => "a929f12d-fb45-4e5e-9864-95e171ae3589",
          "name" => "before-entrance-mountain-paralegal-photo-uninstall"
        }
      ],
      "status" => "available",
      "subnet" => {
        "crn" => "crn:[...]",
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/9270d819-c05e-4352-99e4-80c4680cdb7c",
        "id" => "9270d819-c05e-4352-99e4-80c4680cdb7c",
        "name" => "my-subnet"
      },
      "type" => "secondary"
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_instance_network_interface(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      id: "35bd3f19-bdd4-434b-ad6a-5e9358d65e20",
      network_interface_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_instance_network_interface_floating_ips
    message_response = { "floating_ips" => [{ "address" => "192.0.2.2", "created_at" => "2019-01-28T12:08:05Z",
                                              "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "name" => "my-floating-ip-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "pending", "target" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32/network_interfaces/5a07e83d-c1f3-4df2-bcec-41b09c006847", "id" => "5a07e83d-c1f3-4df2-bcec-41b09c006847", "name" => "my-network-interface-1", "primary_ipv4_address" => "10.0.1.9", "resource_type" => "network_interface" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20/floating_ips?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_network_interface_floating_ips(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      network_interface_id: "35bd3f19-bdd4-434b-ad6a-5e9358d65e20"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_remove_instance_network_interface_floating_ip
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.remove_instance_network_interface_floating_ip(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      network_interface_id: "35bd3f19-bdd4-434b-ad6a-5e9358d65e20",
      id: "ad0cded3-53a3-4d4a-9809-8c59b50d2b80"
    )
  end

  def test_get_instance_network_interface_floating_ip
    message_response = { "address" => "192.0.2.2", "created_at" => "2019-01-28T12:08:05Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "name" => "my-floating-ip-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "pending", "target" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32/network_interfaces/5a07e83d-c1f3-4df2-bcec-41b09c006847", "id" => "5a07e83d-c1f3-4df2-bcec-41b09c006847", "name" => "my-network-interface-1", "primary_ipv4_address" => "10.0.1.9", "resource_type" => "network_interface" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_network_interface_floating_ip(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      network_interface_id: "35bd3f19-bdd4-434b-ad6a-5e9358d65e20",
      id: "ad0cded3-53a3-4d4a-9809-8c59b50d2b80"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_add_instance_network_interface_floating_ip
    message_response = { "address" => "192.0.2.2", "created_at" => "2019-01-28T12:08:05Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "name" => "my-floating-ip-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "pending", "target" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32/network_interfaces/5a07e83d-c1f3-4df2-bcec-41b09c006847", "id" => "5a07e83d-c1f3-4df2-bcec-41b09c006847", "name" => "my-network-interface-1", "primary_ipv4_address" => "10.0.1.9", "resource_type" => "network_interface" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:put, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/network_interfaces/35bd3f19-bdd4-434b-ad6a-5e9358d65e20/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.add_instance_network_interface_floating_ip(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      network_interface_id: "35bd3f19-bdd4-434b-ad6a-5e9358d65e20",
      id: "ad0cded3-53a3-4d4a-9809-8c59b50d2b80"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_snapshots
    message_response = { "bandwidth" => 4000,
                         "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/snapshots?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_snapshots

    assert_equal(message_response, service_response.result)
  end

  def test_create_snapshot
    message_response = { "bandwidth" => 4000,
                         "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/snapshots?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    volume_identity_model = {
      'id': "eb1b7391-2ca2-4ab5-85a8-b92157a633b0"
    }

    snapshot_prototype_model = {
      'source_volume': volume_identity_model,
      'name': "my-snapshot"
    }
    service_response = service.create_snapshot(
      snapshot_prototype: snapshot_prototype_model
    )

    assert_equal(message_response, service_response.result)
  end

  def test_get_snapshot
    message_response = { "bandwidth" => 4000,
                         "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/snapshots/eb1b7391-2ca2-4ab5-84a8-b92157a633b0?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_snapshot(
      id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_snapshot
    message_response = { "bandwidth" => 4000,
                         "boot_volume_attachment" => { "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, "created_at" => "2020-03-26T16:11:57Z", "crn" => "crn:[...]", "dedicated_host" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "id" => "eb1b7391-2ca2-4ab5-84a8-b92157a633b0", "image" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/images/9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "id" => "9aaf3bcb-dcd7-4de7-bb60-24e39ff9d366", "name" => "my-image" }, "memory" => 8, "name" => "my-instance", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/7389-bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }], "placement_target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }, "primary_network_interface" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/bea6a632-5e13-42a4-b4b8-31dc877abfe4", "id" => "bea6a632-5e13-42a4-b4b8-31dc877abfe4", "name" => "my-subnet" } }, "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/bx2-2x8", "name" => "bx2-2x8" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "running", "vcpu" => { "architecture" => "amd64", "count" => 2 }, "volume_attachments" => [{ "device" => { "id" => "a8a15363-a6f7-4f01-af60-715e85b28141" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-a8a15363-a6f7-4f01-af60-715e85b28141", "id" => "a8a15363-a6f7-4f01-af60-715e85b28141", "name" => "my-boot-volume-attachment", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/49c5d61b-41e7-4c01-9b7a-1a97366c6916", "id" => "49c5d61b-41e7-4c01-9b7a-1a97366c6916", "name" => "my-boot-volume" } }, { "device" => { "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/volume_attachments/7389-e77125cb-4df0-4988-a878-531ae0ae0b70", "id" => "e77125cb-4df0-4988-a878-531ae0ae0b70", "name" => "my-volume-attachment-1", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2cc091f5-4d46-48f3-99b7-3527ae3f4392", "id" => "2cc091f5-4d46-48f3-99b7-3527ae3f4392", "name" => "my-data-volume" } }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/snapshots/eb1b7391-2ca2-4ab5-84a8-b92157a633b0?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_snapshot(
      id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      snapshot_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_snapshot
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/snapshots/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60?generation=2&version=2022-03-29")
      .to_return(status: 200, body: "", headers: headers)
    service.delete_snapshot(
      id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60"
    )
  end

  def test_delete_snapshots
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/snapshots?generation=2&source_volume.id=r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60&version=2022-03-29")
      .to_return(status: 200, body: "", headers: headers)
    service.delete_snapshots(
      source_volume_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60"
    )
  end

  def test_list_instance_volume_attachments
    message_response = { "volume_attachments" => [
      { "created_at" => "2019-02-28T16:32:05.000Z", "delete_volume_on_instance_delete" => true,
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/8f06378c-ed0e-481e-b98c-9a6dfbee1ed5/volume_attachments/fdb3642d-c849-4c29-97a9-03b868616f88", "id" => "fdb3642d-c849-4c29-97a9-03b868616f88", "name" => "my-boot-volume-attachment", "status" => "attached", "type" => "boot", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/ac0b16a5-ccc2-47dd-90e2-b9e5f367b6c6", "id" => "ac0b16a5-ccc2-47dd-90e2-b9e5f367b6c6", "name" => "my-boot-volume" } }, { "created_at" => "2019-03-15T11:44:07.000Z", "delete_volume_on_instance_delete" => false, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/8f06378c-ed0e-481e-b98c-9a6dfbee1ed5/volume_attachments/8479a541-58ee-42ca-9efa-15a1551d42b9", "id" => "8479a541-58ee-42ca-9efa-15a1551d42b9", "name" => "my-data-volume-attachment", "status" => "attached", "type" => "data", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/ca4b6df3-f5a8-4667-b5f2-f3b9b4160781", "id" => "ca4b6df3-f5a8-4667-b5f2-f3b9b4160781", "name" => "my-data-volume" } }
    ] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_volume_attachments(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_instance_volume_attachment
    message_response = { "created_at" => "2019-02-28T16:32:05.000Z", "delete_volume_on_instance_delete" => true,
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/8f06378c-ed0e-481e-b98c-9a6dfbee1ed5/volume_attachments/fdb3642d-c849-4c29-97a9-03b868616f88", "id" => "fdb3642d-c849-4c29-97a9-03b868616f88", "name" => "my-boot-volume-attachment", "status" => "attached", "type" => "boot", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/ac0b16a5-ccc2-47dd-90e2-b9e5f367b6c6", "id" => "ac0b16a5-ccc2-47dd-90e2-b9e5f367b6c6", "name" => "my-boot-volume" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_instance_volume_attachment(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      volume: { "crn" => "crn:[...]",
                "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/ac0b16a5-ccc2-47dd-90e2-b9e5f367b6c6", "id" => "ac0b16a5-ccc2-47dd-90e2-b9e5f367b6c6", "name" => "my-boot-volume" }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance_volume_attachment
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/fdb3642d-c849-4c29-97a9-03b868616f88?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_instance_volume_attachment(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      id: "fdb3642d-c849-4c29-97a9-03b868616f88"
    )
  end

  def test_get_instance_volume_attachment
    message_response = { "created_at" => "2019-02-28T16:32:05.000Z", "delete_volume_on_instance_delete" => true,
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/8f06378c-ed0e-481e-b98c-9a6dfbee1ed5/volume_attachments/fdb3642d-c849-4c29-97a9-03b868616f88", "id" => "fdb3642d-c849-4c29-97a9-03b868616f88", "name" => "my-boot-volume-attachment", "status" => "attached", "type" => "boot", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/ac0b16a5-ccc2-47dd-90e2-b9e5f367b6c6", "id" => "ac0b16a5-ccc2-47dd-90e2-b9e5f367b6c6", "name" => "my-boot-volume" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/fdb3642d-c849-4c29-97a9-03b868616f88?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_volume_attachment(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      id: "fdb3642d-c849-4c29-97a9-03b868616f88"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_instance_volume_attachment
    message_response = { "created_at" => "2019-02-28T16:32:05.000Z", "delete_volume_on_instance_delete" => true,
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/8f06378c-ed0e-481e-b98c-9a6dfbee1ed5/volume_attachments/fdb3642d-c849-4c29-97a9-03b868616f88", "id" => "fdb3642d-c849-4c29-97a9-03b868616f88", "name" => "my-boot-volume-attachment", "status" => "attached", "type" => "boot", "volume" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/ac0b16a5-ccc2-47dd-90e2-b9e5f367b6c6", "id" => "ac0b16a5-ccc2-47dd-90e2-b9e5f367b6c6", "name" => "my-boot-volume" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/instances/eb1b7391-2ca2-4ab5-84a8-b92157a633b0/volume_attachments/fdb3642d-c849-4c29-97a9-03b868616f88?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_instance_volume_attachment(
      instance_id: "eb1b7391-2ca2-4ab5-84a8-b92157a633b0",
      id: "fdb3642d-c849-4c29-97a9-03b868616f88",
      volume_attachment_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_instance_groups
    message_response = { "first" => { "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups?limit=50" },
                         "instance_groups" => [{ "created_at" => "2020-12-29T19:55:00Z", "crn" => "crn[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60", "id" => "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60", "instance_template" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "name" => "my-instance-template" }, "managers" => [], "membership_count" => 0, "name" => "issuing-reverb-oblivion-seventh-perch-discover", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "healthy", "subnets" => [{ "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/subnets/07a7-3162c0fc-178f-46da-b4ca-d9448824056c", "id" => "07a7-3162c0fc-178f-46da-b4ca-d9448824056c", "name" => "my-subnet" }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/e2cd90a7-8c7c-476f-b454-9ea0b5387677", "id" => "e2cd90a7-8c7c-476f-b454-9ea0b5387677", "name" => "my-vpc" } }], "limit" => 50, "total_count" => 1 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_groups

    assert_equal(message_response, service_response.result)
  end

  def test_create_instance_group
    message_response = { "created_at" => "2020-12-29T19:55:00Z", "crn" => "crn:[...]",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60", "id" => "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60", "instance_template" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "name" => "my-instance-template" }, "managers" => [], "membership_count" => 0, "name" => "issuing-reverb-oblivion-seventh-perch-discover", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "healthy", "subnets" => [{ "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/subnets/07a7-3162c0fc-178f-46da-b4ca-d9448824056c", "id" => "07a7-3162c0fc-178f-46da-b4ca-d9448824056c", "name" => "my-subnet" }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/e2cd90a7-8c7c-476f-b454-9ea0b5387677", "id" => "e2cd90a7-8c7c-476f-b454-9ea0b5387677", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_instance_group(
      instance_template: {
        "crn": "crn:[...]",
        "href": "https://eu-gb.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84",
        "id": "07a7-eca9fd45-e086-4400-a799-77b09ec5be84",
        "name": "my-instance-template"
      },
      subnets: [
        {
          "crn": "crn:[...]",
          "href": "https://eu-gb.iaas.cloud.ibm.com/v1/subnets/07a7-3162c0fc-178f-46da-b4ca-d9448824056c",
          "id": "07a7-3162c0fc-178f-46da-b4ca-d9448824056c",
          "name": "my-subnet"
        }
      ]
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance_group
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60?generation=2&version=2022-03-29")
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service.delete_instance_group(
      id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60"
    )
  end

  def test_get_instance_group
    message_response = { "created_at" => "2020-12-29T19:55:00Z", "crn" => "crn:[...]",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60", "id" => "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60", "instance_template" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "name" => "my-instance-template" }, "managers" => [], "membership_count" => 0, "name" => "issuing-reverb-oblivion-seventh-perch-discover", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "healthy", "subnets" => [{ "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/subnets/07a7-3162c0fc-178f-46da-b4ca-d9448824056c", "id" => "07a7-3162c0fc-178f-46da-b4ca-d9448824056c", "name" => "my-subnet" }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/e2cd90a7-8c7c-476f-b454-9ea0b5387677", "id" => "e2cd90a7-8c7c-476f-b454-9ea0b5387677", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60?generation=2&version=2022-03-29?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_group(
      id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_instance_group
    message_response = { "created_at" => "2020-12-29T19:55:00Z", "crn" => "crn:[...]",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60", "id" => "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60", "instance_template" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "name" => "my-instance-template" }, "managers" => [], "membership_count" => 0, "name" => "issuing-reverb-oblivion-seventh-perch-discover", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "healthy", "subnets" => [{ "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/subnets/07a7-3162c0fc-178f-46da-b4ca-d9448824056c", "id" => "07a7-3162c0fc-178f-46da-b4ca-d9448824056c", "name" => "my-subnet" }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/e2cd90a7-8c7c-476f-b454-9ea0b5387677", "id" => "e2cd90a7-8c7c-476f-b454-9ea0b5387677", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_instance_group(
      id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance_group_load_balancer
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/load_balancer?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_instance_group_load_balancer(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60"
    )
  end

  def test_list_instance_group_managers
    message_response = {
      "first" => { "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers?limit=50" }, "limit" => 50, "managers" => [{
        "aggregation_window" => 90, "cooldown" => 300, "created_at" => "2020-10-29T19:54:00Z", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "id" => "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "management_enabled" => true, "manager_type" => "autoscale", "max_membership_count" => 5, "min_membership_count" => 1, "name" => "my-manager", "policies" => []
      }], "total_count" => 1
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_group_managers(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_instance_group_manager
    message_response = { "aggregation_window" => 90, "cooldown" => 300, "created_at" => "2020-10-29T19:54:00Z",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "id" => "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "management_enabled" => true, "manager_type" => "autoscale", "max_membership_count" => 50, "min_membership_count" => 1, "name" => "my-manager", "policies" => [] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_instance_group_manager(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_prototype: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance_group_manager
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_instance_group_manager(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f"
    )
  end

  def test_get_instance_group_manager
    message_response = { "aggregation_window" => 90, "cooldown" => 300, "created_at" => "2020-10-29T19:54:00Z",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "id" => "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "management_enabled" => true, "manager_type" => "autoscale", "max_membership_count" => 50, "min_membership_count" => 1, "name" => "my-manager", "policies" => [] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_group_manager(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_instance_group_manager
    message_response = { "aggregation_window" => 90, "cooldown" => 300, "created_at" => "2020-10-29T19:54:00Z",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "id" => "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "management_enabled" => true, "manager_type" => "autoscale", "max_membership_count" => 50, "min_membership_count" => 1, "name" => "my-manager", "policies" => [] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_instance_group_manager(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f",
      instance_group_manager_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_instance_group_manager_actions
    message_response = {
      "first" => { "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers?limit=50" }, "limit" => 50, "managers" => [{
        "aggregation_window" => 90, "cooldown" => 300, "created_at" => "2020-10-29T19:54:00Z", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "id" => "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "management_enabled" => true, "manager_type" => "autoscale", "max_membership_count" => 5, "min_membership_count" => 1, "name" => "my-manager", "policies" => []
      }], "total_count" => 1
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/actions?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_group_manager_actions(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_instance_group_manager_actions
    message_response = { "aggregation_window" => 90, "cooldown" => 300, "created_at" => "2020-10-29T19:54:00Z",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "id" => "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "management_enabled" => true, "manager_type" => "autoscale", "max_membership_count" => 50, "min_membership_count" => 1, "name" => "my-manager", "policies" => [] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/actions?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_instance_group_manager_action(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_action_prototype: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance_group_manager_actions
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/actions/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_instance_group_manager_action(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f",
      id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f"
    )
  end

  def test_get_instance_group_manager_actions
    message_response = { "aggregation_window" => 90, "cooldown" => 300, "created_at" => "2020-10-29T19:54:00Z",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "id" => "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "management_enabled" => true, "manager_type" => "autoscale", "max_membership_count" => 50, "min_membership_count" => 1, "name" => "my-manager", "policies" => [] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/actions/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_group_manager_action(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f",
      id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_instance_group_manager_actions
    message_response = { "aggregation_window" => 90, "cooldown" => 300, "created_at" => "2020-10-29T19:54:00Z",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "id" => "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f", "management_enabled" => true, "manager_type" => "autoscale", "max_membership_count" => 50, "min_membership_count" => 1, "name" => "my-manager", "policies" => [] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/actions/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_instance_group_manager_action(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f",
      id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f",
      instance_group_manager_action_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_instance_group_manager_policies
    message_response = {
      "first" => { "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/policies?limit=50" }, "limit" => 50, "policies" => [{
        "created_at" => "2020-10-29T19:54:00Z", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/policies/r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c", "id" => "r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c", "metric_type" => "cpu", "metric_value" => 50, "name" => "my-policy", "policy_type" => "target"
      }], "total_count" => 1
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/policies?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_group_manager_policies(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_instance_group_manager_policy
    message_response = { "created_at" => "2020-10-29T19:54:00Z",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/policies/r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c", "id" => "r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c", "metric_type" => "cpu", "metric_value" => 50, "name" => "my-policy", "policy_type" => "target" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/policies?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_instance_group_manager_policy(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f",
      instance_group_manager_policy_prototype: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance_group_manager_policy
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/policies/r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c?generation=2&version=2022-03-29?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_instance_group_manager_policy(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f",
      id: "r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c"
    )
  end

  def test_get_instance_group_manager_policy
    message_response = { "created_at" => "2020-10-29T19:54:00Z",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/policies/r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c", "id" => "r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c", "metric_type" => "cpu", "metric_value" => 50, "name" => "my-policy", "policy_type" => "target" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/policies/r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c?generation=2&version=2022-03-29?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_group_manager_policy(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f",
      id: "r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_instance_group_manager_policy
    message_response = { "created_at" => "2020-10-29T19:54:00Z",
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/policies/r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c", "id" => "r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c", "metric_type" => "cpu", "metric_value" => 50, "name" => "my-policy", "policy_type" => "target" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/managers/r018-4f2f7036-86b0-4d1b-a729-12357d45b00f/policies/r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c?generation=2&version=2022-03-29?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_instance_group_manager_policy(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      instance_group_manager_id: "r018-4f2f7036-86b0-4d1b-a729-12357d45b00f",
      id: "r018-02d7b6c3-e3c8-4569-ba6a-caa5d4d6146c",
      instance_group_manager_policy_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance_group_memberships
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/memberships?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_instance_group_memberships(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60"
    )
  end

  def test_list_instance_group_memberships
    message_response = {
      "first" => { "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/memberships?limit=50" }, "limit" => 50, "memberships" => [
        { "created_at" => "2020-10-29T19:54:00Z", "delete_instance_on_membership_delete" => true,
          "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/memberships/04977d01-89c0-488b-a599-3d0dc32880e7", "id" => "04977d01-89c0-488b-a599-3d0dc32880e7", "instance" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instances/07a7_2bc064dc-f463-46dc-9825-ee6aa2e37927", "id" => "07a7_2bc064dc-f463-46dc-9825-ee6aa2e37927", "name" => "issuing-reverb-oblivion-seventh-perch-discove-rjg8mt3dv9-g1e60" }, "instance_template" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "name" => "my-instance-template" }, "name" => "my-membership-1", "status" => "healthy" }, { "created_at" => "2020-10-20T12:34:00Z", "delete_instance_on_membership_delete" => true, "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/memberships/0335f610-0e31-470e-b092-e5ea5ee79e41", "id" => "0335f610-0e31-470e-b092-e5ea5ee79e41", "instance" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instances/07a7_11c592d4-ed11-45f6-91fd-fc3918e4d77d", "id" => "07a7_11c592d4-ed11-45f6-91fd-fc3918e4d77d", "name" => "issuing-reverb-oblivion-seventh-perch-discove-tq6ek486jb-kz8o8" }, "instance_template" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "name" => "my-instance-template-2" }, "name" => "my-membership-2", "status" => "healthy" }
      ], "total_count" => 2
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/memberships?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_instance_group_memberships(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_instance_group_membership
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/memberships/04977d01-89c0-488b-a599-3d0dc32880e7?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_instance_group_membership(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      id: "04977d01-89c0-488b-a599-3d0dc32880e7"
    )
  end

  def test_get_instance_group_membership
    message_response = { "created_at" => "2020-10-29T19:54:00Z", "delete_instance_on_membership_delete" => true,
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/memberships/04977d01-89c0-488b-a599-3d0dc32880e7", "id" => "04977d01-89c0-488b-a599-3d0dc32880e7", "instance" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instances/07a7_2bc064dc-f463-46dc-9825-ee6aa2e37927", "id" => "07a7_2bc064dc-f463-46dc-9825-ee6aa2e37927", "name" => "issuing-reverb-oblivion-seventh-perch-discove-rjg8mt3dv9-g1e60" }, "instance_template" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "name" => "my-instance-template" }, "name" => "my-membership", "status" => "healthy" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/memberships/04977d01-89c0-488b-a599-3d0dc32880e7?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_instance_group_membership(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      id: "04977d01-89c0-488b-a599-3d0dc32880e7"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_instance_group_membership
    message_response = { "created_at" => "2020-10-29T19:54:00Z", "delete_instance_on_membership_delete" => true,
                         "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/memberships/04977d01-89c0-488b-a599-3d0dc32880e7", "id" => "04977d01-89c0-488b-a599-3d0dc32880e7", "instance" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instances/07a7_2bc064dc-f463-46dc-9825-ee6aa2e37927", "id" => "07a7_2bc064dc-f463-46dc-9825-ee6aa2e37927", "name" => "issuing-reverb-oblivion-seventh-perch-discove-rjg8mt3dv9-g1e60" }, "instance_template" => { "crn" => "crn:[...]", "href" => "https://eu-gb.iaas.cloud.ibm.com/v1/instance/templates/07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "id" => "07a7-eca9fd45-e086-4400-a799-77b09ec5be84", "name" => "my-instance-template" }, "name" => "my-membership", "status" => "healthy" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/instance_groups/r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60/memberships/04977d01-89c0-488b-a599-3d0dc32880e7?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_instance_group_membership(
      instance_group_id: "r018-7b3ac170-01f3-43d6-87ec-f0ed11ed3f60",
      id: "04977d01-89c0-488b-a599-3d0dc32880e7",
      instance_group_membership_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_dedicated_host_groups
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups?limit=50" },
                         "groups" => [{ "class" => "mx2", "created_at" => "2020-06-23T21:29:25Z", "crn" => "crn:[...]", "dedicated_hosts" => [], "family" => "memory", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-97e0a56f-9d6e-426b-8ebe-22aacfa47e9a", "id" => "0787-97e0a56f-9d6e-426b-8ebe-22aacfa47e9a", "name" => "pamphlet-subatomic-paging-vividly-emblaze-skies", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host_group", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }, { "class" => "mx2", "created_at" => "2020-04-14T16:53:28Z", "crn" => "crn:[...]", "dedicated_hosts" => [{ "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "name" => "test-new", "resource_type" => "dedicated_host" }], "family" => "memory", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "id" => "0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "name" => "bagpipe-unwelcome-viselike-cramp-rendition-skincare", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host_group", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }], "limit" => 50, "total_count" => 2 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_dedicated_host_groups

    assert_equal(message_response, service_response.result)
  end

  def test_create_dedicated_host_group
    message_response = { "class" => "mx2", "created_at" => "2020-06-23T21:29:25Z", "crn" => "crn:[...]",
                         "dedicated_hosts" => [], "family" => "memory", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-97e0a56f-9d6e-426b-8ebe-22aacfa47e9a", "id" => "0787-97e0a56f-9d6e-426b-8ebe-22aacfa47e9a", "name" => "pamphlet-subatomic-paging-vividly-emblaze-skies", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host_group", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_dedicated_host_group

    assert_equal(message_response, service_response.result)
  end

  def test_delete_dedicated_host_group
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/4bbce614c13444cd8fc5e7e878ef8e21?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_dedicated_host_group(
      id: "4bbce614c13444cd8fc5e7e878ef8e21"
    )
  end

  def test_get_dedicated_host_group
    message_response = { "class" => "mx2", "created_at" => "2020-06-23T21:29:25Z", "crn" => "crn:[...]",
                         "dedicated_hosts" => [], "family" => "memory", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-97e0a56f-9d6e-426b-8ebe-22aacfa47e9a", "id" => "0787-97e0a56f-9d6e-426b-8ebe-22aacfa47e9a", "name" => "pamphlet-subatomic-paging-vividly-emblaze-skies", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host_group", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/4bbce614c13444cd8fc5e7e878ef8e21?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_dedicated_host_group(
      id: "4bbce614c13444cd8fc5e7e878ef8e21"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_dedicated_host_group
    message_response = { "class" => "mx2", "created_at" => "2020-06-23T21:29:25Z", "crn" => "crn:[...]",
                         "dedicated_hosts" => [], "family" => "memory", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-97e0a56f-9d6e-426b-8ebe-22aacfa47e9a", "id" => "0787-97e0a56f-9d6e-426b-8ebe-22aacfa47e9a", "name" => "pamphlet-subatomic-paging-vividly-emblaze-skies", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host_group", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/4bbce614c13444cd8fc5e7e878ef8e21?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_dedicated_host_group(
      id: "4bbce614c13444cd8fc5e7e878ef8e21",
      dedicated_host_group_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_dedicated_host_profiles
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles?limit=50" },
                         "limit" => 50, "profiles" => [{ "class" => "mx2", "family" => "memory", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles/mx2-host-152x1216", "memory" => { "type" => "fixed", "value" => 1216 }, "name" => "mx2-host-152x1216", "resource_type" => "dedicated_host_profile", "socket_count" => { "type" => "fixed", "value" => 4 }, "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "vcpu_architecture" => { "type" => "fixed", "value" => "amd64" }, "vcpu_count" => { "type" => "fixed", "value" => 152 } }], "total_count" => 1 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_dedicated_host_profiles

    assert_equal(message_response, service_response.result)
  end

  def test_get_dedicated_host_profile
    message_response = { "class" => "mx2", "family" => "memory",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles/mx2-host-152x1216", "memory" => { "type" => "fixed", "value" => 1216 }, "name" => "mx2-host-152x1216", "resource_type" => "dedicated_host_profile", "socket_count" => { "type" => "fixed", "value" => 4 }, "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "vcpu_architecture" => { "type" => "fixed", "value" => "amd64" }, "vcpu_count" => { "type" => "fixed", "value" => 152 } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles/mx2-host-152x1216?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_dedicated_host_profile(
      name: "mx2-host-152x1216"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_dedicated_hosts
    message_response = {
      "dedicated_hosts" => [{ "admin_state" => "available", "available_memory" => 346,
                              "available_vcpu" => { "architecture" => "amd64", "count" => 56 }, "created_at" => "2020-05-29T19:38:33Z", "crn" => "crn:[...]", "group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "id" => "0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "name" => "bagpipe-unwelcome-viselike-cramp-rendition-skincare", "resource_type" => "dedicated_host_group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "instance_placement_enabled" => false, "instances" => [], "lifecycle_state" => "stable", "memory" => 346, "name" => "test-new", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles/dh2-56x344", "name" => "dh2-56x344" }, "provisionable" => true, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host", "socket_count" => 2, "state" => "available", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "vcpu" => { "architecture" => "amd64", "count" => 56 }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }], "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts?limit=50" }, "limit" => 50, "total_count" => 1
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_dedicated_hosts

    assert_equal(message_response, service_response.result)
  end

  def test_create_dedicated_host
    message_response = { "admin_state" => "available", "available_memory" => 346,
                         "available_vcpu" => { "architecture" => "amd64", "count" => 56 }, "created_at" => "2020-05-29T19:38:33Z", "crn" => "crn:[...]", "group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "id" => "0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "name" => "bagpipe-unwelcome-viselike-cramp-rendition-skincare", "resource_type" => "dedicated_host_group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "instance_placement_enabled" => false, "instances" => [], "lifecycle_state" => "stable", "memory" => 346, "name" => "test-new", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles/dh2-56x344", "name" => "dh2-56x344" }, "provisionable" => true, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host", "socket_count" => 2, "state" => "available", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "vcpu" => { "architecture" => "amd64", "count" => 56 }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_dedicated_host(
      dedicated_host_prototype: {
        "group": {
          "id": "0c8eccb4-271c-4518-956c-32bfce5cf83b"
        },
        "profile": {
          "name": "m-62x496"
        }
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_dedicated_host
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_dedicated_host(
      id: "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221"
    )
  end

  def test_get_dedicated_host
    message_response = { "admin_state" => "available", "available_memory" => 346,
                         "available_vcpu" => { "architecture" => "amd64", "count" => 56 }, "created_at" => "2020-05-29T19:38:33Z", "crn" => "crn:[...]", "group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "id" => "0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "name" => "bagpipe-unwelcome-viselike-cramp-rendition-skincare", "resource_type" => "dedicated_host_group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "instance_placement_enabled" => false, "instances" => [], "lifecycle_state" => "stable", "memory" => 346, "name" => "test-new", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles/dh2-56x344", "name" => "dh2-56x344" }, "provisionable" => true, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host", "socket_count" => 2, "state" => "available", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "vcpu" => { "architecture" => "amd64", "count" => 56 }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_dedicated_host(
      id: "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_dedicated_host
    message_response = { "admin_state" => "available", "available_memory" => 346,
                         "available_vcpu" => { "architecture" => "amd64", "count" => 56 }, "created_at" => "2020-05-29T19:38:33Z", "crn" => "crn:[...]", "group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "id" => "0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "name" => "bagpipe-unwelcome-viselike-cramp-rendition-skincare", "resource_type" => "dedicated_host_group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "instance_placement_enabled" => false, "instances" => [], "lifecycle_state" => "stable", "memory" => 346, "name" => "test-new", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles/dh2-56x344", "name" => "dh2-56x344" }, "provisionable" => true, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host", "socket_count" => 2, "state" => "available", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "vcpu" => { "architecture" => "amd64", "count" => 56 }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_dedicated_host(
      id: "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221",
      dedicated_host_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_dedicated_host_disks
    message_response = { "admin_state" => "available", "available_memory" => 346,
                         "available_vcpu" => { "architecture" => "amd64", "count" => 56 }, "created_at" => "2020-05-29T19:38:33Z", "crn" => "crn:[...]", "group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "id" => "0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "name" => "bagpipe-unwelcome-viselike-cramp-rendition-skincare", "resource_type" => "dedicated_host_group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "instance_placement_enabled" => false, "instances" => [], "lifecycle_state" => "stable", "memory" => 346, "name" => "test-new", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles/dh2-56x344", "name" => "dh2-56x344" }, "provisionable" => true, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host", "socket_count" => 2, "state" => "available", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "vcpu" => { "architecture" => "amd64", "count" => 56 }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221/disks?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_dedicated_host_disks(
      dedicated_host_id: "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_get_dedicated_host_disk
    message_response = { "admin_state" => "available", "available_memory" => 346,
                         "available_vcpu" => { "architecture" => "amd64", "count" => 56 }, "created_at" => "2020-05-29T19:38:33Z", "crn" => "crn:[...]", "group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "id" => "0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "name" => "bagpipe-unwelcome-viselike-cramp-rendition-skincare", "resource_type" => "dedicated_host_group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "instance_placement_enabled" => false, "instances" => [], "lifecycle_state" => "stable", "memory" => 346, "name" => "test-new", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles/dh2-56x344", "name" => "dh2-56x344" }, "provisionable" => true, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host", "socket_count" => 2, "state" => "available", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "vcpu" => { "architecture" => "amd64", "count" => 56 }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221/disks/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_dedicated_host_disk(
      dedicated_host_id: "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221",
      id: "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_dedicated_host_disk
    message_response = { "admin_state" => "available", "available_memory" => 346,
                         "available_vcpu" => { "architecture" => "amd64", "count" => 56 }, "created_at" => "2020-05-29T19:38:33Z", "crn" => "crn:[...]", "group" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/groups/0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "id" => "0787-b93509fb-78f3-453b-a104-75ab67a2e72e", "name" => "bagpipe-unwelcome-viselike-cramp-rendition-skincare", "resource_type" => "dedicated_host_group" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "id" => "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221", "instance_placement_enabled" => false, "instances" => [], "lifecycle_state" => "stable", "memory" => 346, "name" => "test-new", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/dedicated_host/profiles/dh2-56x344", "name" => "dh2-56x344" }, "provisionable" => true, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "dedicated_host", "socket_count" => 2, "state" => "available", "supported_instance_profiles" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-2x16", "name" => "mx2-2x16" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-4x32", "name" => "mx2-4x32" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-8x64", "name" => "mx2-8x64" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-16x128", "name" => "mx2-16x128" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-32x256", "name" => "mx2-32x256" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instance/profiles/mx2-48x384", "name" => "mx2-48x384" }], "vcpu" => { "architecture" => "amd64", "count" => 56 }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/dedicated_hosts/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221/disks/0787-8c2a09be-ee18-4af2-8ef4-6a6060732221?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_dedicated_host_disk(
      dedicated_host_id: "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221",
      id: "0787-8c2a09be-ee18-4af2-8ef4-6a6060732221",
      dedicated_host_disk_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_volume_profiles
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles?limit=50" },
                         "limit" => 50, "profiles" => [{ "family" => "tiered", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/10iops-tier", "name" => "10iops-tier" }, { "family" => "tiered", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/5iops-tier", "name" => "5iops-tier" }, { "family" => "tiered", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/general-purpose", "name" => "general-purpose" }, { "family" => "custom", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/custom", "name" => "custom" }], "total_count" => 4 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_volume_profiles

    assert_equal(message_response, service_response.result)
  end

  def test_get_volume_profile
    message_response = { "family" => "tiered",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/10iops-tier", "name" => "10iops-tier" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/10iops-tier?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_volume_profile(
      name: "10iops-tier"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_volumes
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes?limit=50" }, "limit" => 50,
                         "volumes" => [{ "capacity" => 100, "created_at" => "2019-01-29T06:26:17Z", "crn" => "crn:[...]", "encryption" => "provider_managed", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/ccbe6fe1-5680-4865-94d3-687076a38293", "id" => "ccbe6fe1-5680-4865-94d3-687076a38293", "iops" => 1000, "name" => "my-volume-1", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/general-purpose", "name" => "general-purpose" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "available", "status_reasons" => [], "volume_attachments" => [{ "delete_volume_on_instance_delete" => true, "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/33bd5872-7034-462b-9f3e-d400c49d347a/volume_attachments/b31c1a5a-122a-4e32-a10b-f2c31271de85", "id" => "b31c1a5a-122a-4e32-a10b-f2c31271de85", "instance" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/33bd5872-7034-462b-9f3e-d400c49d347a", "id" => "33bd5872-7034-462b-9f3e-d400c49d347a", "name" => "instance-1" }, "name" => "volume-attachment-1", "type" => "data" }], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }, { "capacity" => 100, "created_at" => "2019-03-23T16:46:54Z", "crn" => "crn:[...]", "encryption" => "provider_managed", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/9de3e18c-cec9-4cac-a64a-0bdfab21e9d4", "id" => "9de3e18c-cec9-4cac-a64a-0bdfab21e9d4", "iops" => 1000, "name" => "volume-2", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/general-purpose", "name" => "general-purpose" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "available", "status_reasons" => [], "volume_attachments" => [], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }, { "capacity" => 100, "created_at" => "2019-07-13T02:22:43Z", "crn" => "crn:[...]", "encryption" => "provider_managed", "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/89ba05e9-6e35-4964-9747-7ae3f9b30303", "id" => "89ba05e9-6e35-4964-9747-7ae3f9b30303", "iops" => 1000, "name" => "volume-3", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/5iops-tier", "name" => "5iops-tier" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "available", "status_reasons" => [], "volume_attachments" => [], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2", "resource_type" => "zone" } }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/volumes?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_volumes

    assert_equal(message_response, service_response.result)
  end

  def test_create_volume
    message_response = { "capacity" => 50, "created_at" => "2019-03-28T23:16:53.000Z", "crn" => "crn:[...]",
                         "encryption" => "user_managed", "encryption_key" => { "crn" => "crn:[...]" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2d1bb5a8-40a8-447a-acf7-0eadc8aeb054", "id" => "2d1bb5a8-40a8-447a-acf7-0eadc8aeb054", "iops" => 100, "name" => "my-volume-4", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/custom", "name" => "custom" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "available", "status_reasons" => [], "volume_attachments" => [], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/volumes?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_volume(
      volume_prototype: {
        "capacity": 100,
        "profile": {
          "name": "5iops-tier"
        },
        "zone": {
          "name": "us-south-1"
        }
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_volume
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/volumes/2d1bb5a8-40a8-447a-acf7-0eadc8aeb054?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_volume(
      id: "2d1bb5a8-40a8-447a-acf7-0eadc8aeb054"
    )
  end

  def test_get_volume
    message_response = { "capacity" => 50, "created_at" => "2019-03-28T23:16:53.000Z", "crn" => "crn:[...]",
                         "encryption" => "user_managed", "encryption_key" => { "crn" => "crn:[...]" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2d1bb5a8-40a8-447a-acf7-0eadc8aeb054", "id" => "2d1bb5a8-40a8-447a-acf7-0eadc8aeb054", "iops" => 100, "name" => "my-volume-4", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/custom", "name" => "custom" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "available", "status_reasons" => [], "volume_attachments" => [], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/volumes/2d1bb5a8-40a8-447a-acf7-0eadc8aeb054?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_volume(
      id: "2d1bb5a8-40a8-447a-acf7-0eadc8aeb054"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_volume
    message_response = { "capacity" => 50, "created_at" => "2019-03-28T23:16:53.000Z", "crn" => "crn:[...]",
                         "encryption" => "user_managed", "encryption_key" => { "crn" => "crn:[...]" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/volumes/2d1bb5a8-40a8-447a-acf7-0eadc8aeb054", "id" => "2d1bb5a8-40a8-447a-acf7-0eadc8aeb054", "iops" => 100, "name" => "my-volume-4", "profile" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/volume/profiles/custom", "name" => "custom" }, "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "available", "status_reasons" => [], "volume_attachments" => [], "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/volumes/2d1bb5a8-40a8-447a-acf7-0eadc8aeb054?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_volume(
      id: "2d1bb5a8-40a8-447a-acf7-0eadc8aeb054",
      volume_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_regions
    message_response = { "regions" => [
      { "endpoint" => "https://us-south.iaas.cloud.ibm.com",
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south", "name" => "us-south", "status" => "available" }, { "endpoint" => "https://eu-de.iaas.cloud.ibm.com", "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/eu-de", "name" => "eu-de", "status" => "available" }
    ] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/regions?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_regions

    assert_equal(message_response, service_response.result)
  end

  def test_get_region
    message_response = { "endpoint" => "https://us-south.iaas.cloud.ibm.com",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south", "name" => "us-south", "status" => "available" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_region(
      name: "us-south"
    )

    assert_equal(message_response, service_response.result)
  end

  ### HERE ###
  def test_list_region_zones
    message_response = { "zones" => [
      { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1",
        "region" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south", "name" => "us-south" }, "status" => "available" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-2", "name" => "us-south-2", "region" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south", "name" => "us-south" }, "status" => "available" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-3", "name" => "us-south-3", "region" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south", "name" => "us-south" }, "status" => "available" }
    ] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_region_zones(
      region_name: "us-south"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_get_region_zone
    message_response = { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1",
                         "name" => "us-south-1", "region" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south", "name" => "us-south" }, "status" => "available" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_region_zone(
      region_name: "us-south",
      name: "us-south-1"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_public_gateways
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/public_gateways?limit=50" },
                         "limit" => 50, "public_gateways" => [{ "created_at" => "2019-01-27T06:47:20Z", "crn" => "crn:[...]", "floating_ip" => { "address" => "192.0.2.2", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "name" => "my-floating-ip-1" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/public_gateways/ba1b3bf9-27ab-498d-8aac-c30b09b5555b", "id" => "f94a91c7-95db-42f2-9949-93a7e8fb63fb", "name" => "my-public-gateway-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "public_gateway", "status" => "available", "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc-1" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }, { "created_at" => "2019-01-28T06:47:20Z", "crn" => "crn:[...]", "floating_ip" => { "address" => "192.0.2.2", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "f5380e82-cba3-4efa-b17c-ef0993936e05", "name" => "my-floating-ip-1" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/public_gateways/e2928e82-e23f-4f31-92b3-5c154e58da09", "id" => "ec132615-75a5-417b-a720-dec1d27b22ff", "name" => "my-public-gateway-2", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "public_gateway", "status" => "available", "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc-1" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }], "total_count" => 2 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/public_gateways?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_public_gateways

    assert_equal(message_response, service_response.result)
  end

  def test_create_public_gateway
    message_response = { "created_at" => "2019-01-28T06:47:20Z", "crn" => "crn:[...]",
                         "floating_ip" => { "address" => "192.0.2.2", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "f5380e82-cba3-4efa-b17c-ef0993936e05", "name" => "my-floating-ip-1" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/public_gateways/d4d3ef82-bebb-446e-bbe4-038bc82f6776", "id" => "4fd00a61-fe63-4186-81c9-f7253b5c1cd7", "name" => "my-public-gateway", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "public_gateway", "status" => "available", "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc-1" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/public_gateways?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_public_gateway(
      vpc: "a0819609-0997-4f92-9409-86c95ddf59d3",
      zone: "us-south-1"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_public_gateway
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/public_gateways/d4d3ef82-bebb-446e-bbe4-038bc82f6776?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_public_gateway(
      id: "d4d3ef82-bebb-446e-bbe4-038bc82f6776"
    )
  end

  def test_get_public_gateway
    message_response = { "created_at" => "2019-01-28T06:47:20Z", "crn" => "crn:[...]",
                         "floating_ip" => { "address" => "192.0.2.2", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "f5380e82-cba3-4efa-b17c-ef0993936e05", "name" => "my-floating-ip-1" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/public_gateways/d4d3ef82-bebb-446e-bbe4-038bc82f6776", "id" => "4fd00a61-fe63-4186-81c9-f7253b5c1cd7", "name" => "my-public-gateway", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "public_gateway", "status" => "available", "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc-1" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/public_gateways/d4d3ef82-bebb-446e-bbe4-038bc82f6776?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_public_gateway(
      id: "d4d3ef82-bebb-446e-bbe4-038bc82f6776"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_public_gateway
    message_response = { "created_at" => "2019-01-28T06:47:20Z", "crn" => "crn:[...]",
                         "floating_ip" => { "address" => "192.0.2.2", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "f5380e82-cba3-4efa-b17c-ef0993936e05", "name" => "my-floating-ip-1" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/public_gateways/d4d3ef82-bebb-446e-bbe4-038bc82f6776", "id" => "4fd00a61-fe63-4186-81c9-f7253b5c1cd7", "name" => "my-public-gateway", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "public_gateway", "status" => "available", "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/a0819609-0997-4f92-9409-86c95ddf59d3", "id" => "a0819609-0997-4f92-9409-86c95ddf59d3", "name" => "my-vpc-1" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/public_gateways/d4d3ef82-bebb-446e-bbe4-038bc82f6776?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_public_gateway(
      id: "d4d3ef82-bebb-446e-bbe4-038bc82f6776",
      public_gateway_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_floating_ips
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips?limit=50" },
                         "floating_ips" => [{ "address" => "192.0.2.2", "created_at" => "2019-01-28T12:08:05Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "id" => "4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "name" => "my-floating-ip-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "pending", "target" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/f2a2ab09-0c9e-4b2d-a1cf-7425d1c834b9/network_interfaces/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a2", "id" => "bd5f7dc3-93c7-4d3a-89b4-26c4cc364a2", "name" => "my-network-interface-1", "primary_ipv4_address" => "10.0.1.9", "resource_type" => "network_interface" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }, { "address" => "198.51.100.1", "created_at" => "2019-01-29T12:08:05Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/64580c28-713a-4cda-9993-53bc6a529bb4", "id" => "64580c28-713a-4cda-9993-53bc6a529bb4", "name" => "my-floating-ip-2", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "pending", "target" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/f2a2ab09-0c9e-4b2d-a1cf-7425d1c834b9/network_interfaces/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32", "id" => "bd5f7dc3-93c7-4d3a-89b4-26c4cc364", "name" => "my-network-interface-1", "primary_ipv4_address" => "10.0.1.10", "resource_type" => "network_interface" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }], "limit" => 50, "total_count" => 2 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/floating_ips?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_floating_ips

    assert_equal(message_response, service_response.result)
  end

  def test_create_floating_ip
    message_response = { "address" => "192.0.2.2", "created_at" => "2019-01-28T12:08:05Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "name" => "my-floating-ip-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "pending", "target" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32/network_interfaces/5a07e83d-c1f3-4df2-bcec-41b09c006847", "id" => "5a07e83d-c1f3-4df2-bcec-41b09c006847", "name" => "my-network-interface-1", "primary_ipv4_address" => "10.0.1.9", "resource_type" => "network_interface" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/floating_ips?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_floating_ip(
      floating_ip_prototype: {
        "name": "my-new-floating-ip",
        "target": {
          "id": "69e55145-cc7d-4d8e-9e1f-cc3fb60b1793"
        }
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_floating_ip
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_floating_ip(
      id: "ad0cded3-53a3-4d4a-9809-8c59b50d2b80"
    )
  end

  def test_get_floating_ip
    message_response = { "address" => "192.0.2.2", "created_at" => "2019-01-28T12:08:05Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "name" => "my-floating-ip-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "pending", "target" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32/network_interfaces/5a07e83d-c1f3-4df2-bcec-41b09c006847", "id" => "5a07e83d-c1f3-4df2-bcec-41b09c006847", "name" => "my-network-interface-1", "primary_ipv4_address" => "10.0.1.9", "resource_type" => "network_interface" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_floating_ip(
      id: "ad0cded3-53a3-4d4a-9809-8c59b50d2b80"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_floating_ip
    message_response = { "address" => "192.0.2.2", "created_at" => "2019-01-28T12:08:05Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "id" => "ad0cded3-53a3-4d4a-9809-8c59b50d2b80", "name" => "my-floating-ip-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "status" => "pending", "target" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32/network_interfaces/5a07e83d-c1f3-4df2-bcec-41b09c006847", "id" => "5a07e83d-c1f3-4df2-bcec-41b09c006847", "name" => "my-network-interface-1", "primary_ipv4_address" => "10.0.1.9", "resource_type" => "network_interface" }, "zone" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/regions/us-south/zones/us-south-1", "name" => "us-south-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/floating_ips/ad0cded3-53a3-4d4a-9809-8c59b50d2b80?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_floating_ip(
      id: "ad0cded3-53a3-4d4a-9809-8c59b50d2b80",
      floating_ip_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_network_acls
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls?limit=50" },
                         "limit" => 50, "network_acls" => [{ "created_at" => "2019-01-29T06:26:17Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/e9d38838-7531-4383-bd01-662e10527f29", "id" => "e9d38838-7531-4383-bd01-662e10527f29", "name" => "my-network-acl-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "action" => "allow", "created_at" => "2019-01-29T06:26:17Z", "destination" => "0.0.0.0/0", "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee", "id" => "cb19f11d-0e25-4650-a8ab-f4539da563ee", "ip_version" => "ipv4", "name" => "my-allow-all-inbound-rule", "protocol" => "all", "source" => "0.0.0.0/0" }, { "action" => "allow", "created_at" => "2019-01-29T06:26:17Z", "destination" => "0.0.0.0/0", "direction" => "outbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/2c46afc9-b30a-4453-8897-1096383fb053", "id" => "2c46afc9-b30a-4453-8897-1096383fb053", "ip_version" => "ipv4", "name" => "my-allow-all-outbound-rule", "protocol" => "all", "source" => "0.0.0.0/0" }], "subnets" => [{ "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "id" => "3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "name" => "subnet-1" }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" } }, { "created_at" => "2019-01-29T07:21:17Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/a2ce7c07-7775-4aa6-b0c4-320ad5340f84", "id" => "a2ce7c07-7775-4aa6-b0c4-320ad5340f84", "name" => "my-network-acl-2", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "action" => "allow", "created_at" => "2019-01-29T07:21:17Z", "destination" => "0.0.0.0/0", "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee", "id" => "cb19f11d-0e25-4650-a8ab-f4539da563ee", "ip_version" => "ipv4", "name" => "my-allow-all-inbound-rule", "protocol" => "all", "source" => "0.0.0.0/0" }, { "action" => "allow", "created_at" => "2019-01-29T07:21:17Z", "destination" => "0.0.0.0/0", "direction" => "outbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/2c46afc9-b30a-4453-8897-1096383fb053", "id" => "2c46afc9-b30a-4453-8897-1096383fb053", "ip_version" => "ipv4", "name" => "my-allow-all-outbound-rule", "protocol" => "all", "source" => "0.0.0.0/0" }], "subnets" => [], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" } }], "total_count" => 2 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/network_acls?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_network_acls

    assert_equal(message_response, service_response.result)
  end

  def test_create_network_acl
    message_response = { "created_at" => "2019-01-29T06:26:17Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d", "id" => "3217cb8b-5368-452a-9399-a84f14fb539d", "name" => "my-network-acl", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [], "subnets" => [], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/network_acls?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_network_acl(
      network_acl_prototype: {
        "name": "my-network-acl",
        "vpc": {
          "id": "f0aae929-7047-46d1-92e1-9102b07a7f6f"
        }
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_network_acl
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_network_acl(
      id: "3217cb8b-5368-452a-9399-a84f14fb539d"
    )
  end

  def test_get_network_acl
    message_response = { "created_at" => "2019-01-29T06:26:17Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d", "id" => "3217cb8b-5368-452a-9399-a84f14fb539d", "name" => "my-network-acl", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [], "subnets" => [], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_network_acl(
      id: "3217cb8b-5368-452a-9399-a84f14fb539d"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_network_acl
    message_response = { "created_at" => "2019-01-29T06:26:17Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d", "id" => "3217cb8b-5368-452a-9399-a84f14fb539d", "name" => "my-network-acl", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [], "subnets" => [], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/f0aae929-7047-46d1-92e1-9102b07a7f6f", "id" => "f0aae929-7047-46d1-92e1-9102b07a7f6f", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_network_acl(
      id: "3217cb8b-5368-452a-9399-a84f14fb539d",
      network_acl_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_network_acl_rules
    message_response = {
      "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules?limit=50" }, "limit" => 50, "rules" => [
        { "action" => "deny", "created_at" => "2019-01-07T04:01:28Z", "destination" => "0.0.0.0/0", "direction" => "inbound",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee", "id" => "cb19f11d-0e25-4650-a8ab-f4539da563ee", "ip_version" => "ipv4", "name" => "allow-all-inbound-rule", "port_max" => 22, "port_min" => 22, "protocol" => "tcp", "source" => "0.0.0.0/0", "source_port_max" => 65_535, "source_port_min" => 1 }, { "action" => "allow", "created_at" => "2019-01-07T04:01:24Z", "destination" => "0.0.0.0/0", "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/2c46afc9-b30a-4453-8897-1096383fb053", "id" => "2c46afc9-b30a-4453-8897-1096383fb053", "ip_version" => "ipv4", "name" => "allow-all-outbound-rule", "protocol" => "all", "source" => "0.0.0.0/0" }, { "action" => "allow", "created_at" => "2019-01-07T04:01:24Z", "destination" => "0.0.0.0/0", "direction" => "outbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/0b952e7f-0db6-4cbd-954f-92fbcc3acc39", "id" => "0b952e7f-0db6-4cbd-954f-92fbcc3acc39", "ip_version" => "ipv4", "name" => "allow-all-outbound-rule-2", "protocol" => "all", "source" => "0.0.0.0/0" }
      ], "total_count" => 3
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_network_acl_rules(
      network_acl_id: "3217cb8b-5368-452a-9399-a84f14fb539d"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_network_acl_rule
    message_response = { "action" => "allow", "created_at" => "2019-01-29T06:26:17Z", "destination" => "0.0.0.0/0",
                         "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee", "id" => "cb19f11d-0e25-4650-a8ab-f4539da563ee", "ip_version" => "ipv4", "name" => "inbound-rule-1", "protocol" => "all", "source" => "0.0.0.0/0" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_network_acl_rule(
      network_acl_id: "3217cb8b-5368-452a-9399-a84f14fb539d",
      network_acl_rule_prototype: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_network_acl_rule
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_network_acl_rule(
      network_acl_id: "3217cb8b-5368-452a-9399-a84f14fb539d",
      id: "cb19f11d-0e25-4650-a8ab-f4539da563ee"
    )
  end

  def test_get_network_acl_rule
    message_response = { "action" => "allow", "created_at" => "2019-01-29T06:26:17Z", "destination" => "0.0.0.0/0",
                         "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee", "id" => "cb19f11d-0e25-4650-a8ab-f4539da563ee", "ip_version" => "ipv4", "name" => "inbound-rule-1", "protocol" => "all", "source" => "0.0.0.0/0" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_network_acl_rule(
      network_acl_id: "3217cb8b-5368-452a-9399-a84f14fb539d",
      id: "cb19f11d-0e25-4650-a8ab-f4539da563ee"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_network_acl_rule
    message_response = { "action" => "allow", "created_at" => "2019-01-29T06:26:17Z", "destination" => "0.0.0.0/0",
                         "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee", "id" => "cb19f11d-0e25-4650-a8ab-f4539da563ee", "ip_version" => "ipv4", "name" => "inbound-rule-1", "protocol" => "all", "source" => "0.0.0.0/0" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/network_acls/3217cb8b-5368-452a-9399-a84f14fb539d/rules/cb19f11d-0e25-4650-a8ab-f4539da563ee?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_network_acl_rule(
      network_acl_id: "3217cb8b-5368-452a-9399-a84f14fb539d",
      id: "cb19f11d-0e25-4650-a8ab-f4539da563ee",
      network_acl_rule_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_security_groups
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups?limit=50" },
                         "limit" => 50, "security_groups" => [{ "created_at" => "2018-12-03T21:13:27Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001092021", "id" => "2d364f0a-a870-42c3-a554-000001092021", "name" => "my-security-group-1", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface" }], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "direction" => "outbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001092021/rules/b597cff2-38e8-4e6e-999d-000002158409", "id" => "b597cff2-38e8-4e6e-999d-000002158409", "ip_version" => "ipv4", "protocol" => "all", "remote" => { "cidr_block" => "0.0.0.0/0" } }, { "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001092021/rules/b597cff2-38e8-4e6e-999d-000002158945", "id" => "b597cff2-38e8-4e6e-999d-000002158945", "ip_version" => "ipv4", "protocol" => "icmp", "remote" => { "cidr_block" => "0.0.0.0/0" }, "type" => 8 }, { "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001092021/rules/b597cff2-38e8-4e6e-999d-000002158607", "id" => "b597cff2-38e8-4e6e-999d-000002158607", "ip_version" => "ipv4", "protocol" => "all", "remote" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001092021", "id" => "2d364f0a-a870-42c3-a554-000001092021", "name" => "my-security-group-1" } }], "targets" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "resource_type" => "network_interface" }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/210e7530-01a6-485f-a603-47ca070ef3c1", "id" => "210e7530-01a6-485f-a603-47ca070ef3c1", "name" => "my-vpc" } }, { "created_at" => "2018-12-06T02:00:33Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001096421", "id" => "2d364f0a-a870-42c3-a554-000001096421", "name" => "my-security-group-2", "network_interfaces" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "primary_ipv4_address" => "10.0.0.32", "resource_type" => "network_interface" }], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001096421/rules/b597cff2-38e8-4e6e-999d-000002166937", "id" => "b597cff2-38e8-4e6e-999d-000002166937", "ip_version" => "ipv4", "port_max" => 22, "port_min" => 22, "protocol" => "tcp", "remote" => { "cidr_block" => "0.0.0.0/0" } }, { "direction" => "outbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001096421/rules/b597cff2-38e8-4e6e-999d-000002166993", "id" => "b597cff2-38e8-4e6e-999d-000002166993", "ip_version" => "ipv4", "protocol" => "all", "remote" => { "cidr_block" => "0.0.0.0/0" } }, { "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001096421/rules/b597cff2-38e8-4e6e-999d-000002167157", "id" => "b597cff2-38e8-4e6e-999d-000002167157", "ip_version" => "ipv4", "protocol" => "all", "remote" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001096421", "id" => "2d364f0a-a870-42c3-a554-000001096421", "name" => "my-security-group-2" } }, { "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001096421/rules/b597cff2-38e8-4e6e-999d-000002167167", "id" => "b597cff2-38e8-4e6e-999d-000002167167", "ip_version" => "ipv4", "protocol" => "icmp", "remote" => { "cidr_block" => "0.0.0.0/0" } }], "targets" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/e402fa1b-96f6-4aa2-a8d7-703aac843651/network_interfaces/7ca88dfb-8962-469d-b1de-1dd56f4c3275", "id" => "7ca88dfb-8962-469d-b1de-1dd56f4c3275", "name" => "my-network-interface", "resource_type" => "network_interface" }], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/6c008092-e04e-40a4-ac4c-880f60e06281", "id" => "6c008092-e04e-40a4-ac4c-880f60e06281", "name" => "my-vpc-1" } }], "total_count" => 2 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/security_groups?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_security_groups

    assert_equal(message_response, service_response.result)
  end

  def test_create_security_group
    message_response = { "created_at" => "2018-12-07T17:52:13Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037", "id" => "2d364f0a-a870-42c3-a554-000001099037", "name" => "my-security-group-allow-ssh", "network_interfaces" => [], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002172691", "id" => "b597cff2-38e8-4e6e-999d-000002172691", "ip_version" => "ipv4", "port_max" => 22, "port_min" => 22, "protocol" => "tcp", "remote" => { "cidr_block" => "0.0.0.0/0" } }], "targets" => [], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/31cf397a-286a-4289-a7e7-92f177e7e491", "id" => "31cf397a-286a-4289-a7e7-92f177e7e491", "name" => "my-vpc-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/security_groups?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_security_group(
      vpc: "31cf397a-286a-4289-a7e7-92f177e7e491"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_security_group
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_security_group(
      id: "2d364f0a-a870-42c3-a554-000001099037"
    )
  end

  def test_get_security_group
    message_response = { "created_at" => "2018-12-07T17:52:13Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037", "id" => "2d364f0a-a870-42c3-a554-000001099037", "name" => "my-security-group-allow-ssh", "network_interfaces" => [], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002172691", "id" => "b597cff2-38e8-4e6e-999d-000002172691", "ip_version" => "ipv4", "port_max" => 22, "port_min" => 22, "protocol" => "tcp", "remote" => { "cidr_block" => "0.0.0.0/0" } }], "targets" => [], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/31cf397a-286a-4289-a7e7-92f177e7e491", "id" => "31cf397a-286a-4289-a7e7-92f177e7e491", "name" => "my-vpc-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_security_group(
      id: "2d364f0a-a870-42c3-a554-000001099037"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_get_security_group_target
    message_response = { "created_at" => "2018-12-07T17:52:13Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037", "id" => "2d364f0a-a870-42c3-a554-000001099037", "name" => "my-security-group-allow-ssh", "network_interfaces" => [], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002172691", "id" => "b597cff2-38e8-4e6e-999d-000002172691", "ip_version" => "ipv4", "port_max" => 22, "port_min" => 22, "protocol" => "tcp", "remote" => { "cidr_block" => "0.0.0.0/0" } }], "targets" => [], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/31cf397a-286a-4289-a7e7-92f177e7e491", "id" => "31cf397a-286a-4289-a7e7-92f177e7e491", "name" => "my-vpc-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/targets/2d364f0a-a870-42c3-a554-000001099037?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_security_group_target(
      security_group_id: "2d364f0a-a870-42c3-a554-000001099037",
      id: "2d364f0a-a870-42c3-a554-000001099037"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_security_group_targets
    message_response = { "created_at" => "2018-12-07T17:52:13Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037", "id" => "2d364f0a-a870-42c3-a554-000001099037", "name" => "my-security-group-allow-ssh", "network_interfaces" => [], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002172691", "id" => "b597cff2-38e8-4e6e-999d-000002172691", "ip_version" => "ipv4", "port_max" => 22, "port_min" => 22, "protocol" => "tcp", "remote" => { "cidr_block" => "0.0.0.0/0" } }], "targets" => [], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/31cf397a-286a-4289-a7e7-92f177e7e491", "id" => "31cf397a-286a-4289-a7e7-92f177e7e491", "name" => "my-vpc-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/targets?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_security_group_targets(
      security_group_id: "2d364f0a-a870-42c3-a554-000001099037"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_security_group_target_binding
    message_response = { "created_at" => "2018-12-07T17:52:13Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037", "id" => "2d364f0a-a870-42c3-a554-000001099037", "name" => "my-security-group-allow-ssh", "network_interfaces" => [], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002172691", "id" => "b597cff2-38e8-4e6e-999d-000002172691", "ip_version" => "ipv4", "port_max" => 22, "port_min" => 22, "protocol" => "tcp", "remote" => { "cidr_block" => "0.0.0.0/0" } }], "targets" => [], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/31cf397a-286a-4289-a7e7-92f177e7e491", "id" => "31cf397a-286a-4289-a7e7-92f177e7e491", "name" => "my-vpc-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:put, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/31cf397a-286a-4289-a7e7-92f177e7e491/targets/31cf397a-286a-4289-a7e7-92f177e7e491?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_security_group_target_binding(
      security_group_id: "31cf397a-286a-4289-a7e7-92f177e7e491",
      id: "31cf397a-286a-4289-a7e7-92f177e7e491"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_delete_security_group_target_binding
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/targets/2d364f0a-a870-42c3-a554-000001099037?generation=2&version=2022-03-29")
      .to_return(status: 204, body: "", headers: headers)
    service.delete_security_group_target_binding(
      security_group_id: "2d364f0a-a870-42c3-a554-000001099037",
      id: "2d364f0a-a870-42c3-a554-000001099037"
    )
  end

  def test_update_security_group
    message_response = { "created_at" => "2018-12-07T17:52:13Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037", "id" => "2d364f0a-a870-42c3-a554-000001099037", "name" => "my-security-group-allow-ssh", "network_interfaces" => [], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "rules" => [{ "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002172691", "id" => "b597cff2-38e8-4e6e-999d-000002172691", "ip_version" => "ipv4", "port_max" => 22, "port_min" => 22, "protocol" => "tcp", "remote" => { "cidr_block" => "0.0.0.0/0" } }], "targets" => [], "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/31cf397a-286a-4289-a7e7-92f177e7e491", "id" => "31cf397a-286a-4289-a7e7-92f177e7e491", "name" => "my-vpc-2" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_security_group(
      id: "2d364f0a-a870-42c3-a554-000001099037",
      security_group_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_security_group_rules
    message_response = { "rules" => [
      { "direction" => "inbound",
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002172691", "id" => "b597cff2-38e8-4e6e-999d-000002172691", "ip_version" => "ipv4", "port_max" => 22, "port_min" => 22, "protocol" => "tcp", "remote" => { "cidr_block" => "0.0.0.0/0" } }, { "code" => 0, "direction" => "inbound", "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002173027", "id" => "b597cff2-38e8-4e6e-999d-000002173027", "ip_version" => "ipv4", "protocol" => "icmp", "remote" => { "cidr_block" => "0.0.0.0/0" }, "type" => 8 }
    ] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_security_group_rules(
      security_group_id: "2d364f0a-a870-42c3-a554-000001099037"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_security_group_rule
    message_response = { "code" => 0, "direction" => "inbound",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002173027", "id" => "b597cff2-38e8-4e6e-999d-000002173027", "ip_version" => "ipv4", "protocol" => "icmp", "remote" => { "cidr_block" => "0.0.0.0/0" }, "type" => 8 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_security_group_rule(
      security_group_id: "2d364f0a-a870-42c3-a554-000001099037",
      security_group_rule_prototype: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_security_group_rule
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002173027?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_security_group_rule(
      security_group_id: "2d364f0a-a870-42c3-a554-000001099037",
      id: "b597cff2-38e8-4e6e-999d-000002173027"
    )
  end

  def test_get_security_group_rule
    message_response = { "code" => 0, "direction" => "inbound",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002173027", "id" => "b597cff2-38e8-4e6e-999d-000002173027", "ip_version" => "ipv4", "protocol" => "icmp", "remote" => { "cidr_block" => "0.0.0.0/0" }, "type" => 8 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002173027?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_security_group_rule(
      security_group_id: "2d364f0a-a870-42c3-a554-000001099037",
      id: "b597cff2-38e8-4e6e-999d-000002173027"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_security_group_rule
    message_response = { "code" => 0, "direction" => "inbound",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002173027", "id" => "b597cff2-38e8-4e6e-999d-000002173027", "ip_version" => "ipv4", "protocol" => "icmp", "remote" => { "cidr_block" => "0.0.0.0/0" }, "type" => 8 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/security_groups/2d364f0a-a870-42c3-a554-000001099037/rules/b597cff2-38e8-4e6e-999d-000002173027?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_security_group_rule(
      security_group_id: "2d364f0a-a870-42c3-a554-000001099037",
      id: "b597cff2-38e8-4e6e-999d-000002173027",
      security_group_rule_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_ike_policies
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/ike_policies?limit=50" },
                         "ike_policies" => [{ "authentication_algorithm" => "md5", "connections" => [], "created_at" => "2018-12-13T19:27:58.95704Z", "dh_group" => 2, "encryption_algorithm" => "aes256", "href" => "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/e98f46a3-1e4e-4195-b4e5-b8155192689d", "id" => "e98f46a3-1e4e-4195-b4e5-b8155192689d", "ike_version" => 1, "key_lifetime" => 28_800, "name" => "my-ike-policy-0", "negotiation_mode" => "main", "resource_group" => { "href" => "https://resource-manager.bluemix.net/v1/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "ike_policy" }, { "authentication_algorithm" => "md5", "connections" => [], "created_at" => "2018-12-13T19:26:24.475125Z", "dh_group" => 2, "encryption_algorithm" => "aes256", "href" => "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/53ebcf53-2ee4-4a26-ba2c-afc62091a148", "id" => "53ebcf53-2ee4-4a26-ba2c-afc62091a148", "ike_version" => 1, "key_lifetime" => 28_800, "name" => "my-ike-policy-1", "negotiation_mode" => "main", "resource_group" => { "href" => "https://resource-manager.bluemix.net/v1/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "ike_policy" }], "limit" => 50, "total_count" => 2 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/ike_policies?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_ike_policies

    assert_equal(message_response, service_response.result)
  end

  def test_create_ike_policy
    message_response = { "authentication_algorithm" => "md5", "connections" => [],
                         "created_at" => "2018-12-13T19:26:24.475125Z", "dh_group" => 2, "encryption_algorithm" => "aes256", "href" => "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/53ebcf53-2ee4-4a26-ba2c-afc62091a148", "id" => "53ebcf53-2ee4-4a26-ba2c-afc62091a148", "ike_version" => 1, "key_lifetime" => 28_800, "name" => "my-ike-policy-1", "negotiation_mode" => "main", "resource_group" => { "href" => "https://resource-manager.bluemix.net/v1/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "ike_policy" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/ike_policies?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_ike_policy(
      authentication_algorithm: "md5",
      dh_group: 2,
      encryption_algorithm: "aes256",
      ike_version: 1
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_ike_policy
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/53ebcf53-2ee4-4a26-ba2c-afc62091a148?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_ike_policy(
      id: "53ebcf53-2ee4-4a26-ba2c-afc62091a148"
    )
  end

  def test_get_ike_policy
    message_response = { "authentication_algorithm" => "md5", "connections" => [],
                         "created_at" => "2018-12-13T19:26:24.475125Z", "dh_group" => 2, "encryption_algorithm" => "aes256", "href" => "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/53ebcf53-2ee4-4a26-ba2c-afc62091a148", "id" => "53ebcf53-2ee4-4a26-ba2c-afc62091a148", "ike_version" => 1, "key_lifetime" => 28_800, "name" => "my-ike-policy-1", "negotiation_mode" => "main", "resource_group" => { "href" => "https://resource-manager.bluemix.net/v1/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "ike_policy" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/53ebcf53-2ee4-4a26-ba2c-afc62091a148?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_ike_policy(
      id: "53ebcf53-2ee4-4a26-ba2c-afc62091a148"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_ike_policy
    message_response = { "authentication_algorithm" => "md5", "connections" => [],
                         "created_at" => "2018-12-13T19:26:24.475125Z", "dh_group" => 2, "encryption_algorithm" => "aes256", "href" => "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/53ebcf53-2ee4-4a26-ba2c-afc62091a148", "id" => "53ebcf53-2ee4-4a26-ba2c-afc62091a148", "ike_version" => 1, "key_lifetime" => 28_800, "name" => "my-ike-policy-1", "negotiation_mode" => "main", "resource_group" => { "href" => "https://resource-manager.bluemix.net/v1/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "ike_policy" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/53ebcf53-2ee4-4a26-ba2c-afc62091a148?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_ike_policy(
      id: "53ebcf53-2ee4-4a26-ba2c-afc62091a148",
      ike_policy_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_ike_policy_connections
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/53ebcf53-2ee4-4a26-ba2c-afc62091a148/connections?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_ike_policy_connections(
      id: "53ebcf53-2ee4-4a26-ba2c-afc62091a148"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_ipsec_policies
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies?limit=50" },
                         "ipsec_policies" => [{ "authentication_algorithm" => "md5", "connections" => [], "created_at" => "2018-12-13T19:34:16.961597Z", "encapsulation_mode" => "tunnel", "encryption_algorithm" => "aes256", "href" => "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7", "id" => "43c2f663-3960-4289-9253-f6eab23a6cd7", "key_lifetime" => 28_800, "name" => "my-ipsec-policy-1", "pfs" => "disabled", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "resource_type" => "ipsec_policy", "transform_protocol" => "esp" }, { "authentication_algorithm" => "md5", "connections" => [], "created_at" => "2018-12-13T19:34:08.719912Z", "encapsulation_mode" => "tunnel", "encryption_algorithm" => "aes256", "href" => "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/a4c47690-bc52-45df-9bbd-a1f2b814a8ac", "id" => "a4c47690-bc52-45df-9bbd-a1f2b814a8ac", "key_lifetime" => 28_800, "name" => "my-ipsec-policy-2", "pfs" => "disabled", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "resource_type" => "ipsec_policy", "transform_protocol" => "esp" }], "limit" => 50, "total_count" => 2 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_ipsec_policies

    assert_equal(message_response, service_response.result)
  end

  def test_create_ipsec_policy
    message_response = { "authentication_algorithm" => "md5", "connections" => [],
                         "created_at" => "2018-12-13T19:34:16.961597Z", "encapsulation_mode" => "tunnel", "encryption_algorithm" => "aes256", "href" => "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7", "id" => "43c2f663-3960-4289-9253-f6eab23a6cd7", "key_lifetime" => 28_800, "name" => "my-ipsec-policy-2", "pfs" => "disabled", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "resource_type" => "ipsec_policy", "transform_protocol" => "esp" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_ipsec_policy(
      authentication_algorithm: "md5",
      encryption_algorithm: "aes256",
      pfs: "disabled"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_ipsec_policy
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_ipsec_policy(
      id: "43c2f663-3960-4289-9253-f6eab23a6cd7"
    )
  end

  def test_get_ipsec_policy
    message_response = { "authentication_algorithm" => "md5", "connections" => [],
                         "created_at" => "2018-12-13T19:34:16.961597Z", "encapsulation_mode" => "tunnel", "encryption_algorithm" => "aes256", "href" => "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7", "id" => "43c2f663-3960-4289-9253-f6eab23a6cd7", "key_lifetime" => 28_800, "name" => "my-ipsec-policy-2", "pfs" => "disabled", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "resource_type" => "ipsec_policy", "transform_protocol" => "esp" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_ipsec_policy(
      id: "43c2f663-3960-4289-9253-f6eab23a6cd7"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_ipsec_policy
    message_response = { "authentication_algorithm" => "md5", "connections" => [],
                         "created_at" => "2018-12-13T19:34:16.961597Z", "encapsulation_mode" => "tunnel", "encryption_algorithm" => "aes256", "href" => "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7", "id" => "43c2f663-3960-4289-9253-f6eab23a6cd7", "key_lifetime" => 28_800, "name" => "my-ipsec-policy-2", "pfs" => "disabled", "resource_group" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/resource_groups/3fad3f2204eb4998c3964d254ffcd771", "id" => "3fad3f2204eb4998c3964d254ffcd771", "name" => "Default" }, "resource_type" => "ipsec_policy", "transform_protocol" => "esp" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_ipsec_policy(
      id: "43c2f663-3960-4289-9253-f6eab23a6cd7",
      i_psec_policy_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_ipsec_policy_connections
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7/connections?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_ipsec_policy_connections(
      id: "43c2f663-3960-4289-9253-f6eab23a6cd7"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_vpn_gateways
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways?limit=50" },
                         "limit" => 50, "total_count" => 2, "vpn_gateways" => [{ "connections" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/bb7baa8f-e4e2-45f5-9286-aac4139d5e78/connections/9736b5a9-0244-475b-a008-ef75a4d72e67", "id" => "9736b5a9-0244-475b-a008-ef75a4d72e67", "name" => "my-vpn-connection", "resource_type" => "vpn_gateway_connection" }], "created_at" => "2018-12-13T19:50:40.740442Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/bb7baa8f-e4e2-45f5-9286-aac4139d5e78", "id" => "bb7baa8f-e4e2-45f5-9286-aac4139d5e78", "members" => [{ "public_ip" => { "address" => "0.0.0.0" }, "role" => "active", "status" => "pending" }, { "public_ip" => { "address" => "0.0.0.0" }, "role" => "standby", "status" => "pending" }], "mode" => "policy", "name" => "my-vpn-gateway-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "vpn_gateway", "status" => "pending", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/2d746293-8d39-4123-a966-cdb2ec50e7ba", "id" => "2d746293-8d39-4123-a966-cdb2ec50e7ba", "name" => "my-subnet-1" } }, { "connections" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc", "id" => "b67efb2c-bd17-457d-be8e-7b46404062dc", "name" => "my-vpn-connection", "resource_type" => "vpn_gateway_connection" }], "created_at" => "2018-12-13T19:38:05.70368Z", "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9", "id" => "a7d258d5-be1e-491d-83db-526d8d9a2ce9", "members" => [{ "public_ip" => { "address" => "0.0.0.0" }, "role" => "active", "status" => "pending" }, { "public_ip" => { "address" => "0.0.0.0" }, "role" => "standby", "status" => "pending" }], "mode" => "policy", "name" => "my-vpn-gateway-2", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "vpn_gateway", "status" => "pending", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/2d746293-8d39-4123-a966-cdb2ec50e7ba", "id" => "2d746293-8d39-4123-a966-cdb2ec50e7ba", "name" => "my-subnet-1" } }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpn_gateways

    assert_equal(message_response, service_response.result)
  end

  def test_create_vpn_gateway
    message_response = { "connections" => [], "created_at" => "2018-12-13T17:29:36.921569Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/e630bb38-c3a7-4619-b0e5-7bff14e060fe", "id" => "e630bb38-c3a7-4619-b0e5-7bff14e060fe", "members" => [{ "public_ip" => { "address" => "0.0.0.0" }, "role" => "active", "status" => "pending" }, { "public_ip" => { "address" => "0.0.0.0" }, "role" => "standby", "status" => "pending" }], "mode" => "policy", "name" => "my-new-vpn-gateway", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "vpn_gateway", "status" => "pending", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/2d746293-8d39-4123-a966-cdb2ec50e7ba", "id" => "2d746293-8d39-4123-a966-cdb2ec50e7ba", "name" => "my-subnet-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_vpn_gateway(
      vpn_gateway_prototype: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_vpn_gateway
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/e630bb38-c3a7-4619-b0e5-7bff14e060fe?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_vpn_gateway(
      id: "e630bb38-c3a7-4619-b0e5-7bff14e060fe"
    )
  end

  def test_get_vpn_gateway
    message_response = { "connections" => [], "created_at" => "2018-12-13T17:29:36.921569Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/e630bb38-c3a7-4619-b0e5-7bff14e060fe", "id" => "e630bb38-c3a7-4619-b0e5-7bff14e060fe", "members" => [{ "public_ip" => { "address" => "0.0.0.0" }, "role" => "active", "status" => "pending" }, { "public_ip" => { "address" => "0.0.0.0" }, "role" => "standby", "status" => "pending" }], "mode" => "policy", "name" => "my-new-vpn-gateway", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "vpn_gateway", "status" => "pending", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/2d746293-8d39-4123-a966-cdb2ec50e7ba", "id" => "2d746293-8d39-4123-a966-cdb2ec50e7ba", "name" => "my-subnet-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/e630bb38-c3a7-4619-b0e5-7bff14e060fe?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpn_gateway(
      id: "e630bb38-c3a7-4619-b0e5-7bff14e060fe"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_vpn_gateway
    message_response = { "connections" => [], "created_at" => "2018-12-13T17:29:36.921569Z", "crn" => "crn:[...]",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/e630bb38-c3a7-4619-b0e5-7bff14e060fe", "id" => "e630bb38-c3a7-4619-b0e5-7bff14e060fe", "members" => [{ "public_ip" => { "address" => "0.0.0.0" }, "role" => "active", "status" => "pending" }, { "public_ip" => { "address" => "0.0.0.0" }, "role" => "standby", "status" => "pending" }], "mode" => "policy", "name" => "my-new-vpn-gateway", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "vpn_gateway", "status" => "pending", "subnet" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/2d746293-8d39-4123-a966-cdb2ec50e7ba", "id" => "2d746293-8d39-4123-a966-cdb2ec50e7ba", "name" => "my-subnet-1" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/e630bb38-c3a7-4619-b0e5-7bff14e060fe?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_vpn_gateway(
      id: "e630bb38-c3a7-4619-b0e5-7bff14e060fe",
      vpn_gateway_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_vpn_gateway_connections
    message_response = { "connections" => [
      { "admin_state_up" => true, "authentication_mode" => "psk", "created_at" => "2018-12-13T19:40:12.124082Z",
        "dead_peer_detection" => { "action" => "none", "interval" => 15, "timeout" => 30 }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/52f69dc3-6a5c-4bcf-b264-e7fae279b15c", "id" => "52f69dc3-6a5c-4bcf-b264-e7fae279b15c", "local_cidrs" => ["192.0.2.50/24"], "mode" => "policy", "name" => "my-vpn-connection-1", "peer_address" => "192.0.2.5", "peer_cidrs" => ["192.0.2.40/24"], "psk" => "lkj14b1oi0alcniejkso", "resource_type" => "vpn_gateway_connection", "status" => "down" }, { "admin_state_up" => true, "authentication_mode" => "psk", "created_at" => "2018-12-13T19:39:47.938464Z", "dead_peer_detection" => { "action" => "none", "interval" => 15, "timeout" => 30 }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc", "id" => "b67efb2c-bd17-457d-be8e-7b46404062dc", "ike_policy" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/e98f46a3-1e4e-4195-b4e5-b8155192689d", "id" => "e98f46a3-1e4e-4195-b4e5-b8155192689d", "name" => "my-ike-policy", "resource_type" => "ike_policy" }, "ipsec_policy" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7", "id" => "43c2f663-3960-4289-9253-f6eab23a6cd7", "name" => "my-ipsec-policy", "resource_type" => "ipsec_policy" }, "local_cidrs" => ["192.0.2.50/24"], "mode" => "policy", "name" => "my-vpn-connection-2", "peer_address" => "192.0.2.5", "peer_cidrs" => ["192.0.2.40/24"], "psk" => "lkj14b1oi0alcniejkso", "resource_type" => "vpn_gateway_connection", "status" => "down" }
    ] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/e630bb38-c3a7-4619-b0e5-7bff14e060fe/connections?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpn_gateway_connections(
      vpn_gateway_id: "e630bb38-c3a7-4619-b0e5-7bff14e060fe"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_vpn_gateway_connection
    message_response = { "admin_state_up" => true, "authentication_mode" => "psk",
                         "created_at" => "2018-12-13T19:39:47.938464Z", "dead_peer_detection" => { "action" => "none", "interval" => 15, "timeout" => 30 }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc", "id" => "b67efb2c-bd17-457d-be8e-7b46404062dc", "ike_policy" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/e98f46a3-1e4e-4195-b4e5-b8155192689d", "id" => "e98f46a3-1e4e-4195-b4e5-b8155192689d", "name" => "my-ike-policy", "resource_type" => "ike_policy" }, "ipsec_policy" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7", "id" => "43c2f663-3960-4289-9253-f6eab23a6cd7", "name" => "my-ipsec-policy", "resource_type" => "ipsec_policy" }, "local_cidrs" => ["192.0.2.50/24"], "mode" => "policy", "name" => "my-vpn-connection-2", "peer_address" => "192.0.2.5", "peer_cidrs" => ["192.0.2.40/24"], "psk" => "lkj14b1oi0alcniejkso", "resource_type" => "vpn_gateway_connection", "status" => "down" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_vpn_gateway_connection(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      vpn_gateway_connection_prototype: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_vpn_gateway_connection
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_vpn_gateway_connection(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc"
    )
  end

  def test_get_vpn_gateway_connection
    message_response = { "admin_state_up" => true, "authentication_mode" => "psk",
                         "created_at" => "2018-12-13T19:39:47.938464Z", "dead_peer_detection" => { "action" => "none", "interval" => 15, "timeout" => 30 }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc", "id" => "b67efb2c-bd17-457d-be8e-7b46404062dc", "ike_policy" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/e98f46a3-1e4e-4195-b4e5-b8155192689d", "id" => "e98f46a3-1e4e-4195-b4e5-b8155192689d", "name" => "my-ike-policy", "resource_type" => "ike_policy" }, "ipsec_policy" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7", "id" => "43c2f663-3960-4289-9253-f6eab23a6cd7", "name" => "my-ipsec-policy", "resource_type" => "ipsec_policy" }, "local_cidrs" => ["192.0.2.50/24"], "mode" => "policy", "name" => "my-vpn-connection-2", "peer_address" => "192.0.2.5", "peer_cidrs" => ["192.0.2.40/24"], "psk" => "lkj14b1oi0alcniejkso", "resource_type" => "vpn_gateway_connection", "status" => "down" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpn_gateway_connection(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_vpn_gateway_connection
    message_response = { "admin_state_up" => true, "authentication_mode" => "psk",
                         "created_at" => "2018-12-13T19:39:47.938464Z", "dead_peer_detection" => { "action" => "none", "interval" => 15, "timeout" => 30 }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc", "id" => "b67efb2c-bd17-457d-be8e-7b46404062dc", "ike_policy" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/ike_policies/e98f46a3-1e4e-4195-b4e5-b8155192689d", "id" => "e98f46a3-1e4e-4195-b4e5-b8155192689d", "name" => "my-ike-policy", "resource_type" => "ike_policy" }, "ipsec_policy" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/ipsec_policies/43c2f663-3960-4289-9253-f6eab23a6cd7", "id" => "43c2f663-3960-4289-9253-f6eab23a6cd7", "name" => "my-ipsec-policy", "resource_type" => "ipsec_policy" }, "local_cidrs" => ["192.0.2.50/24"], "mode" => "policy", "name" => "my-vpn-connection-2", "peer_address" => "192.0.2.5", "peer_cidrs" => ["192.0.2.40/24"], "psk" => "lkj14b1oi0alcniejkso", "resource_type" => "vpn_gateway_connection", "status" => "down" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_vpn_gateway_connection(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc",
      vpn_gateway_connection_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_vpn_servers
    message_response = { "limit" => 10, "first" => { "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers?limit=10" }, "vpn_servers" => [{ "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:c30a05fd-7ca2-4c37-829a-dc8b3cf4358e::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1", "created_at" => "2022-07-22T08:52:35.290Z", "clients" => [{ "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:cf42568c-d6d7-4841-90f6-6d2295066324::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "c86faa8e-467f-4980-895c-4e848dfc9dbf", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:99eb688a-9d3e-4282-a64b-f7a35ff3300a::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/c86faa8e-467f-4980-895c-4e848dfc9dbf", "resource_type" => "vpn_server_client" }, { "id" => "5473db01-c13d-4e0a-8ddf-82c980525f26", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:b8d96501-7b0c-4348-b2f5-3a631729bc52::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/5473db01-c13d-4e0a-8ddf-82c980525f26", "resource_type" => "vpn_server_client" }, { "id" => "b9137493-06c4-482f-9137-877a34154ae2", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:29a2588e-fd3b-40da-9b28-579d8c5bbbe7::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/b9137493-06c4-482f-9137-877a34154ae2", "resource_type" => "vpn_server_client" }, { "id" => "15892f3f-fb1b-4314-8074-f27da41a3fef", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:7c1737dc-267c-476f-a536-dcad3601853e::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/15892f3f-fb1b-4314-8074-f27da41a3fef", "resource_type" => "vpn_server_client" }, { "id" => "791c2280-b3ae-4a1f-a729-f2a7bf8d0617", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:306f5011-a680-4368-90b7-deee448455b2::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/791c2280-b3ae-4a1f-a729-f2a7bf8d0617", "resource_type" => "vpn_server_client" }, { "id" => "3bebb5b9-f0ae-4e2f-9677-59c8dd116fe0", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:8d914653-1f92-459e-8300-64718c00f957::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/3bebb5b9-f0ae-4e2f-9677-59c8dd116fe0", "resource_type" => "vpn_server_client" }, { "id" => "c118f3c4-7efe-4e49-9b84-04b7fc5379c5", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:3b2b83dd-4f88-4bce-8137-d2e5e3676ff6::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/c118f3c4-7efe-4e49-9b84-04b7fc5379c5", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:2f26db2c-c2f3-44bb-8570-67b4896ce741::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:b81aeaa7-d95f-4cd9-b877-d387b7ac0e1a::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:6760f4c4-5412-48a6-8413-6e837aa5feec::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:1d4dbb7f-b517-4272-bd7d-d9907b62a201::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:c436abfd-04f9-4dc1-8453-05545de6be47::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:bf45d38f-55d6-49b6-99cb-17369aa80454::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:2b0b18c5-6fe9-46a6-854e-15c1a0311d5d::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:c769846e-ea44-4326-8de6-764595f5e1e0::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:ab0aefb4-b935-4ea9-a8a8-83da6149c91d::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:17fd9e26-f4c0-45d7-9704-fc84f1a57fbb::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:a2feea7b-0de4-4924-9993-1db501844b02::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:f0ec068d-63ca-4369-915c-249870bad207::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:46bf568d-b717-4152-9997-05aacb5572e7::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:4f29a59a-fe1d-4f0d-87af-c7014623ce0a::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:41acf940-1dee-4550-9b94-3e6160a3654e::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }, { "id" => "1", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:d2413685-845c-4f23-b3b5-05f1e63f5fed::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/clients/1", "resource_type" => "vpn_server_client" }], "routes" => [{ "id" => "ab984ca6-1ad0-459e-a752-bad8f1ace69b", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:d12fdd66-68fd-4ea4-878d-af5b9c58bf84::", "name" => "vpn-server-route-40359", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/routes/ab984ca6-1ad0-459e-a752-bad8f1ace69b", "resource_type" => "vpn_server_route" }, { "id" => "d608381f-53d1-4e01-bad4-27c386985ba8", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:0b15f484-5395-490f-a989-160dcab6aa42::", "name" => "vpn-server-route-54794", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/routes/d608381f-53d1-4e01-bad4-27c386985ba8", "resource_type" => "vpn_server_route" }, { "id" => "e71c6c8b-a57d-466e-a07a-494ba1c36f40", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:2b2a9416-1882-4f14-85b9-6fd3bf37e441::", "name" => "vpn-server-route-38122", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/routes/e71c6c8b-a57d-466e-a07a-494ba1c36f40", "resource_type" => "vpn_server_route" }, { "id" => "153ed98b-f9ac-4132-a369-5b6b06b80f9a", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:97506370-eac9-47fb-8742-870a924f7bd9::", "name" => "vpn-server-route-29115", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/routes/153ed98b-f9ac-4132-a369-5b6b06b80f9a", "resource_type" => "vpn_server_route" }, { "id" => "2bace512-bd1b-452f-adec-56d80aa1adac", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:470921d2-f467-4683-b823-5ac89e84fad0::", "name" => "vpn-server-route-27598", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/routes/2bace512-bd1b-452f-adec-56d80aa1adac", "resource_type" => "vpn_server_route" }, { "id" => "dfb64f42-8818-45c5-ac27-3eda85976128", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:6b24dff3-e5ef-405c-a703-7a11236e8daf::", "name" => "vpn-server-route-18217", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/routes/dfb64f42-8818-45c5-ac27-3eda85976128", "resource_type" => "vpn_server_route" }, { "id" => "de4d55c6-4a73-4186-a437-7344d35d3bce", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:ec7c5662-d172-4aea-ad82-173ffd7e6c64::", "name" => "vpn-server-route-19628", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/1/routes/de4d55c6-4a73-4186-a437-7344d35d3bce", "resource_type" => "vpn_server_route" }], "certificate" => { "crn" => "crn:v1:staging:public:cloudcerts:us-south:a/823bd195e9fd4f0db40ac2e1bffef3e0:8867331f-922c-4d92-a801-41972bb9ee6c:certificate:627556ee336337ebe448cb2553fb3784" }, "client_authentication" => [{ "crl" => "The certificate revocation list (CRL) contents in PEM format.", "client_ca" => { "crn" => "crn:v1:staging:public:cloudcerts:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:8867331f-922c-4d92-a801-41972bb9ee6b:certificate:827556ee336337ebe448cb2553fb3784" }, "method" => "certificate" }, { "method" => "username", "identity_provider" => { "provider_type" => "iam" } }], "client_auto_delete" => true, "client_auto_delete_timeout" => 7, "client_dns_server_ips" => [{ "address" => "170.219.224.21" }, { "address" => "170.8.81.90" }], "client_idle_timeout" => 1202, "client_ip_pool" => "172.240.95.0/16", "enable_split_tunneling" => true, "health_state" => "ok", "hostname" => "my-vpn-server-52151.client-vpn.cloud.ibm.com", "lifecycle_state" => "stable", "name" => "aaa-default-vpn-server-1", "port" => 1194, "protocol" => "tcp", "resource_group" => { "id" => "720a9c5878c7403ba80573f717ecf9b0", "name" => "SmokeTest", "crn" => "crn:v1:staging:public:resource-controller::a/249d926cb9bb46119e3bda8ed7f7f618::resource-group:720a9c5878c7403ba80573f717ecf9b0" }, "resource_type" => "vpn_server", "security_groups" => [{ "id" => "58fd2383-acb8-11e8-94ce-3e338a9fcdfb", "name" => "aaa-default-sg-1", "href" => "http://localhost:4000/rias-mock/us-east/v1/security_groups/58fd2383-acb8-11e8-94ce-3e338a9fcdfb" }, { "id" => "58fd2382-acb8-11e8-94ce-3e338a9fcdfb", "name" => "aaa-default-sg-3", "href" => "http://localhost:4000/rias-mock/us-east/v1/security_groups/58fd2382-acb8-11e8-94ce-3e338a9fcdfb" }], "subnets" => [{ "id" => "3052f86f-bca3-416f-b236-0df955d00e60", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:fb5fd5f5-cc54-4743-ae63-c3669476b8bd::", "name" => "subnet-assumenda-1605-us-east", "href" => "http://localhost:4000/rias-mock/us-east/v1/subnets/3052f86f-bca3-416f-b236-0df955d00e60" }], "zone" => { "name" => "us-east-1", "region_name" => "us-east" }, "private_ips" => [{ "id" => "f7cfbdd0-0e12-4b39-8562-08b3c956695e", "subnetId" => "3052f86f-bca3-416f-b236-0df955d00e60", "name" => "reservedIp-a-6325-us-east", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:29531169-6d5d-434d-bac0-f87ad2e281e3::", "created_at" => "2022-05-25T08:52:35.290Z", "address" => "244.39.39.14", "status" => "available", "zone" => { "name" => "us-east-1", "region_name" => "us-east" }, "auto_delete" => true, "owner" => "user", "meta" => { "revision" => 1, "created" => 1_658_739_155_290, "version" => 0, "updated" => 1_658_739_155_290 }, "$loki" => 1296, "href" => "http://localhost:4000/rias-mock/us-east/v1/subnets/3052f86f-bca3-416f-b236-0df955d00e60/reserved_ips/f7cfbdd0-0e12-4b39-8562-08b3c956695e", "resource_type" => "reserved_ip" }] }], "total_count" => 1 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers?sort=name&generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpn_servers(
      sort: "name"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_vpn_server
    message_response = { "id" => "970e8b78-8f09-4acf-b37a-30458bdfec95", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:64f39757-09c8-4360-a033-5182e5dd785a::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95", "created_at" => "2022-05-31T06:23:50.431Z", "clients" => [{ "id" => "c74f8cc2-a174-4522-b057-7433e5f48833", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:71a3aeca-61ad-458f-99be-57c59ca0e60b::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/c74f8cc2-a174-4522-b057-7433e5f48833", "resource_type" => "vpn_server_client" }, { "id" => "4750e2a7-a314-40f0-b659-ca69ad55dc57", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:b1213d1a-5f9d-437f-ab03-1f7a37654cb2::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/4750e2a7-a314-40f0-b659-ca69ad55dc57", "resource_type" => "vpn_server_client" }], "routes" => [{ "id" => "bc56343b-50ae-40cb-ba48-4eb9b00ff8c5", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:618a480a-31df-410e-b02f-535b2bce1b74::", "name" => "vpn-server-route-64183", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes/bc56343b-50ae-40cb-ba48-4eb9b00ff8c5", "resource_type" => "vpn_server_route" }, { "id" => "68e6a4b7-3e11-4864-8e68-a46ddf2b30bc", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:baacc0cc-5983-41c4-af2f-a16c14ea85cf::", "name" => "vpn-server-route-16232", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes/68e6a4b7-3e11-4864-8e68-a46ddf2b30bc", "resource_type" => "vpn_server_route" }], "certificate" => { "crn" => "crn:v1:bluemix:public:secrets-manager:us-south:a/123456:36fa422d-080d-4d83-8d2d-86851b4001df:secret:2e786aab-42fa-63ed-14f8-d66d552f4dd5" }, "client_authentication" => [{ "method" => "certificate", "identity_provider" => { "provider_type" => "iam" } }], "client_auto_delete" => true, "client_auto_delete_timeout" => 12, "client_dns_server_ips" => [{ "address" => "170.132.69.168" }, { "address" => "170.139.137.219" }], "client_idle_timeout" => 10_716, "client_ip_pool" => "172.16.0.0/16", "enable_split_tunneling" => true, "health_state" => "degraded", "hostname" => "my-vpn-server-33134.client-vpn.cloud.ibm.com", "lifecycle_state" => "deleted", "name" => "my-example-vpn-server", "port" => 1194, "protocol" => "udp", "resource_group" => { "id" => "5018a8564e8120570150b0764d39ebcc", "name" => "Default", "crn" => "crn:v1:staging:public:resource-controller::a/249d926cb9bb46119e3bda8ed7f7f618::resource-group:5018a8564e8120570150b0764d39ebcc" }, "resource_type" => "vpn_server", "security_groups" => [{ "id" => "0ded0ce9-af4e-4d55-9433-6251a9f00ea2", "name" => "sg-sed-9833-jp-tok", "href" => "http://localhost:4000/rias-mock/us-east/v1/security_groups/0ded0ce9-af4e-4d55-9433-6251a9f00ea2" }], "subnets" => [{ "id" => "0965c6b5-6c08-4545-9b26-3e620fd78839", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:51920ad2-b8c2-44da-a4eb-e455fa220d83::", "name" => "my-subnet-vpn-server", "href" => "http://localhost:4000/rias-mock/us-east/v1/subnets/0965c6b5-6c08-4545-9b26-3e620fd78839" }], "zone" => { "name" => "us-east-1", "region_name" => "us-east" }, "private_ips" => [{ "id" => "0fdd77b5-64f3-4461-9ae6-994f7a099080", "subnetId" => "0965c6b5-6c08-4545-9b26-3e620fd78839", "name" => "reservedIp-aut-5916-us-east", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:f964a2c5-e8d1-4a1a-b8ff-ae6abdcd7921::", "created_at" => "2022-04-30T06:23:50.432Z", "address" => "162.241.143.4", "status" => "available", "zone" => { "name" => "us-east-1", "region_name" => "us-east" }, "auto_delete" => true, "owner" => "user", "meta" => { "revision" => 2, "created" => 1_658_816_630_432, "version" => 0, "updated" => 1_658_816_630_433 }, "$loki" => 1407, "target" => { "resource_type" => "cloud_resource", "crn" => "crn:v1:staging:public:cloud-object-storage:global:a/4fb75f5f291f4266a40399c529aad632:e56cef34-7771-428f-b988-c86421e575ec::" }, "href" => "http://localhost:4000/rias-mock/us-east/v1/subnets/0965c6b5-6c08-4545-9b26-3e620fd78839/reserved_ips/0fdd77b5-64f3-4461-9ae6-994f7a099080", "resource_type" => "reserved_ip" }] }
    headers = {
      "Content-Type" => "application/json"
    }
    certificate_instance_identity_model = {
      'crn': "crn:v1:bluemix:public:secrets-manager:us-south:a/123456:36fa422d-080d-4d83-8d2d-86851b4001df:secret:2e786aab-42fa-63ed-14f8-d66d552f4dd5"
    }

    vpn_server_authentication_by_username_id_provider_model = {
      'provider_type': "iam"
    }

    vpn_server_authentication_prototype_model = {
      'method': "certificate",
      'identity_provider': vpn_server_authentication_by_username_id_provider_model
    }

    subnet_identity_model = {
      'id': "970e8b78-8f09-4acf-b37a-30458bdfec96"
    }
    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_vpn_server(
      certificate: certificate_instance_identity_model,
      client_authentication: [vpn_server_authentication_prototype_model],
      client_ip_pool: "172.16.0.0/16",
      subnets: [subnet_identity_model],
      name: "my-example-vpn-server"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_get_vpn_server
    message_response = { "id" => "970e8b78-8f09-4acf-b37a-30458bdfec95", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:64f39757-09c8-4360-a033-5182e5dd785a::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95", "created_at" => "2022-05-31T06:23:50.431Z", "clients" => [{ "id" => "c74f8cc2-a174-4522-b057-7433e5f48833", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:71a3aeca-61ad-458f-99be-57c59ca0e60b::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/c74f8cc2-a174-4522-b057-7433e5f48833", "resource_type" => "vpn_server_client" }, { "id" => "4750e2a7-a314-40f0-b659-ca69ad55dc57", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:b1213d1a-5f9d-437f-ab03-1f7a37654cb2::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/4750e2a7-a314-40f0-b659-ca69ad55dc57", "resource_type" => "vpn_server_client" }], "routes" => [{ "id" => "bc56343b-50ae-40cb-ba48-4eb9b00ff8c5", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:618a480a-31df-410e-b02f-535b2bce1b74::", "name" => "vpn-server-route-64183", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes/bc56343b-50ae-40cb-ba48-4eb9b00ff8c5", "resource_type" => "vpn_server_route" }, { "id" => "68e6a4b7-3e11-4864-8e68-a46ddf2b30bc", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:baacc0cc-5983-41c4-af2f-a16c14ea85cf::", "name" => "vpn-server-route-16232", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes/68e6a4b7-3e11-4864-8e68-a46ddf2b30bc", "resource_type" => "vpn_server_route" }], "certificate" => { "crn" => "crn:v1:bluemix:public:secrets-manager:us-south:a/123456:36fa422d-080d-4d83-8d2d-86851b4001df:secret:2e786aab-42fa-63ed-14f8-d66d552f4dd5" }, "client_authentication" => [{ "method" => "certificate", "identity_provider" => { "provider_type" => "iam" } }], "client_auto_delete" => true, "client_auto_delete_timeout" => 12, "client_dns_server_ips" => [{ "address" => "170.132.69.168" }, { "address" => "170.139.137.219" }], "client_idle_timeout" => 10_716, "client_ip_pool" => "172.16.0.0/16", "enable_split_tunneling" => true, "health_state" => "degraded", "hostname" => "my-vpn-server-33134.client-vpn.cloud.ibm.com", "lifecycle_state" => "deleted", "name" => "my-example-vpn-server", "port" => 1194, "protocol" => "udp", "resource_group" => { "id" => "5018a8564e8120570150b0764d39ebcc", "name" => "Default", "crn" => "crn:v1:staging:public:resource-controller::a/249d926cb9bb46119e3bda8ed7f7f618::resource-group:5018a8564e8120570150b0764d39ebcc" }, "resource_type" => "vpn_server", "security_groups" => [{ "id" => "0ded0ce9-af4e-4d55-9433-6251a9f00ea2", "name" => "sg-sed-9833-jp-tok", "href" => "http://localhost:4000/rias-mock/us-east/v1/security_groups/0ded0ce9-af4e-4d55-9433-6251a9f00ea2" }], "subnets" => [{ "id" => "0965c6b5-6c08-4545-9b26-3e620fd78839", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:51920ad2-b8c2-44da-a4eb-e455fa220d83::", "name" => "my-subnet-vpn-server", "href" => "http://localhost:4000/rias-mock/us-east/v1/subnets/0965c6b5-6c08-4545-9b26-3e620fd78839" }], "zone" => { "name" => "us-east-1", "region_name" => "us-east" }, "private_ips" => [{ "id" => "0fdd77b5-64f3-4461-9ae6-994f7a099080", "subnetId" => "0965c6b5-6c08-4545-9b26-3e620fd78839", "name" => "reservedIp-aut-5916-us-east", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:f964a2c5-e8d1-4a1a-b8ff-ae6abdcd7921::", "created_at" => "2022-04-30T06:23:50.432Z", "address" => "162.241.143.4", "status" => "available", "zone" => { "name" => "us-east-1", "region_name" => "us-east" }, "auto_delete" => true, "owner" => "user", "meta" => { "revision" => 2, "created" => 1_658_816_630_432, "version" => 0, "updated" => 1_658_816_630_433 }, "$loki" => 1407, "target" => { "resource_type" => "cloud_resource", "crn" => "crn:v1:staging:public:cloud-object-storage:global:a/4fb75f5f291f4266a40399c529aad632:e56cef34-7771-428f-b988-c86421e575ec::" }, "href" => "http://localhost:4000/rias-mock/us-east/v1/subnets/0965c6b5-6c08-4545-9b26-3e620fd78839/reserved_ips/0fdd77b5-64f3-4461-9ae6-994f7a099080", "resource_type" => "reserved_ip" }] }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpn_server(
      id: "970e8b78-8f09-4acf-b37a-30458bdfec95"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_update_vpn_server
    message_response = { "id" => "970e8b78-8f09-4acf-b37a-30458bdfec95", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:64f39757-09c8-4360-a033-5182e5dd785a::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95", "created_at" => "2022-05-31T06:23:50.431Z", "clients" => [{ "id" => "c74f8cc2-a174-4522-b057-7433e5f48833", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:71a3aeca-61ad-458f-99be-57c59ca0e60b::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/c74f8cc2-a174-4522-b057-7433e5f48833", "resource_type" => "vpn_server_client" }, { "id" => "4750e2a7-a314-40f0-b659-ca69ad55dc57", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:b1213d1a-5f9d-437f-ab03-1f7a37654cb2::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/4750e2a7-a314-40f0-b659-ca69ad55dc57", "resource_type" => "vpn_server_client" }], "routes" => [{ "id" => "bc56343b-50ae-40cb-ba48-4eb9b00ff8c5", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:618a480a-31df-410e-b02f-535b2bce1b74::", "name" => "vpn-server-route-64183", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes/bc56343b-50ae-40cb-ba48-4eb9b00ff8c5", "resource_type" => "vpn_server_route" }, { "id" => "68e6a4b7-3e11-4864-8e68-a46ddf2b30bc", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:baacc0cc-5983-41c4-af2f-a16c14ea85cf::", "name" => "vpn-server-route-16232", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes/68e6a4b7-3e11-4864-8e68-a46ddf2b30bc", "resource_type" => "vpn_server_route" }], "certificate" => { "crn" => "crn:v1:bluemix:public:secrets-manager:us-south:a/123456:36fa422d-080d-4d83-8d2d-86851b4001df:secret:2e786aab-42fa-63ed-14f8-d66d552f4dd5" }, "client_authentication" => [{ "method" => "certificate", "identity_provider" => { "provider_type" => "iam" } }], "client_auto_delete" => true, "client_auto_delete_timeout" => 12, "client_dns_server_ips" => [{ "address" => "170.132.69.168" }, { "address" => "170.139.137.219" }], "client_idle_timeout" => 10_716, "client_ip_pool" => "172.16.0.0/16", "enable_split_tunneling" => true, "health_state" => "degraded", "hostname" => "my-vpn-server-33134.client-vpn.cloud.ibm.com", "lifecycle_state" => "deleted", "name" => "my-example-vpn-server", "port" => 1194, "protocol" => "udp", "resource_group" => { "id" => "5018a8564e8120570150b0764d39ebcc", "name" => "Default", "crn" => "crn:v1:staging:public:resource-controller::a/249d926cb9bb46119e3bda8ed7f7f618::resource-group:5018a8564e8120570150b0764d39ebcc" }, "resource_type" => "vpn_server", "security_groups" => [{ "id" => "0ded0ce9-af4e-4d55-9433-6251a9f00ea2", "name" => "sg-sed-9833-jp-tok", "href" => "http://localhost:4000/rias-mock/us-east/v1/security_groups/0ded0ce9-af4e-4d55-9433-6251a9f00ea2" }], "subnets" => [{ "id" => "0965c6b5-6c08-4545-9b26-3e620fd78839", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:51920ad2-b8c2-44da-a4eb-e455fa220d83::", "name" => "my-subnet-vpn-server", "href" => "http://localhost:4000/rias-mock/us-east/v1/subnets/0965c6b5-6c08-4545-9b26-3e620fd78839" }], "zone" => { "name" => "us-east-1", "region_name" => "us-east" }, "private_ips" => [{ "id" => "0fdd77b5-64f3-4461-9ae6-994f7a099080", "subnetId" => "0965c6b5-6c08-4545-9b26-3e620fd78839", "name" => "reservedIp-aut-5916-us-east", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:f964a2c5-e8d1-4a1a-b8ff-ae6abdcd7921::", "created_at" => "2022-04-30T06:23:50.432Z", "address" => "162.241.143.4", "status" => "available", "zone" => { "name" => "us-east-1", "region_name" => "us-east" }, "auto_delete" => true, "owner" => "user", "meta" => { "revision" => 2, "created" => 1_658_816_630_432, "version" => 0, "updated" => 1_658_816_630_433 }, "$loki" => 1407, "target" => { "resource_type" => "cloud_resource", "crn" => "crn:v1:staging:public:cloud-object-storage:global:a/4fb75f5f291f4266a40399c529aad632:e56cef34-7771-428f-b988-c86421e575ec::" }, "href" => "http://localhost:4000/rias-mock/us-east/v1/subnets/0965c6b5-6c08-4545-9b26-3e620fd78839/reserved_ips/0fdd77b5-64f3-4461-9ae6-994f7a099080", "resource_type" => "reserved_ip" }] }
    headers = {
      "Content-Type" => "application/json"
    }
    vpn_server_patch_model = {}
    vpn_server_patch_model["name"] = "my-vpn-server-updated"
    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_vpn_server(
      id: "970e8b78-8f09-4acf-b37a-30458bdfec95",
      vpn_server_patch: vpn_server_patch_model
    )
    assert_equal(message_response, service_response.result)
  end

  def test_delete_vpn_server
    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95?generation=2&version=2022-03-29")
      .with(
        headers: {
          "Connection" => "close",
          "Host" => "us-south.iaas.cloud.ibm.com",
          "X-Ibmcloud-Sdk-Analytics" => "service_name=vpc;service_version=V1;operation_id=delete_vpn_server"
        }
      )
      .to_return(status: 202, body: "", headers: {})
    service.delete_vpn_server(
      id: "970e8b78-8f09-4acf-b37a-30458bdfec95"
    )
  end

  def test_get_vpn_server_client_configuration
    # message_response = { "clients" => [{ "id" => "c74f8cc2-a174-4522-b057-7433e5f48833", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:71a3aeca-61ad-458f-99be-57c59ca0e60b::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/c74f8cc2-a174-4522-b057-7433e5f48833", "common_name" => "www.mock-certificate51610.com", "client_ip" => { "address" => "192.103.208.190" }, "data_received" => 41_053, "data_sent" => 28_914, "disconnected_at" => "", "created_at" => "2022-07-26T06:23:50.434Z", "remote_ip" => { "address" => "9.111.1.1" }, "remote_port" => 27_872, "resource_type" => "vpn_server_client", "status" => "connected" }, { "id" => "4750e2a7-a314-40f0-b659-ca69ad55dc57", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:b1213d1a-5f9d-437f-ab03-1f7a37654cb2::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/4750e2a7-a314-40f0-b659-ca69ad55dc57", "common_name" => "www.mock-certificate56773.com", "client_ip" => { "address" => "192.200.244.138" }, "data_received" => 26_558, "data_sent" => 53_975, "disconnected_at" => "2022-07-26T06:23:50.434Z", "created_at" => "2022-07-26T06:23:50.434Z", "remote_ip" => { "address" => "9.111.1.1" }, "remote_port" => 13_623, "resource_type" => "vpn_server_client", "status" => "disconnected" }], "limit" => 10, "first" => { "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients?limit=10" } }
    message_response = "Mock data of vpn server client configuration..."

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/client_configuration?generation=2&version=2022-03-29")
      .with(
        headers: {
          "Connection" => "close",
          "Host" => "us-south.iaas.cloud.ibm.com",
          "X-Ibmcloud-Sdk-Analytics" => "service_name=vpc;service_version=V1;operation_id=get_vpn_server_client_configuration"
        }
      )
      .to_return(status: 200, body: message_response, headers: {})
    service_response = service.get_vpn_server_client_configuration(
      id: "970e8b78-8f09-4acf-b37a-30458bdfec95"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_list_vpn_server_clients
    message_response = { "clients" => [{ "id" => "c74f8cc2-a174-4522-b057-7433e5f48833", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:71a3aeca-61ad-458f-99be-57c59ca0e60b::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/c74f8cc2-a174-4522-b057-7433e5f48833", "common_name" => "www.mock-certificate51610.com", "client_ip" => { "address" => "192.103.208.190" }, "data_received" => 41_053, "data_sent" => 28_914, "disconnected_at" => "", "created_at" => "2022-07-26T06:23:50.434Z", "remote_ip" => { "address" => "9.111.1.1" }, "remote_port" => 27_872, "resource_type" => "vpn_server_client", "status" => "connected" }, { "id" => "4750e2a7-a314-40f0-b659-ca69ad55dc57", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:b1213d1a-5f9d-437f-ab03-1f7a37654cb2::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/4750e2a7-a314-40f0-b659-ca69ad55dc57", "common_name" => "www.mock-certificate56773.com", "client_ip" => { "address" => "192.200.244.138" }, "data_received" => 26_558, "data_sent" => 53_975, "disconnected_at" => "2022-07-26T06:23:50.434Z", "created_at" => "2022-07-26T06:23:50.434Z", "remote_ip" => { "address" => "9.111.1.1" }, "remote_port" => 13_623, "resource_type" => "vpn_server_client", "status" => "disconnected" }], "limit" => 10, "first" => { "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients?limit=10" } }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients?sort=created_at&generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpn_server_clients(
      vpn_server_id: "970e8b78-8f09-4acf-b37a-30458bdfec95",
      sort: "created_at"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_get_vpn_server_client
    message_response = { "id" => "c50e2258-c3fd-4151-b422-40a2db4d752c", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:fa53fbaf-94fd-44ea-821b-6326636671ae::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/4430a134-7f73-4eb9-8f05-6c4414209459/clients/c50e2258-c3fd-4151-b422-40a2db4d752c", "common_name" => "www.mock-certificate35951.com", "client_ip" => { "address" => "192.5.149.16" }, "data_received" => 47_394, "data_sent" => 65_117, "disconnected_at" => "2022-07-26T11:16:19.251Z", "created_at" => "2022-07-26T11:16:19.251Z", "remote_ip" => { "address" => "9.111.1.1" }, "remote_port" => 15_559, "resource_type" => "vpn_server_client", "status" => "disconnected" }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/c50e2258-c3fd-4151-b422-40a2db4d752c?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_vpn_server_client(
      vpn_server_id: "970e8b78-8f09-4acf-b37a-30458bdfec95",
      id: "c50e2258-c3fd-4151-b422-40a2db4d752c"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_disconnect_vpn_client
    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/clients/c50e2258-c3fd-4151-b422-40a2db4d752c/disconnect?generation=2&version=2022-03-29")
      .with(
        headers: {
          "Connection" => "close",
          "Host" => "us-south.iaas.cloud.ibm.com",
          "X-Ibmcloud-Sdk-Analytics" => "service_name=vpc;service_version=V1;operation_id=disconnect_vpn_client"
        }
      )
      .to_return(status: 202, body: "", headers: {})
    service.disconnect_vpn_client(
      vpn_server_id: "970e8b78-8f09-4acf-b37a-30458bdfec95",
      id: "c50e2258-c3fd-4151-b422-40a2db4d752c"
    )
  end

  def test_list_vpn_server_routes
    message_response = { "routes" => [{ "id" => "6a4053e7-c4f8-43ce-b8a2-799cf6a54cca", "name" => "vpn-server-route-10914", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:1feffe29-bca1-438d-a000-f2fb7f43ff34::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/4430a134-7f73-4eb9-8f05-6c4414209459/routes/6a4053e7-c4f8-43ce-b8a2-799cf6a54cca", "action" => "translate", "create_at" => "2022-05-10T11:16:19.252Z", "destination" => "192.99.198.0/24", "lifecycle_state" => "pending", "resource_type" => "vpn_server_route" }, { "id" => "64ed7781-c7c8-4b3b-92e6-65d7067d9949", "name" => "vpn-server-route-25134", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:97afa026-deff-4f55-bd65-e6719ed70259::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/4430a134-7f73-4eb9-8f05-6c4414209459/routes/64ed7781-c7c8-4b3b-92e6-65d7067d9949", "action" => "translate", "create_at" => "2022-05-06T11:16:19.252Z", "destination" => "192.221.154.0/24", "lifecycle_state" => "stable", "resource_type" => "vpn_server_route" }, { "id" => "bd9b698a-ce82-4a5a-b34d-d72d89b5f57e", "name" => "vpn-server-route-53876", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:13985a13-ea30-41a5-9b0e-598f9746bbc1::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/4430a134-7f73-4eb9-8f05-6c4414209459/routes/bd9b698a-ce82-4a5a-b34d-d72d89b5f57e", "action" => "drop", "create_at" => "2022-07-07T11:16:19.252Z", "destination" => "192.76.206.0/24", "lifecycle_state" => "updating", "resource_type" => "vpn_server_route" }] }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 202, body: message_response.to_json, headers: headers)
    service_response = service.list_vpn_server_routes(
      vpn_server_id: "970e8b78-8f09-4acf-b37a-30458bdfec95"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_create_vpn_server_route
    message_response = { "id" => "5e57b6f6-3a07-4417-a3bb-fed686a0bd0b", "name" => "my-vpn-server-route", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:e0a80347-d63b-48fb-b004-9a36eed2d55c::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/4430a134-7f73-4eb9-8f05-6c4414209459/routes/5e57b6f6-3a07-4417-a3bb-fed686a0bd0b", "action" => "drop", "create_at" => "2022-07-07T11:16:19.334Z", "destination" => "172.16.0.0/16", "lifecycle_state" => "stable", "resource_type" => "vpn_server_route" }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 202, body: message_response.to_json, headers: headers)
    service_response = service.create_vpn_server_route(
      vpn_server_id: "970e8b78-8f09-4acf-b37a-30458bdfec95",
      destination: "172.16.0.0/16",
      name: "my-vpn-server-route"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_get_vpn_server_route
    message_response = { "id" => "5e57b6f6-3a07-4417-a3bb-fed686a0bd0b", "name" => "my-vpn-server-route", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:e0a80347-d63b-48fb-b004-9a36eed2d55c::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/4430a134-7f73-4eb9-8f05-6c4414209459/routes/5e57b6f6-3a07-4417-a3bb-fed686a0bd0b", "action" => "drop", "create_at" => "2022-07-07T11:16:19.334Z", "destination" => "172.16.0.0/16", "lifecycle_state" => "stable", "resource_type" => "vpn_server_route" }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes/5e57b6f6-3a07-4417-a3bb-fed686a0bd0b?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 202, body: message_response.to_json, headers: headers)
    service_response = service.get_vpn_server_route(
      vpn_server_id: "970e8b78-8f09-4acf-b37a-30458bdfec95",
      id: "5e57b6f6-3a07-4417-a3bb-fed686a0bd0b"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_update_vpn_server_route
    message_response = { "id" => "5e57b6f6-3a07-4417-a3bb-fed686a0bd0b", "name" => "my-vpn-server-route", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:e0a80347-d63b-48fb-b004-9a36eed2d55c::", "href" => "http://localhost:4000/rias-mock/us-east/v1/vpn_servers/4430a134-7f73-4eb9-8f05-6c4414209459/routes/5e57b6f6-3a07-4417-a3bb-fed686a0bd0b", "action" => "drop", "create_at" => "2022-07-07T11:16:19.334Z", "destination" => "172.16.0.0/16", "lifecycle_state" => "stable", "resource_type" => "vpn_server_route" }
    headers = {
      "Content-Type" => "application/json"
    }
    vpn_server_route_patch_model = {}
    vpn_server_route_patch_model["name"] = "my-vpnserver-route-updated"
    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes/5e57b6f6-3a07-4417-a3bb-fed686a0bd0b?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 202, body: message_response.to_json, headers: headers)
    service_response = service.update_vpn_server_route(
      vpn_server_id: "970e8b78-8f09-4acf-b37a-30458bdfec95",
      id: "5e57b6f6-3a07-4417-a3bb-fed686a0bd0b",
      vpn_server_route_patch: vpn_server_route_patch_model
    )
    assert_equal(message_response, service_response.result)
  end

  def test_delete_vpn_server_route
    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes/5e57b6f6-3a07-4417-a3bb-fed686a0bd0b?generation=2&version=2022-03-29")
      .with(
        headers: {
          "Connection" => "close",
          "Host" => "us-south.iaas.cloud.ibm.com",
          "X-Ibmcloud-Sdk-Analytics" => "service_name=vpc;service_version=V1;operation_id=delete_vpn_server_route"
        }
      )
      .to_return(status: 200, body: "", headers: {})
    service.delete_vpn_server_route(
      vpn_server_id: "970e8b78-8f09-4acf-b37a-30458bdfec95",
      id: "5e57b6f6-3a07-4417-a3bb-fed686a0bd0b"
    )
  end

  def test_delete_vpn_server_client
    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpn_servers/970e8b78-8f09-4acf-b37a-30458bdfec95/routes/c50e2258-c3fd-4151-b422-40a2db4d752c?generation=2&version=2022-03-29")
      .with(
        headers: {
          "Connection" => "close",
          "Host" => "us-south.iaas.cloud.ibm.com",
          "X-Ibmcloud-Sdk-Analytics" => "service_name=vpc;service_version=V1;operation_id=delete_vpn_server_route"
        }
      )
      .to_return(status: 200, body: "", headers: {})
    service.delete_vpn_server_route(
      vpn_server_id: "970e8b78-8f09-4acf-b37a-30458bdfec95",
      id: "c50e2258-c3fd-4151-b422-40a2db4d752c"
    )
  end

  def test_list_backup_policies
    message_response = { "limit" => 10, "first" => { "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies?limit=10" }, "backup_policies" => [{ "created_at" => "2022-07-08T11:46:39.284Z", "last_job_completed_at" => "2022-04-29T11:46:39.284Z", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:60e1010f-dbbf-48d0-ad78-a3e47686b414::", "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/backup-policy-1002", "id" => "backup-policy-1002", "lifecycle_state" => "stable", "match_resource_types" => ["volume"], "match_user_tags" => ["defaultPlan2:defaultPolicy1", "defaultPlan2:defaultPolicy2", "defaultPlan2:defaultPolicy3", "defaultPlan2:defaultPolicy4", "defaultPlan2:defaultPolicy5", "defaultPlan2:defaultPolicy6", "defaultPlan2:defaultPolicy7"], "name" => "aaa-default-backup-policy-2", "plans" => [{ "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/backup-policy-1002/plans/1de7bb8b-6e26-4d51-856e-8a381edbaf99", "id" => "1de7bb8b-6e26-4d51-856e-8a381edbaf99", "name" => "default-backup-policy-2-default-plan", "resource_type" => "backup_policy_plan" }], "resource_group" => { "name" => "SmokeTest", "id" => "720a9c5878c7403ba80573f717ecf9b0" }, "resource_type" => "backup_policy" }, { "created_at" => "2022-07-05T11:46:39.284Z", "last_job_completed_at" => "2022-07-08T11:46:39.284Z", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:ebac104f-077a-44a0-bc04-f9489fca5e27::", "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/backup-policy-1003", "id" => "backup-policy-1003", "lifecycle_state" => "stable", "match_resource_types" => ["volume"], "match_user_tags" => [], "name" => "aaa-default-backup-policy-3", "plans" => [{ "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/backup-policy-1003/plans/2c060bf4-0c9b-4cde-9a3d-30beb6f7111b", "id" => "2c060bf4-0c9b-4cde-9a3d-30beb6f7111b", "name" => "default-backup-policy-3-default-plan", "resource_type" => "backup_policy_plan" }], "resource_group" => { "name" => "Default", "id" => "5018a8564e8120570150b0764d39ebcc" }, "resource_type" => "backup_policy" }, { "created_at" => "2022-07-03T11:46:39.284Z", "last_job_completed_at" => "2022-07-01T11:46:39.284Z", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:cd4662bb-62a0-442b-bef3-782a58db48e0::", "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/backup-policy-1001", "id" => "backup-policy-1001", "lifecycle_state" => "stable", "match_resource_types" => ["volume"], "match_user_tags" => ["defaultBackupTag:defaultBackupTagValue"], "name" => "aaa-default-backup-policy-1", "plans" => [{ "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/backup-policy-1001/plans/3cfa3590-5481-47b0-b8b9-4f570f0afa12", "id" => "3cfa3590-5481-47b0-b8b9-4f570f0afa12", "name" => "default-backup-policy-1-default-plan", "resource_type" => "backup_policy_plan" }], "resource_group" => { "name" => "Default", "id" => "5018a8564e8120570150b0764d39ebcc" }, "resource_type" => "backup_policy" }], "total_count" => 3 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/backup_policies?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_backup_policies
    assert_equal(message_response, service_response.result)
  end

  def test_create_backup_policy
    message_response = { "created_at" => "2022-07-26T11:48:01.147Z", "last_job_completed_at" => "2022-07-19T11:48:01.147Z", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:349162a6-0c56-4dc6-97d2-0f54611fe415::", "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1", "id" => "d5b7008f-b3da-46d4-a499-d3c8368f0ce1", "lifecycle_state" => "pending", "match_resource_types" => ["volume"], "match_user_tags" => ["my-daily-backup-policy"], "name" => "my-backup-policy", "plans" => [{ "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06", "id" => "9eab386c-1d86-47fb-8d86-e0732ebcce06", "name" => "my-backup-policy-plan", "resource_type" => "backup_policy_plan" }], "resource_group" => { "name" => "SmokeTest", "id" => "720a9c5878c7403ba80573f717ecf9b0" }, "resource_type" => "backup_policy", "status" => "stable" }
    headers = {
      "Content-Type" => "application/json"
    }
    backup_policy_plan_deletion_trigger_prototype_model = {
      'delete_after': 20,
      'delete_over_count': 20
    }

    backup_policy_plan_prototype_model = {
      'active': true,
      'attach_user_tags': ["my-daily-backup-plan"],
      'copy_user_tags': true,
      'cron_spec': "*/5 1,2,3 * * *",
      'deletion_trigger': backup_policy_plan_deletion_trigger_prototype_model,
      'name': "my-backup-policy-plan"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/backup_policies?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_backup_policy(
      match_user_tags: ["my-daily-backup-policy"],
      match_resource_types: ["volume"],
      name: "my-backup-policy",
      plans: [backup_policy_plan_prototype_model]
    )
    assert_equal(message_response, service_response.result)
  end

  def test_list_backup_policy_plans
    message_response = { "plans" => [{ "active" => true, "attach_user_tags" => ["my-daily-backup-plan"], "copy_user_tags" => true, "created_at" => "2022-06-15T11:48:01.147Z", "cron_spec" => "*/5 1,2,3 * * *", "deletion_trigger" => { "delete_after" => 20 }, "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06", "id" => "9eab386c-1d86-47fb-8d86-e0732ebcce06", "lifecycle_state" => "pending", "name" => "my-backup-policy-plan", "resource_type" => "backup_policy_plan" }] }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_backup_policy_plans(
      backup_policy_id: "d5b7008f-b3da-46d4-a499-d3c8368f0ce1"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_create_backup_policy_plan
    message_response = { "active" => true, "attach_user_tags" => ["my-daily-backup-plan"], "copy_user_tags" => true, "created_at" => "2022-06-15T11:48:01.147Z", "cron_spec" => "*/5 1,2,3 * * *", "deletion_trigger" => { "delete_after" => 20 }, "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06", "id" => "9eab386c-1d86-47fb-8d86-e0732ebcce06", "lifecycle_state" => "pending", "name" => "my-backup-policy-plan", "resource_type" => "backup_policy_plan" }
    headers = {
      "Content-Type" => "application/json"
    }
    backup_policy_plan_deletion_trigger_prototype_model = {
      'delete_after': 20,
      'delete_over_count': 20
    }
    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_backup_policy_plan(
      backup_policy_id: "d5b7008f-b3da-46d4-a499-d3c8368f0ce1",
      cron_spec: "*/5 1,2,3 * * *",
      active: true,
      attach_user_tags: ["my-daily-backup-plan"],
      copy_user_tags: true,
      deletion_trigger: backup_policy_plan_deletion_trigger_prototype_model,
      name: "my-backup-policy-plan"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_get_backup_policy_plan
    message_response = { "active" => true, "attach_user_tags" => ["my-daily-backup-plan"], "copy_user_tags" => true, "created_at" => "2022-06-15T11:48:01.147Z", "cron_spec" => "*/5 1,2,3 * * *", "deletion_trigger" => { "delete_after" => 20 }, "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06", "id" => "9eab386c-1d86-47fb-8d86-e0732ebcce06", "lifecycle_state" => "pending", "name" => "my-backup-policy-plan", "resource_type" => "backup_policy_plan" }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_backup_policy_plan(
      backup_policy_id: "d5b7008f-b3da-46d4-a499-d3c8368f0ce1",
      id: "9eab386c-1d86-47fb-8d86-e0732ebcce06"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_update_backup_policy_plan
    message_response = { "active" => true, "attach_user_tags" => ["my-daily-backup-plan"], "copy_user_tags" => true, "created_at" => "2022-06-15T11:48:01.147Z", "cron_spec" => "*/5 1,2,3 * * *", "deletion_trigger" => { "delete_after" => 20 }, "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06", "id" => "9eab386c-1d86-47fb-8d86-e0732ebcce06", "lifecycle_state" => "pending", "name" => "my-backup-policy-plan", "resource_type" => "backup_policy_plan" }
    headers = {
      "Content-Type" => "application/json"
    }
    backup_policy_plan_patch_model = {}
    backup_policy_plan_patch_model["name"] = "my-backup-policy-plan-updated"
    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_backup_policy_plan(
      backup_policy_id: "d5b7008f-b3da-46d4-a499-d3c8368f0ce1",
      id: "9eab386c-1d86-47fb-8d86-e0732ebcce06",
      backup_policy_plan_patch: backup_policy_plan_patch_model
    )
    assert_equal(message_response, service_response.result)
  end

  def test_get_backup_policy
    message_response = { "created_at" => "2022-07-26T11:48:01.147Z", "last_job_completed_at" => "2022-07-19T11:48:01.147Z", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:349162a6-0c56-4dc6-97d2-0f54611fe415::", "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1", "id" => "d5b7008f-b3da-46d4-a499-d3c8368f0ce1", "lifecycle_state" => "pending", "match_resource_types" => ["volume"], "match_user_tags" => ["my-daily-backup-policy"], "name" => "my-backup-policy", "plans" => [{ "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06", "id" => "9eab386c-1d86-47fb-8d86-e0732ebcce06", "name" => "my-backup-policy-plan-updated", "resource_type" => "backup_policy_plan" }, { "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/8d0c8d7f-7b61-441d-9cd7-21acef0566bf", "id" => "8d0c8d7f-7b61-441d-9cd7-21acef0566bf", "name" => "my-backup-policy-plan", "resource_type" => "backup_policy" }], "resource_group" => { "name" => "SmokeTest", "id" => "720a9c5878c7403ba80573f717ecf9b0" }, "resource_type" => "backup_policy", "status" => "stable" }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_backup_policy(
      id: "d5b7008f-b3da-46d4-a499-d3c8368f0ce1"
    )
    assert_equal(message_response, service_response.result)
  end

  def test_update_backup_policy
    message_response = { "created_at" => "2022-07-26T11:48:01.147Z", "last_job_completed_at" => "2022-07-19T11:48:01.147Z", "crn" => "crn:v1:staging:public:is:us-east:a/823bd195e9fd4f0db40ac2e1bffef3e0:349162a6-0c56-4dc6-97d2-0f54611fe415::", "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1", "id" => "d5b7008f-b3da-46d4-a499-d3c8368f0ce1", "lifecycle_state" => "pending", "match_resource_types" => ["volume"], "match_user_tags" => ["my-daily-backup-policy"], "name" => "my-backup-policy-updated", "plans" => [{ "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06", "id" => "9eab386c-1d86-47fb-8d86-e0732ebcce06", "name" => "my-backup-policy-plan-updated", "resource_type" => "backup_policy_plan" }, { "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/8d0c8d7f-7b61-441d-9cd7-21acef0566bf", "id" => "8d0c8d7f-7b61-441d-9cd7-21acef0566bf", "name" => "my-backup-policy-plan", "resource_type" => "backup_policy" }], "resource_group" => { "name" => "SmokeTest", "id" => "720a9c5878c7403ba80573f717ecf9b0" }, "resource_type" => "backup_policy", "status" => "stable" }
    headers = {
      "Content-Type" => "application/json"
    }
    backup_policy_patch_model = {}
    backup_policy_patch_model["name"] = "my-backup-policy-updated"
    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_backup_policy(
      id: "d5b7008f-b3da-46d4-a499-d3c8368f0ce1",
      backup_policy_patch: backup_policy_patch_model
    )
    assert_equal(message_response, service_response.result)
  end

  def test_delete_backup_policy_plan
    message_response = { "active" => true, "attach_user_tags" => ["my-daily-backup-plan"], "copy_user_tags" => true, "created_at" => "2022-06-15T11:48:01.147Z", "cron_spec" => "*/5 1,2,3 * * *", "deletion_trigger" => { "delete_after" => 20 }, "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06", "id" => "9eab386c-1d86-47fb-8d86-e0732ebcce06", "lifecycle_state" => "pending", "name" => "my-backup-policy-plan-updated", "resource_type" => "backup_policy_plan" }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/9eab386c-1d86-47fb-8d86-e0732ebcce06?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 202, body: message_response.to_json, headers: headers)
    service_response = service.delete_backup_policy_plan(
      backup_policy_id: "d5b7008f-b3da-46d4-a499-d3c8368f0ce1",
      id: "9eab386c-1d86-47fb-8d86-e0732ebcce06"
    )
    assert_equal(202, service_response.status)
    assert_equal(message_response, service_response.result)
  end

  def test_delete_backup_policy
    message_response = { "created_at" => "2022-07-26T11:48:01.147Z", "last_job_completed_at" => "2022-07-19T11:48:01.147Z", "crn" => "crn:v1:staging:public:is:eu-gb:a/823bd195e9fd4f0db40ac2e1bffef3e0:349162a6-0c56-4dc6-97d2-0f54611fe415::", "href" => "", "id" => "d5b7008f-b3da-46d4-a499-d3c8368f0ce1", "lifecycle_state" => "pending", "match_resource_types" => ["volume"], "match_user_tags" => ["my-daily-backup-policy"], "name" => "my-backup-policy-updated", "plans" => [{ "active" => true, "created_at" => "2022-04-22T11:48:01.161Z", "last_job_completed_at" => "2022-05-10T11:48:01.161Z", "href" => "http://localhost:4000/rias-mock/us-east/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1/plans/8d0c8d7f-7b61-441d-9cd7-21acef0566bf", "id" => "8d0c8d7f-7b61-441d-9cd7-21acef0566bf", "lifecycle_state" => "pending", "name" => "my-backup-policy-plan", "copy_user_tags" => true, "resource_type" => "backup_policy", "deletion_trigger" => { "delete_after" => 20 }, "cron_spec" => "*/5 1,2,3 * * *", "attach_user_tags" => ["my-daily-backup-plan"], "deletionTrigger" => { "delete_after" => 20 } }], "resource_group" => { "id" => "720a9c5878c7403ba80573f717ecf9b0" }, "resource_type" => "backup_policy", "region" => "us-east", "status" => "stable" }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/backup_policies/d5b7008f-b3da-46d4-a499-d3c8368f0ce1?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 202, body: message_response.to_json, headers: headers)
    service_response = service.delete_backup_policy(
      id: "d5b7008f-b3da-46d4-a499-d3c8368f0ce1"
    )
    assert_equal(202, service_response.status)
    assert_equal(message_response, service_response.result)
  end

  def test_list_vpn_gateway_connection_local_cidrs
    message_response = {
      "local_cidrs" => [
        "0.0.19.0/24"
      ]
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc/local_cidrs?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpn_gateway_connection_local_cidrs(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_remove_vpn_gateway_connection_local_cidr
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc/local_cidrs/0.0.19.0/24?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.remove_vpn_gateway_connection_local_cidr(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc",
      cidr_prefix: "0.0.19.0",
      prefix_length: "24"
    )
  end

  def test_check_vpn_gateway_connection_local_cidr
    message_response = {
      "local_cidrs" => [
        "0.0.19.0/24"
      ]
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc/local_cidrs/0.0.19.0/24?generation=2&version=2022-03-29")
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service.check_vpn_gateway_connection_local_cidr(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc",
      cidr_prefix: "0.0.19.0",
      prefix_length: "24"
    )
  end

  def test_add_vpn_gateway_connection_local_cidr
    message_response = {
      "local_cidrs" => [
        "0.0.19.0/24"
      ]
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:put, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc/local_cidrs/0.0.19.0/24?generation=2&version=2022-03-29")
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service.add_vpn_gateway_connection_local_cidr(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc",
      cidr_prefix: "0.0.19.0",
      prefix_length: "24"
    )
  end

  def test_list_vpn_gateway_connection_peer_cidrs
    message_response = {
      "peer_cidrs" => [
        "0.0.150.0/24"
      ]
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc/peer_cidrs?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_vpn_gateway_connection_peer_cidrs(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_remove_vpn_gateway_connection_peer_cidr
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc/peer_cidrs/0.0.150.0/24?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.remove_vpn_gateway_connection_peer_cidr(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc",
      cidr_prefix: "0.0.150.0",
      prefix_length: "24"
    )
  end

  def test_check_vpn_gateway_connection_peer_cidr
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc/peer_cidrs/0.0.150.0/24?generation=2&version=2022-03-29")
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service.check_vpn_gateway_connection_peer_cidr(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc",
      cidr_prefix: "0.0.150.0",
      prefix_length: "24"
    )
  end

  def test_add_vpn_gateway_connection_peer_cidr
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:put, "https://us-south.iaas.cloud.ibm.com/v1/vpn_gateways/a7d258d5-be1e-491d-83db-526d8d9a2ce9/connections/b67efb2c-bd17-457d-be8e-7b46404062dc/peer_cidrs/0.0.150.0/24?generation=2&version=2022-03-29")
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service.add_vpn_gateway_connection_peer_cidr(
      vpn_gateway_id: "a7d258d5-be1e-491d-83db-526d8d9a2ce9",
      id: "b67efb2c-bd17-457d-be8e-7b46404062dc",
      cidr_prefix: "0.0.150.0",
      prefix_length: "24"
    )
  end

  def test_list_load_balancer_profiles
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancer/profiles?limit=50" },
                         "limit" => 50, "profiles" => [{ "family" => "network", "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancer/profiles/network-fixed", "logging_supported" => { "type" => "fixed", "value" => [] }, "name" => "network-fixed" }], "total_count" => 1 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancer/profiles?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_load_balancer_profiles

    assert_equal(message_response, service_response.result)
  end

  def test_get_load_balancer_profile
    message_response = { "family" => "network",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancer/profiles/network-fixed", "logging_supported" => { "type" => "fixed", "value" => [] }, "name" => "network-fixed" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancer/profiles/network-fixed?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_load_balancer_profile(
      name: "network-fixed"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_load_balancers
    message_response = { "load_balancers" => [
      { "created_at" => "2018-12-16T16:29:30.160929Z", "crn" => "crn:[...]", "hostname" => "7b6dc78d.lb.appdomain.cloud",
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca", "id" => "7b6dc78d-49f3-435f-b767-e05f9affd3ca", "is_public" => true, "listeners" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca/listeners/a8433879-cb79-4b62-af8f-7b3329eac465", "id" => "a8433879-cb79-4b62-af8f-7b3329eac465" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca/listeners/6a034f25-06b4-4cc3-8e3f-6a372616798b", "id" => "6a034f25-06b4-4cc3-8e3f-6a372616798b" }], "logging" => { "datapath" => { "active" => true } }, "name" => "my-load-balancer-1", "operating_status" => "online", "pools" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca/pools/2c431ab3-0151-11e9-a178-22dd3503b06c", "id" => "2c431ab3-0151-11e9-a178-22dd3503b06c", "name" => "add-prod-servers-http" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca/pools/c3629207-014f-11e9-a178-22dd3503b06c", "id" => "c3629207-014f-11e9-a178-22dd3503b06c", "name" => "my-prod-servers-tcp" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca/pools/c35ce451-014f-11e9-a178-22dd3503b06c", "id" => "c35ce451-014f-11e9-a178-22dd3503b06c", "name" => "update-prod-servers-http" }], "private_ips" => [{ "address" => "10.0.0.32" }, { "address" => "10.0.0.35" }], "profile" => { "family" => "application", "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancer/profiles/dynamic", "name" => "dynamic" }, "provisioning_status" => "active", "public_ips" => [{ "address" => "192.0.0.56" }, { "address" => "192.0.0.44" }], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/6eb23aa499254c66917dc265c374eca9", "id" => "6eb23aa499254c66917dc265c374eca9", "name" => "Default" }, "subnets" => [{ "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "id" => "3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "name" => "subnet-1" }] }, { "created_at" => "2018-12-13T18:00:11.896545Z", "crn" => "crn:[...]", "hostname" => "1bf28ca5.lb.appdomain.cloud", "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/1bf28ca5-3037-4b96-b4a0-f22e82eae3db", "id" => "1bf28ca5-3037-4b96-b4a0-f22e82eae3db", "is_public" => true, "listeners" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/1bf28ca5-3037-4b96-b4a0-f22e82eae3db/listeners/72cdbc3e-f8ac-4c74-8b91-75a4e6648242", "id" => "72cdbc3e-f8ac-4c74-8b91-75a4e6648242" }], "logging" => { "datapath" => { "active" => true } }, "name" => "my-load-balancer-2", "operating_status" => "online", "pools" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/1bf28ca5-3037-4b96-b4a0-f22e82eae3db/pools/efa7abe9-ff00-11e8-a9c9-5a9d1cc77531", "id" => "efa7abe9-ff00-11e8-a9c9-5a9d1cc77531", "name" => "pool-1" }], "private_ips" => [{ "address" => "10.0.0.21" }, { "address" => "10.0.0.41" }], "profile" => { "family" => "application", "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancer/profiles/dynamic", "name" => "dynamic" }, "provisioning_status" => "active", "public_ips" => [{ "address" => "192.0.0.51" }, { "address" => "192.0.0.55" }], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/6eb23aa499254c66917dc265c374eca9", "id" => "6eb23aa499254c66917dc265c374eca9", "name" => "Default" }, "subnets" => [{ "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "id" => "3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "name" => "subnet-1" }] }
    ] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_load_balancers

    assert_equal(message_response, service_response.result)
  end

  def test_create_load_balancer
    message_response = { "created_at" => "2018-12-16T16:29:30.160929Z", "crn" => "crn:[...]",
                         "hostname" => "7b6dc78d.lb.appdomain.cloud", "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca", "id" => "7b6dc78d-49f3-435f-b767-e05f9affd3ca", "is_public" => true, "listeners" => [], "logging" => { "datapath" => { "active" => false } }, "name" => "my-load-balancer", "operating_status" => "online", "pools" => [], "private_ips" => [{ "address" => "10.0.0.32" }, { "address" => "10.0.0.35" }], "profile" => { "family" => "application", "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancer/profiles/dynamic", "name" => "dynamic" }, "provisioning_status" => "active", "public_ips" => [{ "address" => "192.0.0.56" }, { "address" => "192.0.0.44" }], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/6eb23aa499254c66917dc265c374eca9", "id" => "6eb23aa499254c66917dc265c374eca9", "name" => "Default" }, "subnets" => [{ "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "id" => "3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "name" => "subnet-1" }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_load_balancer(
      is_public: true,
      subnets: [
        {
          "crn": "crn:[...]",
          "href": "https://us-south.iaas.cloud.ibm.com/v1/subnets/3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96",
          "id": "3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96",
          "name": "subnet-1"
        }
      ]
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_load_balancer
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_load_balancer(
      id: "7b6dc78d-49f3-435f-b767-e05f9affd3ca"
    )
  end

  def test_get_load_balancer
    message_response = { "created_at" => "2018-12-16T16:29:30.160929Z", "crn" => "crn:[...]",
                         "hostname" => "7b6dc78d.lb.appdomain.cloud", "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca", "id" => "7b6dc78d-49f3-435f-b767-e05f9affd3ca", "is_public" => true, "listeners" => [], "logging" => { "datapath" => { "active" => false } }, "name" => "my-load-balancer", "operating_status" => "online", "pools" => [], "private_ips" => [{ "address" => "10.0.0.32" }, { "address" => "10.0.0.35" }], "profile" => { "family" => "application", "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancer/profiles/dynamic", "name" => "dynamic" }, "provisioning_status" => "active", "public_ips" => [{ "address" => "192.0.0.56" }, { "address" => "192.0.0.44" }], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/6eb23aa499254c66917dc265c374eca9", "id" => "6eb23aa499254c66917dc265c374eca9", "name" => "Default" }, "subnets" => [{ "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "id" => "3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "name" => "subnet-1" }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_load_balancer(
      id: "7b6dc78d-49f3-435f-b767-e05f9affd3ca"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_load_balancer
    message_response = { "created_at" => "2018-12-16T16:29:30.160929Z", "crn" => "crn:[...]",
                         "hostname" => "7b6dc78d.lb.appdomain.cloud", "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca", "id" => "7b6dc78d-49f3-435f-b767-e05f9affd3ca", "is_public" => true, "listeners" => [], "logging" => { "datapath" => { "active" => false } }, "name" => "my-load-balancer", "operating_status" => "online", "pools" => [], "private_ips" => [{ "address" => "10.0.0.32" }, { "address" => "10.0.0.35" }], "profile" => { "family" => "application", "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancer/profiles/dynamic", "name" => "dynamic" }, "provisioning_status" => "active", "public_ips" => [{ "address" => "192.0.0.56" }, { "address" => "192.0.0.44" }], "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/6eb23aa499254c66917dc265c374eca9", "id" => "6eb23aa499254c66917dc265c374eca9", "name" => "Default" }, "subnets" => [{ "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "id" => "3ff9fac4-7989-4c2e-ba7a-fad3bbdfaa96", "name" => "subnet-1" }] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_load_balancer(
      id: "7b6dc78d-49f3-435f-b767-e05f9affd3ca",
      load_balancer_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_get_load_balancer_statistics
    message_response = {
      "active_connections" => 1,
      "connection_rate" => 0,
      "data_processed_this_month" => 2_048_683,
      "throughput" => 0
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/7b6dc78d-49f3-435f-b767-e05f9affd3ca/statistics?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_load_balancer_statistics(
      id: "7b6dc78d-49f3-435f-b767-e05f9affd3ca"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_load_balancer_listeners
    message_response = { "listeners" => [
      { "accept_proxy_protocol" => false, "connection_limit" => 2000, "created_at" => "2018-12-18T01:07:46.739378Z",
        "default_pool" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ab4393-0261-11e9-8317-bec54e704988", "id" => "54ab4393-0261-11e9-8317-bec54e704988", "name" => "backend-http" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/4968d116-3174-405a-b334-3b8d00432f0d", "id" => "4968d116-3174-405a-b334-3b8d00432f0d", "port" => 80, "protocol" => "http", "provisioning_status" => "active" }, { "accept_proxy_protocol" => false, "connection_limit" => 3000, "created_at" => "2018-12-18T01:07:46.744224Z", "default_pool" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317­bec54e704988", "id" => "54ad563a-0261-11e9-8317-bec54e704988", "name" => "backend-tcp" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/d2b9b86e-5704-4b0f-a903-46f63be0addc", "id" => "d2b9b86e-5704-4b0f-a903-46f63be0addc", "port" => 90, "protocol" => "tcp", "provisioning_status" => "active" }, { "accept_proxy_protocol" => false, "certificate_instance" => { "crn" => "crn:[...]" }, "connection_limit" => 5000, "created_at" => "2018-12-18T01:07:47.808361Z", "default_pool" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ab4393-0261-11e9-8317-bec54e704988", "id" => "54ab4393-0261-11e9-8317-bec54e704988", "name" => "backend-http" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/30d893b8-1d5a-4bfb-8297-442c6c2f425b", "id" => "30d893b8-1d5a-4bfb-8297-442c6c2f425b", "port" => 443, "protocol" => "https", "provisioning_status" => "active" }
    ] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_load_balancer_listeners(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_load_balancer_listener
    message_response = { "accept_proxy_protocol" => false, "connection_limit" => 2000,
                         "created_at" => "2018-12-18T05:56:05.963323505Z", "default_pool" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ab4393-0261-11e9-8317-bec54e704988", "id" => "54ab4393-0261-11e9-8317-bec54e704988", "name" => "backend-http" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd", "id" => "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd", "port" => 99, "protocol" => "http", "provisioning_status" => "create_pending" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_load_balancer_listener(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      port: 99,
      protocol: "https"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_load_balancer_listener
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_load_balancer_listener(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd"
    )
  end

  def test_get_load_balancer_listener
    message_response = { "accept_proxy_protocol" => false, "connection_limit" => 2000,
                         "created_at" => "2018-12-18T05:56:05.963323505Z", "default_pool" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ab4393-0261-11e9-8317-bec54e704988", "id" => "54ab4393-0261-11e9-8317-bec54e704988", "name" => "backend-http" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd", "id" => "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd", "port" => 99, "protocol" => "http", "provisioning_status" => "create_pending" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_load_balancer_listener(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_load_balancer_listener
    message_response = { "accept_proxy_protocol" => false, "connection_limit" => 2000,
                         "created_at" => "2018-12-18T05:56:05.963323505Z", "default_pool" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ab4393-0261-11e9-8317-bec54e704988", "id" => "54ab4393-0261-11e9-8317-bec54e704988", "name" => "backend-http" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd", "id" => "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd", "port" => 99, "protocol" => "http", "provisioning_status" => "create_pending" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_load_balancer_listener(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd",
      load_balancer_listener_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_load_balancer_listener_policies
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd/policies?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_load_balancer_listener_policies(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      listener_id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_load_balancer_listener_policy
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd/policies?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_load_balancer_listener_policy(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      listener_id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd",
      action: "",
      priority: ""
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_load_balancer_listener_policy
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd/policies/47d4c9f2-8e41-433d-a095-2287efe4b8ae?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_load_balancer_listener_policy(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      listener_id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd",
      id: "47d4c9f2-8e41-433d-a095-2287efe4b8ae"
    )
  end

  def test_get_load_balancer_listener_policy
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd/policies/47d4c9f2-8e41-433d-a095-2287efe4b8ae?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_load_balancer_listener_policy(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      listener_id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd",
      id: "47d4c9f2-8e41-433d-a095-2287efe4b8ae"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_load_balancer_listener_policy
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd/policies/47d4c9f2-8e41-433d-a095-2287efe4b8ae?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_load_balancer_listener_policy(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      listener_id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd",
      id: "47d4c9f2-8e41-433d-a095-2287efe4b8ae",
      load_balancer_listener_policy_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_load_balancer_listener_policy_rules
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd/policies/47d4c9f2-8e41-433d-a095-2287efe4b8ae/rules?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_load_balancer_listener_policy_rules(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      listener_id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd",
      policy_id: "47d4c9f2-8e41-433d-a095-2287efe4b8ae"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_load_balancer_listener_policy_rule
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd/policies/47d4c9f2-8e41-433d-a095-2287efe4b8ae/rules?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_load_balancer_listener_policy_rule(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      listener_id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd",
      policy_id: "47d4c9f2-8e41-433d-a095-2287efe4b8ae",
      condition: "",
      type: "",
      value: ""
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_load_balancer_listener_policy_rule
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd/policies/47d4c9f2-8e41-433d-a095-2287efe4b8ae/rules/b2f46c0b-4dd6-4881-9d53-a2a6581ac43b?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_load_balancer_listener_policy_rule(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      listener_id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd",
      policy_id: "47d4c9f2-8e41-433d-a095-2287efe4b8ae",
      id: "b2f46c0b-4dd6-4881-9d53-a2a6581ac43b"
    )
  end

  def test_get_load_balancer_listener_policy_rule
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd/policies/47d4c9f2-8e41-433d-a095-2287efe4b8ae/rules/b2f46c0b-4dd6-4881-9d53-a2a6581ac43b?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_load_balancer_listener_policy_rule(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      listener_id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd",
      policy_id: "47d4c9f2-8e41-433d-a095-2287efe4b8ae",
      id: "b2f46c0b-4dd6-4881-9d53-a2a6581ac43b"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_load_balancer_listener_policy_rule
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/listeners/f5ceb28b-f448-4a5e-8d9d-ec81714f20bd/policies/47d4c9f2-8e41-433d-a095-2287efe4b8ae/rules/b2f46c0b-4dd6-4881-9d53-a2a6581ac43b?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_load_balancer_listener_policy_rule(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      listener_id: "f5ceb28b-f448-4a5e-8d9d-ec81714f20bd",
      policy_id: "47d4c9f2-8e41-433d-a095-2287efe4b8ae",
      id: "b2f46c0b-4dd6-4881-9d53-a2a6581ac43b",
      load_balancer_listener_policy_rule_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_load_balancer_pools
    message_response = { "pools" => [
      { "algorithm" => "least_connections", "created_at" => "2018-12-18T01:07:46.716159Z",
        "health_monitor" => { "delay" => 5, "max_retries" => 2, "timeout" => 2, "type" => "http", "url_path" => "/" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109­4484-894a-09f332753169/pools/54ab4393-0261-11e9-8317-bec54e704988", "id" => "54ab4393-0261-11e9-8317-bec54e704988", "members" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ab4393-0261-11e9-8317-bec54e704988/members/8c4ba2ee-9b24-452c-b720-1f885a20407c", "id" => "8c4ba2ee-9b24-452c-b720-1f885a20407c" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ab4393-0261-11e9-8317-bec54e704988/members/32d9ef39-9513-4bc9-a089-8809656b12e5", "id" => "32d9ef39-9513-4bc9-a089-8809656b12e5" }], "name" => "backend-http", "protocol" => "http", "provisioning_status" => "active", "proxy_protocol" => "v1" }, { "algorithm" => "round_robin", "created_at" => "2018-12-18T01:07:46.729263Z", "health_monitor" => { "delay" => 5, "max_retries" => 2, "timeout" => 2, "type" => "http", "url_path" => "/" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988", "id" => "fa248e5d-86b6-4c3d-a0c3-3df1bf59d5b8", "members" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/fa248e5d-86b6-4c3d-a0c3-3df1bf59d5b8/members/c8184f3f-3663-41f4-a353-2abb593cd9fe", "id" => "c8184f3f-3663-41f4-a353-2abb593cd9fe" }, { "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/fa248e5d-86b6-4c3d-a0c3-3df1bf59d5b8/members/e0f7d259-e365-41d5-8fe8-fbc8b16341d1", "id" => "e0f7d259-e365-41d5-8fe8-fbc8b16341d1" }], "name" => "backend-tcp", "protocol" => "tcp", "provisioning_status" => "active", "proxy_protocol" => "disabled" }
    ] }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_load_balancer_pools(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_load_balancer_pool
    message_response = { "algorithm" => "round_robin", "created_at" => "2018-12-18T01:07:46.716159Z",
                         "health_monitor" => { "delay" => 51, "max_retries" => 3, "timeout" => 21, "type" => "http", "url_path" => "/" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109­4484-894a-09f332753169/pools/528c70d0-acc1-47c7-a32d-698c350f4f81", "id" => "528c70d0-acc1-47c7-a32d-698c350f4f81", "members" => [], "name" => "my-pool", "protocol" => "tcp", "provisioning_status" => "create_pending", "proxy_protocol" => "disabled" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109­4484-894a-09f332753169/pools?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_load_balancer_pool(
      load_balancer_id: "2c791a20-4109­4484-894a-09f332753169",
      algorithm: "round_robin",
      health_monitor: {
        "delay": 51,
        "max_retries": 3,
        "timeout": 21,
        "type": "http",
        "url_path": "/"
      },
      protocol: "tcp"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_load_balancer_pool
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/64d1a65c-d759-4e87-9dc5-ff570d41e4b6/pools/528c70d0-acc1-47c7-a32d-698c350f4f81?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_load_balancer_pool(
      load_balancer_id: "64d1a65c-d759-4e87-9dc5-ff570d41e4b6",
      id: "528c70d0-acc1-47c7-a32d-698c350f4f81"
    )
  end

  def test_get_load_balancer_pool
    message_response = { "algorithm" => "round_robin", "created_at" => "2018-12-18T01:07:46.716159Z",
                         "health_monitor" => { "delay" => 51, "max_retries" => 3, "timeout" => 21, "type" => "http", "url_path" => "/" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109­4484-894a-09f332753169/pools/528c70d0-acc1-47c7-a32d-698c350f4f81", "id" => "528c70d0-acc1-47c7-a32d-698c350f4f81", "members" => [], "name" => "my-pool", "protocol" => "tcp", "provisioning_status" => "create_pending", "proxy_protocol" => "disabled" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/64d1a65c-d759-4e87-9dc5-ff570d41e4b6/pools/528c70d0-acc1-47c7-a32d-698c350f4f81?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_load_balancer_pool(
      load_balancer_id: "64d1a65c-d759-4e87-9dc5-ff570d41e4b6",
      id: "528c70d0-acc1-47c7-a32d-698c350f4f81"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_load_balancer_pool
    message_response = { "algorithm" => "round_robin", "created_at" => "2018-12-18T01:07:46.716159Z",
                         "health_monitor" => { "delay" => 51, "max_retries" => 3, "timeout" => 21, "type" => "http", "url_path" => "/" }, "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109­4484-894a-09f332753169/pools/528c70d0-acc1-47c7-a32d-698c350f4f81", "id" => "528c70d0-acc1-47c7-a32d-698c350f4f81", "members" => [], "name" => "my-pool", "protocol" => "tcp", "provisioning_status" => "create_pending", "proxy_protocol" => "disabled" }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/64d1a65c-d759-4e87-9dc5-ff570d41e4b6/pools/528c70d0-acc1-47c7-a32d-698c350f4f81?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_load_balancer_pool(
      load_balancer_id: "64d1a65c-d759-4e87-9dc5-ff570d41e4b6",
      id: "528c70d0-acc1-47c7-a32d-698c350f4f81",
      load_balancer_pool_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_load_balancer_pool_members
    message_response = {
      "members" => [
        {
          "created_at" => "2018-12-18T01:07:46.733487Z",
          "health" => "ok",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members/54aec7cf-0261-11e9-8317-bec54e704988",
          "id" => "54aec7cf-0261-11e9-8317-bec54e704988",
          "port" => 80,
          "provisioning_status" => "active",
          "target" => { "address" => "10.0.0.25" },
          "weight" => 50
        },
        {
          "created_at" => "2018-12-18T01:07:46.734764Z",
          "health" => "ok",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members/daebeb48-1658-4772-8ca9-e410cd6e1415",
          "id" => "daebeb48-1658-4772-8ca9-e410cd6e1415",
          "port" => 80,
          "provisioning_status" => "active",
          "target" => { "address" => "10.0.0.29" },
          "weight" => 50
        }
      ]
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_load_balancer_pool_members(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      pool_id: "54ad563a-0261-11e9-8317-bec54e704988"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_create_load_balancer_pool_member
    message_response = {
      "created_at" => "2018-12-18T01:07:46.733487Z",
      "health" => "ok",
      "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members/54aec7cf-0261-11e9-8317-bec54e704988",
      "id" => "54aec7cf-0261-11e9-8317-bec54e704988",
      "port" => 80,
      "provisioning_status" => "active",
      "target" => { "address" => "10.0.0.25" },
      "weight" => 50
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_load_balancer_pool_member(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      pool_id: "54ad563a-0261-11e9-8317-bec54e704988",
      port: 80,
      target: { "address" => "10.0.0.25" }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_replace_load_balancer_pool_members
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:put, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 202, body: message_response.to_json, headers: headers)
    service_response = service.replace_load_balancer_pool_members(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      pool_id: "54ad563a-0261-11e9-8317-bec54e704988",
      members: [
        {
          "created_at" => "2018-12-18T01:07:46.733487Z",
          "health" => "ok",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members/54aec7cf-0261-11e9-8317-bec54e704988",
          "id" => "54aec7cf-0261-11e9-8317-bec54e704988",
          "port" => 80,
          "provisioning_status" => "active",
          "target" => { "address" => "10.0.0.25" },
          "weight" => 50
        },
        {
          "created_at" => "2018-12-18T01:07:46.734764Z",
          "health" => "ok",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members/daebeb48-1658-4772-8ca9-e410cd6e1415",
          "id" => "daebeb48-1658-4772-8ca9-e410cd6e1415",
          "port" => 80,
          "provisioning_status" => "active",
          "target" => { "address" => "10.0.0.29" },
          "weight" => 50
        }
      ]
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_load_balancer_pool_member
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members/daebeb48-1658-4772-8ca9-e410cd6e1415?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.delete_load_balancer_pool_member(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      pool_id: "54ad563a-0261-11e9-8317-bec54e704988",
      id: "daebeb48-1658-4772-8ca9-e410cd6e1415"
    )
  end

  def test_get_load_balancer_pool_member
    message_response = {
      "created_at" => "2018-12-18T01:07:46.733487Z",
      "health" => "ok",
      "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members/54aec7cf-0261-11e9-8317-bec54e704988",
      "id" => "54aec7cf-0261-11e9-8317-bec54e704988",
      "port" => 80,
      "provisioning_status" => "active",
      "target" => { "address" => "10.0.0.25" },
      "weight" => 50
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members/daebeb48-1658-4772-8ca9-e410cd6e1415?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_load_balancer_pool_member(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      pool_id: "54ad563a-0261-11e9-8317-bec54e704988",
      id: "daebeb48-1658-4772-8ca9-e410cd6e1415"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_load_balancer_pool_member
    message_response = {
      "created_at" => "2018-12-18T01:07:46.733487Z",
      "health" => "ok",
      "href" => "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members/54aec7cf-0261-11e9-8317-bec54e704988",
      "id" => "54aec7cf-0261-11e9-8317-bec54e704988",
      "port" => 80,
      "provisioning_status" => "active",
      "target" => { "address" => "10.0.0.25" },
      "weight" => 50
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/load_balancers/2c791a20-4109-4484-894a-09f332753169/pools/54ad563a-0261-11e9-8317-bec54e704988/members/daebeb48-1658-4772-8ca9-e410cd6e1415?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_load_balancer_pool_member(
      load_balancer_id: "2c791a20-4109-4484-894a-09f332753169",
      pool_id: "54ad563a-0261-11e9-8317-bec54e704988",
      id: "daebeb48-1658-4772-8ca9-e410cd6e1415",
      load_balancer_pool_member_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_endpoint_gateways
    message_response = {
      "endpoint_gateways" => [
        { "created_at" => "2020-07-24T19:42:46Z", "crn" => "crn:[...]", "health_state" => "ok",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a", "id" => "r134-a4841334-b584-4293-938e-3bc63b4a5b6a", "ips" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-bb7e061d-7259-45b6-a0da-416ace665269", "id" => "0716-bb7e061d-7259-45b6-a0da-416ace665269", "name" => "my-reserved-ip-1", "resource_type" => "subnet_reserved_ip" }], "lifecycle_state" => "stable", "name" => "my-endpoint-gateway-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "endpoint_gateway", "service_endpoints" => ["time.adn.networklayer.com"], "target" => { "name" => "ibm-ntp-server", "resource_type" => "provider_infrastructure_service" }, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/r134-d50a9a31-ec85-4442-a6a3-4b1b9da417f0", "id" => "r134-d50a9a31-ec85-4442-a6a3-4b1b9da417f0", "name" => "my-vpc" } }, { "created_at" => "2020-07-24T19:43:56Z", "crn" => "crn:[...]", "health_state" => "ok", "href" => "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-badc3b88-b9c2-46c3-acb1-2fd4361f6f7d", "id" => "r134-badc3b88-b9c2-46c3-acb1-2fd4361f6f7d", "ips" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-236a7fcf-3f9b-4612-8827-e7eddd216b6b", "id" => "0716-236a7fcf-3f9b-4612-8827-e7eddd216b6b", "name" => "my-reserved-ip-2", "resource_type" => "subnet_reserved_ip" }], "lifecycle_state" => "stable", "name" => "my-endpoint-gateway-2", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "endpoint_gateway", "service_endpoints" => ["time.adn.networklayer.com"], "target" => { "name" => "ibm-ntp-server", "resource_type" => "provider_infrastructure_service" }, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/r134-e2cd90a7-8c7c-476f-b454-9ea0b5387677", "id" => "r134-e2cd90a7-8c7c-476f-b454-9ea0b5387677", "name" => "my-other-vpc" } }
      ], "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways?limit=50" }, "limit" => 50, "total_count" => 2
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_endpoint_gateways

    assert_equal(message_response, service_response.result)
  end

  def test_create_endpoint_gateway
    message_response = { "created_at" => "2020-07-24T19:42:46Z", "crn" => "crn:[...]", "health_state" => "ok",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a", "id" => "r134-a4841334-b584-4293-938e-3bc63b4a5b6a", "ips" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-bb7e061d-7259-45b6-a0da-416ace665269", "id" => "0716-bb7e061d-7259-45b6-a0da-416ace665269", "name" => "my-reserved-ip-1", "resource_type" => "subnet_reserved_ip" }], "lifecycle_state" => "stable", "name" => "my-endpoint-gateway-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "endpoint_gateway", "service_endpoints" => ["time.adn.networklayer.com"], "target" => { "name" => "ibm-ntp-server", "resource_type" => "provider_infrastructure_service" }, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/r134-d50a9a31-ec85-4442-a6a3-4b1b9da417f0", "id" => "r134-d50a9a31-ec85-4442-a6a3-4b1b9da417f0", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 201, body: message_response.to_json, headers: headers)
    service_response = service.create_endpoint_gateway(
      target: {
        "name" => "ibm-ntp-server",
        "resource_type" => "provider_infrastructure_service"
      },
      vpc: "r134-d50a9a31-ec85-4442-a6a3-4b1b9da417f0"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_endpoint_gateway_ips
    message_response = {
      "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/ips?limit=50" }, "ips" => [
        { "address" => "10.240.0.7", "auto_delete" => true, "created_at" => "2020-07-24T19:52:18Z",
          "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/ips/0716-9faf2f32-8528-4180-a14d-c1f6c5c83292", "id" => "0716-9faf2f32-8528-4180-a14d-c1f6c5c83292", "name" => "my-reserved-ip-1", "owner" => "user", "resource_type" => "subnet_reserved_ip", "target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-fb050c0c-b33a-44b1-9eae-4ae6e6ebaba4", "id" => "r134-fb050c0c-b33a-44b1-9eae-4ae6e6ebaba4", "name" => "my-endpoint-gateway-1", "resource_type" => "endpoint_gateway" } }, { "address" => "10.240.64.4", "auto_delete" => true, "created_at" => "2020-07-24T19:53:23Z", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0726-ebe8b8e7-d20c-4175-92bf-835704ed331b/ips/0726-16f16cdc-6488-4ef3-8c47-969212e844c1", "id" => "0726-16f16cdc-6488-4ef3-8c47-969212e844c1", "name" => "my-reserved-ip-2", "owner" => "user", "resource_type" => "subnet_reserved_ip", "target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-fb050c0c-b33a-44b1-9eae-4ae6e6ebaba4", "id" => "r134-fb050c0c-b33a-44b1-9eae-4ae6e6ebaba4", "name" => "my-endpoint-gateway-1", "resource_type" => "endpoint_gateway" } }
      ], "limit" => 50, "total_count" => 2
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a/ips?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_endpoint_gateway_ips(
      endpoint_gateway_id: "r134-a4841334-b584-4293-938e-3bc63b4a5b6a"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_remove_endpoint_gateway_ip
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a/ips/0716-9faf2f32-8528-4180-a14d-c1f6c5c83292?generation=2&version=2022-03-29")
      .to_return(status: 204, body: message_response.to_json, headers: headers)
    service.remove_endpoint_gateway_ip(
      endpoint_gateway_id: "r134-a4841334-b584-4293-938e-3bc63b4a5b6a",
      id: "0716-9faf2f32-8528-4180-a14d-c1f6c5c83292"
    )
  end

  def test_get_endpoint_gateway_ip
    message_response = {
      "address" => "10.240.0.7",
      "auto_delete" => true,
      "created_at" => "2020-07-24T19:52:18Z",
      "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/ips/0716-9faf2f32-8528-4180-a14d-c1f6c5c83292",
      "id" => "0716-9faf2f32-8528-4180-a14d-c1f6c5c83292",
      "name" => "my-reserved-ip-1",
      "owner" => "user",
      "resource_type" => "subnet_reserved_ip",
      "target" => {
        "crn" => "crn:[...]",
        "href" => "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-fb050c0c-b33a-44b1-9eae-4ae6e6ebaba4",
        "id" => "r134-fb050c0c-b33a-44b1-9eae-4ae6e6ebaba4",
        "name" => "my-endpoint-gateway-1",
        "resource_type" => "endpoint_gateway"
      }
    }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a/ips/0716-9faf2f32-8528-4180-a14d-c1f6c5c83292?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_endpoint_gateway_ip(
      endpoint_gateway_id: "r134-a4841334-b584-4293-938e-3bc63b4a5b6a",
      id: "0716-9faf2f32-8528-4180-a14d-c1f6c5c83292"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_add_endpoint_gateway_ip
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:put, "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a/ips/0716-9faf2f32-8528-4180-a14d-c1f6c5c83292?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.add_endpoint_gateway_ip(
      endpoint_gateway_id: "r134-a4841334-b584-4293-938e-3bc63b4a5b6a",
      id: "0716-9faf2f32-8528-4180-a14d-c1f6c5c83292"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_endpoint_gateway
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a?generation=2&version=2022-03-29")
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service.delete_endpoint_gateway(
      id: "r134-a4841334-b584-4293-938e-3bc63b4a5b6a"
    )
  end

  def test_get_endpoint_gateway
    message_response = { "created_at" => "2020-07-24T19:42:46Z", "crn" => "crn:[...]", "health_state" => "ok",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a", "id" => "r134-a4841334-b584-4293-938e-3bc63b4a5b6a", "ips" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-bb7e061d-7259-45b6-a0da-416ace665269", "id" => "0716-bb7e061d-7259-45b6-a0da-416ace665269", "name" => "my-reserved-ip-1", "resource_type" => "subnet_reserved_ip" }], "lifecycle_state" => "stable", "name" => "my-endpoint-gateway-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "endpoint_gateway", "service_endpoints" => ["time.adn.networklayer.com"], "target" => { "name" => "ibm-ntp-server", "resource_type" => "provider_infrastructure_service" }, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/r134-d50a9a31-ec85-4442-a6a3-4b1b9da417f0", "id" => "r134-d50a9a31-ec85-4442-a6a3-4b1b9da417f0", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_endpoint_gateway(
      id: "r134-a4841334-b584-4293-938e-3bc63b4a5b6a"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_endpoint_gateway
    message_response = { "created_at" => "2020-07-24T19:42:46Z", "crn" => "crn:[...]", "health_state" => "ok",
                         "href" => "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a", "id" => "r134-a4841334-b584-4293-938e-3bc63b4a5b6a", "ips" => [{ "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/0716-b28a7e6d-a66b-4de7-8713-15dcffdce401/reserved_ips/0716-bb7e061d-7259-45b6-a0da-416ace665269", "id" => "0716-bb7e061d-7259-45b6-a0da-416ace665269", "name" => "my-reserved-ip-1", "resource_type" => "subnet_reserved_ip" }], "lifecycle_state" => "stable", "name" => "my-endpoint-gateway-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "resource_type" => "endpoint_gateway", "service_endpoints" => ["time.adn.networklayer.com"], "target" => { "name" => "ibm-ntp-server", "resource_type" => "provider_infrastructure_service" }, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/r134-d50a9a31-ec85-4442-a6a3-4b1b9da417f0", "id" => "r134-d50a9a31-ec85-4442-a6a3-4b1b9da417f0", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/endpoint_gateways/r134-a4841334-b584-4293-938e-3bc63b4a5b6a?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_endpoint_gateway(
      id: "r134-a4841334-b584-4293-938e-3bc63b4a5b6a",
      endpoint_gateway_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end

  def test_list_flow_log_collectors
    message_response = { "first" => { "href" => "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors?limit=50" },
                         "flow_log_collectors" => [{ "active" => true, "auto_delete" => true, "created_at" => "2019-06-28T12:08:05Z", "crn" => "crn:v1:bluemix:public:is:us-south:a/123456::flow-log-collector:4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "href" => "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors/4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "id" => "4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "lifecycle_state" => "pending", "name" => "my-flow-log-collector-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "storage_bucket" => { "endpoint" => "https://s3.us.cloud-object-storage.appdomain.cloud", "name" => "bucket-27200-lwx4cfvcue" }, "target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/1e09281b-f177-46fb-baf1-bc152b2e391a/network_interfaces/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32", "id" => "bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32", "name" => "my-network-interface-1", "resource_type" => "network_interface" }, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/e2cd90a7-8c7c-476f-b454-9ea0b5387677", "id" => "e2cd90a7-8c7c-476f-b454-9ea0b5387677", "name" => "my-vpc" } }, { "active" => true, "auto_delete" => true, "created_at" => "2019-06-19T12:08:05Z", "crn" => "crn:v1:bluemix:public:is:us-south:a/123456::flow-log-collector:64580c28-713a-4cda-9993-53bc6a529bb4", "href" => "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors/64580c28-713a-4cda-9993-53bc6a529bb4", "id" => "64580c28-713a-4cda-9993-53bc6a529bb4", "lifecycle_state" => "stable", "name" => "my-flow-log-collector-2", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "storage_bucket" => { "endpoint" => "https://s3.us.cloud-object-storage.appdomain.cloud", "name" => "bucket-27200-lwx4cfvcue" }, "target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/subnets/8722d01c-9c78-4555-82b5-53ad1266f959", "id" => "8722d01c-9c78-4555-82b5-53ad1266f959", "name" => "my-subnet-1", "resource_type" => "subnet" }, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/e2cd90a7-8c7c-476f-b454-9ea0b5387677", "id" => "e2cd90a7-8c7c-476f-b454-9ea0b5387677", "name" => "my-vpc" } }], "limit" => 50, "total_count" => 2 }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.list_flow_log_collectors

    assert_equal(message_response, service_response.result)
  end

  def test_create_flow_log_collector
    message_response = { "active" => true, "auto_delete" => true, "created_at" => "2019-06-28T12:08:05Z",
                         "crn" => "crn:v1:bluemix:public:is:us-south:a/123456::flow-log-collector:4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "href" => "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors/4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "id" => "4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "lifecycle_state" => "pending", "name" => "my-flow-log-collector-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "storage_bucket" => { "endpoint" => "https://s3.us.cloud-object-storage.appdomain.cloud", "name" => "bucket-27200-lwx4cfvcue" }, "target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/1e09281b-f177-46fb-baf1-bc152b2e391a/network_interfaces/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32", "id" => "bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32", "name" => "my-network-interface-1", "resource_type" => "network_interface" }, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/e2cd90a7-8c7c-476f-b454-9ea0b5387677", "id" => "e2cd90a7-8c7c-476f-b454-9ea0b5387677", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:post, "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.create_flow_log_collector(
      storage_bucket: {
        "endpoint": "https://s3.us.cloud-object-storage.appdomain.cloud",
        "name": "bucket-27200-lwx4cfvcue"
      },
      target: {
        "crn": "crn:[...]",
        "href": "https://us-south.iaas.cloud.ibm.com/v1/instances/1e09281b-f177-46fb-baf1-bc152b2e391a/network_interfaces/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32",
        "id": "bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32",
        "name": "my-network-interface-1",
        "resource_type": "network_interface"
      }
    )

    assert_equal(message_response, service_response.result)
  end

  def test_delete_flow_log_collector
    message_response = {}
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:delete, "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors/4dd1852a-3373-46c0-9240-f9c7f0d0c1a3?generation=2&version=2022-03-29")
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service.delete_flow_log_collector(
      id: "4dd1852a-3373-46c0-9240-f9c7f0d0c1a3"
    )
  end

  def test_get_flow_log_collector
    message_response = { "active" => true, "auto_delete" => true, "created_at" => "2019-06-28T12:08:05Z",
                         "crn" => "crn:v1:bluemix:public:is:us-south:a/123456::flow-log-collector:4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "href" => "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors/4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "id" => "4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "lifecycle_state" => "pending", "name" => "my-flow-log-collector-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "storage_bucket" => { "endpoint" => "https://s3.us.cloud-object-storage.appdomain.cloud", "name" => "bucket-27200-lwx4cfvcue" }, "target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/1e09281b-f177-46fb-baf1-bc152b2e391a/network_interfaces/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32", "id" => "bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32", "name" => "my-network-interface-1", "resource_type" => "network_interface" }, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/e2cd90a7-8c7c-476f-b454-9ea0b5387677", "id" => "e2cd90a7-8c7c-476f-b454-9ea0b5387677", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:get, "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors/4dd1852a-3373-46c0-9240-f9c7f0d0c1a3?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.get_flow_log_collector(
      id: "4dd1852a-3373-46c0-9240-f9c7f0d0c1a3"
    )

    assert_equal(message_response, service_response.result)
  end

  def test_update_flow_log_collector
    message_response = { "active" => true, "auto_delete" => true, "created_at" => "2019-06-28T12:08:05Z",
                         "crn" => "crn:v1:bluemix:public:is:us-south:a/123456::flow-log-collector:4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "href" => "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors/4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "id" => "4dd1852a-3373-46c0-9240-f9c7f0d0c1a3", "lifecycle_state" => "pending", "name" => "my-flow-log-collector-1", "resource_group" => { "href" => "https://resource-controller.cloud.ibm.com/v2/resource_groups/4bbce614c13444cd8fc5e7e878ef8e21", "id" => "4bbce614c13444cd8fc5e7e878ef8e21", "name" => "Default" }, "storage_bucket" => { "endpoint" => "https://s3.us.cloud-object-storage.appdomain.cloud", "name" => "bucket-27200-lwx4cfvcue" }, "target" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/instances/1e09281b-f177-46fb-baf1-bc152b2e391a/network_interfaces/bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32", "id" => "bd5f7dc3-93c7-4d3a-89b4-26c4cc364a32", "name" => "my-network-interface-1", "resource_type" => "network_interface" }, "vpc" => { "crn" => "crn:[...]", "href" => "https://us-south.iaas.cloud.ibm.com/v1/vpcs/e2cd90a7-8c7c-476f-b454-9ea0b5387677", "id" => "e2cd90a7-8c7c-476f-b454-9ea0b5387677", "name" => "my-vpc" } }
    headers = {
      "Content-Type" => "application/json"
    }

    stub_request(:patch, "https://us-south.iaas.cloud.ibm.com/v1/flow_log_collectors/4dd1852a-3373-46c0-9240-f9c7f0d0c1a3?generation=2&version=2022-03-29")
      .with(
        headers: { "Accept" => "application/json" }
      )
      .to_return(status: 200, body: message_response.to_json, headers: headers)
    service_response = service.update_flow_log_collector(
      id: "4dd1852a-3373-46c0-9240-f9c7f0d0c1a3",
      flow_log_collector_patch: {}
    )

    assert_equal(message_response, service_response.result)
  end
end
