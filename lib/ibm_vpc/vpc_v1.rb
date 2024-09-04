# frozen_string_literal: true

# (C) Copyright IBM Corp. 2024.
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
#
# IBM OpenAPI SDK Code Generator Version: 3.67.0-df2073a1-20230222-221157
#
# The IBM Cloud Virtual Private Cloud (VPC) API can be used to programmatically
# provision and manage virtual server instances, along with subnets, volumes, load
# balancers, and more.

require "concurrent"
require "erb"
require "json"
require "ibm_cloud_sdk_core"
require_relative "./common.rb"

module IbmVpc
  ##
  # The vpc V1 service.
  class VpcV1 < IBMCloudSdkCore::BaseService
    include Concurrent::Async
    DEFAULT_SERVICE_NAME = "vpc"
    DEFAULT_SERVICE_URL = "https://us-south.iaas.cloud.ibm.com/v1"
    DEFAULT_SERVICE_VERSION = "2024-08-20"
    attr_accessor :version
    attr_accessor :generation
    ##
    # @!method initialize(args)
    # Construct a new client for the vpc service.
    #
    # @param args [Hash] The args to initialize with
    # @option args version [String] The API version, in format `YYYY-MM-DD`. For the API behavior documented here,
    #   specify any date between `2024-04-30` and `2024-08-20`.
    # @option args service_url [String] The base service URL to use when contacting the service.
    #   The base service_url may differ between IBM Cloud regions.
    # @option args authenticator [Object] The Authenticator instance to be configured for this service.
    # @option args service_name [String] The name of the service to configure. Will be used as the key to load
    #   any external configuration, if applicable.
    def initialize(args = {})
      @__async_initialized__ = false
      defaults = {}
      defaults[:service_url] = DEFAULT_SERVICE_URL
      defaults[:service_name] = DEFAULT_SERVICE_NAME
      defaults[:authenticator] = nil
      defaults[:version] = DEFAULT_SERVICE_VERSION
      defaults[:generation] = 2
      user_service_url = args[:service_url] unless args[:service_url].nil?
      args = defaults.merge(args)
      @generation = args[:generation]

      @version = args[:version]
      raise ArgumentError.new("version must be provided") if @version.nil?

      super
      @service_url = user_service_url unless user_service_url.nil?
    end

    #########################
    # VPCs
    #########################

    ##
    # @!method list_vpcs(start: nil, limit: nil, resource_group_id: nil, classic_access: nil)
    # List VPCs.
    # This request lists VPCs in the region. A VPC is a virtual network that belongs to
    #   an account and provides logical isolation from other networks. A VPC is made up of
    #   resources in one or more zones. VPCs are regional, and each VPC can contain
    #   resources in multiple zones in a region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param classic_access [Boolean] Filters the collection to VPCs with a `classic_access` property matching the
    #   specified value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpcs(start: nil, limit: nil, resource_group_id: nil, classic_access: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpcs")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "classic_access" => classic_access
      }

      method_url = "/vpcs"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_vpc(address_prefix_management: nil, classic_access: nil, dns: nil, name: nil, resource_group: nil)
    # Create a VPC.
    # This request creates a new VPC from a VPC prototype object. The prototype object
    #   is structured in the same way as a retrieved VPC, and contains the information
    #   necessary to create the new VPC.
    # @param address_prefix_management [String] Indicates whether a [default address
    #   prefix](https://cloud.ibm.com/docs/vpc?topic=vpc-configuring-address-prefixes)
    #   will be automatically created for each zone in this VPC. If `manual`, this VPC
    #   will be created with no default address prefixes.
    #
    #   Since address prefixes are managed identically regardless of whether they were
    #   automatically created, the value is not preserved as a VPC property.
    # @param classic_access [Boolean] Indicates whether this VPC will be connected to Classic Infrastructure. If true,
    #   this VPC's resources will have private network connectivity to the account's
    #   Classic Infrastructure resources. Only one VPC, per region, may be connected in
    #   this way. This value is set at creation and subsequently immutable.
    # @param dns [VPCDNSPrototype] The DNS configuration for this VPC.
    #
    #   If unspecified, the system will assign DNS servers capable of resolving hosts and
    #   endpoint
    #   gateways within this VPC, and hosts on the internet.
    # @param name [String] The name for this VPC. The name must not be used by another VPC in the region. If
    #   unspecified, the name will be a hyphenated list of randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpc(address_prefix_management: nil, classic_access: nil, dns: nil, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_vpc")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "address_prefix_management" => address_prefix_management,
        "classic_access" => classic_access,
        "dns" => dns,
        "name" => name,
        "resource_group" => resource_group
      }

      method_url = "/vpcs"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpc(id:, if_match: nil)
    # Delete a VPC.
    # This request deletes a VPC. This operation cannot be reversed.
    #
    #   For this request to succeed:
    #   - Instances, subnets, public gateways, and endpoint gateways must not reside in
    #   this VPC
    #   - The VPC must not be providing DNS resolution for any other VPCs
    #   - If `dns.enable_hub` is `true`, `dns.resolution_binding_count` must be zero
    #
    #   All security groups and network ACLs associated with the VPC are automatically
    #   deleted. All flow log collectors with `auto_delete` set to `true` targeting the
    #   VPC or any resource in the VPC are automatically deleted.
    # @param id [String] The VPC identifier.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value.
    # @return [nil]
    def delete_vpc(id:, if_match: nil)
      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpc")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_vpc(id:)
    # Retrieve a VPC.
    # This request retrieves a single VPC specified by the identifier in the URL.
    # @param id [String] The VPC identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpc(id:)
      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpc")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_vpc(id:, vpc_patch:, if_match: nil)
    # Update a VPC.
    # This request updates a VPC with the information provided in a VPC patch object.
    #   The patch object is structured in the same way as a retrieved VPC and needs to
    #   contain only the information to be updated.
    # @param id [String] The VPC identifier.
    # @param vpc_patch [Hash] The VPC patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpc(id:, vpc_patch:, if_match: nil)
      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_patch must be provided") if vpc_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_vpc")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = vpc_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/vpcs/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_vpc_default_network_acl(id:)
    # Retrieve a VPC's default network ACL.
    # This request retrieves the default network ACL for the VPC specified by the
    #   identifier in the URL. The default network ACL is applied to any new subnets in
    #   the VPC which do not specify a network ACL.
    # @param id [String] The VPC identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpc_default_network_acl(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpc_default_network_acl")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/default_network_acl" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_vpc_default_routing_table(id:)
    # Retrieve a VPC's default routing table.
    # This request retrieves the default routing table for the VPC specified by the
    #   identifier in the URL. The default routing table is associated with any subnets in
    #   the VPC which have not been explicitly associated with another routing table.
    # @param id [String] The VPC identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpc_default_routing_table(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpc_default_routing_table")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/default_routing_table" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_vpc_default_security_group(id:)
    # Retrieve a VPC's default security group.
    # This request retrieves the default security group for the VPC specified by the
    #   identifier in the URL. Resources created in this VPC that allow a security group
    #   to be optionally specified will use this security group by default.
    # @param id [String] The VPC identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpc_default_security_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpc_default_security_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/default_security_group" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_vpc_address_prefixes(vpc_id:, start: nil, limit: nil)
    # List address prefixes for a VPC.
    # This request lists address pool prefixes for a VPC.
    # @param vpc_id [String] The VPC identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpc_address_prefixes(vpc_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpc_address_prefixes")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/vpcs/%s/address_prefixes" % [ERB::Util.url_encode(vpc_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_vpc_address_prefix(vpc_id:, cidr:, zone:, is_default: nil, name: nil)
    # Create an address prefix for a VPC.
    # This request creates a new prefix from a prefix prototype object. The prototype
    #   object is structured in the same way as a retrieved prefix, and contains the
    #   information necessary to create the new prefix.
    # @param vpc_id [String] The VPC identifier.
    # @param cidr [String] The IPv4 range of the address prefix, expressed in CIDR format. The range must not
    #   overlap with any existing address prefixes in the VPC or any of the following
    #   reserved address ranges:
    #
    #     - `127.0.0.0/8` (IPv4 loopback addresses)
    #     - `161.26.0.0/16` (IBM services)
    #     - `166.8.0.0/14` (Cloud Service Endpoints)
    #     - `169.254.0.0/16` (IPv4 link-local addresses)
    #     - `224.0.0.0/4` (IPv4 multicast addresses)
    #
    #   The prefix length of the address prefix's CIDR must be between `/9` (8,388,608
    #   addresses) and `/29` (8 addresses).
    # @param zone [ZoneIdentity] The zone this address prefix will reside in.
    # @param is_default [Boolean] Indicates whether this will be the default address prefix for this zone in this
    #   VPC. If `true`, the VPC must not have a default address prefix for this zone.
    # @param name [String] The name for this address prefix. The name must not be used by another address
    #   prefix for the VPC. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpc_address_prefix(vpc_id:, cidr:, zone:, is_default: nil, name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("cidr must be provided") if cidr.nil?

      raise ArgumentError.new("zone must be provided") if zone.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_vpc_address_prefix")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "cidr" => cidr,
        "zone" => zone,
        "is_default" => is_default,
        "name" => name
      }

      method_url = "/vpcs/%s/address_prefixes" % [ERB::Util.url_encode(vpc_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpc_address_prefix(vpc_id:, id:)
    # Delete an address prefix.
    # This request deletes a prefix. This operation cannot be reversed. The request will
    #   fail if any subnets use addresses from this prefix.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The prefix identifier.
    # @return [nil]
    def delete_vpc_address_prefix(vpc_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpc_address_prefix")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/address_prefixes/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_vpc_address_prefix(vpc_id:, id:)
    # Retrieve an address prefix.
    # This request retrieves a single prefix specified by the identifier in the URL.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The prefix identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpc_address_prefix(vpc_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpc_address_prefix")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/address_prefixes/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_vpc_address_prefix(vpc_id:, id:, address_prefix_patch:)
    # Update an address prefix.
    # This request updates a prefix with the information in a provided prefix patch. The
    #   prefix patch object is structured in the same way as a retrieved prefix and
    #   contains only the information to be updated.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The prefix identifier.
    # @param address_prefix_patch [Hash] The prefix patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpc_address_prefix(vpc_id:, id:, address_prefix_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("address_prefix_patch must be provided") if address_prefix_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_vpc_address_prefix")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = address_prefix_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/vpcs/%s/address_prefixes/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_vpc_dns_resolution_bindings(vpc_id:, sort: nil, start: nil, limit: nil, name: nil, vpc_crn: nil, vpc_name: nil, account_id: nil)
    # List DNS resolution bindings for a VPC.
    # This request lists DNS resolution bindings for a VPC. A DNS resolution binding
    #   represents an association with another VPC for centralizing DNS name resolution.
    #
    #   If the VPC specified by the identifier in the URL is a DNS hub VPC (has
    #   `dns.enable_hub` set to `true`) then there is one binding for each VPC bound to
    #   the hub VPC. The endpoint gateways in the bound VPCs can allow (using
    #   `allow_dns_resolution_binding`) the hub VPC to centralize resolution of their DNS
    #   names.
    #
    #   If the VPC specified by the identifier in the URL is not a DNS hub VPC, then there
    #   is at most one binding (to a hub VPC). The endpoint gateways in the VPC specified
    #   by the identifier in the URL can allow (using `allow_dns_resolution_binding`) its
    #   hub VPC to centralize resolution of their DNS names.
    #
    #   To make use of centralized DNS resolution, a VPC bound to a DNS hub VPC must
    #   delegate DNS resolution to its hub VPC by setting `dns.resolver.type` to
    #   `delegate`.
    #
    #   The bindings will be sorted by their `created_at` property values, with newest
    #   bindings first. Bindings with identical `created_at` property values will in turn
    #   be sorted by ascending `name` property values.
    # @param vpc_id [String] The VPC identifier.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param vpc_crn [String] Filters the collection to resources with a `vpc.crn` property matching the
    #   specified CRN.
    # @param vpc_name [String] Filters the collection to resources with a `vpc.name` property matching the exact
    #   specified name.
    # @param account_id [String] Filters the collection to resources with a `vpc.remote.account.id` property
    #   matching the specified account identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpc_dns_resolution_bindings(vpc_id:, sort: nil, start: nil, limit: nil, name: nil, vpc_crn: nil, vpc_name: nil, account_id: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpc_dns_resolution_bindings")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "sort" => sort,
        "start" => start,
        "limit" => limit,
        "name" => name,
        "vpc.crn" => vpc_crn,
        "vpc.name" => vpc_name,
        "account.id" => account_id
      }

      method_url = "/vpcs/%s/dns_resolution_bindings" % [ERB::Util.url_encode(vpc_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_vpc_dns_resolution_binding(vpc_id:, vpc:, name: nil)
    # Create a DNS resolution binding.
    # This request creates a new DNS resolution binding from a DNS resolution binding
    #   prototype object. The prototype object is structured in the same way as a
    #   retrieved DNS resolution binding, and contains the information necessary to create
    #   the new DNS resolution binding.
    #
    #   For this request to succeed, `dns.enable_hub` must be `false` for the VPC
    #   specified by the identifier in the URL, and the VPC must not already have a DNS
    #   resolution binding.
    #
    #   See [About DNS sharing for VPE gateways](/docs/vpc?topic=vpc-hub-spoke-model) for
    #   more information.
    # @param vpc_id [String] The VPC identifier.
    # @param vpc [VPCIdentity] Another VPC to bind this VPC to for DNS resolution. The VPC must have
    #   `dns.enable_hub` set to `true`, and may be in a different account (subject to
    #   IAM policies).
    #
    #   Additionally, the VPC specified in the URL (this VPC) must have `dns.enable_hub`
    #   set to `false` and a `dns.resolution_binding_count` of zero.
    # @param name [String] The name for this DNS resolution binding. The name must not be used by another DNS
    #   resolution binding for the VPC. If unspecified, the name will be a hyphenated list
    #   of randomly-selected words.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpc_dns_resolution_binding(vpc_id:, vpc:, name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("vpc must be provided") if vpc.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_vpc_dns_resolution_binding")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "vpc" => vpc,
        "name" => name
      }

      method_url = "/vpcs/%s/dns_resolution_bindings" % [ERB::Util.url_encode(vpc_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpc_dns_resolution_binding(vpc_id:, id:)
    # Delete a DNS resolution binding.
    # This request deletes a DNS resolution binding. This operation cannot be reversed.
    #
    #   For this request to succeed, the VPC specified by the identifier in the URL must
    #   not have
    #   `dns.resolver.type` set to `delegated`.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The DNS resolution binding identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def delete_vpc_dns_resolution_binding(vpc_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpc_dns_resolution_binding")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/dns_resolution_bindings/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      response = request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_vpc_dns_resolution_binding(vpc_id:, id:)
    # Retrieve a DNS resolution binding.
    # This request retrieves a single DNS resolution binding specified by the identifier
    #   in the URL.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The DNS resolution binding identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpc_dns_resolution_binding(vpc_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpc_dns_resolution_binding")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/dns_resolution_bindings/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_vpc_dns_resolution_binding(vpc_id:, id:, vpcdns_resolution_binding_patch:)
    # Update a DNS resolution binding.
    # This request updates a DNS resolution binding with the information in a provided
    #   DNS resolution binding patch. The DNS resolution binding patch object is
    #   structured in the same way as a retrieved DNS resolution binding and contains only
    #   the information to be updated.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The DNS resolution binding identifier.
    # @param vpcdns_resolution_binding_patch [Hash] The DNS resolution binding patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpc_dns_resolution_binding(vpc_id:, id:, vpcdns_resolution_binding_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("vpcdns_resolution_binding_patch must be provided") if vpcdns_resolution_binding_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_vpc_dns_resolution_binding")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = vpcdns_resolution_binding_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/vpcs/%s/dns_resolution_bindings/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_vpc_routes(vpc_id:, zone_name: nil, start: nil, limit: nil)
    # List routes in a VPC's default routing table.
    # This request lists routes in the VPC's default routing table. Each route is
    #   zone-specific and directs any packets matching its destination CIDR block to a
    #   `next_hop` IP address. The most specific route matching a packet's destination
    #   will be used. If multiple equally-specific routes exist, traffic will be
    #   distributed across them.
    # @param vpc_id [String] The VPC identifier.
    # @param zone_name [String] Filters the collection to resources with a `zone.name` property matching the exact
    #   specified name.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpc_routes(vpc_id:, zone_name: nil, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpc_routes")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "zone.name" => zone_name,
        "start" => start,
        "limit" => limit
      }

      method_url = "/vpcs/%s/routes" % [ERB::Util.url_encode(vpc_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_vpc_route(vpc_id:, destination:, zone:, action: nil, advertise: nil, name: nil, next_hop: nil, priority: nil)
    # Create a route in a VPC's default routing table.
    # This request creates a new route in the VPC's default routing table. The route
    #   prototype object is structured in the same way as a retrieved route, and contains
    #   the information necessary to create the new route. The request will fail if the
    #   new route will cause a loop.
    # @param vpc_id [String] The VPC identifier.
    # @param destination [String] The destination CIDR of the route. The host identifier in the CIDR must be zero.
    #
    #   At most two routes per `zone` in a table can have the same `destination` and
    #   `priority`, and only if both routes have an `action` of `deliver` and the
    #   `next_hop` is an IP address.
    # @param zone [ZoneIdentity] The zone to apply the route to.
    #
    #   If subnets are attached to the route's routing table, egress traffic from those
    #   subnets in this zone will be subject to this route. If this route's routing table
    #   has any of `route_direct_link_ingress`, `route_internet_ingress`,
    #   `route_transit_gateway_ingress` or `route_vpc_zone_ingress`  set to`true`, traffic
    #   from those ingress sources arriving in this zone will be subject to this route.
    # @param action [String] The action to perform with a packet matching the route:
    #   - `delegate`: delegate to system-provided routes
    #   - `delegate_vpc`: delegate to system-provided routes, ignoring Internet-bound
    #   routes
    #   - `deliver`: deliver the packet to the specified `next_hop`
    #   - `drop`: drop the packet.
    # @param advertise [Boolean] Indicates whether this route will be advertised to the ingress sources specified
    #   by the `advertise_routes_to` routing table property.
    #
    #   All routes in a routing table with the same `destination` and `zone` must have the
    #   same
    #   `advertise` value.
    # @param name [String] The name for this route. The name must not be used by another route in the routing
    #   table. Names starting with `ibm-` are reserved for system-provided routes, and are
    #   not allowed. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param next_hop [RoutePrototypeNextHop] If `action` is `deliver`, the next hop that packets will be delivered to (must not
    #   be
    #   `0.0.0.0`). For other `action` values, it must be omitted or specified as
    #   `0.0.0.0`.
    #
    #   At most two routes per `zone` in a table can have the same `destination` and
    #   `priority`,
    #   and only when each route has an `action` of `deliver` and `next_hop` is an IP
    #   address.
    # @param priority [Fixnum] The priority of this route. Smaller values have higher priority.
    #
    #   If a routing table contains multiple routes with the same `zone` and
    #   `destination`, the route with the highest priority (smallest value) is selected.
    #   If two routes have the same `destination` and `priority`, traffic is distributed
    #   between them.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpc_route(vpc_id:, destination:, zone:, action: nil, advertise: nil, name: nil, next_hop: nil, priority: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("destination must be provided") if destination.nil?

      raise ArgumentError.new("zone must be provided") if zone.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_vpc_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "destination" => destination,
        "zone" => zone,
        "action" => action,
        "advertise" => advertise,
        "name" => name,
        "next_hop" => next_hop,
        "priority" => priority
      }

      method_url = "/vpcs/%s/routes" % [ERB::Util.url_encode(vpc_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpc_route(vpc_id:, id:)
    # Delete a VPC route.
    # This request deletes a route. This operation cannot be reversed.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The route identifier.
    # @return [nil]
    def delete_vpc_route(vpc_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpc_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/routes/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_vpc_route(vpc_id:, id:)
    # Retrieve a VPC route.
    # This request retrieves a single route specified by the identifier in the URL.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The route identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpc_route(vpc_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpc_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/routes/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_vpc_route(vpc_id:, id:, route_patch:)
    # Update a VPC route.
    # This request updates a route with the information in a provided route patch. The
    #   route patch object is structured in the same way as a retrieved route and contains
    #   only the information to be updated.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The route identifier.
    # @param route_patch [Hash] The route patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpc_route(vpc_id:, id:, route_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("route_patch must be provided") if route_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_vpc_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = route_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/vpcs/%s/routes/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_vpc_routing_tables(vpc_id:, start: nil, limit: nil, is_default: nil)
    # List routing tables for a VPC.
    # This request lists routing tables for a VPC. Each subnet in a VPC is associated
    #   with a routing table, which controls delivery of packets sent on that subnet
    #   according to the action of the most specific matching route in the table. If
    #   multiple equally-specific routes exist, traffic will be distributed across them.
    #   If no routes match, delivery will be controlled by the system's built-in routes.
    # @param vpc_id [String] The VPC identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param is_default [Boolean] Filters the collection to routing tables with an `is_default` property matching
    #   the specified value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpc_routing_tables(vpc_id:, start: nil, limit: nil, is_default: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpc_routing_tables")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "is_default" => is_default
      }

      method_url = "/vpcs/%s/routing_tables" % [ERB::Util.url_encode(vpc_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_vpc_routing_table(vpc_id:, accept_routes_from: nil, advertise_routes_to: nil, name: nil, route_direct_link_ingress: nil, route_internet_ingress: nil, route_transit_gateway_ingress: nil, route_vpc_zone_ingress: nil, routes: nil)
    # Create a routing table for a VPC.
    # This request creates a routing table from a routing table prototype object. The
    #   prototype object is structured in the same way as a retrieved routing table, and
    #   contains the information necessary to create the new routing table.
    # @param vpc_id [String] The VPC identifier.
    # @param accept_routes_from [Array[ResourceFilter]] The filters specifying the resources that may create routes in this routing table.
    # @param advertise_routes_to [Array[String]] The ingress sources to advertise routes to. Routes in the table with `advertise`
    #   enabled will be advertised to these sources.
    # @param name [String] The name for this routing table. The name must not be used by another routing
    #   table in the VPC. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param route_direct_link_ingress [Boolean] If set to `true`, this routing table will be used to route traffic that originates
    #   from [Direct Link](https://cloud.ibm.com/docs/dl) to this VPC. The VPC must not
    #   already have a routing table with this property set to `true`.
    #
    #   Incoming traffic will be routed according to the routing table with one exception:
    #   routes with an `action` of `deliver` are treated as `drop` unless the `next_hop`
    #   is an IP address in a subnet in the route's `zone` that is able to accept traffic.
    #   Therefore, if an incoming packet matches a route with a `next_hop` of a VPN
    #   gateway connection, the packet will be dropped.
    #
    #   If [Classic
    #   Access](https://cloud.ibm.com/docs/vpc?topic=vpc-setting-up-access-to-classic-infrastructure)
    #   is enabled for this VPC, and this property is set to `true`, its incoming traffic
    #   will also be routed according to this routing table.
    # @param route_internet_ingress [Boolean] If set to `true`, this routing table will be used to route traffic that originates
    #   from the internet. For this to succeed, the VPC must not already have a routing
    #   table with this property set to `true`.
    #
    #   Incoming traffic will be routed according to the routing table with two
    #   exceptions:
    #   - Traffic destined for IP addresses associated with public gateways will not be
    #     subject to routes in this routing table.
    #   - Routes with an `action` of `deliver` are treated as `drop` unless the `next_hop`
    #   is
    #     an IP address in a subnet in the route's `zone` that is able to accept traffic.
    #     Therefore, if an incoming packet matches a route with a `next_hop` of a VPN
    #   gateway
    #     connection, the packet will be dropped.
    # @param route_transit_gateway_ingress [Boolean] If set to `true`, this routing table will be used to route traffic that originates
    #   from [Transit Gateway](https://cloud.ibm.com/docs/transit-gateway) to this VPC.
    #   The VPC must not already have a routing table with this property set to `true`.
    #
    #   Incoming traffic will be routed according to the routing table with one exception:
    #   routes with an `action` of `deliver` are treated as `drop` unless the `next_hop`
    #   is an IP address in a subnet in the route's `zone` that is able to accept traffic.
    #   Therefore, if an incoming packet matches a route with a `next_hop` of a VPN
    #   gateway connection, the packet will be dropped.
    # @param route_vpc_zone_ingress [Boolean] If set to `true`, this routing table will be used to route traffic that originates
    #   from subnets in other zones in this VPC. The VPC must not already have a routing
    #   table with this property set to `true`.
    #
    #   Incoming traffic will be routed according to the routing table with one exception:
    #   routes with an `action` of `deliver` are treated as `drop` unless the `next_hop`
    #   is an IP address in a subnet in the route's `zone` that is able to accept traffic.
    #   Therefore, if an incoming packet matches a route with a `next_hop` of a VPN
    #   gateway connection, the packet will be dropped.
    # @param routes [Array[RoutePrototype]] The prototype objects for routes to create for this routing table. If unspecified,
    #   the routing table will be created with no routes.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpc_routing_table(vpc_id:, accept_routes_from: nil, advertise_routes_to: nil, name: nil, route_direct_link_ingress: nil, route_internet_ingress: nil, route_transit_gateway_ingress: nil, route_vpc_zone_ingress: nil, routes: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_vpc_routing_table")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "accept_routes_from" => accept_routes_from,
        "advertise_routes_to" => advertise_routes_to,
        "name" => name,
        "route_direct_link_ingress" => route_direct_link_ingress,
        "route_internet_ingress" => route_internet_ingress,
        "route_transit_gateway_ingress" => route_transit_gateway_ingress,
        "route_vpc_zone_ingress" => route_vpc_zone_ingress,
        "routes" => routes
      }

      method_url = "/vpcs/%s/routing_tables" % [ERB::Util.url_encode(vpc_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpc_routing_table(vpc_id:, id:, if_match: nil)
    # Delete a VPC routing table.
    # This request deletes a routing table.  A routing table cannot be deleted if it is
    #   associated with any subnets in the VPC. Additionally, a VPC's default routing
    #   table cannot be deleted. This operation cannot be reversed.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The routing table identifier.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value.
    # @return [nil]
    def delete_vpc_routing_table(vpc_id:, id:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpc_routing_table")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/routing_tables/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_vpc_routing_table(vpc_id:, id:)
    # Retrieve a VPC routing table.
    # This request retrieves a single routing table specified by the identifier in the
    #   URL.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The routing table identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpc_routing_table(vpc_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpc_routing_table")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/routing_tables/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_vpc_routing_table(vpc_id:, id:, routing_table_patch:, if_match: nil)
    # Update a VPC routing table.
    # This request updates a routing table with the information in a provided routing
    #   table patch. The patch object is structured in the same way as a retrieved table
    #   and contains only the information to be updated.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The routing table identifier.
    # @param routing_table_patch [Hash] The routing table patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpc_routing_table(vpc_id:, id:, routing_table_patch:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("routing_table_patch must be provided") if routing_table_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_vpc_routing_table")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = routing_table_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/vpcs/%s/routing_tables/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_vpc_routing_table_routes(vpc_id:, routing_table_id:, start: nil, limit: nil)
    # List routes in a VPC routing table.
    # This request lists routes in a VPC routing table. If subnets are associated with
    #   this routing table, delivery of packets sent on a subnet is performed according to
    #   the action of the most specific matching route in the table (provided the subnet
    #   and route are in the same zone). If multiple equally-specific routes exist, the
    #   route with the highest priority will be used. If two matching routes have the same
    #   destination and priority, traffic will be distributed between them. If no routes
    #   match, delivery will be controlled by the system's built-in routes.
    # @param vpc_id [String] The VPC identifier.
    # @param routing_table_id [String] The routing table identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpc_routing_table_routes(vpc_id:, routing_table_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("routing_table_id must be provided") if routing_table_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpc_routing_table_routes")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/vpcs/%s/routing_tables/%s/routes" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(routing_table_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_vpc_routing_table_route(vpc_id:, routing_table_id:, destination:, zone:, action: nil, advertise: nil, name: nil, next_hop: nil, priority: nil)
    # Create a route in a VPC routing table.
    # This request creates a new VPC route from a VPC route prototype object. The
    #   prototype object is structured in the same way as a retrieved VPC route and
    #   contains the information necessary to create the route.
    # @param vpc_id [String] The VPC identifier.
    # @param routing_table_id [String] The routing table identifier.
    # @param destination [String] The destination CIDR of the route. The host identifier in the CIDR must be zero.
    #
    #   At most two routes per `zone` in a table can have the same `destination` and
    #   `priority`, and only if both routes have an `action` of `deliver` and the
    #   `next_hop` is an IP address.
    # @param zone [ZoneIdentity] The zone to apply the route to.
    #
    #   If subnets are attached to the route's routing table, egress traffic from those
    #   subnets in this zone will be subject to this route. If this route's routing table
    #   has any of `route_direct_link_ingress`, `route_internet_ingress`,
    #   `route_transit_gateway_ingress` or `route_vpc_zone_ingress`  set to`true`, traffic
    #   from those ingress sources arriving in this zone will be subject to this route.
    # @param action [String] The action to perform with a packet matching the route:
    #   - `delegate`: delegate to system-provided routes
    #   - `delegate_vpc`: delegate to system-provided routes, ignoring Internet-bound
    #   routes
    #   - `deliver`: deliver the packet to the specified `next_hop`
    #   - `drop`: drop the packet.
    # @param advertise [Boolean] Indicates whether this route will be advertised to the ingress sources specified
    #   by the `advertise_routes_to` routing table property.
    #
    #   All routes in a routing table with the same `destination` and `zone` must have the
    #   same
    #   `advertise` value.
    # @param name [String] The name for this route. The name must not be used by another route in the routing
    #   table. Names starting with `ibm-` are reserved for system-provided routes, and are
    #   not allowed. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param next_hop [RoutePrototypeNextHop] If `action` is `deliver`, the next hop that packets will be delivered to (must not
    #   be
    #   `0.0.0.0`). For other `action` values, it must be omitted or specified as
    #   `0.0.0.0`.
    #
    #   At most two routes per `zone` in a table can have the same `destination` and
    #   `priority`,
    #   and only when each route has an `action` of `deliver` and `next_hop` is an IP
    #   address.
    # @param priority [Fixnum] The priority of this route. Smaller values have higher priority.
    #
    #   If a routing table contains multiple routes with the same `zone` and
    #   `destination`, the route with the highest priority (smallest value) is selected.
    #   If two routes have the same `destination` and `priority`, traffic is distributed
    #   between them.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpc_routing_table_route(vpc_id:, routing_table_id:, destination:, zone:, action: nil, advertise: nil, name: nil, next_hop: nil, priority: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("routing_table_id must be provided") if routing_table_id.nil?

      raise ArgumentError.new("destination must be provided") if destination.nil?

      raise ArgumentError.new("zone must be provided") if zone.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_vpc_routing_table_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "destination" => destination,
        "zone" => zone,
        "action" => action,
        "advertise" => advertise,
        "name" => name,
        "next_hop" => next_hop,
        "priority" => priority
      }

      method_url = "/vpcs/%s/routing_tables/%s/routes" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(routing_table_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpc_routing_table_route(vpc_id:, routing_table_id:, id:)
    # Delete a VPC routing table route.
    # This request deletes a VPC route. This operation cannot be reversed. Only VPC
    #   routes with an `origin` of `user` are allowed to be deleted.
    # @param vpc_id [String] The VPC identifier.
    # @param routing_table_id [String] The routing table identifier.
    # @param id [String] The VPC routing table route identifier.
    # @return [nil]
    def delete_vpc_routing_table_route(vpc_id:, routing_table_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("routing_table_id must be provided") if routing_table_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpc_routing_table_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/routing_tables/%s/routes/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(routing_table_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_vpc_routing_table_route(vpc_id:, routing_table_id:, id:)
    # Retrieve a VPC routing table route.
    # This request retrieves a single VPC route specified by the identifier in the URL
    #   path.
    # @param vpc_id [String] The VPC identifier.
    # @param routing_table_id [String] The routing table identifier.
    # @param id [String] The VPC routing table route identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpc_routing_table_route(vpc_id:, routing_table_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("routing_table_id must be provided") if routing_table_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpc_routing_table_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpcs/%s/routing_tables/%s/routes/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(routing_table_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_vpc_routing_table_route(vpc_id:, routing_table_id:, id:, route_patch:)
    # Update a VPC routing table route.
    # This request updates a VPC route with the information provided in a route patch
    #   object. The patch object is structured in the same way as a retrieved VPC route
    #   and needs to contain only the information to be updated. Only VPC routes with an
    #   `origin` of `user` are allowed to be updated.
    # @param vpc_id [String] The VPC identifier.
    # @param routing_table_id [String] The routing table identifier.
    # @param id [String] The VPC routing table route identifier.
    # @param route_patch [Hash] The VPC route patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpc_routing_table_route(vpc_id:, routing_table_id:, id:, route_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("routing_table_id must be provided") if routing_table_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("route_patch must be provided") if route_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_vpc_routing_table_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = route_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/vpcs/%s/routing_tables/%s/routes/%s" % [ERB::Util.url_encode(vpc_id), ERB::Util.url_encode(routing_table_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Subnets
    #########################

    ##
    # @!method list_subnets(start: nil, limit: nil, resource_group_id: nil, zone_name: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil, routing_table_id: nil, routing_table_name: nil)
    # List subnets.
    # This request lists subnets in the region. Subnets are contiguous ranges of IP
    #   addresses specified in CIDR block notation. Each subnet is within a particular
    #   zone and cannot span multiple zones or regions.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param zone_name [String] Filters the collection to resources with a `zone.name` property matching the exact
    #   specified name.
    # @param vpc_id [String] Filters the collection to resources with a `vpc.id` property matching the
    #   specified identifier.
    # @param vpc_crn [String] Filters the collection to resources with a `vpc.crn` property matching the
    #   specified CRN.
    # @param vpc_name [String] Filters the collection to resources with a `vpc.name` property matching the exact
    #   specified name.
    # @param routing_table_id [String] Filters the collection to subnets with a `routing_table.id` property matching the
    #   specified identifier.
    # @param routing_table_name [String] Filters the collection to subnets with a `routing_table.name` property matching
    #   the exact specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_subnets(start: nil, limit: nil, resource_group_id: nil, zone_name: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil, routing_table_id: nil, routing_table_name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_subnets")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "zone.name" => zone_name,
        "vpc.id" => vpc_id,
        "vpc.crn" => vpc_crn,
        "vpc.name" => vpc_name,
        "routing_table.id" => routing_table_id,
        "routing_table.name" => routing_table_name
      }

      method_url = "/subnets"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_subnet(subnet_prototype:)
    # Create a subnet.
    # This request creates a new subnet from a subnet prototype object. The prototype
    #   object is structured in the same way as a retrieved subnet, and contains the
    #   information necessary to create the new subnet. For this request to succeed, the
    #   prototype's CIDR block must not overlap with an existing subnet in the VPC.
    # @param subnet_prototype [SubnetPrototype] The subnet prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_subnet(subnet_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("subnet_prototype must be provided") if subnet_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_subnet")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = subnet_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/subnets"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_subnet(id:)
    # Delete a subnet.
    # This request deletes a subnet. This operation cannot be reversed. For this request
    #   to succeed, the subnet must not be referenced by any bare metal server network
    #   interfaces, instance network interfaces, virtual network interfaces, VPN gateways,
    #   or load balancers. A delete operation automatically detaches the subnet from any
    #   network ACLs, public gateways, or endpoint gateways. All flow log collectors with
    #   `auto_delete` set to `true` targeting the subnet or any resource in the subnet are
    #   automatically deleted.
    # @param id [String] The subnet identifier.
    # @return [nil]
    def delete_subnet(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_subnet")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/subnets/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_subnet(id:)
    # Retrieve a subnet.
    # This request retrieves a single subnet specified by the identifier in the URL.
    # @param id [String] The subnet identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_subnet(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_subnet")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/subnets/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_subnet(id:, subnet_patch:)
    # Update a subnet.
    # This request updates a subnet with the information in a provided subnet patch. The
    #   subnet patch object is structured in the same way as a retrieved subnet and
    #   contains only the information to be updated.
    # @param id [String] The subnet identifier.
    # @param subnet_patch [Hash] The subnet patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_subnet(id:, subnet_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("subnet_patch must be provided") if subnet_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_subnet")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = subnet_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/subnets/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_subnet_network_acl(id:)
    # Retrieve a subnet's attached network ACL.
    # This request retrieves the network ACL attached to the subnet specified by the
    #   identifier in the URL.
    # @param id [String] The subnet identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_subnet_network_acl(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_subnet_network_acl")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/subnets/%s/network_acl" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method replace_subnet_network_acl(id:, network_acl_identity:)
    # Replace the network ACL for a subnet.
    # This request replaces the existing network ACL for a subnet with the network ACL
    #   specified in the request body.
    # @param id [String] The subnet identifier.
    # @param network_acl_identity [NetworkACLIdentity] The network ACL identity.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def replace_subnet_network_acl(id:, network_acl_identity:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("network_acl_identity must be provided") if network_acl_identity.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "replace_subnet_network_acl")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = network_acl_identity
      headers["Content-Type"] = "application/json"

      method_url = "/subnets/%s/network_acl" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method unset_subnet_public_gateway(id:)
    # Detach a public gateway from a subnet.
    # This request detaches the public gateway from the subnet specified by the subnet
    #   identifier in the URL.
    # @param id [String] The subnet identifier.
    # @return [nil]
    def unset_subnet_public_gateway(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "unset_subnet_public_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/subnets/%s/public_gateway" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_subnet_public_gateway(id:)
    # Retrieve a subnet's attached public gateway.
    # This request retrieves the public gateway attached to the subnet specified by the
    #   identifier in the URL.
    # @param id [String] The subnet identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_subnet_public_gateway(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_subnet_public_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/subnets/%s/public_gateway" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method set_subnet_public_gateway(id:, public_gateway_identity:)
    # Attach a public gateway to a subnet.
    # This request attaches the public gateway, specified in the request body, to the
    #   subnet specified by the subnet identifier in the URL. The public gateway must have
    #   the same VPC and zone as the subnet.
    # @param id [String] The subnet identifier.
    # @param public_gateway_identity [PublicGatewayIdentity] The public gateway identity.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def set_subnet_public_gateway(id:, public_gateway_identity:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("public_gateway_identity must be provided") if public_gateway_identity.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "set_subnet_public_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = public_gateway_identity
      headers["Content-Type"] = "application/json"

      method_url = "/subnets/%s/public_gateway" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_subnet_routing_table(id:)
    # Retrieve a subnet's attached routing table.
    # This request retrieves the routing table attached to the subnet specified by the
    #   identifier in the URL.
    # @param id [String] The subnet identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_subnet_routing_table(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_subnet_routing_table")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/subnets/%s/routing_table" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method replace_subnet_routing_table(id:, routing_table_identity:)
    # Replace the routing table for a subnet.
    # This request replaces the existing routing table for a subnet with the routing
    #   table specified in the request body.
    #
    #   For this request to succeed, the routing table `route_direct_link_ingress`,
    #   `route_internet_ingress`, `route_transit_gateway_ingress`, and
    #   `route_vpc_zone_ingress` properties must be `false`.
    # @param id [String] The subnet identifier.
    # @param routing_table_identity [RoutingTableIdentity] The routing table identity.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def replace_subnet_routing_table(id:, routing_table_identity:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("routing_table_identity must be provided") if routing_table_identity.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "replace_subnet_routing_table")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = routing_table_identity
      headers["Content-Type"] = "application/json"

      method_url = "/subnets/%s/routing_table" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_subnet_reserved_ips(subnet_id:, start: nil, limit: nil, sort: nil, target_id: nil, target_crn: nil, target_name: nil, target_resource_type: nil)
    # List reserved IPs in a subnet.
    # This request lists reserved IPs in a subnet. A reserved IP resource will exist for
    #   every address in the subnet which is not available for use.
    # @param subnet_id [String] The subnet identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @param target_id [String] Filters the collection to resources with a `target.id` property matching the
    #   specified identifier.
    # @param target_crn [String] Filters the collection to resources with a `target.crn` property matching the
    #   specified CRN.
    # @param target_name [String] Filters the collection to resources with a `target.name` property matching the
    #   exact specified name.
    # @param target_resource_type [String] Filters the collection to resources with a `target.resource_type` property
    #   matching the specified value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_subnet_reserved_ips(subnet_id:, start: nil, limit: nil, sort: nil, target_id: nil, target_crn: nil, target_name: nil, target_resource_type: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("subnet_id must be provided") if subnet_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_subnet_reserved_ips")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "sort" => sort,
        "target.id" => target_id,
        "target.crn" => target_crn,
        "target.name" => target_name,
        "target.resource_type" => target_resource_type
      }

      method_url = "/subnets/%s/reserved_ips" % [ERB::Util.url_encode(subnet_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_subnet_reserved_ip(subnet_id:, address: nil, auto_delete: nil, name: nil, target: nil)
    # Reserve an IP in a subnet.
    # This request reserves an IP address in a subnet. If the provided prototype object
    #   includes an `address`, the address must not already be reserved.
    # @param subnet_id [String] The subnet identifier.
    # @param address [String] The IP address to reserve, which must not already be reserved on the subnet.
    #
    #   If unspecified, an available address on the subnet will automatically be selected.
    # @param auto_delete [Boolean] Indicates whether this reserved IP member will be automatically deleted when
    #   either
    #   `target` is deleted, or the reserved IP is unbound. Must be `false` if the
    #   reserved IP is unbound.
    # @param name [String] The name for this reserved IP. The name must not be used by another reserved IP in
    #   the subnet. Names starting with `ibm-` are reserved for provider-owned resources,
    #   and are not allowed. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param target [ReservedIPTargetPrototype] The target to bind this reserved IP to.  The target must be in the same VPC.
    #
    #   The following targets are supported:
    #   - An endpoint gateway not already bound to a reserved IP in the subnet's zone.
    #   - A virtual network interface.
    #
    #   If unspecified, the reserved IP will be created unbound.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_subnet_reserved_ip(subnet_id:, address: nil, auto_delete: nil, name: nil, target: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("subnet_id must be provided") if subnet_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_subnet_reserved_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "address" => address,
        "auto_delete" => auto_delete,
        "name" => name,
        "target" => target
      }

      method_url = "/subnets/%s/reserved_ips" % [ERB::Util.url_encode(subnet_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_subnet_reserved_ip(subnet_id:, id:)
    # Delete a reserved IP.
    # This request releases a reserved IP. This operation cannot be reversed.
    #
    #   For this request to succeed, the reserved IP must not be required by another
    #   resource, such as a bare metal server network interface, instance network
    #   interface or virtual network interface for which it is the primary IP. A
    #   provider-owned reserved IP is not allowed to be deleted.
    # @param subnet_id [String] The subnet identifier.
    # @param id [String] The reserved IP identifier.
    # @return [nil]
    def delete_subnet_reserved_ip(subnet_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("subnet_id must be provided") if subnet_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_subnet_reserved_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/subnets/%s/reserved_ips/%s" % [ERB::Util.url_encode(subnet_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_subnet_reserved_ip(subnet_id:, id:)
    # Retrieve a reserved IP.
    # This request retrieves a single reserved IP specified by the identifier in the
    #   URL.
    # @param subnet_id [String] The subnet identifier.
    # @param id [String] The reserved IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_subnet_reserved_ip(subnet_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("subnet_id must be provided") if subnet_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_subnet_reserved_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/subnets/%s/reserved_ips/%s" % [ERB::Util.url_encode(subnet_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_subnet_reserved_ip(subnet_id:, id:, reserved_ip_patch:)
    # Update a reserved IP.
    # This request updates a reserved IP with the information in a provided reserved IP
    #   patch. The reserved IP patch object is structured in the same way as a retrieved
    #   reserved IP and contains only the information to be updated.
    #
    #   A provider-owned reserved IP is not allowed to be updated.
    # @param subnet_id [String] The subnet identifier.
    # @param id [String] The reserved IP identifier.
    # @param reserved_ip_patch [Hash] The reserved IP patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_subnet_reserved_ip(subnet_id:, id:, reserved_ip_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("subnet_id must be provided") if subnet_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("reserved_ip_patch must be provided") if reserved_ip_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_subnet_reserved_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = reserved_ip_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/subnets/%s/reserved_ips/%s" % [ERB::Util.url_encode(subnet_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Images
    #########################

    ##
    # @!method list_images(start: nil, limit: nil, resource_group_id: nil, name: nil, status: nil, visibility: nil, user_data_format: nil)
    # List images.
    # This request lists images available in the region. An image provides source data
    #   for a volume. Images are either system-provided, or created from another source,
    #   such as importing from Cloud Object Storage.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param status [Array[String]] Filters the collection to images with a `status` property matching one of the
    #   specified comma-separated values.
    # @param visibility [String] Filters the collection to images with a `visibility` property matching the
    #   specified value.
    # @param user_data_format [Array[String]] Filters the collection to images with a `user_data_format` property matching one
    #   of the specified comma-separated values.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_images(start: nil, limit: nil, resource_group_id: nil, name: nil, status: nil, visibility: nil, user_data_format: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_images")
      headers.merge!(sdk_headers)
      status *= "," unless status.nil?
      user_data_format *= "," unless user_data_format.nil?

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "name" => name,
        "status" => status,
        "visibility" => visibility,
        "user_data_format" => user_data_format
      }

      method_url = "/images"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_image(image_prototype:)
    # Create an image.
    # This request creates a new image from an image prototype object. The prototype
    #   object is structured in the same way as a retrieved image, and contains the
    #   information necessary to create the new image. If an image is being imported, a
    #   URL to the image file on object storage must be specified. If an image is being
    #   created from an existing volume, that volume must be specified.
    # @param image_prototype [ImagePrototype] The image prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_image(image_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("image_prototype must be provided") if image_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_image")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = image_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/images"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_image(id:)
    # Delete an image.
    # This request deletes an image. Any active image export jobs will be completed
    #   first. This operation cannot be reversed. A system-provided image is not allowed
    #   to be deleted. Additionally, an image cannot be deleted if it:
    #   - has a `status` of `deleting`
    #   - has a `status` of `pending` with a `status_reasons` code of
    #   `image_request_in_progress`
    #   - has `catalog_offering.managed` set to `true`.
    # @param id [String] The image identifier.
    # @return [nil]
    def delete_image(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_image")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/images/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_image(id:)
    # Retrieve an image.
    # This request retrieves a single image specified by the identifier in the URL.
    # @param id [String] The image identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_image(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_image")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/images/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_image(id:, image_patch:)
    # Update an image.
    # This request updates an image with the information in a provided image patch. The
    #   image patch object is structured in the same way as a retrieved image and contains
    #   only the information to be updated. A system-provided image is not allowed to be
    #   updated. An image with a `status` of `deleting` cannot be updated.
    # @param id [String] The image identifier.
    # @param image_patch [Hash] The image patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_image(id:, image_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("image_patch must be provided") if image_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_image")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = image_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/images/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method deprecate_image(id:)
    # Deprecate an image.
    # This request deprecates an image, resulting in its `status` becoming `deprecated`
    #   and
    #   `deprecation_at` being set to the current date and time.
    #
    #   The image must:
    #   - have a `status` of `available`
    #   - have `catalog_offering.managed` set to `false`
    #   - not have `deprecation_at` set
    #
    #   The image must not have `deprecation_at` set, must have `catalog_offering.managed`
    #   set to
    #   `false`, and must have a `status` of `available`.
    #
    #   A system-provided image is not allowed to be deprecated.
    # @param id [String] The image identifier.
    # @return [nil]
    def deprecate_image(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "deprecate_image")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/images/%s/deprecate" % [ERB::Util.url_encode(id)]

      request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method obsolete_image(id:)
    # Obsolete an image.
    # This request obsoletes an image, resulting in its `status` becoming `obsolete` and
    #   `obsolescence_at` being set to the current date and time.
    #
    #   The image must:
    #   - have a `status` of `available` or `deprecated`
    #   - have `catalog_offering.managed` set to `false`
    #   - not have `deprecation_at` set in the future
    #   - not have `obsolescence_at` set
    #
    #   A system-provided image is not allowed to be obsoleted.
    # @param id [String] The image identifier.
    # @return [nil]
    def obsolete_image(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "obsolete_image")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/images/%s/obsolete" % [ERB::Util.url_encode(id)]

      request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method list_image_export_jobs(image_id:, name: nil)
    # List export jobs for an image.
    # This request lists export jobs for an image. Each job tracks the exporting of the
    #   image to another location, such as a bucket within cloud object storage.
    #
    #   The jobs will be sorted by their `created_at` property values, with newest jobs
    #   first. Jobs with identical `created_at` property values will in turn be sorted by
    #   ascending
    #   `name` property values.
    # @param image_id [String] The image identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_image_export_jobs(image_id:, name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("image_id must be provided") if image_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_image_export_jobs")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "name" => name
      }

      method_url = "/images/%s/export_jobs" % [ERB::Util.url_encode(image_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_image_export_job(image_id:, storage_bucket:, format: nil, name: nil)
    # Create an export job for an image.
    # This request creates and queues a new export job for the image specified in the
    #   URL using the image export job prototype object. The image must be owned by the
    #   account and be in the `available`, `deprecated`, `obsolete`, or `unusable` state.
    #   The prototype object is structured in the same way as a retrieved image export
    #   job, and contains the information necessary to create and queue the new image
    #   export job.
    # @param image_id [String] The image identifier.
    # @param storage_bucket [CloudObjectStorageBucketIdentity] The Cloud Object Storage bucket to export the image to. The bucket must exist and
    #   an IAM
    #   service authorization must grant `Image Service for VPC` of
    #   `VPC Infrastructure Services` writer access to the bucket.
    # @param format [String] The format to use for the exported image. If the image is encrypted, only `qcow2`
    #   is supported.
    # @param name [String] The name for this image export job. The name must not be used by another export
    #   job for the image. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words prefixed with the first 16 characters of the parent image
    #   name.
    #
    #   The exported image object name in Cloud Object Storage (`storage_object.name` in
    #   the response) will be based on this name. The object name will be unique within
    #   the bucket.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_image_export_job(image_id:, storage_bucket:, format: nil, name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("image_id must be provided") if image_id.nil?

      raise ArgumentError.new("storage_bucket must be provided") if storage_bucket.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_image_export_job")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "storage_bucket" => storage_bucket,
        "format" => format,
        "name" => name
      }

      method_url = "/images/%s/export_jobs" % [ERB::Util.url_encode(image_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_image_export_job(image_id:, id:)
    # Delete an image export job.
    # This request deletes an image export job. This operation cannot be reversed. If
    #   the job has not completed, the job will be canceled, and the incomplete exported
    #   image object deleted. If the job has completed, the exported image object will not
    #   be deleted.
    # @param image_id [String] The image identifier.
    # @param id [String] The image export job identifier.
    # @return [nil]
    def delete_image_export_job(image_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("image_id must be provided") if image_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_image_export_job")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/images/%s/export_jobs/%s" % [ERB::Util.url_encode(image_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_image_export_job(image_id:, id:)
    # Retrieve an image export job.
    # This request retrieves a single image export job specified by the identifier in
    #   the URL.
    # @param image_id [String] The image identifier.
    # @param id [String] The image export job identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_image_export_job(image_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("image_id must be provided") if image_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_image_export_job")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/images/%s/export_jobs/%s" % [ERB::Util.url_encode(image_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_image_export_job(image_id:, id:, image_export_job_patch:)
    # Update an image export job.
    # This request updates an image export job with the information in a provided image
    #   export job patch. The image export job patch object is structured in the same way
    #   as a retrieved image export job and contains only the information to be updated.
    # @param image_id [String] The image identifier.
    # @param id [String] The image export job identifier.
    # @param image_export_job_patch [Hash] The image export job patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_image_export_job(image_id:, id:, image_export_job_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("image_id must be provided") if image_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("image_export_job_patch must be provided") if image_export_job_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_image_export_job")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = image_export_job_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/images/%s/export_jobs/%s" % [ERB::Util.url_encode(image_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_operating_systems(start: nil, limit: nil)
    # List operating systems.
    # This request lists operating systems in the region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_operating_systems(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_operating_systems")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/operating_systems"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_operating_system(name:)
    # Retrieve an operating system.
    # This request retrieves a single operating system specified by the name in the URL.
    # @param name [String] The operating system name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_operating_system(name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("name must be provided") if name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_operating_system")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/operating_systems/%s" % [ERB::Util.url_encode(name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end
    #########################
    # Keys
    #########################

    ##
    # @!method list_keys(start: nil, limit: nil)
    # List keys.
    # This request lists keys in the region. A key contains a public SSH key which may
    #   be installed on instances when they are created. Private keys are not stored.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_keys(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_keys")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/keys"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_key(public_key:, name: nil, resource_group: nil, type: nil)
    # Create a key.
    # This request creates a new SSH key from an key prototype object. The prototype
    #   object is structured in the same way as a retrieved key, and contains the
    #   information necessary to create the new key. The public key value must be
    #   provided.
    # @param public_key [String] A unique public SSH key to import, in OpenSSH format (consisting of three
    #   space-separated fields: the algorithm name, base64-encoded key, and a comment).
    #   The algorithm and comment fields may be omitted, as only the key field is
    #   imported.
    #
    #   Keys of type `rsa` may be 2048 or 4096 bits in length, however 4096 is
    #   recommended. Keys of type `ed25519` are 256 bits in length.
    # @param name [String] The name for this key. The name must not be used by another key in the region. If
    #   unspecified, the name will be a hyphenated list of randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @param type [String] The crypto-system used by this key.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_key(public_key:, name: nil, resource_group: nil, type: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("public_key must be provided") if public_key.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_key")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "public_key" => public_key,
        "name" => name,
        "resource_group" => resource_group,
        "type" => type
      }

      method_url = "/keys"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_key(id:)
    # Delete a key.
    # This request deletes a key. This operation cannot be reversed.
    # @param id [String] The key identifier.
    # @return [nil]
    def delete_key(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_key")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/keys/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_key(id:)
    # Retrieve a key.
    # This request retrieves a single key specified by the identifier in the URL.
    # @param id [String] The key identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_key(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_key")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/keys/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_key(id:, key_patch:)
    # Update a key.
    # This request updates a key's name.
    # @param id [String] The key identifier.
    # @param key_patch [Hash] The key patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_key(id:, key_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("key_patch must be provided") if key_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_key")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = key_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/keys/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Instances
    #########################

    ##
    # @!method list_instance_profiles
    # List instance profiles.
    # This request lists provisionable [instance
    #   profiles](https://cloud.ibm.com/docs/vpc?topic=vpc-profiles) in the region. An
    #   instance profile specifies the performance characteristics and pricing model for
    #   an instance.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_profiles
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_profiles")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance/profiles"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_instance_profile(name:)
    # Retrieve an instance profile.
    # This request retrieves a single instance profile specified by the name in the URL.
    # @param name [String] The instance profile name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_profile(name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("name must be provided") if name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_profile")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance/profiles/%s" % [ERB::Util.url_encode(name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_instance_templates
    # List instance templates.
    # This request lists instance templates in the region.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_templates
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_templates")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance/templates"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance_template(instance_template_prototype:)
    # Create an instance template.
    # This request creates a new instance template. The prototype object is structured
    #   in the same way as a retrieved instance template, and contains the information
    #   necessary to provision a new instance from the template.
    #
    #   If a `source_template` is specified in the prototype object, its contents are
    #   copied into the new template prior to copying any other properties provided in the
    #   prototype object.
    # @param instance_template_prototype [InstanceTemplatePrototype] The instance template prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_template(instance_template_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_template_prototype must be provided") if instance_template_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance_template")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_template_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/instance/templates"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_template(id:)
    # Delete an instance template.
    # This request deletes the instance template. This operation cannot be reversed.
    # @param id [String] The instance template identifier.
    # @return [nil]
    def delete_instance_template(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_template")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance/templates/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance_template(id:)
    # Retrieve an instance template.
    # This request retrieves a single instance template specified by the identifier in
    #   the URL.
    # @param id [String] The instance template identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_template(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_template")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance/templates/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance_template(id:, instance_template_patch:)
    # Update an instance template.
    # This request updates an instance template with the information provided in the
    #   instance template patch. The instance template patch object is structured in the
    #   same way as a retrieved instance template and contains only the information to be
    #   updated.
    # @param id [String] The instance template identifier.
    # @param instance_template_patch [Hash] The instance template patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance_template(id:, instance_template_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("instance_template_patch must be provided") if instance_template_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance_template")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_template_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instance/templates/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_instances(start: nil, limit: nil, resource_group_id: nil, name: nil, dedicated_host_id: nil, dedicated_host_crn: nil, dedicated_host_name: nil, placement_group_id: nil, placement_group_crn: nil, placement_group_name: nil, reservation_id: nil, reservation_crn: nil, reservation_name: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil)
    # List instances.
    # This request lists instances in the region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param dedicated_host_id [String] Filters the collection to resources with a `dedicated_host.id` property matching
    #   the specified identifier.
    # @param dedicated_host_crn [String] Filters the collection to resources with a `dedicated_host.crn` property matching
    #   the specified CRN.
    # @param dedicated_host_name [String] Filters the collection to resources with a `dedicated_host.name` property matching
    #   the exact specified name.
    # @param placement_group_id [String] Filters the collection to resources with a `placement_target.id` property matching
    #   the specified placement group identifier.
    # @param placement_group_crn [String] Filters the collection to resources with a `placement_target.crn` property
    #   matching the specified placement group CRN.
    # @param placement_group_name [String] Filters the collection to resources with a `placement_target.name` property
    #   matching the exact specified placement group name.
    # @param reservation_id [String] Filters the collection to resources with a `reservation.id` property matching the
    #   specified identifier.
    # @param reservation_crn [String] Filters the collection to resources with a `reservation.crn` property matching the
    #   specified identifier.
    # @param reservation_name [String] Filters the collection to resources with a `reservation.name` property matching
    #   the specified identifier.
    # @param vpc_id [String] Filters the collection to resources with a `vpc.id` property matching the
    #   specified identifier.
    # @param vpc_crn [String] Filters the collection to resources with a `vpc.crn` property matching the
    #   specified CRN.
    # @param vpc_name [String] Filters the collection to resources with a `vpc.name` property matching the exact
    #   specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instances(start: nil, limit: nil, resource_group_id: nil, name: nil, dedicated_host_id: nil, dedicated_host_crn: nil, dedicated_host_name: nil, placement_group_id: nil, placement_group_crn: nil, placement_group_name: nil, reservation_id: nil, reservation_crn: nil, reservation_name: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instances")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "name" => name,
        "dedicated_host.id" => dedicated_host_id,
        "dedicated_host.crn" => dedicated_host_crn,
        "dedicated_host.name" => dedicated_host_name,
        "placement_group.id" => placement_group_id,
        "placement_group.crn" => placement_group_crn,
        "placement_group.name" => placement_group_name,
        "reservation.id" => reservation_id,
        "reservation.crn" => reservation_crn,
        "reservation.name" => reservation_name,
        "vpc.id" => vpc_id,
        "vpc.crn" => vpc_crn,
        "vpc.name" => vpc_name
      }

      method_url = "/instances"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance(instance_prototype:)
    # Create an instance.
    # This request provisions a new instance from an instance prototype object. The
    #   prototype object is structured in the same way as a retrieved instance, and
    #   contains the information necessary to provision the new instance. The instance is
    #   automatically started.
    # @param instance_prototype [InstancePrototype] The instance prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance(instance_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_prototype must be provided") if instance_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/instances"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance(id:, if_match: nil)
    # Delete an instance.
    # This request deletes an instance. This operation cannot be reversed. Any floating
    #   IPs associated with instance network interfaces are implicitly disassociated. All
    #   virtual network interfaces with `auto_delete` set to `true` targeting instance
    #   network attachments on the instance are automatically deleted. All flow log
    #   collectors with
    #   `auto_delete` set to `true` targeting the instance, the instance network
    #   attachments, the instance network interfaces, or the automatically deleted virtual
    #   network interfaces are automatically deleted.
    # @param id [String] The virtual server instance identifier.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value.
    # @return [nil]
    def delete_instance(id:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance(id:)
    # Retrieve an instance.
    # This request retrieves a single instance specified by the identifier in the URL.
    # @param id [String] The virtual server instance identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance(id:, instance_patch:, if_match: nil)
    # Update an instance.
    # This request updates an instance with the information in a provided instance
    #   patch. The instance patch object is structured in the same way as a retrieved
    #   instance and contains only the information to be updated.
    # @param id [String] The virtual server instance identifier.
    # @param instance_patch [Hash] The instance patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance(id:, instance_patch:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("instance_patch must be provided") if instance_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instances/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_instance_initialization(id:)
    # Retrieve initialization configuration for an instance.
    # This request retrieves configuration used to initialize the instance, such as SSH
    #   keys and the Windows administrator password. These can subsequently be changed on
    #   the instance and therefore may not be current.
    # @param id [String] The instance identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_initialization(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_initialization")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/initialization" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance_action(instance_id:, type:, force: nil)
    # Create an instance action.
    # This request creates a new action which will be queued up to run as soon as any
    #   pending or running actions have completed.
    # @param instance_id [String] The virtual server instance identifier.
    # @param type [String] The type of action.
    # @param force [Boolean] If set to true, the action will be forced immediately, and all queued actions
    #   deleted. Ignored for the start action.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_action(instance_id:, type:, force: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("type must be provided") if type.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance_action")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "type" => type,
        "force" => force
      }

      method_url = "/instances/%s/actions" % [ERB::Util.url_encode(instance_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance_console_access_token(instance_id:, console_type:, force: nil)
    # Create a console access token for an instance.
    # This request creates a new single-use console access token for an instance. All
    #   console configuration is provided at token create time, and the token is
    #   subsequently used in the `access_token` query parameter for the WebSocket request.
    #    The access token is only valid for a short period of time, and a maximum of one
    #   token is valid for a given instance at a time.
    # @param instance_id [String] The virtual server instance identifier.
    # @param console_type [String] The instance console type for which this token may be used.
    # @param force [Boolean] Indicates whether to disconnect an existing serial console session as the serial
    #   console cannot be shared.  This has no effect on VNC consoles.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_console_access_token(instance_id:, console_type:, force: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("console_type must be provided") if console_type.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance_console_access_token")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "console_type" => console_type,
        "force" => force
      }

      method_url = "/instances/%s/console_access_token" % [ERB::Util.url_encode(instance_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_instance_disks(instance_id:)
    # List disks on an instance.
    # This request lists disks on an instance.  A disk is a block device that is locally
    #   attached to the instance's physical host and is also referred to as instance
    #   storage. By default, the listed disks are sorted by their `created_at` property
    #   values, with the newest disk first.
    # @param instance_id [String] The virtual server instance identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_disks(instance_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_disks")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/disks" % [ERB::Util.url_encode(instance_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_instance_disk(instance_id:, id:)
    # Retrieve an instance disk.
    # This request retrieves a single instance disk specified by the identifier in the
    #   URL.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The instance disk identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_disk(instance_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_disk")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/disks/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance_disk(instance_id:, id:, instance_disk_patch:)
    # Update an instance disk.
    # This request updates the instance disk with the information in a provided patch.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The instance disk identifier.
    # @param instance_disk_patch [Hash] The instance disk patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance_disk(instance_id:, id:, instance_disk_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("instance_disk_patch must be provided") if instance_disk_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance_disk")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_disk_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instances/%s/disks/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_instance_network_attachments(instance_id:)
    # List network attachments on an instance.
    # This request lists network attachments on an instance. A network attachment
    #   represents a device on the instance to which a virtual network interface is
    #   attached.
    #
    #   The network attachments will be sorted by their `created_at` property values, with
    #   newest network attachments first. Network attachments with identical `created_at`
    #   property values will in turn be sorted by ascending `name` property values.
    # @param instance_id [String] The virtual server instance identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_network_attachments(instance_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_network_attachments")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_attachments" % [ERB::Util.url_encode(instance_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance_network_attachment(instance_id:, virtual_network_interface:, name: nil)
    # Create a network attachment on an instance.
    # This request creates a new instance network attachment from an instance network
    #   attachment prototype object. The prototype object is structured in the same way as
    #   a retrieved instance network attachment, and contains the information necessary to
    #   create the new instance network attachment.
    # @param instance_id [String] The virtual server instance identifier.
    # @param virtual_network_interface [InstanceNetworkAttachmentPrototypeVirtualNetworkInterface] A virtual network interface for the instance network attachment. This can be
    #   specified
    #   using an existing virtual network interface, or a prototype object for a new
    #   virtual
    #   network interface.
    #
    #   If an existing virtual network interface is specified, `enable_infrastructure_nat`
    #   must be
    #   `true`.
    # @param name [String] The name for this network attachment. Names must be unique within the instance the
    #   network attachment resides in. If unspecified, the name will be a hyphenated list
    #   of randomly-selected words.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_network_attachment(instance_id:, virtual_network_interface:, name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("virtual_network_interface must be provided") if virtual_network_interface.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance_network_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "virtual_network_interface" => virtual_network_interface,
        "name" => name
      }

      method_url = "/instances/%s/network_attachments" % [ERB::Util.url_encode(instance_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_network_attachment(instance_id:, id:)
    # Delete an instance network attachment.
    # This request deletes an instance network attachment. This operation cannot be
    #   reversed. Any floating IPs associated with the instance network attachment are
    #   implicitly disassociated. All flow log collectors with `auto_delete` set to `true`
    #   targeting the instance network attachment are automatically deleted. The primary
    #   instance network attachment is not allowed to be deleted.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The instance network attachment identifier.
    # @return [nil]
    def delete_instance_network_attachment(instance_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_network_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_attachments/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance_network_attachment(instance_id:, id:)
    # Retrieve an instance network attachment.
    # This request retrieves a single instance network attachment specified by the
    #   identifier in the URL.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The instance network attachment identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_network_attachment(instance_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_network_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_attachments/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance_network_attachment(instance_id:, id:, instance_network_attachment_patch:)
    # Update an instance network attachment.
    # This request updates an instance network attachment with the information provided
    #   in an instance network interface patch object. The instance network attachment
    #   patch object is structured in the same way as a retrieved instance network
    #   attachment and needs to contain only the information to be updated.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The instance network attachment identifier.
    # @param instance_network_attachment_patch [Hash] The instance network attachment patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance_network_attachment(instance_id:, id:, instance_network_attachment_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("instance_network_attachment_patch must be provided") if instance_network_attachment_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance_network_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_network_attachment_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instances/%s/network_attachments/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_instance_network_interfaces(instance_id:)
    # List network interfaces on an instance.
    # This request lists network interfaces on an instance. An instance network
    #   interface is an abstract representation of a network device and attaches an
    #   instance to a single subnet. Each network interface on an instance can attach to
    #   any subnet in the zone, including subnets that are already attached to the
    #   instance. Multiple network interfaces on the instance may also attach to the same
    #   subnet.
    #
    #   If this instance has network attachments, each returned network interface is a
    #   [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface.
    # @param instance_id [String] The virtual server instance identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_network_interfaces(instance_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_network_interfaces")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_interfaces" % [ERB::Util.url_encode(instance_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance_network_interface(instance_id:, subnet:, allow_ip_spoofing: nil, name: nil, primary_ip: nil, security_groups: nil)
    # Create a network interface on an instance.
    # This request creates a new instance network interface from an instance network
    #   interface prototype object. The prototype object is structured in the same way as
    #   a retrieved instance network interface, and contains the information necessary to
    #   create the new instance network interface. Any subnet in the instance's VPC may be
    #   specified. Addresses on the instance network interface must be within the
    #   specified subnet's CIDR blocks.
    #
    #   If this instance has network attachments, each network interface is a [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface, and new network interfaces are not allowed to be created.
    # @param instance_id [String] The virtual server instance identifier.
    # @param subnet [SubnetIdentity] The associated subnet.
    # @param allow_ip_spoofing [Boolean] Indicates whether source IP spoofing is allowed on this instance network
    #   interface.
    #
    #   If this instance has network attachments, this network interface is a
    #   [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface, and source IP spoofing is managed on the attached virtual network
    #   interface.
    # @param name [String] The name for the instance network interface. The name must not be used by another
    #   network interface on the virtual server instance. If unspecified, the name will be
    #   a hyphenated list of randomly-selected words.
    # @param primary_ip [NetworkInterfaceIPPrototype] The primary IP address to bind to the instance network interface. This can be
    #   specified using an existing reserved IP, or a prototype object for a new reserved
    #   IP.
    #
    #   If an existing reserved IP or a prototype object with an address is specified, it
    #   must
    #   be available on the instance network interface's subnet. Otherwise, an
    #   available address on the subnet will be automatically selected and reserved.
    # @param security_groups [Array[SecurityGroupIdentity]] The security groups to use for this instance network interface. If unspecified,
    #   the VPC's default security group is used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_network_interface(instance_id:, subnet:, allow_ip_spoofing: nil, name: nil, primary_ip: nil, security_groups: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("subnet must be provided") if subnet.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "subnet" => subnet,
        "allow_ip_spoofing" => allow_ip_spoofing,
        "name" => name,
        "primary_ip" => primary_ip,
        "security_groups" => security_groups
      }

      method_url = "/instances/%s/network_interfaces" % [ERB::Util.url_encode(instance_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_network_interface(instance_id:, id:)
    # Delete an instance network interface.
    # This request deletes an instance network interface. This operation cannot be
    #   reversed. Any floating IPs associated with the instance network interface are
    #   implicitly disassociated. All flow log collectors with `auto_delete` set to `true`
    #   targeting the instance network interface are automatically deleted. The primary
    #   instance network interface is not allowed to be deleted.
    #
    #   If this instance has network attachments, this network interface is a [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface, and is not allowed to be deleted.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The instance network interface identifier.
    # @return [nil]
    def delete_instance_network_interface(instance_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_interfaces/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance_network_interface(instance_id:, id:)
    # Retrieve an instance network interface.
    # This request retrieves a single instance network interface specified by the
    #   identifier in the URL.
    #
    #   If this instance has network attachments, the retrieved network interface is a
    #   [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The instance network interface identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_network_interface(instance_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_interfaces/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance_network_interface(instance_id:, id:, network_interface_patch:)
    # Update an instance network interface.
    # This request updates an instance network interface with the information provided
    #   in an instance network interface patch object. The instance network interface
    #   patch object is structured in the same way as a retrieved instance network
    #   interface and needs to contain only the information to be updated.
    #
    #   If this instance has network attachments, this network interface is a [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface, and is not allowed to be updated.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The instance network interface identifier.
    # @param network_interface_patch [Hash] The instance network interface patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance_network_interface(instance_id:, id:, network_interface_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("network_interface_patch must be provided") if network_interface_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = network_interface_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instances/%s/network_interfaces/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_instance_network_interface_floating_ips(instance_id:, network_interface_id:)
    # List floating IPs associated with an instance network interface.
    # This request lists floating IPs associated with an instance network interface.
    # @param instance_id [String] The virtual server instance identifier.
    # @param network_interface_id [String] The instance network interface identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_network_interface_floating_ips(instance_id:, network_interface_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_network_interface_floating_ips")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_interfaces/%s/floating_ips" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(network_interface_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method remove_instance_network_interface_floating_ip(instance_id:, network_interface_id:, id:)
    # Disassociate a floating IP from an instance network interface.
    # This request disassociates the specified floating IP from the specified instance
    #   network interface.
    # @param instance_id [String] The virtual server instance identifier.
    # @param network_interface_id [String] The instance network interface identifier.
    # @param id [String] The floating IP identifier.
    # @return [nil]
    def remove_instance_network_interface_floating_ip(instance_id:, network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "remove_instance_network_interface_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_interfaces/%s/floating_ips/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(network_interface_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance_network_interface_floating_ip(instance_id:, network_interface_id:, id:)
    # Retrieve associated floating IP.
    # This request retrieves a specified floating IP address if it is associated with
    #   the instance network interface and instance specified in the URL.
    # @param instance_id [String] The virtual server instance identifier.
    # @param network_interface_id [String] The instance network interface identifier.
    # @param id [String] The floating IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_network_interface_floating_ip(instance_id:, network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_network_interface_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_interfaces/%s/floating_ips/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(network_interface_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method add_instance_network_interface_floating_ip(instance_id:, network_interface_id:, id:)
    # Associate a floating IP with an instance network interface.
    # This request associates the specified floating IP with the specified instance
    #   network interface, replacing any existing association.
    #
    #   The existing floating IP must:
    #   - not be required by another resource, such as a public gateway
    #   - be in the same `zone` as the instance
    #
    #   A request body is not required, and if provided, is ignored.
    # @param instance_id [String] The virtual server instance identifier.
    # @param network_interface_id [String] The instance network interface identifier.
    # @param id [String] The floating IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def add_instance_network_interface_floating_ip(instance_id:, network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "add_instance_network_interface_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_interfaces/%s/floating_ips/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(network_interface_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_instance_network_interface_ips(instance_id:, network_interface_id:, start: nil, limit: nil)
    # List the primary reserved IP for an instance network interface.
    # This request lists the primary reserved IP for an instance network interface.
    # @param instance_id [String] The virtual server instance identifier.
    # @param network_interface_id [String] The instance network interface identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_network_interface_ips(instance_id:, network_interface_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_network_interface_ips")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/instances/%s/network_interfaces/%s/ips" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(network_interface_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_instance_network_interface_ip(instance_id:, network_interface_id:, id:)
    # Retrieve the primary reserved IP.
    # This request retrieves the primary reserved IP for an instance network interface.
    # @param instance_id [String] The virtual server instance identifier.
    # @param network_interface_id [String] The instance network interface identifier.
    # @param id [String] The reserved IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_network_interface_ip(instance_id:, network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_network_interface_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/network_interfaces/%s/ips/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(network_interface_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_instance_volume_attachments(instance_id:)
    # List volumes attachments on an instance.
    # This request lists volume attachments on an instance. A volume attachment connects
    #   a volume to an instance. Each instance may have many volume attachments but each
    #   volume attachment connects exactly one instance to exactly one volume.
    # @param instance_id [String] The virtual server instance identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_volume_attachments(instance_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_volume_attachments")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/volume_attachments" % [ERB::Util.url_encode(instance_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance_volume_attachment(instance_id:, volume:, delete_volume_on_instance_delete: nil, name: nil)
    # Create a volume attachment on an instance.
    # This request creates a new volume attachment from a volume attachment prototype
    #   object, connecting a volume to an instance. For this request to succeed, the
    #   specified volume must not be busy. The prototype object is structured in the same
    #   way as a retrieved volume attachment, and contains the information necessary to
    #   create the new volume attachment.
    # @param instance_id [String] The virtual server instance identifier.
    # @param volume [VolumeAttachmentPrototypeVolume] An existing volume to attach to the instance, or a prototype object for a new
    #   volume.
    # @param delete_volume_on_instance_delete [Boolean] Indicates whether deleting the instance will also delete the attached volume.
    # @param name [String] The name for this volume attachment. The name must not be used by another volume
    #   attachment on the instance. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_volume_attachment(instance_id:, volume:, delete_volume_on_instance_delete: nil, name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("volume must be provided") if volume.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance_volume_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "volume" => volume,
        "delete_volume_on_instance_delete" => delete_volume_on_instance_delete,
        "name" => name
      }

      method_url = "/instances/%s/volume_attachments" % [ERB::Util.url_encode(instance_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_volume_attachment(instance_id:, id:)
    # Delete a volume attachment.
    # This request deletes a volume attachment. This operation cannot be reversed, but a
    #   new volume attachment may subsequently be created for the volume.  For this
    #   request to succeed, the volume must not be busy.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The volume attachment identifier.
    # @return [nil]
    def delete_instance_volume_attachment(instance_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_volume_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/volume_attachments/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance_volume_attachment(instance_id:, id:)
    # Retrieve a volume attachment.
    # This request retrieves a single volume attachment specified by the identifier in
    #   the URL.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The volume attachment identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_volume_attachment(instance_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_volume_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instances/%s/volume_attachments/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance_volume_attachment(instance_id:, id:, volume_attachment_patch:)
    # Update a volume attachment.
    # This request updates a volume attachment with the information provided in a volume
    #   attachment patch object. The volume attachment patch object is structured in the
    #   same way as a retrieved volume attachment and needs to contain only the
    #   information to be updated.
    # @param instance_id [String] The virtual server instance identifier.
    # @param id [String] The volume attachment identifier.
    # @param volume_attachment_patch [Hash] The volume attachment patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance_volume_attachment(instance_id:, id:, volume_attachment_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_id must be provided") if instance_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("volume_attachment_patch must be provided") if volume_attachment_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance_volume_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = volume_attachment_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instances/%s/volume_attachments/%s" % [ERB::Util.url_encode(instance_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Instance groups
    #########################

    ##
    # @!method list_instance_groups(start: nil, limit: nil)
    # List instance groups.
    # This request lists instance groups in the region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_groups(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_groups")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/instance_groups"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance_group(instance_template:, subnets:, application_port: nil, load_balancer: nil, load_balancer_pool: nil, membership_count: nil, name: nil, resource_group: nil)
    # Create an instance group.
    # This request creates a new instance group.
    # @param instance_template [InstanceTemplateIdentity] Instance template to use when creating new instances.
    #
    #   Instance groups are not compatible with instance templates that specify `true` for
    #   `default_trusted_profile.auto_link`.
    # @param subnets [Array[SubnetIdentity]] The subnets to use when creating new instances.
    # @param application_port [Fixnum] The port to use for new load balancer pool members created by this instance group.
    #   The load balancer pool member will receive load balancer traffic on this port,
    #   unless the load balancer listener is using a port range. (Traffic received on a
    #   listener using a port range will be sent to members using the same port the
    #   listener received it on.)
    #
    #   This port will also be used for health checks unless the port property of
    #   `health_monitor` property is specified.
    #
    #   This property must be specified if and only if `load_balancer_pool` has been
    #   specified.
    # @param load_balancer [LoadBalancerIdentity] The load balancer associated with the specified load balancer pool.
    #   Required if `load_balancer_pool` is specified. The load balancer must have
    #   `instance_groups_supported` set to `true`.
    # @param load_balancer_pool [LoadBalancerPoolIdentity] If specified, this instance group will manage the load balancer pool. A pool
    #   member
    #   will be created for each instance created by this group.  The specified load
    #   balancer pool must not be used by another instance group in the VPC.
    #
    #   If specified, `load_balancer` and `application_port` must also be specified.
    # @param membership_count [Fixnum] The number of instances in the instance group.
    # @param name [String] The name for this instance group. The name must not be used by another instance
    #   group in the region. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_group(instance_template:, subnets:, application_port: nil, load_balancer: nil, load_balancer_pool: nil, membership_count: nil, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_template must be provided") if instance_template.nil?

      raise ArgumentError.new("subnets must be provided") if subnets.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "instance_template" => instance_template,
        "subnets" => subnets,
        "application_port" => application_port,
        "load_balancer" => load_balancer,
        "load_balancer_pool" => load_balancer_pool,
        "membership_count" => membership_count,
        "name" => name,
        "resource_group" => resource_group
      }

      method_url = "/instance_groups"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_group(id:)
    # Delete an instance group.
    # This request deletes an instance group. This operation cannot be reversed. Any
    #   instances associated with the group will be deleted.
    # @param id [String] The instance group identifier.
    # @return [nil]
    def delete_instance_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance_group(id:)
    # Retrieve an instance group.
    # This request retrieves a single instance group specified by identifier in the URL.
    # @param id [String] The instance group identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance_group(id:, instance_group_patch:)
    # Update an instance group.
    # This request updates an instance group with the information provided instance
    #   group patch. The instance group patch object is structured in the same way as a
    #   retrieved instance group and contains only the information to be updated.
    # @param id [String] The instance group identifier.
    # @param instance_group_patch [Hash] The instance group patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance_group(id:, instance_group_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("instance_group_patch must be provided") if instance_group_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_group_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instance_groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_group_load_balancer(instance_group_id:)
    # Delete an instance group load balancer.
    # This request unbinds the instance group from the load balancer pool, and deletes
    #   the load balancer pool members.
    # @param instance_group_id [String] The instance group identifier.
    # @return [nil]
    def delete_instance_group_load_balancer(instance_group_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_group_load_balancer")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s/load_balancer" % [ERB::Util.url_encode(instance_group_id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method list_instance_group_managers(instance_group_id:, start: nil, limit: nil)
    # List managers for an instance group.
    # This request lists managers for an instance group.
    # @param instance_group_id [String] The instance group identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_group_managers(instance_group_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_group_managers")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/instance_groups/%s/managers" % [ERB::Util.url_encode(instance_group_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance_group_manager(instance_group_id:, instance_group_manager_prototype:)
    # Create a manager for an instance group.
    # This request creates a new instance group manager.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_prototype [InstanceGroupManagerPrototype] The instance group manager prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_group_manager(instance_group_id:, instance_group_manager_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_prototype must be provided") if instance_group_manager_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance_group_manager")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_group_manager_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/instance_groups/%s/managers" % [ERB::Util.url_encode(instance_group_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_group_manager(instance_group_id:, id:)
    # Delete an instance group manager.
    # This request deletes an instance group manager. This operation cannot be reversed.
    # @param instance_group_id [String] The instance group identifier.
    # @param id [String] The instance group manager identifier.
    # @return [nil]
    def delete_instance_group_manager(instance_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_group_manager")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s/managers/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance_group_manager(instance_group_id:, id:)
    # Retrieve an instance group manager.
    # This request retrieves a single instance group manager specified by identifier in
    #   the URL.
    # @param instance_group_id [String] The instance group identifier.
    # @param id [String] The instance group manager identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_group_manager(instance_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_group_manager")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s/managers/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance_group_manager(instance_group_id:, id:, instance_group_manager_patch:)
    # Update an instance group manager.
    # This request updates an instance group manager with the information provided
    #   instance group manager patch.
    # @param instance_group_id [String] The instance group identifier.
    # @param id [String] The instance group manager identifier.
    # @param instance_group_manager_patch [Hash] The instance group manager patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance_group_manager(instance_group_id:, id:, instance_group_manager_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("instance_group_manager_patch must be provided") if instance_group_manager_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance_group_manager")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_group_manager_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instance_groups/%s/managers/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_instance_group_manager_actions(instance_group_id:, instance_group_manager_id:, start: nil, limit: nil)
    # List actions for an instance group manager.
    # This request lists instance group actions for an instance group manager.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_group_manager_actions(instance_group_id:, instance_group_manager_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_id must be provided") if instance_group_manager_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_group_manager_actions")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/instance_groups/%s/managers/%s/actions" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(instance_group_manager_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance_group_manager_action(instance_group_id:, instance_group_manager_id:, instance_group_manager_action_prototype:)
    # Create an instance group manager action.
    # This request creates a new instance group manager action.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param instance_group_manager_action_prototype [InstanceGroupManagerActionPrototype] The instance group manager action prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_group_manager_action(instance_group_id:, instance_group_manager_id:, instance_group_manager_action_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_id must be provided") if instance_group_manager_id.nil?

      raise ArgumentError.new("instance_group_manager_action_prototype must be provided") if instance_group_manager_action_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance_group_manager_action")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_group_manager_action_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/instance_groups/%s/managers/%s/actions" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(instance_group_manager_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_group_manager_action(instance_group_id:, instance_group_manager_id:, id:)
    # Delete specified instance group manager action.
    # This request deletes an instance group manager action. This operation cannot be
    #   reversed.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param id [String] The instance group manager action identifier.
    # @return [nil]
    def delete_instance_group_manager_action(instance_group_id:, instance_group_manager_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_id must be provided") if instance_group_manager_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_group_manager_action")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s/managers/%s/actions/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(instance_group_manager_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance_group_manager_action(instance_group_id:, instance_group_manager_id:, id:)
    # Retrieve specified instance group manager action.
    # This request retrieves a single instance group manager action specified by
    #   identifier in the URL.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param id [String] The instance group manager action identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_group_manager_action(instance_group_id:, instance_group_manager_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_id must be provided") if instance_group_manager_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_group_manager_action")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s/managers/%s/actions/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(instance_group_manager_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance_group_manager_action(instance_group_id:, instance_group_manager_id:, id:, instance_group_manager_action_patch:)
    # Update specified instance group manager action.
    # This request updates an instance group manager action.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param id [String] The instance group manager action identifier.
    # @param instance_group_manager_action_patch [Hash] The instance group manager action patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance_group_manager_action(instance_group_id:, instance_group_manager_id:, id:, instance_group_manager_action_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_id must be provided") if instance_group_manager_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("instance_group_manager_action_patch must be provided") if instance_group_manager_action_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance_group_manager_action")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_group_manager_action_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instance_groups/%s/managers/%s/actions/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(instance_group_manager_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_instance_group_manager_policies(instance_group_id:, instance_group_manager_id:, start: nil, limit: nil)
    # List policies for an instance group manager.
    # This request lists policies for an instance group manager.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_group_manager_policies(instance_group_id:, instance_group_manager_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_id must be provided") if instance_group_manager_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_group_manager_policies")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/instance_groups/%s/managers/%s/policies" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(instance_group_manager_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_instance_group_manager_policy(instance_group_id:, instance_group_manager_id:, instance_group_manager_policy_prototype:)
    # Create a policy for an instance group manager.
    # This request creates a new instance group manager policy.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param instance_group_manager_policy_prototype [InstanceGroupManagerPolicyPrototype] The instance group manager policy prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_group_manager_policy(instance_group_id:, instance_group_manager_id:, instance_group_manager_policy_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_id must be provided") if instance_group_manager_id.nil?

      raise ArgumentError.new("instance_group_manager_policy_prototype must be provided") if instance_group_manager_policy_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_instance_group_manager_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_group_manager_policy_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/instance_groups/%s/managers/%s/policies" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(instance_group_manager_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_group_manager_policy(instance_group_id:, instance_group_manager_id:, id:)
    # Delete an instance group manager policy.
    # This request deletes an instance group manager policy. This operation cannot be
    #   reversed.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param id [String] The instance group manager policy identifier.
    # @return [nil]
    def delete_instance_group_manager_policy(instance_group_id:, instance_group_manager_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_id must be provided") if instance_group_manager_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_group_manager_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s/managers/%s/policies/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(instance_group_manager_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance_group_manager_policy(instance_group_id:, instance_group_manager_id:, id:)
    # Retrieve an instance group manager policy.
    # This request retrieves a single instance group manager policy specified by
    #   identifier in the URL.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param id [String] The instance group manager policy identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_group_manager_policy(instance_group_id:, instance_group_manager_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_id must be provided") if instance_group_manager_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_group_manager_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s/managers/%s/policies/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(instance_group_manager_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance_group_manager_policy(instance_group_id:, instance_group_manager_id:, id:, instance_group_manager_policy_patch:)
    # Update an instance group manager policy.
    # This request updates an instance group manager policy.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param id [String] The instance group manager policy identifier.
    # @param instance_group_manager_policy_patch [Hash] The instance group manager policy patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance_group_manager_policy(instance_group_id:, instance_group_manager_id:, id:, instance_group_manager_policy_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("instance_group_manager_id must be provided") if instance_group_manager_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("instance_group_manager_policy_patch must be provided") if instance_group_manager_policy_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance_group_manager_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_group_manager_policy_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instance_groups/%s/managers/%s/policies/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(instance_group_manager_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_group_memberships(instance_group_id:)
    # Delete memberships from an instance group.
    # This request deletes memberships of an instance group. This operation cannot be
    #   reversed. Memberships that have `delete_instance_on_membership_delete` set to
    #   `true` will also have their instances deleted.
    # @param instance_group_id [String] The instance group identifier.
    # @return [nil]
    def delete_instance_group_memberships(instance_group_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_group_memberships")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s/memberships" % [ERB::Util.url_encode(instance_group_id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method list_instance_group_memberships(instance_group_id:, start: nil, limit: nil)
    # List memberships for an instance group.
    # This request lists instance group memberships for an instance group.
    # @param instance_group_id [String] The instance group identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instance_group_memberships(instance_group_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_instance_group_memberships")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/instance_groups/%s/memberships" % [ERB::Util.url_encode(instance_group_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_instance_group_membership(instance_group_id:, id:)
    # Delete an instance group membership.
    # This request deletes a memberships of an instance group. This operation cannot be
    #   reversed. reversed. If the membership has `delete_instance_on_membership_delete`
    #   set to `true`, the instance will also be deleted.
    # @param instance_group_id [String] The instance group identifier.
    # @param id [String] The instance group membership identifier.
    # @return [nil]
    def delete_instance_group_membership(instance_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_instance_group_membership")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s/memberships/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_instance_group_membership(instance_group_id:, id:)
    # Retrieve an instance group membership.
    # This request retrieves a single instance group membership specified by identifier
    #   in the URL.
    # @param instance_group_id [String] The instance group identifier.
    # @param id [String] The instance group membership identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_instance_group_membership(instance_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_instance_group_membership")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/instance_groups/%s/memberships/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_instance_group_membership(instance_group_id:, id:, instance_group_membership_patch:)
    # Update an instance group membership.
    # This request updates an instance group membership with the information provided
    #   instance group membership patch.
    # @param instance_group_id [String] The instance group identifier.
    # @param id [String] The instance group membership identifier.
    # @param instance_group_membership_patch [Hash] The instance group membership patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance_group_membership(instance_group_id:, id:, instance_group_membership_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("instance_group_id must be provided") if instance_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("instance_group_membership_patch must be provided") if instance_group_membership_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_instance_group_membership")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = instance_group_membership_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/instance_groups/%s/memberships/%s" % [ERB::Util.url_encode(instance_group_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Reservations
    #########################

    ##
    # @!method list_reservations(start: nil, limit: nil, name: nil, resource_group_id: nil, zone_name: nil)
    # List reservations.
    # This request lists reservations in the region. A reservation provides reserved
    #   capacity for a specified profile in a specified zone. A reservation can also
    #   include a long-term committed use discount.
    #
    #   The reservations will be sorted by their `created_at` property values, with newest
    #   reservations first. Reservations with identical `created_at` property values will
    #   in turn be sorted by ascending `name` property values.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param zone_name [String] Filters the collection to resources with a `zone.name` property matching the exact
    #   specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_reservations(start: nil, limit: nil, name: nil, resource_group_id: nil, zone_name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_reservations")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "name" => name,
        "resource_group.id" => resource_group_id,
        "zone.name" => zone_name
      }

      method_url = "/reservations"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_reservation(capacity:, committed_use:, profile:, zone:, affinity_policy: nil, name: nil, resource_group: nil)
    # Create a reservation.
    # This request creates a new reservation from a reservation prototype object. The
    #   prototype object is structured in the same way as a retrieved reservation, and
    #   contains the information necessary to create the new reservation.
    # @param capacity [ReservationCapacityPrototype] The capacity reservation configuration to use.
    # @param committed_use [ReservationCommittedUsePrototype] The committed use configuration to use for this reservation.
    # @param profile [ReservationProfilePrototype] The [profile](https://cloud.ibm.com/docs/vpc?topic=vpc-profiles) to use for this
    #   reservation.
    # @param zone [ZoneIdentity] The zone to use for this reservation.
    # @param affinity_policy [String] The affinity policy to use for this reservation:
    #   - `restricted`: The reservation must be manually requested.
    # @param name [String] The name for this reservation. The name must not be used by another reservation in
    #   the region. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_reservation(capacity:, committed_use:, profile:, zone:, affinity_policy: nil, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("capacity must be provided") if capacity.nil?

      raise ArgumentError.new("committed_use must be provided") if committed_use.nil?

      raise ArgumentError.new("profile must be provided") if profile.nil?

      raise ArgumentError.new("zone must be provided") if zone.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_reservation")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "capacity" => capacity,
        "committed_use" => committed_use,
        "profile" => profile,
        "zone" => zone,
        "affinity_policy" => affinity_policy,
        "name" => name,
        "resource_group" => resource_group
      }

      method_url = "/reservations"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_reservation(id:)
    # Delete a reservation.
    # This request deletes a reservation. This operation cannot be reversed.
    #   Reservations with a `status` of `active` are not allowed to be deleted.
    # @param id [String] The reservation identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def delete_reservation(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_reservation")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/reservations/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_reservation(id:)
    # Retrieve a reservation.
    # This request retrieves a single reservation specified by identifier in the URL.
    # @param id [String] The reservation identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_reservation(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_reservation")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/reservations/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_reservation(id:, reservation_patch:)
    # Update a reservation.
    # This request updates a reservation with the information provided in a reservation
    #   patch object. The patch object is structured in the same way as a retrieved
    #   reservation and needs to contain only the information to be updated.
    # @param id [String] The reservation identifier.
    # @param reservation_patch [Hash] The reservation patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_reservation(id:, reservation_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("reservation_patch must be provided") if reservation_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_reservation")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = reservation_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/reservations/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method activate_reservation(id:)
    # Activate a reservation.
    # This request activates a reservation. For this request to succeed, the reservation
    #   status must be `inactive`.
    # @param id [String] The reservation identifier.
    # @return [nil]
    def activate_reservation(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "activate_reservation")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/reservations/%s/activate" % [ERB::Util.url_encode(id)]

      request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end
    #########################
    # Dedicated hosts
    #########################

    ##
    # @!method list_dedicated_host_groups(start: nil, limit: nil, resource_group_id: nil, zone_name: nil, name: nil)
    # List dedicated host groups.
    # This request lists dedicated host groups in the region. Host groups are a
    #   collection of dedicated hosts for placement of instances. Each dedicated host must
    #   belong to one and only one group. Host groups do not span zones.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param zone_name [String] Filters the collection to resources with a `zone.name` property matching the exact
    #   specified name.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_dedicated_host_groups(start: nil, limit: nil, resource_group_id: nil, zone_name: nil, name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_dedicated_host_groups")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "zone.name" => zone_name,
        "name" => name
      }

      method_url = "/dedicated_host/groups"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_dedicated_host_group(_class:, family:, zone:, name: nil, resource_group: nil)
    # Create a dedicated host group.
    # This request creates a new dedicated host group.
    # @param _class [String] The dedicated host profile class for hosts in this group.
    # @param family [String] The dedicated host profile family for hosts in this group.
    # @param zone [ZoneIdentity] The zone this dedicated host group will reside in.
    # @param name [String] The name for this dedicated host group. The name must not be used by another
    #   dedicated host group in the region. If unspecified, the name will be a hyphenated
    #   list of randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_dedicated_host_group(_class:, family:, zone:, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("_class must be provided") if _class.nil?

      raise ArgumentError.new("family must be provided") if family.nil?

      raise ArgumentError.new("zone must be provided") if zone.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_dedicated_host_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "class" => _class,
        "family" => family,
        "zone" => zone,
        "name" => name,
        "resource_group" => resource_group
      }

      method_url = "/dedicated_host/groups"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_dedicated_host_group(id:)
    # Delete a dedicated host group.
    # This request deletes a dedicated host group.
    # @param id [String] The dedicated host group identifier.
    # @return [nil]
    def delete_dedicated_host_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_dedicated_host_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/dedicated_host/groups/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_dedicated_host_group(id:)
    # Retrieve a dedicated host group.
    # This request retrieves a single dedicated host group specified by the identifier
    #   in the URL.
    # @param id [String] The dedicated host group identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_dedicated_host_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_dedicated_host_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/dedicated_host/groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_dedicated_host_group(id:, dedicated_host_group_patch:)
    # Update a dedicated host group.
    # This request updates a dedicated host group with the information in a provided
    #   dedicated host group patch. The dedicated host group patch object is structured in
    #   the same way as a retrieved dedicated host group and contains only the information
    #   to be updated.
    # @param id [String] The dedicated host group identifier.
    # @param dedicated_host_group_patch [Hash] The dedicated host group patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_dedicated_host_group(id:, dedicated_host_group_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("dedicated_host_group_patch must be provided") if dedicated_host_group_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_dedicated_host_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = dedicated_host_group_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/dedicated_host/groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_dedicated_host_profiles(start: nil, limit: nil)
    # List dedicated host profiles.
    # This request lists provisionable [dedicated host
    #   profiles](https://cloud.ibm.com/docs/vpc?topic=vpc-dh-profiles) in the region. A
    #   dedicated host profile specifies the hardware characteristics for a dedicated
    #   host.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_dedicated_host_profiles(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_dedicated_host_profiles")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/dedicated_host/profiles"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_dedicated_host_profile(name:)
    # Retrieve a dedicated host profile.
    # This request retrieves a single dedicated host profile specified by the name in
    #   the URL.
    # @param name [String] The dedicated host profile name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_dedicated_host_profile(name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("name must be provided") if name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_dedicated_host_profile")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/dedicated_host/profiles/%s" % [ERB::Util.url_encode(name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_dedicated_hosts(dedicated_host_group_id: nil, start: nil, limit: nil, resource_group_id: nil, zone_name: nil, name: nil)
    # List dedicated hosts.
    # This request lists dedicated hosts in the region.
    # @param dedicated_host_group_id [String] Filters the collection to dedicated hosts with a `group.id` property matching the
    #   specified identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param zone_name [String] Filters the collection to resources with a `zone.name` property matching the exact
    #   specified name.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_dedicated_hosts(dedicated_host_group_id: nil, start: nil, limit: nil, resource_group_id: nil, zone_name: nil, name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_dedicated_hosts")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "dedicated_host_group.id" => dedicated_host_group_id,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "zone.name" => zone_name,
        "name" => name
      }

      method_url = "/dedicated_hosts"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_dedicated_host(dedicated_host_prototype:)
    # Create a dedicated host.
    # This request creates a new dedicated host.
    # @param dedicated_host_prototype [DedicatedHostPrototype] The dedicated host prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_dedicated_host(dedicated_host_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("dedicated_host_prototype must be provided") if dedicated_host_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_dedicated_host")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = dedicated_host_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/dedicated_hosts"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_dedicated_host_disks(dedicated_host_id:)
    # List disks on a dedicated host.
    # This request lists disks on a dedicated host.  A disk is a physical device that is
    #   locally attached to the compute node. By default, the listed disks are sorted by
    #   their
    #   `created_at` property values, with the newest disk first.
    # @param dedicated_host_id [String] The dedicated host identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_dedicated_host_disks(dedicated_host_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("dedicated_host_id must be provided") if dedicated_host_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_dedicated_host_disks")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/dedicated_hosts/%s/disks" % [ERB::Util.url_encode(dedicated_host_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_dedicated_host_disk(dedicated_host_id:, id:)
    # Retrieve a dedicated host disk.
    # This request retrieves a single dedicated host disk specified by the identifier in
    #   the URL.
    # @param dedicated_host_id [String] The dedicated host identifier.
    # @param id [String] The dedicated host disk identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_dedicated_host_disk(dedicated_host_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("dedicated_host_id must be provided") if dedicated_host_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_dedicated_host_disk")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/dedicated_hosts/%s/disks/%s" % [ERB::Util.url_encode(dedicated_host_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_dedicated_host_disk(dedicated_host_id:, id:, dedicated_host_disk_patch:)
    # Update a dedicated host disk.
    # This request updates the dedicated host disk with the information in a provided
    #   patch.
    # @param dedicated_host_id [String] The dedicated host identifier.
    # @param id [String] The dedicated host disk identifier.
    # @param dedicated_host_disk_patch [Hash] The dedicated host disk patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_dedicated_host_disk(dedicated_host_id:, id:, dedicated_host_disk_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("dedicated_host_id must be provided") if dedicated_host_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("dedicated_host_disk_patch must be provided") if dedicated_host_disk_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_dedicated_host_disk")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = dedicated_host_disk_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/dedicated_hosts/%s/disks/%s" % [ERB::Util.url_encode(dedicated_host_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_dedicated_host(id:)
    # Delete a dedicated host.
    # This request deletes a dedicated host.
    # @param id [String] The dedicated host identifier.
    # @return [nil]
    def delete_dedicated_host(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_dedicated_host")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/dedicated_hosts/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_dedicated_host(id:)
    # Retrieve a dedicated host.
    # This request retrieves a single dedicated host specified by the identifiers in the
    #   URL.
    # @param id [String] The dedicated host identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_dedicated_host(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_dedicated_host")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/dedicated_hosts/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_dedicated_host(id:, dedicated_host_patch:)
    # Update a dedicated host.
    # This request updates a dedicated host with the information in a provided dedicated
    #   host patch. The dedicated host patch object is structured in the same way as a
    #   retrieved dedicated host and contains only the information to be updated.
    # @param id [String] The dedicated host identifier.
    # @param dedicated_host_patch [Hash] The dedicated host patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_dedicated_host(id:, dedicated_host_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("dedicated_host_patch must be provided") if dedicated_host_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_dedicated_host")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = dedicated_host_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/dedicated_hosts/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Placement groups
    #########################

    ##
    # @!method list_placement_groups(start: nil, limit: nil)
    # List placement groups.
    # This request lists placement groups in the region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_placement_groups(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_placement_groups")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/placement_groups"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_placement_group(strategy:, name: nil, resource_group: nil)
    # Create a placement group.
    # This request creates a new placement group.
    # @param strategy [String] The strategy for this placement group:
    #   - `host_spread`: place on different compute hosts
    #   - `power_spread`: place on compute hosts that use different power sources
    #
    #   The enumerated values for this property may
    #   [expand](https://cloud.ibm.com/apidocs/vpc#property-value-expansion) in the
    #   future.
    # @param name [String] The name for this placement group. The name must not be used by another placement
    #   group in the region. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_placement_group(strategy:, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("strategy must be provided") if strategy.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_placement_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "strategy" => strategy,
        "name" => name,
        "resource_group" => resource_group
      }

      method_url = "/placement_groups"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_placement_group(id:)
    # Delete a placement group.
    # This request deletes a placement group. This operation cannot be reversed. For
    #   this request to succeed, the placement group must not be associated with an
    #   instance.
    # @param id [String] The placement group identifier.
    # @return [nil]
    def delete_placement_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_placement_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/placement_groups/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_placement_group(id:)
    # Retrieve a placement group.
    # This request retrieves a single placement group specified by identifier in the
    #   URL.
    # @param id [String] The placement group identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_placement_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_placement_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/placement_groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_placement_group(id:, placement_group_patch:)
    # Update a placement group.
    # This request updates a placement group with the information provided placement
    #   group patch. The placement group patch object is structured in the same way as a
    #   retrieved placement group and contains only the information to be updated.
    # @param id [String] The placement group identifier.
    # @param placement_group_patch [Hash] The placement group patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_placement_group(id:, placement_group_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("placement_group_patch must be provided") if placement_group_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_placement_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = placement_group_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/placement_groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Bare metal servers
    #########################

    ##
    # @!method list_bare_metal_server_profiles(start: nil, limit: nil)
    # List bare metal server profiles.
    # This request lists [bare metal server
    #   profiles](https://cloud.ibm.com/docs/vpc?topic=vpc-bare-metal-servers-profile)
    #   available in the region. A bare metal server profile specifies the performance
    #   characteristics and pricing model for a bare metal server.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_bare_metal_server_profiles(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_bare_metal_server_profiles")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/bare_metal_server/profiles"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_bare_metal_server_profile(name:)
    # Retrieve a bare metal server profile.
    # This request retrieves a single bare metal server profile specified by the name in
    #   the URL.
    # @param name [String] The bare metal server profile name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_bare_metal_server_profile(name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("name must be provided") if name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_bare_metal_server_profile")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_server/profiles/%s" % [ERB::Util.url_encode(name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_bare_metal_servers(start: nil, limit: nil, resource_group_id: nil, name: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil)
    # List bare metal servers.
    # This request lists bare metal servers in the region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param vpc_id [String] Filters the collection to resources with a `vpc.id` property matching the
    #   specified identifier.
    # @param vpc_crn [String] Filters the collection to resources with a `vpc.crn` property matching the
    #   specified CRN.
    # @param vpc_name [String] Filters the collection to resources with a `vpc.name` property matching the exact
    #   specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_bare_metal_servers(start: nil, limit: nil, resource_group_id: nil, name: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_bare_metal_servers")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "name" => name,
        "vpc.id" => vpc_id,
        "vpc.crn" => vpc_crn,
        "vpc.name" => vpc_name
      }

      method_url = "/bare_metal_servers"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_bare_metal_server(bare_metal_server_prototype:)
    # Create a bare metal server.
    # This request provisions a new bare metal server from a prototype object. The
    #   prototype object is structured in the same way as a retrieved bare metal server,
    #   and contains the information necessary to provision the new bare metal server. The
    #   bare metal server is automatically started.
    # @param bare_metal_server_prototype [BareMetalServerPrototype] The bare metal server prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_bare_metal_server(bare_metal_server_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_prototype must be provided") if bare_metal_server_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_bare_metal_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = bare_metal_server_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/bare_metal_servers"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_bare_metal_server_console_access_token(bare_metal_server_id:, console_type:, force: nil)
    # Create a console access token for a bare metal server.
    # This request creates a new single-use console access token for a bare metal
    #   server. All console configuration is provided at token create time, and the token
    #   is subsequently used in the `access_token` query parameter for the WebSocket
    #   request.  The access token is only valid for a short period of time, and a maximum
    #   of one token is valid for a given bare metal server at a time.  For this request
    #   to succeed, the server must have a `status` of `stopped`, `starting`, or
    #   `running`.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param console_type [String] The bare metal server console type for which this token may be used
    #
    #   Must be `serial` for bare metal servers with a `cpu.architecture` of `s390x`.
    # @param force [Boolean] Indicates whether to disconnect an existing serial console session as the serial
    #   console cannot be shared.  This has no effect on VNC consoles.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_bare_metal_server_console_access_token(bare_metal_server_id:, console_type:, force: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("console_type must be provided") if console_type.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_bare_metal_server_console_access_token")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "console_type" => console_type,
        "force" => force
      }

      method_url = "/bare_metal_servers/%s/console_access_token" % [ERB::Util.url_encode(bare_metal_server_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_bare_metal_server_disks(bare_metal_server_id:)
    # List disks on a bare metal server.
    # This request lists  disks on a bare metal server.  A disk is a block device that
    #   is locally attached to the physical server.  By default, the listed disks are
    #   sorted by their `created_at` property values, with the newest disk first.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_bare_metal_server_disks(bare_metal_server_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_bare_metal_server_disks")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/disks" % [ERB::Util.url_encode(bare_metal_server_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_bare_metal_server_disk(bare_metal_server_id:, id:)
    # Retrieve a bare metal server disk.
    # This request retrieves a single disk specified by the identifier in the URL.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param id [String] The bare metal server disk identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_bare_metal_server_disk(bare_metal_server_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_bare_metal_server_disk")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/disks/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_bare_metal_server_disk(bare_metal_server_id:, id:, bare_metal_server_disk_patch:)
    # Update a bare metal server disk.
    # This request updates the bare metal server disk with the information in a provided
    #   patch.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param id [String] The bare metal server disk identifier.
    # @param bare_metal_server_disk_patch [Hash] The bare metal server disk patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_bare_metal_server_disk(bare_metal_server_id:, id:, bare_metal_server_disk_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("bare_metal_server_disk_patch must be provided") if bare_metal_server_disk_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_bare_metal_server_disk")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = bare_metal_server_disk_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/bare_metal_servers/%s/disks/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_bare_metal_server_network_attachments(bare_metal_server_id:, start: nil, limit: nil)
    # List network attachments on a bare metal server.
    # This request lists network attachments on a bare metal server. A bare metal server
    #   network attachment is an abstract representation of a network device and attaches
    #   a bare metal server to a single subnet. Each network interface on a bare metal
    #   server can attach to any subnet in the zone, including subnets that are already
    #   attached to the bare metal server.
    #
    #   The network attachments will be sorted by their `created_at` property values, with
    #   newest network attachments first. Network attachments with identical `created_at`
    #   property values will in turn be sorted by ascending `name` property values.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_bare_metal_server_network_attachments(bare_metal_server_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_bare_metal_server_network_attachments")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/bare_metal_servers/%s/network_attachments" % [ERB::Util.url_encode(bare_metal_server_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_bare_metal_server_network_attachment(bare_metal_server_id:, bare_metal_server_network_attachment_prototype:)
    # Create a network attachment on a bare metal server.
    # This request creates a new bare metal server network attachment from a bare metal
    #   server network attachment prototype object. The prototype object is structured in
    #   the same way as a retrieved bare metal server network attachment, and contains the
    #   information necessary to create the new bare metal server network attachment.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param bare_metal_server_network_attachment_prototype [BareMetalServerNetworkAttachmentPrototype] The bare metal server network attachment prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_bare_metal_server_network_attachment(bare_metal_server_id:, bare_metal_server_network_attachment_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("bare_metal_server_network_attachment_prototype must be provided") if bare_metal_server_network_attachment_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_bare_metal_server_network_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = bare_metal_server_network_attachment_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/bare_metal_servers/%s/network_attachments" % [ERB::Util.url_encode(bare_metal_server_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_bare_metal_server_network_attachment(bare_metal_server_id:, id:)
    # Delete a bare metal server network attachment.
    # This request deletes a bare metal server network attachment. This operation cannot
    #   be reversed. Any floating IPs associated with the bare metal server network
    #   attachment are implicitly disassociated.
    #
    #   The bare metal server's primary network attachment cannot be deleted.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param id [String] The bare metal server network attachment identifier.
    # @return [nil]
    def delete_bare_metal_server_network_attachment(bare_metal_server_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_bare_metal_server_network_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/network_attachments/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_bare_metal_server_network_attachment(bare_metal_server_id:, id:)
    # Retrieve a bare metal server network attachment.
    # This request retrieves a single bare metal server network attachment specified by
    #   the identifier in the URL.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param id [String] The bare metal server network attachment identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_bare_metal_server_network_attachment(bare_metal_server_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_bare_metal_server_network_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/network_attachments/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_bare_metal_server_network_attachment(bare_metal_server_id:, id:, bare_metal_server_network_attachment_patch:)
    # Update a bare metal server network attachment.
    # This request updates a bare metal server network attachment with the information
    #   provided in a bare metal server network attachment patch object. The bare metal
    #   server network attachment patch object is structured in the same way as a
    #   retrieved bare metal server network attachment and contains only the information
    #   to be updated.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param id [String] The bare metal server network attachment identifier.
    # @param bare_metal_server_network_attachment_patch [Hash] The bare metal server network attachment patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_bare_metal_server_network_attachment(bare_metal_server_id:, id:, bare_metal_server_network_attachment_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("bare_metal_server_network_attachment_patch must be provided") if bare_metal_server_network_attachment_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_bare_metal_server_network_attachment")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = bare_metal_server_network_attachment_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/bare_metal_servers/%s/network_attachments/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_bare_metal_server_network_interfaces(bare_metal_server_id:, start: nil, limit: nil)
    # List network interfaces on a bare metal server.
    # This request lists network interfaces on a bare metal server. A bare metal server
    #   network interface is an abstract representation of a network device and attaches a
    #   bare metal server to a single subnet. Each network interface on a bare metal
    #   server can attach to any subnet in the zone, including subnets that are already
    #   attached to the bare metal server.
    #
    #   If this bare metal server has network attachments, each returned network interface
    #   is a [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_bare_metal_server_network_interfaces(bare_metal_server_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_bare_metal_server_network_interfaces")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/bare_metal_servers/%s/network_interfaces" % [ERB::Util.url_encode(bare_metal_server_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_bare_metal_server_network_interface(bare_metal_server_id:, bare_metal_server_network_interface_prototype:)
    # Create a network interface on a bare metal server.
    # This request creates a new bare metal server network interface from a bare metal
    #   server network interface prototype object. The prototype object is structured in
    #   the same way as a retrieved bare metal server network interface, and contains the
    #   information necessary to create the new bare metal server network interface. Any
    #   subnet in the bare metal server's VPC may be specified, even if it is already
    #   attached to another bare metal server network interface. Addresses on the bare
    #   metal server network interface must be within the specified subnet's CIDR blocks.
    #
    #   If this bare metal server has network attachments, each network interface is a
    #   [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface, and new network interfaces are not allowed to be created.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param bare_metal_server_network_interface_prototype [BareMetalServerNetworkInterfacePrototype] The bare metal server network interface prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_bare_metal_server_network_interface(bare_metal_server_id:, bare_metal_server_network_interface_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("bare_metal_server_network_interface_prototype must be provided") if bare_metal_server_network_interface_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_bare_metal_server_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = bare_metal_server_network_interface_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/bare_metal_servers/%s/network_interfaces" % [ERB::Util.url_encode(bare_metal_server_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_bare_metal_server_network_interface(bare_metal_server_id:, id:)
    # Delete a bare metal server network interface.
    # This request deletes a bare metal server network interface. This operation cannot
    #   be reversed. Any floating IPs associated with the bare metal server network
    #   interface are implicitly disassociated.  The primary bare metal server network
    #   interface is not allowed to be deleted.
    #
    #   If this bare metal server has network attachments, this network interface is a
    #   [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface, and is not allowed to be deleted.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param id [String] The bare metal server network interface identifier.
    # @return [nil]
    def delete_bare_metal_server_network_interface(bare_metal_server_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_bare_metal_server_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/network_interfaces/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_bare_metal_server_network_interface(bare_metal_server_id:, id:)
    # Retrieve a bare metal server network interface.
    # This request retrieves a single bare metal server network interface specified by
    #   the identifier in the URL.
    #
    #   If this bare metal server has network attachments, the retrieved network interface
    #   is a [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param id [String] The bare metal server network interface identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_bare_metal_server_network_interface(bare_metal_server_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_bare_metal_server_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/network_interfaces/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_bare_metal_server_network_interface(bare_metal_server_id:, id:, bare_metal_server_network_interface_patch:)
    # Update a bare metal server network interface.
    # This request updates a bare metal server network interface with the information
    #   provided in a bare metal server network interface patch object. The bare metal
    #   server network interface patch object is structured in the same way as a retrieved
    #   bare metal server network interface and needs to contain only the information to
    #   be updated.
    #
    #   If this bare metal server has network attachments, this network interface is a
    #   [read-only
    #   representation](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#vni-old-api-clients)
    #   of its corresponding network attachment and its attached virtual network
    #   interface, and is not allowed to be updated.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param id [String] The bare metal server network interface identifier.
    # @param bare_metal_server_network_interface_patch [Hash] The bare metal server network interface patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_bare_metal_server_network_interface(bare_metal_server_id:, id:, bare_metal_server_network_interface_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("bare_metal_server_network_interface_patch must be provided") if bare_metal_server_network_interface_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_bare_metal_server_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = bare_metal_server_network_interface_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/bare_metal_servers/%s/network_interfaces/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_bare_metal_server_network_interface_floating_ips(bare_metal_server_id:, network_interface_id:)
    # List floating IPs associated with a bare metal server network interface.
    # This request lists floating IPs associated with a bare metal server network
    #   interface.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param network_interface_id [String] The bare metal server network interface identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_bare_metal_server_network_interface_floating_ips(bare_metal_server_id:, network_interface_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_bare_metal_server_network_interface_floating_ips")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/network_interfaces/%s/floating_ips" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(network_interface_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method remove_bare_metal_server_network_interface_floating_ip(bare_metal_server_id:, network_interface_id:, id:)
    # Disassociate a floating IP from a bare metal server network interface.
    # This request disassociates the specified floating IP from the specified bare metal
    #   server network interface.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param network_interface_id [String] The bare metal server network interface identifier.
    # @param id [String] The floating IP identifier.
    # @return [nil]
    def remove_bare_metal_server_network_interface_floating_ip(bare_metal_server_id:, network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "remove_bare_metal_server_network_interface_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/network_interfaces/%s/floating_ips/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(network_interface_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_bare_metal_server_network_interface_floating_ip(bare_metal_server_id:, network_interface_id:, id:)
    # Retrieve associated floating IP.
    # This request retrieves a specified floating IP if it is associated with the bare
    #   metal server network interface specified in the URL.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param network_interface_id [String] The bare metal server network interface identifier.
    # @param id [String] The floating IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_bare_metal_server_network_interface_floating_ip(bare_metal_server_id:, network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_bare_metal_server_network_interface_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/network_interfaces/%s/floating_ips/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(network_interface_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method add_bare_metal_server_network_interface_floating_ip(bare_metal_server_id:, network_interface_id:, id:)
    # Associate a floating IP with a bare metal server network interface.
    # This request associates the specified floating IP with the specified bare metal
    #   server network interface. If `enable_infrastructure_nat` is `false`, this adds the
    #   IP to any existing associations. If `enable_infrastructure_nat` is `true`, this
    #   replaces any existing association.
    #
    #   The existing floating IP must:
    #   - not be required by another resource, such as a public gateway
    #   - be in the same `zone` as the bare metal server
    #
    #   A request body is not required, and if provided, is ignored.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param network_interface_id [String] The bare metal server network interface identifier.
    # @param id [String] The floating IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def add_bare_metal_server_network_interface_floating_ip(bare_metal_server_id:, network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "add_bare_metal_server_network_interface_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/network_interfaces/%s/floating_ips/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(network_interface_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_bare_metal_server_network_interface_ips(bare_metal_server_id:, network_interface_id:)
    # List the primary reserved IP for a bare metal server network interface.
    # This request lists the primary reserved IP for a bare metal server network
    #   interface.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param network_interface_id [String] The bare metal server network interface identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_bare_metal_server_network_interface_ips(bare_metal_server_id:, network_interface_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_bare_metal_server_network_interface_ips")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/network_interfaces/%s/ips" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(network_interface_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_bare_metal_server_network_interface_ip(bare_metal_server_id:, network_interface_id:, id:)
    # Retrieve the primary reserved IP.
    # This request retrieves the primary reserved IP for a bare metal server network
    #   interface.
    # @param bare_metal_server_id [String] The bare metal server identifier.
    # @param network_interface_id [String] The bare metal server network interface identifier.
    # @param id [String] The reserved IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_bare_metal_server_network_interface_ip(bare_metal_server_id:, network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("bare_metal_server_id must be provided") if bare_metal_server_id.nil?

      raise ArgumentError.new("network_interface_id must be provided") if network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_bare_metal_server_network_interface_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/network_interfaces/%s/ips/%s" % [ERB::Util.url_encode(bare_metal_server_id), ERB::Util.url_encode(network_interface_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_bare_metal_server(id:)
    # Delete a bare metal server.
    # This request deletes a bare metal server. This operation cannot be reversed. Any
    #   floating IPs associated with the bare metal server network interfaces are
    #   implicitly disassociated.
    # @param id [String] The bare metal server identifier.
    # @return [nil]
    def delete_bare_metal_server(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_bare_metal_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_bare_metal_server(id:)
    # Retrieve a bare metal server.
    # This request retrieves a single bare metal server specified by the identifier in
    #   the URL.
    # @param id [String] The bare metal server identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_bare_metal_server(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_bare_metal_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_bare_metal_server(id:, bare_metal_server_patch:)
    # Update a bare metal server.
    # This request updates a bare metal server with the information in a provided patch.
    #   The bare metal server patch object is structured in the same way as a retrieved
    #   bare metal server and contains only the information to be updated.
    # @param id [String] The bare metal server identifier.
    # @param bare_metal_server_patch [Hash] The bare metal server patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_bare_metal_server(id:, bare_metal_server_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("bare_metal_server_patch must be provided") if bare_metal_server_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_bare_metal_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = bare_metal_server_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/bare_metal_servers/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_firmware_for_bare_metal_server(id:, auto_start: nil)
    # Update firmware for a bare metal server.
    # This request updates a bare metal server to the latest available firmware. The
    #   server must be stopped.
    # @param id [String] The bare metal server identifier.
    # @param auto_start [Boolean] Indicates whether to automatically start the bare metal server after the firmware
    #   update is successfully completed.
    # @return [nil]
    def update_firmware_for_bare_metal_server(id:, auto_start: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_firmware_for_bare_metal_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "auto_start" => auto_start
      }

      method_url = "/bare_metal_servers/%s/firmware/update" % [ERB::Util.url_encode(id)]

      request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_bare_metal_server_initialization(id:)
    # Retrieve initialization configuration for a bare metal server.
    # This request retrieves configuration used to initialize the bare metal server,
    #   such as the image used, SSH keys, and any configured usernames and passwords.
    #   These can subsequently be changed on the server and therefore may not be current.
    # @param id [String] The bare metal server identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_bare_metal_server_initialization(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_bare_metal_server_initialization")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/initialization" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method replace_bare_metal_server_initialization(id:, image:, keys:, user_data: nil)
    # Reinitialize a bare metal server.
    # This request reinitializes a bare metal server with the specified image and SSH
    #   keys. The server must be stopped. Upon successful reinitiatilization, the bare
    #   metal server will be started automatically.
    # @param id [String] The bare metal server identifier.
    # @param image [ImageIdentity] The image to be used when provisioning the bare metal server.
    # @param keys [Array[KeyIdentity]] The public SSH keys to install on the bare metal server. Keys will be made
    #   available to the bare metal server as cloud-init vendor data. For cloud-init
    #   enabled images, these keys will also be added as SSH authorized keys for the
    #   administrative user.
    #
    #   For Windows images, at least one key must be specified, and one will be selected
    #   to encrypt the administrator password. Keys are optional for other images, but if
    #   no keys are specified, the instance will be inaccessible unless the specified
    #   image provides another means of access.
    # @param user_data [String] User data to be made available when initializing the bare metal server.
    #
    #   If unspecified, no user data will be made available.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def replace_bare_metal_server_initialization(id:, image:, keys:, user_data: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("image must be provided") if image.nil?

      raise ArgumentError.new("keys must be provided") if keys.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "replace_bare_metal_server_initialization")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "image" => image,
        "keys" => keys,
        "user_data" => user_data
      }

      method_url = "/bare_metal_servers/%s/initialization" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method restart_bare_metal_server(id:)
    # Restart a bare metal server.
    # This request immediately restarts a bare metal server.  For this request to
    #   succeed, the server must have a `status` of `running`.
    # @param id [String] The bare metal server identifier.
    # @return [nil]
    def restart_bare_metal_server(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "restart_bare_metal_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/restart" % [ERB::Util.url_encode(id)]

      request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method start_bare_metal_server(id:)
    # Start a bare metal server.
    # This request starts a bare metal server.  It will run immediately provided the
    #   server is stopped.
    # @param id [String] The bare metal server identifier.
    # @return [nil]
    def start_bare_metal_server(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "start_bare_metal_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/bare_metal_servers/%s/start" % [ERB::Util.url_encode(id)]

      request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method stop_bare_metal_server(id:, type:)
    # Stop a bare metal server.
    # This request stops a bare metal server. It will run immediately provided the
    #   server is running. Note: A soft stop may not complete as it relies on the
    #   operating system to perform the operation.
    # @param id [String] The bare metal server identifier.
    # @param type [String] The type of stop operation:
    #   - `soft`: signal running operating system to quiesce and shutdown cleanly
    #   - `hard`: immediately stop the server.
    # @return [nil]
    def stop_bare_metal_server(id:, type:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("type must be provided") if type.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "stop_bare_metal_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "type" => type
      }

      method_url = "/bare_metal_servers/%s/stop" % [ERB::Util.url_encode(id)]

      request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: false
      )
      nil
    end
    #########################
    # Volumes
    #########################

    ##
    # @!method list_volume_profiles(start: nil, limit: nil)
    # List volume profiles.
    # This request lists [volume
    #   profiles](https://cloud.ibm.com/docs/vpc?topic=vpc-block-storage-profiles)
    #   available in the region. A volume profile specifies the performance
    #   characteristics and pricing model for a volume.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_volume_profiles(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_volume_profiles")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/volume/profiles"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_volume_profile(name:)
    # Retrieve a volume profile.
    # This request retrieves a single volume profile specified by the name in the URL.
    # @param name [String] The volume profile name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_volume_profile(name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("name must be provided") if name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_volume_profile")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/volume/profiles/%s" % [ERB::Util.url_encode(name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_volumes(start: nil, limit: nil, name: nil, attachment_state: nil, encryption: nil, operating_system_family: nil, operating_system_architecture: nil, zone_name: nil, tag: nil)
    # List volumes.
    # This request lists volumes in the region. Volumes are network-connected block
    #   storage devices that may be attached to one or more instances in the same region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param attachment_state [String] Filters the collection to volumes with an `attachment_state` property matching the
    #   specified value.
    # @param encryption [String] Filters the collection to resources with an `encryption` property matching the
    #   specified value.
    # @param operating_system_family [String] Filters the collection to resources with an `operating_system.family` property
    #   matching the specified operating system family.
    #
    #   This parameter also supports the values `null` and `not:null` which filter the
    #   collection to resources which have no operating system or any operating system,
    #   respectively.
    # @param operating_system_architecture [String] Filters the collection to resources with an `operating_system.architecture`
    #   property matching the specified operating system architecture.
    #
    #   This parameter also supports the values `null` and `not:null` which filter the
    #   collection to resources which have no operating system or any operating system,
    #   respectively.
    # @param zone_name [String] Filters the collection to resources with a `zone.name` property matching the exact
    #   specified name.
    # @param tag [String] Filters the collection to resources with an item in the `tags` property matching
    #   the exact specified tag.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_volumes(start: nil, limit: nil, name: nil, attachment_state: nil, encryption: nil, operating_system_family: nil, operating_system_architecture: nil, zone_name: nil, tag: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_volumes")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "name" => name,
        "attachment_state" => attachment_state,
        "encryption" => encryption,
        "operating_system.family" => operating_system_family,
        "operating_system.architecture" => operating_system_architecture,
        "zone.name" => zone_name,
        "tag" => tag
      }

      method_url = "/volumes"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_volume(volume_prototype:)
    # Create a volume.
    # This request creates a new volume from a volume prototype object. The prototype
    #   object is structured in the same way as a retrieved volume, and contains the
    #   information necessary to create the new volume.
    # @param volume_prototype [VolumePrototype] The volume prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_volume(volume_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("volume_prototype must be provided") if volume_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_volume")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = volume_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/volumes"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_volume(id:, if_match: nil)
    # Delete a volume.
    # This request deletes a volume. This operation cannot be reversed. For this request
    #   to succeed, the volume must not be attached to any instances.
    # @param id [String] The volume identifier.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value.
    # @return [nil]
    def delete_volume(id:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_volume")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/volumes/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_volume(id:)
    # Retrieve a volume.
    # This request retrieves a single volume specified by the identifier in the URL.
    # @param id [String] The volume identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_volume(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_volume")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/volumes/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_volume(id:, volume_patch:, if_match: nil)
    # Update a volume.
    # This request updates a volume with the information in a provided volume patch. The
    #   volume patch object is structured in the same way as a retrieved volume and
    #   contains only the information to be updated.
    # @param id [String] The volume identifier.
    # @param volume_patch [Hash] The volume patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_volume(id:, volume_patch:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("volume_patch must be provided") if volume_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_volume")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = volume_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/volumes/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Snapshots
    #########################

    ##
    # @!method list_snapshot_consistency_groups(start: nil, limit: nil, resource_group_id: nil, name: nil, sort: nil, backup_policy_plan_id: nil)
    # List snapshot consistency groups.
    # This request lists snapshot consistency groups in the region. A snapshot
    #   consistency group is a collection of individual snapshots taken at the same time.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @param backup_policy_plan_id [String] Filters the collection to backup policy jobs with a `backup_policy_plan.id`
    #   property matching the specified identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_snapshot_consistency_groups(start: nil, limit: nil, resource_group_id: nil, name: nil, sort: nil, backup_policy_plan_id: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_snapshot_consistency_groups")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "name" => name,
        "sort" => sort,
        "backup_policy_plan.id" => backup_policy_plan_id
      }

      method_url = "/snapshot_consistency_groups"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_snapshot_consistency_group(snapshot_consistency_group_prototype:)
    # Create a snapshot consistency group.
    # This request creates a new snapshot consistency group from a snapshot consistency
    #   group object.  The prototype object is structured in the same way as a retrieved
    #   consistency group, and contains the information necessary to provision the new
    #   snapshot consistency group.
    # @param snapshot_consistency_group_prototype [SnapshotConsistencyGroupPrototype] The snapshot consistency group prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_snapshot_consistency_group(snapshot_consistency_group_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("snapshot_consistency_group_prototype must be provided") if snapshot_consistency_group_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_snapshot_consistency_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = snapshot_consistency_group_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/snapshot_consistency_groups"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_snapshot_consistency_group(id:)
    # Delete a snapshot consistency group.
    # This request deletes snapshot consistency group. This operation cannot be
    #   reversed. If the `delete_snapshots_on_delete` property is `true`, all snapshots in
    #   the consistency group will also be deleted.
    # @param id [String] The snapshot consistency group identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def delete_snapshot_consistency_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_snapshot_consistency_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/snapshot_consistency_groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_snapshot_consistency_group(id:)
    # Retrieve a snapshot consistency group.
    # This request retrieves a single snapshot consistency group specified by the
    #   identifier in the URL.
    # @param id [String] The snapshot consistency group identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_snapshot_consistency_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_snapshot_consistency_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/snapshot_consistency_groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_snapshot_consistency_group(id:, snapshot_consistency_group_patch:, if_match: nil)
    # Update a snapshot consistency group.
    # This request updates a snapshot consistency group with the information in a
    #   provided snapshot consistency group patch. The snapshot consistency group patch
    #   object is structured in the same way as a retrieved snapshot consistency group and
    #   contains only the information to be updated.
    # @param id [String] The snapshot consistency group identifier.
    # @param snapshot_consistency_group_patch [Hash] The snapshot consistency group patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_snapshot_consistency_group(id:, snapshot_consistency_group_patch:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("snapshot_consistency_group_patch must be provided") if snapshot_consistency_group_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_snapshot_consistency_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = snapshot_consistency_group_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/snapshot_consistency_groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_snapshots(source_volume_id:)
    # Delete a filtered collection of snapshots.
    # This request deletes snapshots that match the specified filter. This operation
    #   cannot be reversed.
    # @param source_volume_id [String] Filters the collection to resources with a `source_volume.id` property matching
    #   the specified identifier.
    # @return [nil]
    def delete_snapshots(source_volume_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("source_volume_id must be provided") if source_volume_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_snapshots")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "source_volume.id" => source_volume_id
      }

      method_url = "/snapshots"

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method list_snapshots(start: nil, limit: nil, tag: nil, resource_group_id: nil, name: nil, source_volume_id: nil, source_volume_crn: nil, source_image_id: nil, source_image_crn: nil, sort: nil, backup_policy_plan_id: nil, copies_id: nil, copies_name: nil, copies_crn: nil, copies_remote_region_name: nil, source_snapshot_id: nil, source_snapshot_remote_region_name: nil, source_volume_remote_region_name: nil, source_image_remote_region_name: nil, clones_zone_name: nil, snapshot_consistency_group_id: nil, snapshot_consistency_group_crn: nil)
    # List snapshots.
    # This request lists snapshots in the region. A snapshot preserves the data of a
    #   volume at the time the snapshot is created.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param tag [String] Filters the collection to resources with an item in the `tags` property matching
    #   the exact specified tag.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param source_volume_id [String] Filters the collection to resources with a `source_volume.id` property matching
    #   the specified identifier.
    # @param source_volume_crn [String] Filters the collection to resources with a `source_volume.crn` property matching
    #   the specified CRN.
    # @param source_image_id [String] Filters the collection to resources with a `source_image.id` property matching the
    #   specified identifier.
    #
    #   This parameter also supports the values `null` and `not:null` which filter the
    #   collection to resources which have no source image or any existent source image,
    #   respectively.
    # @param source_image_crn [String] Filters the collection to resources with a `source_image.crn` property matching
    #   the specified CRN.
    #
    #   This parameter also supports the values `null` and `not:null` which filter the
    #   collection to resources which have no source image or any existent source image,
    #   respectively.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @param backup_policy_plan_id [String] Filters the collection to backup policy jobs with a `backup_policy_plan.id`
    #   property matching the specified identifier.
    # @param copies_id [String] Filters the collection to snapshots with an item in the `copies` property with an
    #   `id` property matching the specified identifier.
    # @param copies_name [String] Filters the collection to snapshots with an item in the `copies` property with a
    #   `name` property matching the exact specified name.
    # @param copies_crn [String] Filters the collection to snapshots with an item in the `copies` property with an
    #   `id` property matching the specified CRN.
    # @param copies_remote_region_name [String] Filters the collection to snapshots with an item in the `copies` property with a
    #   `remote.region.name` property matching the exact specified name.
    # @param source_snapshot_id [String] Filters the collection to resources with a `source_snapshot.id` property matching
    #   the specified identifier.
    # @param source_snapshot_remote_region_name [String] Filters the collection to resources with a `source_snapshot.remote.region.name`
    #   property matching the exact specified name.
    # @param source_volume_remote_region_name [String] Filters the collection to resources with a `source_volume.remote.region.name`
    #   property matching the exact specified name.
    # @param source_image_remote_region_name [String] Filters the collection to resources with a `source_image.remote.region.name`
    #   property matching the exact specified name.
    # @param clones_zone_name [String] Filters the collection to snapshots with an item in the `clones` property with a
    #   `zone.name` property matching the exact specified name.
    # @param snapshot_consistency_group_id [String] Filters the collection to resources with a `snapshot_consistency_group.id`
    #   property matching the specified identifier.
    # @param snapshot_consistency_group_crn [String] Filters the collection to resources with a `snapshot_consistency_group.crn`
    #   property matching the specified identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_snapshots(start: nil, limit: nil, tag: nil, resource_group_id: nil, name: nil, source_volume_id: nil, source_volume_crn: nil, source_image_id: nil, source_image_crn: nil, sort: nil, backup_policy_plan_id: nil, copies_id: nil, copies_name: nil, copies_crn: nil, copies_remote_region_name: nil, source_snapshot_id: nil, source_snapshot_remote_region_name: nil, source_volume_remote_region_name: nil, source_image_remote_region_name: nil, clones_zone_name: nil, snapshot_consistency_group_id: nil, snapshot_consistency_group_crn: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_snapshots")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "tag" => tag,
        "resource_group.id" => resource_group_id,
        "name" => name,
        "source_volume.id" => source_volume_id,
        "source_volume.crn" => source_volume_crn,
        "source_image.id" => source_image_id,
        "source_image.crn" => source_image_crn,
        "sort" => sort,
        "backup_policy_plan.id" => backup_policy_plan_id,
        "copies[].id" => copies_id,
        "copies[].name" => copies_name,
        "copies[].crn" => copies_crn,
        "copies[].remote.region.name" => copies_remote_region_name,
        "source_snapshot.id" => source_snapshot_id,
        "source_snapshot.remote.region.name" => source_snapshot_remote_region_name,
        "source_volume.remote.region.name" => source_volume_remote_region_name,
        "source_image.remote.region.name" => source_image_remote_region_name,
        "clones[].zone.name" => clones_zone_name,
        "snapshot_consistency_group.id" => snapshot_consistency_group_id,
        "snapshot_consistency_group.crn" => snapshot_consistency_group_crn
      }

      method_url = "/snapshots"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_snapshot(snapshot_prototype:)
    # Create a snapshot.
    # This request creates a new snapshot from a snapshot prototype object.  The
    #   prototype object is structured in the same way as a retrieved snapshot, and
    #   contains the information necessary to provision the new snapshot.
    # @param snapshot_prototype [SnapshotPrototype] The snapshot prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_snapshot(snapshot_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("snapshot_prototype must be provided") if snapshot_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_snapshot")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = snapshot_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/snapshots"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_snapshot(id:, if_match: nil)
    # Delete a snapshot.
    # This request deletes a snapshot. This operation cannot be reversed.
    # @param id [String] The snapshot identifier.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value.
    # @return [nil]
    def delete_snapshot(id:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_snapshot")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/snapshots/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_snapshot(id:)
    # Retrieve a snapshot.
    # This request retrieves a single snapshot specified by the identifier in the URL.
    # @param id [String] The snapshot identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_snapshot(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_snapshot")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/snapshots/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_snapshot(id:, snapshot_patch:, if_match: nil)
    # Update a snapshot.
    # This request updates a snapshot with the information in a provided snapshot patch.
    #   The snapshot consistency group patch object is structured in the same way as a
    #   retrieved snapshot and contains only the information to be updated.
    # @param id [String] The snapshot identifier.
    # @param snapshot_patch [Hash] The snapshot patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_snapshot(id:, snapshot_patch:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("snapshot_patch must be provided") if snapshot_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_snapshot")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = snapshot_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/snapshots/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_snapshot_clones(id:)
    # List clones for a snapshot.
    # This request lists clones for a snapshot. Use a clone to quickly restore a
    #   snapshot within the clone's zone.
    # @param id [String] The snapshot identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_snapshot_clones(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_snapshot_clones")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/snapshots/%s/clones" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_snapshot_clone(id:, zone_name:)
    # Delete a snapshot clone.
    # This request deletes a snapshot clone. This operation cannot be reversed, but an
    #   equivalent clone may be recreated from the snapshot.
    # @param id [String] The snapshot identifier.
    # @param zone_name [String] The zone name.
    # @return [nil]
    def delete_snapshot_clone(id:, zone_name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("zone_name must be provided") if zone_name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_snapshot_clone")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/snapshots/%s/clones/%s" % [ERB::Util.url_encode(id), ERB::Util.url_encode(zone_name)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_snapshot_clone(id:, zone_name:)
    # Retrieve a snapshot clone.
    # This request retrieves a single clone specified by the snapshot identifier and
    #   zone name in the URL.
    # @param id [String] The snapshot identifier.
    # @param zone_name [String] The zone name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_snapshot_clone(id:, zone_name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("zone_name must be provided") if zone_name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_snapshot_clone")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/snapshots/%s/clones/%s" % [ERB::Util.url_encode(id), ERB::Util.url_encode(zone_name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_snapshot_clone(id:, zone_name:)
    # Create a clone for a snapshot.
    # This request creates a new clone for a snapshot in the specified zone. A request
    #   body is not required, and if provided, is ignored. If the snapshot already has a
    #   clone in the zone, it is returned.
    # @param id [String] The snapshot identifier.
    # @param zone_name [String] The zone name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_snapshot_clone(id:, zone_name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("zone_name must be provided") if zone_name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_snapshot_clone")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/snapshots/%s/clones/%s" % [ERB::Util.url_encode(id), ERB::Util.url_encode(zone_name)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end
    #########################
    # Shares
    #########################

    ##
    # @!method list_share_profiles(start: nil, limit: nil, sort: nil)
    # List file share profiles.
    # This request lists [file share
    #   profiles](https://cloud.ibm.com/docs/vpc?topic=vpc-file-storage-profiles)
    #   available in the region. A file share profile specifies the performance
    #   characteristics and pricing model for a file share.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_share_profiles(start: nil, limit: nil, sort: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_share_profiles")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "sort" => sort
      }

      method_url = "/share/profiles"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_share_profile(name:)
    # Retrieve a file share profile.
    # This request retrieves a single file share profile specified by the name in the
    #   URL.
    # @param name [String] The file share profile name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_share_profile(name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("name must be provided") if name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_share_profile")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/share/profiles/%s" % [ERB::Util.url_encode(name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_shares(start: nil, limit: nil, resource_group_id: nil, name: nil, sort: nil, replication_role: nil)
    # List file shares.
    # This request lists file shares in the region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @param replication_role [String] Filters the collection to file shares with a `replication_role` property matching
    #   the specified value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_shares(start: nil, limit: nil, resource_group_id: nil, name: nil, sort: nil, replication_role: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_shares")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "name" => name,
        "sort" => sort,
        "replication_role" => replication_role
      }

      method_url = "/shares"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_share(share_prototype:)
    # Create a file share.
    # This request provisions new file shares from a share prototype object. The new
    #   file shares can be a standalone share, a replica share, or both a source and
    #   replica share.
    #
    #   The prototype object is structured in the same way as a retrieved share, and
    #   contains the information necessary to provision the new file shares.
    # @param share_prototype [SharePrototype] The file share prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_share(share_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_prototype must be provided") if share_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_share")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = share_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/shares"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_share(id:, if_match: nil)
    # Delete a file share.
    # This request deletes a share. This operation cannot be reversed. A share cannot be
    #   deleted if it:
    #   - has share mount targets
    #   - has a `lifecycle_state` of `updating`
    #   - has a replication operation in progress
    #
    #   If the request is accepted, the share `lifecycle_state` will be set to `deleting`.
    #   Once deletion processing completes, it will no longer be retrievable.
    # @param id [String] The file share identifier.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def delete_share(id:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_share")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/shares/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_share(id:)
    # Retrieve a file share.
    # This request retrieves a single file share specified by the identifier in the URL.
    # @param id [String] The file share identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_share(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_share")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/shares/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_share(id:, share_patch:, if_match: nil)
    # Update a file share.
    # This request updates a share with the information in a provided share patch. The
    #   share patch object is structured in the same way as a retrieved share and contains
    #   only the information to be updated.
    # @param id [String] The file share identifier.
    # @param share_patch [Hash] The file share patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_share(id:, share_patch:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("share_patch must be provided") if share_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_share")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = share_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/shares/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_share_accessor_bindings(id:, start: nil, limit: nil)
    # List accessor bindings for a file share.
    # This request lists accessor bindings for a share. Each accessor binding identifies
    #   a resource (possibly in another account) with access to this file share's data.
    #
    #   The share accessor bindings will be sorted by their `created_at` property values,
    #   with newest bindings first.
    # @param id [String] The file share identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_share_accessor_bindings(id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_share_accessor_bindings")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/shares/%s/accessor_bindings" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_share_accessor_binding(share_id:, id:)
    # Delete a file share accessor binding.
    # This request deletes a share accessor binding. This operation cannot be reversed.
    # @param share_id [String] The file share identifier.
    # @param id [String] The file share accessor binding identifier.
    # @return [nil]
    def delete_share_accessor_binding(share_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_id must be provided") if share_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_share_accessor_binding")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/shares/%s/accessor_bindings/%s" % [ERB::Util.url_encode(share_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_share_accessor_binding(share_id:, id:)
    # Retrieve a file share accessor binding.
    # This request retrieves a single accessor binding specified by the identifier in
    #   the URL.
    # @param share_id [String] The file share identifier.
    # @param id [String] The file share accessor binding identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_share_accessor_binding(share_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_id must be provided") if share_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_share_accessor_binding")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/shares/%s/accessor_bindings/%s" % [ERB::Util.url_encode(share_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method failover_share(share_id:, fallback_policy: nil, timeout: nil)
    # Failover to replica file share.
    # This request triggers a failover to the replica file share specified by the
    #   identifier in the URL. The failover cannot be started if a source share or the
    #   replica share has a `lifecycle_state` of `updating`, or has a replication
    #   operation in progress.
    #
    #   If `fallback_policy` is specified as `split`, and the request is accepted but the
    #   failover operation cannot be performed, a split will be triggered.
    # @param share_id [String] The file share identifier.
    # @param fallback_policy [String] The action to take if the failover request is accepted but cannot be performed or
    #   times out:
    #   - `fail`: Fail the operation, resulting in the replication relationship being
    #   unchanged.
    #   - `split`: Split the replica from its source, resulting in two individual
    #   read-write
    #       file shares. Because the final sync was not completed, the replica may be
    #       out-of-date. This occurs in disaster recovery scenarios where the source is
    #   known to
    #       be unreachable.
    # @param timeout [Fixnum] The failover timeout in seconds.
    #
    #   If the timeout is reached, the `fallback_policy` will be triggered.
    # @return [nil]
    def failover_share(share_id:, fallback_policy: nil, timeout: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_id must be provided") if share_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "failover_share")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "fallback_policy" => fallback_policy,
        "timeout" => timeout
      }

      method_url = "/shares/%s/failover" % [ERB::Util.url_encode(share_id)]

      request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: false
      )
      nil
    end

    ##
    # @!method list_share_mount_targets(share_id:, name: nil, start: nil, limit: nil)
    # List mount targets for a file share.
    # This request lists mount targets for a file share. A mount target is a network
    #   endpoint at which a file share may be mounted. The file share can be mounted by
    #   clients in the same VPC and zone after creating share mount targets.
    #
    #   The share mount targets will be sorted by their `created_at` property values, with
    #   newest targets first.
    # @param share_id [String] The file share identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_share_mount_targets(share_id:, name: nil, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_id must be provided") if share_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_share_mount_targets")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "name" => name,
        "start" => start,
        "limit" => limit
      }

      method_url = "/shares/%s/mount_targets" % [ERB::Util.url_encode(share_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_share_mount_target(share_id:, share_mount_target_prototype:)
    # Create a mount target for a file share.
    # This request creates a new share mount target from a share mount target prototype
    #   object.
    #
    #   The prototype object is structured in the same way as a retrieved share mount
    #   target, and contains the information necessary to provision the new file share
    #   mount target.
    # @param share_id [String] The file share identifier.
    # @param share_mount_target_prototype [ShareMountTargetPrototype] The share mount target prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_share_mount_target(share_id:, share_mount_target_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_id must be provided") if share_id.nil?

      raise ArgumentError.new("share_mount_target_prototype must be provided") if share_mount_target_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_share_mount_target")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = share_mount_target_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/shares/%s/mount_targets" % [ERB::Util.url_encode(share_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_share_mount_target(share_id:, id:)
    # Delete a file share mount target.
    # This request deletes a share mount target. This operation cannot be reversed.
    #
    #   If the request is accepted, the share mount target `lifecycle_state` will be set
    #   to
    #   `deleting`. Once deletion processing completes, it will no longer be retrievable.
    # @param share_id [String] The file share identifier.
    # @param id [String] The file share mount target identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def delete_share_mount_target(share_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_id must be provided") if share_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_share_mount_target")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/shares/%s/mount_targets/%s" % [ERB::Util.url_encode(share_id), ERB::Util.url_encode(id)]

      response = request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_share_mount_target(share_id:, id:)
    # Retrieve a file share mount target.
    # This request retrieves a single share mount target specified by the identifier in
    #   the URL.
    # @param share_id [String] The file share identifier.
    # @param id [String] The file share mount target identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_share_mount_target(share_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_id must be provided") if share_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_share_mount_target")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/shares/%s/mount_targets/%s" % [ERB::Util.url_encode(share_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_share_mount_target(share_id:, id:, share_mount_target_patch:)
    # Update a file share mount target.
    # This request updates a share mount target with the information provided in a share
    #   mount target patch object. The share mount target patch object is structured in
    #   the same way as a retrieved share mount target and needs to contain only the
    #   information to be updated.
    # @param share_id [String] The file share identifier.
    # @param id [String] The file share mount target identifier.
    # @param share_mount_target_patch [Hash] The share mount target patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_share_mount_target(share_id:, id:, share_mount_target_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_id must be provided") if share_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("share_mount_target_patch must be provided") if share_mount_target_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_share_mount_target")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = share_mount_target_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/shares/%s/mount_targets/%s" % [ERB::Util.url_encode(share_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_share_source(share_id:)
    # Split the source file share from a replica file share.
    # This request removes the replication relationship between a source share and the
    #   replica share specified by the identifier in the URL. The replication relationship
    #   cannot be removed if a source share or the replica share has a `lifecycle_state`
    #   of `updating`, or has a replication operation in progress.
    #
    #   This operation cannot be reversed.
    # @param share_id [String] The file share identifier.
    # @return [nil]
    def delete_share_source(share_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_id must be provided") if share_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_share_source")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/shares/%s/source" % [ERB::Util.url_encode(share_id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_share_source(share_id:)
    # Retrieve the source file share for a replica file share.
    # This request retrieves the source file share associated with the replica file
    #   share specified by the identifier in the URL.
    # @param share_id [String] The file share identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_share_source(share_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("share_id must be provided") if share_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_share_source")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/shares/%s/source" % [ERB::Util.url_encode(share_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end
    #########################
    # Backup policies
    #########################

    ##
    # @!method list_backup_policies(start: nil, limit: nil, resource_group_id: nil, name: nil, tag: nil)
    # List backup policies.
    # This request lists backup policies in the region. Backup policies control which
    #   sources are selected for backup and include a set of backup policy plans that
    #   provide the backup schedules and deletion triggers.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param tag [String] Filters the collection to resources with an item in the `tags` property matching
    #   the exact specified tag.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_backup_policies(start: nil, limit: nil, resource_group_id: nil, name: nil, tag: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_backup_policies")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "name" => name,
        "tag" => tag
      }

      method_url = "/backup_policies"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_backup_policy(backup_policy_prototype:)
    # Create a backup policy.
    # This request creates a new backup policy from a backup policy prototype object.
    #   The prototype object is structured in the same way as a retrieved backup policy,
    #   and contains the information necessary to create the new backup policy.
    # @param backup_policy_prototype [BackupPolicyPrototype] The backup policy prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_backup_policy(backup_policy_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("backup_policy_prototype must be provided") if backup_policy_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_backup_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = backup_policy_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/backup_policies"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_backup_policy_jobs(backup_policy_id:, status: nil, backup_policy_plan_id: nil, start: nil, limit: nil, sort: nil, source_id: nil, target_snapshots_id: nil, target_snapshots_crn: nil)
    # List jobs for a backup policy.
    # This request retrieves jobs for a backup policy. A backup job represents the
    #   execution of a backup policy plan for a resource matching the policy's criteria.
    # @param backup_policy_id [String] The backup policy identifier.
    # @param status [String] Filters the collection to backup policy jobs with a `status` property matching the
    #   specified value.
    # @param backup_policy_plan_id [String] Filters the collection to backup policy jobs with a `backup_policy_plan.id`
    #   property matching the specified identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @param source_id [String] Filters the collection to backup policy jobs with a `source.id` property matching
    #   the specified identifier.
    # @param target_snapshots_id [String] Filters the collection to backup policy jobs with an item in the
    #   `target_snapshots` property with an `id` property matching the specified
    #   identifier.
    # @param target_snapshots_crn [String] Filters the collection to backup policy jobs with an item in the
    #   `target_snapshots` property with a `crn` property matching the specified CRN.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_backup_policy_jobs(backup_policy_id:, status: nil, backup_policy_plan_id: nil, start: nil, limit: nil, sort: nil, source_id: nil, target_snapshots_id: nil, target_snapshots_crn: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("backup_policy_id must be provided") if backup_policy_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_backup_policy_jobs")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "status" => status,
        "backup_policy_plan.id" => backup_policy_plan_id,
        "start" => start,
        "limit" => limit,
        "sort" => sort,
        "source.id" => source_id,
        "target_snapshots[].id" => target_snapshots_id,
        "target_snapshots[].crn" => target_snapshots_crn
      }

      method_url = "/backup_policies/%s/jobs" % [ERB::Util.url_encode(backup_policy_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_backup_policy_job(backup_policy_id:, id:)
    # Retrieve a backup policy job.
    # This request retrieves a single backup policy job specified by the identifier in
    #   the URL.
    # @param backup_policy_id [String] The backup policy identifier.
    # @param id [String] The backup policy job identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_backup_policy_job(backup_policy_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("backup_policy_id must be provided") if backup_policy_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_backup_policy_job")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/backup_policies/%s/jobs/%s" % [ERB::Util.url_encode(backup_policy_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_backup_policy_plans(backup_policy_id:, name: nil)
    # List plans for a backup policy.
    # This request retrieves plans for a backup policy. Backup plans provide the backup
    #   schedule and deletion triggers.
    # @param backup_policy_id [String] The backup policy identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_backup_policy_plans(backup_policy_id:, name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("backup_policy_id must be provided") if backup_policy_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_backup_policy_plans")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "name" => name
      }

      method_url = "/backup_policies/%s/plans" % [ERB::Util.url_encode(backup_policy_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_backup_policy_plan(backup_policy_id:, cron_spec:, active: nil, attach_user_tags: nil, clone_policy: nil, copy_user_tags: nil, deletion_trigger: nil, name: nil, remote_region_policies: nil)
    # Create a plan for a backup policy.
    # This request creates a new backup policy plan from a backup policy plan prototype
    #   object. The prototype object is structured in the same way as a retrieved backup
    #   policy plan, and contains the information necessary to create the new backup
    #   policy plan.
    #
    #   Backups created by this plan will use the resource group of the source being
    #   backed up.
    #
    #   Backups created by this plan will use the plan's name truncated to 46 characters,
    #   followed by a unique 16-character suffix.
    # @param backup_policy_id [String] The backup policy identifier.
    # @param cron_spec [String] The cron specification for the backup schedule. The backup policy jobs
    #   (which create and delete backups for this plan) will not start until this time,
    #   and may start for up to 90 minutes after this time.
    #
    #   All backup schedules for plans in the same policy must be at least an hour apart.
    # @param active [Boolean] Indicates whether the plan is active.
    # @param attach_user_tags [Array[String]] User tags to attach to each backup (snapshot) created by this plan. If
    #   unspecified, no user tags will be attached.
    # @param clone_policy [BackupPolicyPlanClonePolicyPrototype]
    # @param copy_user_tags [Boolean] Indicates whether to copy the source's user tags to the created backups
    #   (snapshots).
    # @param deletion_trigger [BackupPolicyPlanDeletionTriggerPrototype]
    # @param name [String] The name for this backup policy plan. The name must not be used by another plan
    #   for the backup policy. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param remote_region_policies [Array[BackupPolicyPlanRemoteRegionPolicyPrototype]] The policies for additional backups in remote regions.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_backup_policy_plan(backup_policy_id:, cron_spec:, active: nil, attach_user_tags: nil, clone_policy: nil, copy_user_tags: nil, deletion_trigger: nil, name: nil, remote_region_policies: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("backup_policy_id must be provided") if backup_policy_id.nil?

      raise ArgumentError.new("cron_spec must be provided") if cron_spec.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_backup_policy_plan")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "cron_spec" => cron_spec,
        "active" => active,
        "attach_user_tags" => attach_user_tags,
        "clone_policy" => clone_policy,
        "copy_user_tags" => copy_user_tags,
        "deletion_trigger" => deletion_trigger,
        "name" => name,
        "remote_region_policies" => remote_region_policies
      }

      method_url = "/backup_policies/%s/plans" % [ERB::Util.url_encode(backup_policy_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_backup_policy_plan(backup_policy_id:, id:, if_match: nil)
    # Delete a backup policy plan.
    # This request deletes a backup policy plan. This operation cannot be reversed. Any
    #   backups that have been created by the plan will remain but will no longer be
    #   subject to the plan's deletion trigger. Any running jobs associated with the plan
    #   will run to completion before the plan is deleted.
    #
    #   If the request is accepted, the backup policy plan `status` will be set to
    #   `deleting`. Once deletion processing completes, the backup policy plan will no
    #   longer be retrievable.
    # @param backup_policy_id [String] The backup policy identifier.
    # @param id [String] The backup policy plan identifier.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def delete_backup_policy_plan(backup_policy_id:, id:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("backup_policy_id must be provided") if backup_policy_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_backup_policy_plan")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/backup_policies/%s/plans/%s" % [ERB::Util.url_encode(backup_policy_id), ERB::Util.url_encode(id)]

      response = request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_backup_policy_plan(backup_policy_id:, id:)
    # Retrieve a backup policy plan.
    # This request retrieves a single backup policy plan specified by the identifier in
    #   the URL.
    # @param backup_policy_id [String] The backup policy identifier.
    # @param id [String] The backup policy plan identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_backup_policy_plan(backup_policy_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("backup_policy_id must be provided") if backup_policy_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_backup_policy_plan")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/backup_policies/%s/plans/%s" % [ERB::Util.url_encode(backup_policy_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_backup_policy_plan(backup_policy_id:, id:, backup_policy_plan_patch:, if_match: nil)
    # Update a backup policy plan.
    # This request updates a backup policy plan with the information in a provided plan
    #   patch. The plan patch object is structured in the same way as a retrieved backup
    #   policy plan and can contains only the information to be updated.
    # @param backup_policy_id [String] The backup policy identifier.
    # @param id [String] The backup policy plan identifier.
    # @param backup_policy_plan_patch [Hash] The backup policy plan patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_backup_policy_plan(backup_policy_id:, id:, backup_policy_plan_patch:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("backup_policy_id must be provided") if backup_policy_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("backup_policy_plan_patch must be provided") if backup_policy_plan_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_backup_policy_plan")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = backup_policy_plan_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/backup_policies/%s/plans/%s" % [ERB::Util.url_encode(backup_policy_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_backup_policy(id:, if_match: nil)
    # Delete a backup policy.
    # This request deletes a backup policy. This operation cannot be reversed.
    #
    #   If the request is accepted, the backup policy `status` will be set to `deleting`.
    #   Once deletion processing completes, the backup policy will no longer be
    #   retrievable.
    # @param id [String] The backup policy identifier.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def delete_backup_policy(id:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_backup_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/backup_policies/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_backup_policy(id:)
    # Retrieve a backup policy.
    # This request retrieves a single backup policy specified by the identifier in the
    #   URL.
    # @param id [String] The backup policy identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_backup_policy(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_backup_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/backup_policies/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_backup_policy(id:, backup_policy_patch:, if_match: nil)
    # Update a backup policy.
    # This request updates a backup policy with the information in a provided backup
    #   policy patch. The backup policy patch object is structured in the same way as a
    #   retrieved backup policy and contains only the information to be updated.
    # @param id [String] The backup policy identifier.
    # @param backup_policy_patch [Hash] The backup policy patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_backup_policy(id:, backup_policy_patch:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("backup_policy_patch must be provided") if backup_policy_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_backup_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = backup_policy_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/backup_policies/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Geography
    #########################

    ##
    # @!method list_regions
    # List regions.
    # This request lists regions. Each region is a separate geographic area that
    #   contains multiple isolated zones. Resources can be provisioned into one or more
    #   zones in a region. Each zone is isolated, but connected to other zones in the same
    #   region with low-latency and high-bandwidth links. Regions represent the top-level
    #   of fault isolation available. Resources deployed within a single region also
    #   benefit from the low latency afforded by geographic proximity.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_regions
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_regions")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/regions"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_region(name:)
    # Retrieve a region.
    # This request retrieves a single region specified by the name in the URL.
    # @param name [String] The region name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_region(name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("name must be provided") if name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_region")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/regions/%s" % [ERB::Util.url_encode(name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_region_zones(region_name:)
    # List zones in a region.
    # This request lists zones in a region. Zones represent logically-isolated data
    #   centers with high-bandwidth and low-latency interconnects to other zones in the
    #   same region. Faults in a zone do not affect other zones.
    # @param region_name [String] The region name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_region_zones(region_name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("region_name must be provided") if region_name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_region_zones")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/regions/%s/zones" % [ERB::Util.url_encode(region_name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_region_zone(region_name:, name:)
    # Retrieve a zone.
    # This request retrieves a single zone specified by the region and zone names in the
    #   URL.
    # @param region_name [String] The region name.
    # @param name [String] The zone name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_region_zone(region_name:, name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("region_name must be provided") if region_name.nil?

      raise ArgumentError.new("name must be provided") if name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_region_zone")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/regions/%s/zones/%s" % [ERB::Util.url_encode(region_name), ERB::Util.url_encode(name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end
    #########################
    # Virtual network interfaces
    #########################

    ##
    # @!method list_virtual_network_interfaces(start: nil, limit: nil, resource_group_id: nil)
    # List virtual network interfaces.
    # This request lists virtual network interfaces in the region. A virtual network
    #   interface is a logical abstraction of a virtual network interface in a subnet, and
    #   may be attached to a target resource.
    #
    #   The virtual network interfaces will be sorted by their `created_at` property
    #   values, with newest virtual network interfaces first. Virtual network interfaces
    #   with identical
    #   `created_at` property values will in turn be sorted by ascending `name` property
    #   values.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_virtual_network_interfaces(start: nil, limit: nil, resource_group_id: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_virtual_network_interfaces")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id
      }

      method_url = "/virtual_network_interfaces"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_virtual_network_interface(allow_ip_spoofing: nil, auto_delete: nil, enable_infrastructure_nat: nil, ips: nil, name: nil, primary_ip: nil, protocol_state_filtering_mode: nil, resource_group: nil, security_groups: nil, subnet: nil)
    # Create a virtual network interface.
    # This request creates a new virtual network interface from a virtual network
    #   interface prototype object. The prototype object is structured in the same way as
    #   a retrieved virtual network interface, and contains the information necessary to
    #   create the new virtual network interface.
    # @param allow_ip_spoofing [Boolean] Indicates whether source IP spoofing is allowed on this interface. If `false`,
    #   source IP spoofing is prevented on this interface. If `true`, source IP spoofing
    #   is allowed on this interface.
    # @param auto_delete [Boolean] Indicates whether this virtual network interface will be automatically deleted
    #   when
    #   `target` is deleted. Must be `false` if the virtual network interface is unbound.
    # @param enable_infrastructure_nat [Boolean] If `true`:
    #   - The VPC infrastructure performs any needed NAT operations.
    #   - `floating_ips` must not have more than one floating IP.
    #
    #   If `false`:
    #   - Packets are passed unchanged to/from the virtual network interface,
    #     allowing the workload to perform any needed NAT operations.
    #   - `allow_ip_spoofing` must be `false`.
    #   - Can only be attached to a `target` with a `resource_type` of
    #     `bare_metal_server_network_attachment`.
    # @param ips [Array[VirtualNetworkInterfaceIPPrototype]] Additional IP addresses to bind to the virtual network interface. Each item may be
    #   either a reserved IP identity, or a reserved IP prototype object which will be
    #   used to create a new reserved IP. All IP addresses must be in the primary IP's
    #   subnet.
    #
    #   If reserved IP identities are provided, the specified reserved IPs must be
    #   unbound.
    #
    #   If reserved IP prototype objects with addresses are provided, the addresses must
    #   be available on the virtual network interface's subnet. For any prototype objects
    #   that do not specify an address, an available address on the subnet will be
    #   automatically selected and reserved.
    # @param name [String] The name for this virtual network interface. The name must not be used by another
    #   virtual network interface in the VPC. If unspecified, the name will be a
    #   hyphenated list of randomly-selected words. Names beginning with `ibm-` are
    #   reserved for provider-owned resources, and are not allowed.
    # @param primary_ip [VirtualNetworkInterfacePrimaryIPPrototype] The primary IP address to bind to the virtual network interface. May be either a
    #   reserved IP identity, or a reserved IP prototype object which will be used to
    #   create a
    #   new reserved IP.
    #
    #   If a reserved IP identity is provided, the specified reserved IP must be unbound.
    #
    #   If a reserved IP prototype object with an address is provided, the address must be
    #   available on the virtual network interface's subnet. If no address is specified,
    #   an available address on the subnet will be automatically selected and reserved.
    # @param protocol_state_filtering_mode [String] The protocol state filtering mode to use for this virtual network interface. If
    #   `auto`, protocol state packet filtering is enabled or disabled based on the
    #   virtual network interface's `target` resource type:
    #
    #   - `bare_metal_server_network_attachment`: disabled
    #   - `instance_network_attachment`: enabled
    #   - `share_mount_target`: enabled
    #
    #   Protocol state filtering monitors each network connection flowing over this
    #   virtual network interface, and drops any packets that are invalid based on the
    #   current connection state and protocol. See [Protocol state filtering
    #   mode](https://cloud.ibm.com/docs/vpc?topic=vpc-vni-about#protocol-state-filtering)
    #   for more information.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @param security_groups [Array[SecurityGroupIdentity]] The security groups to use for this virtual network interface. If unspecified, the
    #   default security group of the VPC for the subnet is used.
    # @param subnet [SubnetIdentity] The associated subnet. Required if `primary_ip` does not specify a reserved IP
    #   identity.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_virtual_network_interface(allow_ip_spoofing: nil, auto_delete: nil, enable_infrastructure_nat: nil, ips: nil, name: nil, primary_ip: nil, protocol_state_filtering_mode: nil, resource_group: nil, security_groups: nil, subnet: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_virtual_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "allow_ip_spoofing" => allow_ip_spoofing,
        "auto_delete" => auto_delete,
        "enable_infrastructure_nat" => enable_infrastructure_nat,
        "ips" => ips,
        "name" => name,
        "primary_ip" => primary_ip,
        "protocol_state_filtering_mode" => protocol_state_filtering_mode,
        "resource_group" => resource_group,
        "security_groups" => security_groups,
        "subnet" => subnet
      }

      method_url = "/virtual_network_interfaces"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_virtual_network_interfaces(id:)
    # Delete a virtual network interface.
    # This request deletes a virtual network interface. This operation cannot be
    #   reversed. For this request to succeed, the virtual network interface must not be
    #   required by another resource, such as the primary network attachment for an
    #   instance.
    # @param id [String] The virtual network interface identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def delete_virtual_network_interfaces(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_virtual_network_interfaces")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/virtual_network_interfaces/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_virtual_network_interface(id:)
    # Retrieve a virtual network interface.
    # This request retrieves a single virtual network interface specified by the
    #   identifier in the URL.
    # @param id [String] The virtual network interface identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_virtual_network_interface(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_virtual_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/virtual_network_interfaces/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_virtual_network_interface(id:, virtual_network_interface_patch:)
    # Update a virtual network interface.
    # This request updates a virtual network interface with the information in a
    #   provided virtual network interface patch. The virtual network interface patch
    #   object is structured in the same way as a retrieved virtual network interface and
    #   contains only the information to be updated.
    # @param id [String] The virtual network interface identifier.
    # @param virtual_network_interface_patch [Hash] The virtual network interface patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_virtual_network_interface(id:, virtual_network_interface_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("virtual_network_interface_patch must be provided") if virtual_network_interface_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_virtual_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = virtual_network_interface_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/virtual_network_interfaces/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_network_interface_floating_ips(virtual_network_interface_id:, start: nil, limit: nil, sort: nil)
    # List floating IPs associated with a virtual network interface.
    # This request lists floating IPs associated with a virtual network interface.
    # @param virtual_network_interface_id [String] The virtual network interface identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value
    #   `-name` sorts the collection by the `name` property in descending order, and the
    #   value `name` sorts it by the `name` property in ascending order.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_network_interface_floating_ips(virtual_network_interface_id:, start: nil, limit: nil, sort: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("virtual_network_interface_id must be provided") if virtual_network_interface_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_network_interface_floating_ips")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "sort" => sort
      }

      method_url = "/virtual_network_interfaces/%s/floating_ips" % [ERB::Util.url_encode(virtual_network_interface_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method remove_network_interface_floating_ip(virtual_network_interface_id:, id:)
    # Disassociate a floating IP from a virtual network interface.
    # This request disassociates the specified floating IP from the specified virtual
    #   network interface.
    # @param virtual_network_interface_id [String] The virtual network interface identifier.
    # @param id [String] The floating IP identifier.
    # @return [nil]
    def remove_network_interface_floating_ip(virtual_network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("virtual_network_interface_id must be provided") if virtual_network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "remove_network_interface_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/virtual_network_interfaces/%s/floating_ips/%s" % [ERB::Util.url_encode(virtual_network_interface_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_network_interface_floating_ip(virtual_network_interface_id:, id:)
    # Retrieve associated floating IP.
    # This request retrieves a specified floating IP if it is associated with the
    #   virtual network interface specified in the URL.
    # @param virtual_network_interface_id [String] The virtual network interface identifier.
    # @param id [String] The floating IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_network_interface_floating_ip(virtual_network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("virtual_network_interface_id must be provided") if virtual_network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_network_interface_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/virtual_network_interfaces/%s/floating_ips/%s" % [ERB::Util.url_encode(virtual_network_interface_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method add_network_interface_floating_ip(virtual_network_interface_id:, id:)
    # Add an association between a floating IP and a virtual network interface.
    # This request adds an association between the specified floating IP and the
    #   specified virtual network interface.
    #
    #   If the virtual network interface has `enable_infrastructure_nat` set to `true`, no
    #   more than one floating IP can be associated, and network address translation is
    #   performed between the floating IP address and the virtual network interface's
    #   `primary_ip` address.
    #
    #   If the virtual network interface has `enable_infrastructure_nat` set to `false`,
    #   packets are passed unchanged to/from the virtual network interface.
    #
    #   The floating IP must:
    #   - be in the same `zone` as the virtual network interface
    #   - not currently be associated with another resource
    #
    #   The virtual network interface's `target` must not currently be a file share mount
    #   target.
    #
    #   A request body is not required, and if provided, is ignored.
    # @param virtual_network_interface_id [String] The virtual network interface identifier.
    # @param id [String] The floating IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def add_network_interface_floating_ip(virtual_network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("virtual_network_interface_id must be provided") if virtual_network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "add_network_interface_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/virtual_network_interfaces/%s/floating_ips/%s" % [ERB::Util.url_encode(virtual_network_interface_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_virtual_network_interface_ips(virtual_network_interface_id:, start: nil, limit: nil, sort: nil)
    # List reserved IPs bound to a virtual network interface.
    # This request lists reserved IPs bound to a virtual network interface.
    # @param virtual_network_interface_id [String] The virtual network interface identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value
    #   `-name` sorts the collection by the `name` property in descending order, and the
    #   value `name` sorts it by the `name` property in ascending order.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_virtual_network_interface_ips(virtual_network_interface_id:, start: nil, limit: nil, sort: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("virtual_network_interface_id must be provided") if virtual_network_interface_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_virtual_network_interface_ips")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "sort" => sort
      }

      method_url = "/virtual_network_interfaces/%s/ips" % [ERB::Util.url_encode(virtual_network_interface_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method remove_virtual_network_interface_ip(virtual_network_interface_id:, id:)
    # Unbind a reserved IP from a virtual network interface.
    # This request unbinds the specified reserved IP from the specified virtual network
    #   interface. If the reserved IP has `auto_delete` set to `true`, the reserved IP
    #   will be deleted.
    #
    #   The reserved IP for the `primary_ip` cannot be unbound.
    # @param virtual_network_interface_id [String] The virtual network interface identifier.
    # @param id [String] The reserved IP identifier.
    # @return [nil]
    def remove_virtual_network_interface_ip(virtual_network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("virtual_network_interface_id must be provided") if virtual_network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "remove_virtual_network_interface_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/virtual_network_interfaces/%s/ips/%s" % [ERB::Util.url_encode(virtual_network_interface_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_virtual_network_interface_ip(virtual_network_interface_id:, id:)
    # Retrieve bound reserved IP.
    # This request retrieves the specified reserved IP address if it is bound to the
    #   virtual network interface specified in the URL.
    # @param virtual_network_interface_id [String] The virtual network interface identifier.
    # @param id [String] The reserved IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_virtual_network_interface_ip(virtual_network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("virtual_network_interface_id must be provided") if virtual_network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_virtual_network_interface_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/virtual_network_interfaces/%s/ips/%s" % [ERB::Util.url_encode(virtual_network_interface_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method add_virtual_network_interface_ip(virtual_network_interface_id:, id:)
    # Bind a reserved IP to a virtual network interface.
    # This request binds the specified reserved IP to the specified virtual network
    #   interface.
    #
    #   The reserved IP must currently be unbound and in the primary IP's subnet. The
    #   virtual network interface's `target` must not currently be a file share mount
    #   target.
    # @param virtual_network_interface_id [String] The virtual network interface identifier.
    # @param id [String] The reserved IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def add_virtual_network_interface_ip(virtual_network_interface_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("virtual_network_interface_id must be provided") if virtual_network_interface_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "add_virtual_network_interface_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/virtual_network_interfaces/%s/ips/%s" % [ERB::Util.url_encode(virtual_network_interface_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end
    #########################
    # Public gateways
    #########################

    ##
    # @!method list_public_gateways(start: nil, limit: nil, resource_group_id: nil)
    # List public gateways.
    # This request lists public gateways in the region. A public gateway is a virtual
    #   network device associated with a VPC, which allows access to the Internet. A
    #   public gateway resides in a zone and can be connected to subnets in the same zone
    #   only.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_public_gateways(start: nil, limit: nil, resource_group_id: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_public_gateways")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id
      }

      method_url = "/public_gateways"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_public_gateway(vpc:, zone:, floating_ip: nil, name: nil, resource_group: nil)
    # Create a public gateway.
    # This request creates a new public gateway from a public gateway prototype object.
    #   For this to succeed, the VPC must not already have a public gateway in the
    #   specified zone.
    #
    #   If a floating IP is provided, it must be unbound. If a floating IP is not
    #   provided, one will be created and bound to the public gateway. Once a public
    #   gateway has been created, its floating IP cannot be unbound. A public gateway must
    #   be explicitly attached to each subnet it will provide connectivity for.
    # @param vpc [VPCIdentity] The VPC this public gateway will reside in.
    # @param zone [ZoneIdentity] The zone this public gateway will reside in.
    # @param floating_ip [PublicGatewayFloatingIPPrototype]
    # @param name [String] The name for this public gateway. The name must not be used by another public
    #   gateway in the VPC. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_public_gateway(vpc:, zone:, floating_ip: nil, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc must be provided") if vpc.nil?

      raise ArgumentError.new("zone must be provided") if zone.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_public_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "vpc" => vpc,
        "zone" => zone,
        "floating_ip" => floating_ip,
        "name" => name,
        "resource_group" => resource_group
      }

      method_url = "/public_gateways"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_public_gateway(id:)
    # Delete a public gateway.
    # This request deletes a public gateway. This operation cannot be reversed. For this
    #   request to succeed, the public gateway must not be attached to any subnets. The
    #   public gateway's floating IP will be automatically unbound. If the floating IP was
    #   created when the public gateway was created, it will be deleted.
    # @param id [String] The public gateway identifier.
    # @return [nil]
    def delete_public_gateway(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_public_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/public_gateways/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_public_gateway(id:)
    # Retrieve a public gateway.
    # This request retrieves a single public gateway specified by the identifier in the
    #   URL.
    # @param id [String] The public gateway identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_public_gateway(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_public_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/public_gateways/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_public_gateway(id:, public_gateway_patch:)
    # Update a public gateway.
    # This request updates a public gateway's name.
    # @param id [String] The public gateway identifier.
    # @param public_gateway_patch [Hash] The public gateway patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_public_gateway(id:, public_gateway_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("public_gateway_patch must be provided") if public_gateway_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_public_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = public_gateway_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/public_gateways/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Floating IPs
    #########################

    ##
    # @!method list_floating_ips(start: nil, limit: nil, resource_group_id: nil, sort: nil, target_id: nil, target_crn: nil, target_name: nil, target_resource_type: nil)
    # List floating IPs.
    # This request lists floating IPs in the region. Floating IPs allow inbound and
    #   outbound traffic from the Internet to an instance.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @param target_id [String] Filters the collection to resources with a `target.id` property matching the
    #   specified identifier.
    # @param target_crn [String] Filters the collection to resources with a `target.crn` property matching the
    #   specified CRN.
    # @param target_name [String] Filters the collection to resources with a `target.name` property matching the
    #   exact specified name.
    # @param target_resource_type [String] Filters the collection to resources with a `target.resource_type` property
    #   matching the specified value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_floating_ips(start: nil, limit: nil, resource_group_id: nil, sort: nil, target_id: nil, target_crn: nil, target_name: nil, target_resource_type: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_floating_ips")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "sort" => sort,
        "target.id" => target_id,
        "target.crn" => target_crn,
        "target.name" => target_name,
        "target.resource_type" => target_resource_type
      }

      method_url = "/floating_ips"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_floating_ip(floating_ip_prototype:)
    # Reserve a floating IP.
    # This request reserves a new floating IP.
    # @param floating_ip_prototype [FloatingIPPrototype] The floating IP prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_floating_ip(floating_ip_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("floating_ip_prototype must be provided") if floating_ip_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = floating_ip_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/floating_ips"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_floating_ip(id:)
    # Delete a floating IP.
    # This request disassociates (if associated) and releases a floating IP. This
    #   operation cannot be reversed. For this request to succeed, the floating IP must
    #   not be required by another resource, such as a public gateway.
    # @param id [String] The floating IP identifier.
    # @return [nil]
    def delete_floating_ip(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/floating_ips/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_floating_ip(id:)
    # Retrieve a floating IP.
    # This request retrieves a single floating IP specified by the identifier in the
    #   URL.
    # @param id [String] The floating IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_floating_ip(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/floating_ips/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_floating_ip(id:, floating_ip_patch:)
    # Update a floating IP.
    # This request updates a floating IP's name and/or target.
    # @param id [String] The floating IP identifier.
    # @param floating_ip_patch [Hash] The floating IP patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_floating_ip(id:, floating_ip_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("floating_ip_patch must be provided") if floating_ip_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_floating_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = floating_ip_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/floating_ips/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Network ACLs
    #########################

    ##
    # @!method list_network_acls(start: nil, limit: nil, resource_group_id: nil)
    # List network ACLs.
    # This request lists network ACLs in the region. A network ACL defines a set of
    #   packet filtering (5-tuple) rules for all traffic in and out of a subnet. Both
    #   allow and deny rules can be defined, and rules are stateless such that reverse
    #   traffic in response to allowed traffic is not automatically permitted.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_network_acls(start: nil, limit: nil, resource_group_id: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_network_acls")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id
      }

      method_url = "/network_acls"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_network_acl(network_acl_prototype:)
    # Create a network ACL.
    # This request creates a new stateless network ACL from a network ACL prototype
    #   object. The prototype object is structured in the same way as a retrieved network
    #   ACL, and contains the information necessary to create the new network ACL.
    # @param network_acl_prototype [NetworkACLPrototype] The network ACL prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_network_acl(network_acl_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("network_acl_prototype must be provided") if network_acl_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_network_acl")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = network_acl_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/network_acls"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_network_acl(id:)
    # Delete a network ACL.
    # This request deletes a network ACL. This operation cannot be reversed. For this
    #   request to succeed, the network ACL must not be the default network ACL for any
    #   VPCs, and the network ACL must not be attached to any subnets.
    # @param id [String] The network ACL identifier.
    # @return [nil]
    def delete_network_acl(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_network_acl")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/network_acls/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_network_acl(id:)
    # Retrieve a network ACL.
    # This request retrieves a single network ACL specified by the identifier in the
    #   URL.
    # @param id [String] The network ACL identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_network_acl(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_network_acl")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/network_acls/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_network_acl(id:, network_acl_patch:)
    # Update a network ACL.
    # This request updates a network ACL's name.
    # @param id [String] The network ACL identifier.
    # @param network_acl_patch [Hash] The network ACL patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_network_acl(id:, network_acl_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("network_acl_patch must be provided") if network_acl_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_network_acl")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = network_acl_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/network_acls/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_network_acl_rules(network_acl_id:, start: nil, limit: nil, direction: nil)
    # List rules for a network ACL.
    # This request lists rules for a network ACL. These rules can allow or deny traffic
    #   between a source CIDR block and a destination CIDR block over a particular
    #   protocol and port range.
    # @param network_acl_id [String] The network ACL identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param direction [String] Filters the collection to rules with a `direction` property matching the specified
    #   value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_network_acl_rules(network_acl_id:, start: nil, limit: nil, direction: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("network_acl_id must be provided") if network_acl_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_network_acl_rules")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "direction" => direction
      }

      method_url = "/network_acls/%s/rules" % [ERB::Util.url_encode(network_acl_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_network_acl_rule(network_acl_id:, network_acl_rule_prototype:)
    # Create a rule for a network ACL.
    # This request creates a new rule from a network ACL rule prototype object. The
    #   prototype object is structured in the same way as a retrieved rule, and contains
    #   the information necessary to create the new rule.
    # @param network_acl_id [String] The network ACL identifier.
    # @param network_acl_rule_prototype [NetworkACLRulePrototype] The network ACL rule prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_network_acl_rule(network_acl_id:, network_acl_rule_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("network_acl_id must be provided") if network_acl_id.nil?

      raise ArgumentError.new("network_acl_rule_prototype must be provided") if network_acl_rule_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_network_acl_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = network_acl_rule_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/network_acls/%s/rules" % [ERB::Util.url_encode(network_acl_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_network_acl_rule(network_acl_id:, id:)
    # Delete a network ACL rule.
    # This request deletes a rule. This operation cannot be reversed.
    # @param network_acl_id [String] The network ACL identifier.
    # @param id [String] The rule identifier.
    # @return [nil]
    def delete_network_acl_rule(network_acl_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("network_acl_id must be provided") if network_acl_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_network_acl_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/network_acls/%s/rules/%s" % [ERB::Util.url_encode(network_acl_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_network_acl_rule(network_acl_id:, id:)
    # Retrieve a network ACL rule.
    # This request retrieves a single rule specified by the identifier in the URL.
    # @param network_acl_id [String] The network ACL identifier.
    # @param id [String] The rule identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_network_acl_rule(network_acl_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("network_acl_id must be provided") if network_acl_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_network_acl_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/network_acls/%s/rules/%s" % [ERB::Util.url_encode(network_acl_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_network_acl_rule(network_acl_id:, id:, network_acl_rule_patch:)
    # Update a network ACL rule.
    # This request updates a rule with the information in a provided rule patch. The
    #   rule patch object contains only the information to be updated. The request will
    #   fail if the information is not applicable to the rule's protocol.
    # @param network_acl_id [String] The network ACL identifier.
    # @param id [String] The rule identifier.
    # @param network_acl_rule_patch [Hash] The network ACL rule patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_network_acl_rule(network_acl_id:, id:, network_acl_rule_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("network_acl_id must be provided") if network_acl_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("network_acl_rule_patch must be provided") if network_acl_rule_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_network_acl_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = network_acl_rule_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/network_acls/%s/rules/%s" % [ERB::Util.url_encode(network_acl_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Security groups
    #########################

    ##
    # @!method list_security_groups(start: nil, limit: nil, resource_group_id: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil)
    # List security groups.
    # This request lists security groups in the region. Security groups provide a way to
    #   apply IP filtering rules to instances in the associated VPC. With security groups,
    #   all traffic is denied by default, and rules added to security groups define which
    #   traffic the security group permits. Security group rules are stateful such that
    #   reverse traffic in response to allowed traffic is automatically permitted.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param vpc_id [String] Filters the collection to resources with a `vpc.id` property matching the
    #   specified identifier.
    # @param vpc_crn [String] Filters the collection to resources with a `vpc.crn` property matching the
    #   specified CRN.
    # @param vpc_name [String] Filters the collection to resources with a `vpc.name` property matching the exact
    #   specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_security_groups(start: nil, limit: nil, resource_group_id: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_security_groups")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "vpc.id" => vpc_id,
        "vpc.crn" => vpc_crn,
        "vpc.name" => vpc_name
      }

      method_url = "/security_groups"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_security_group(vpc:, name: nil, resource_group: nil, rules: nil)
    # Create a security group.
    # This request creates a new security group from a security group prototype object.
    #   The prototype object is structured in the same way as a retrieved security group,
    #   and contains the information necessary to create the new security group. If
    #   security group rules are included in the prototype object, those rules will be
    #   added to the security group. Each security group is scoped to one VPC. Only
    #   resources in that VPC can be added to the security group.
    # @param vpc [VPCIdentity] The VPC this security group will reside in.
    # @param name [String] The name for this security group. The name must not be used by another security
    #   group for the VPC. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @param rules [Array[SecurityGroupRulePrototype]] The prototype objects for rules to be created for this security group. If
    #   unspecified, no rules will be created, resulting in all traffic being denied.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_security_group(vpc:, name: nil, resource_group: nil, rules: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc must be provided") if vpc.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_security_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "vpc" => vpc,
        "name" => name,
        "resource_group" => resource_group,
        "rules" => rules
      }

      method_url = "/security_groups"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_security_group(id:)
    # Delete a security group.
    # This request deletes a security group. A security group cannot be deleted if it is
    #   referenced by any security group targets or rules. Additionally, a VPC's default
    #   security group cannot be deleted. This operation cannot be reversed.
    # @param id [String] The security group identifier.
    # @return [nil]
    def delete_security_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_security_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_security_group(id:)
    # Retrieve a security group.
    # This request retrieves a single security group specified by the identifier in the
    #   URL path.
    # @param id [String] The security group identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_security_group(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_security_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_security_group(id:, security_group_patch:)
    # Update a security group.
    # This request updates a security group with the information provided in a security
    #   group patch object. The security group patch object is structured in the same way
    #   as a retrieved security group and contains only the information to be updated.
    # @param id [String] The security group identifier.
    # @param security_group_patch [Hash] The security group patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_security_group(id:, security_group_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("security_group_patch must be provided") if security_group_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_security_group")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = security_group_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/security_groups/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_security_group_rules(security_group_id:)
    # List rules in a security group.
    # This request lists rules in a security group. These rules define what traffic the
    #   security group permits. Security group rules are stateful, such that reverse
    #   traffic in response to allowed traffic is automatically permitted.
    # @param security_group_id [String] The security group identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_security_group_rules(security_group_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_security_group_rules")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s/rules" % [ERB::Util.url_encode(security_group_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_security_group_rule(security_group_id:, security_group_rule_prototype:)
    # Create a rule for a security group.
    # This request creates a new security group rule from a security group rule
    #   prototype object. The prototype object is structured in the same way as a
    #   retrieved security group rule and contains the information necessary to create the
    #   rule. As part of creating a new rule in a security group, the rule is applied to
    #   all the networking interfaces in the security group. Rules specify which IP
    #   traffic a security group will allow. Security group rules are stateful, such that
    #   reverse traffic in response to allowed traffic is automatically permitted. A rule
    #   allowing inbound TCP traffic on port 80 also allows outbound TCP traffic on port
    #   80 without the need for an additional rule.
    # @param security_group_id [String] The security group identifier.
    # @param security_group_rule_prototype [SecurityGroupRulePrototype] The properties of the security group rule to be created.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_security_group_rule(security_group_id:, security_group_rule_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      raise ArgumentError.new("security_group_rule_prototype must be provided") if security_group_rule_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_security_group_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = security_group_rule_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/security_groups/%s/rules" % [ERB::Util.url_encode(security_group_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_security_group_rule(security_group_id:, id:)
    # Delete a security group rule.
    # This request deletes a security group rule. This operation cannot be reversed.
    #   Removing a security group rule will not end existing connections allowed by that
    #   rule.
    # @param security_group_id [String] The security group identifier.
    # @param id [String] The rule identifier.
    # @return [nil]
    def delete_security_group_rule(security_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_security_group_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s/rules/%s" % [ERB::Util.url_encode(security_group_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_security_group_rule(security_group_id:, id:)
    # Retrieve a security group rule.
    # This request retrieves a single security group rule specified by the identifier in
    #   the URL path.
    # @param security_group_id [String] The security group identifier.
    # @param id [String] The rule identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_security_group_rule(security_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_security_group_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s/rules/%s" % [ERB::Util.url_encode(security_group_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_security_group_rule(security_group_id:, id:, security_group_rule_patch:)
    # Update a security group rule.
    # This request updates a security group rule with the information in a provided rule
    #   patch object. The rule patch object contains only the information to be updated.
    #   The request will fail if the information is not applicable to the rule's protocol.
    # @param security_group_id [String] The security group identifier.
    # @param id [String] The rule identifier.
    # @param security_group_rule_patch [Hash] The security group rule patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_security_group_rule(security_group_id:, id:, security_group_rule_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("security_group_rule_patch must be provided") if security_group_rule_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_security_group_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = security_group_rule_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/security_groups/%s/rules/%s" % [ERB::Util.url_encode(security_group_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_security_group_targets(security_group_id:, start: nil, limit: nil)
    # List targets associated with a security group.
    # This request lists targets associated with a security group, to which the rules in
    #   the security group are applied.
    # @param security_group_id [String] The security group identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_security_group_targets(security_group_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_security_group_targets")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/security_groups/%s/targets" % [ERB::Util.url_encode(security_group_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_security_group_target_binding(security_group_id:, id:)
    # Remove a target from a security group.
    # This request removes a target from a security group. For this request to succeed,
    #   the target must be attached to at least one other security group.  The specified
    #   target identifier can be:
    #
    #   - A bare metal server network interface identifier
    #   - A virtual network interface identifier
    #   - A VPN server identifier
    #   - A load balancer identifier
    #   - An endpoint gateway identifier
    #   - An instance network interface identifier
    #
    #   Security groups are stateful, so any changes to a target's security groups are
    #   applied to new connections. Existing connections are not affected.
    # @param security_group_id [String] The security group identifier.
    # @param id [String] The security group target identifier.
    # @return [nil]
    def delete_security_group_target_binding(security_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_security_group_target_binding")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s/targets/%s" % [ERB::Util.url_encode(security_group_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_security_group_target(security_group_id:, id:)
    # Retrieve a security group target.
    # This request retrieves a single target specified by the identifier in the URL
    #   path. The target must be an existing target of the security group.
    # @param security_group_id [String] The security group identifier.
    # @param id [String] The security group target identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_security_group_target(security_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_security_group_target")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s/targets/%s" % [ERB::Util.url_encode(security_group_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_security_group_target_binding(security_group_id:, id:)
    # Add a target to a security group.
    # This request adds a resource to an existing security group. The specified target
    #   identifier can be:
    #
    #   - A bare metal server network interface identifier
    #   - A virtual network interface identifier
    #   - A VPN server identifier
    #   - A load balancer identifier
    #   - An endpoint gateway identifier
    #   - An instance network interface identifier
    #
    #   When a target is added to a security group, the security group rules are applied
    #   to the target. A request body is not required, and if provided, is ignored.
    # @param security_group_id [String] The security group identifier.
    # @param id [String] The security group target identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_security_group_target_binding(security_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_security_group_target_binding")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s/targets/%s" % [ERB::Util.url_encode(security_group_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end
    #########################
    # VPN gateways
    #########################

    ##
    # @!method list_ike_policies(start: nil, limit: nil)
    # List IKE policies.
    # This request lists IKE policies in the region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_ike_policies(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_ike_policies")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/ike_policies"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_ike_policy(authentication_algorithm:, dh_group:, encryption_algorithm:, ike_version:, key_lifetime: nil, name: nil, resource_group: nil)
    # Create an IKE policy.
    # This request creates a new IKE policy.
    # @param authentication_algorithm [String] The authentication algorithm.
    # @param dh_group [Fixnum] The Diffie-Hellman group.
    # @param encryption_algorithm [String] The encryption algorithm.
    # @param ike_version [Fixnum] The IKE protocol version.
    # @param key_lifetime [Fixnum] The key lifetime in seconds.
    # @param name [String] The name for this IKE policy. The name must not be used by another IKE policies in
    #   the region. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_ike_policy(authentication_algorithm:, dh_group:, encryption_algorithm:, ike_version:, key_lifetime: nil, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("authentication_algorithm must be provided") if authentication_algorithm.nil?

      raise ArgumentError.new("dh_group must be provided") if dh_group.nil?

      raise ArgumentError.new("encryption_algorithm must be provided") if encryption_algorithm.nil?

      raise ArgumentError.new("ike_version must be provided") if ike_version.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_ike_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "authentication_algorithm" => authentication_algorithm,
        "dh_group" => dh_group,
        "encryption_algorithm" => encryption_algorithm,
        "ike_version" => ike_version,
        "key_lifetime" => key_lifetime,
        "name" => name,
        "resource_group" => resource_group
      }

      method_url = "/ike_policies"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_ike_policy(id:)
    # Delete an IKE policy.
    # This request deletes an IKE policy. This operation cannot be reversed. For this
    #   request to succeed, there must not be any VPN gateway connections using this
    #   policy.
    # @param id [String] The IKE policy identifier.
    # @return [nil]
    def delete_ike_policy(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_ike_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/ike_policies/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_ike_policy(id:)
    # Retrieve an IKE policy.
    # This request retrieves a single IKE policy specified by the identifier in the URL.
    # @param id [String] The IKE policy identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_ike_policy(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_ike_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/ike_policies/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_ike_policy(id:, ike_policy_patch:)
    # Update an IKE policy.
    # This request updates the properties of an existing IKE policy.
    # @param id [String] The IKE policy identifier.
    # @param ike_policy_patch [Hash] The IKE policy patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_ike_policy(id:, ike_policy_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("ike_policy_patch must be provided") if ike_policy_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_ike_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = ike_policy_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/ike_policies/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_ike_policy_connections(id:, start: nil, limit: nil)
    # List VPN gateway connections that use a specified IKE policy.
    # This request lists VPN gateway connections that use a IKE policy.
    # @param id [String] The IKE policy identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_ike_policy_connections(id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_ike_policy_connections")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/ike_policies/%s/connections" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_ipsec_policies(start: nil, limit: nil)
    # List IPsec policies.
    # This request lists IPsec policies in the region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_ipsec_policies(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_ipsec_policies")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/ipsec_policies"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_ipsec_policy(authentication_algorithm:, encryption_algorithm:, pfs:, key_lifetime: nil, name: nil, resource_group: nil)
    # Create an IPsec policy.
    # This request creates a new IPsec policy.
    # @param authentication_algorithm [String] The authentication algorithm
    #
    #   Must be `disabled` if and only if the `encryption_algorithm` is
    #   `aes128gcm16`, `aes192gcm16`, or `aes256gcm16`.
    # @param encryption_algorithm [String] The encryption algorithm
    #
    #   The `authentication_algorithm` must be `disabled` if and only if
    #   `encryption_algorithm` is `aes128gcm16`, `aes192gcm16`, or
    #   `aes256gcm16`.
    # @param pfs [String] Perfect Forward Secrecy.
    # @param key_lifetime [Fixnum] The key lifetime in seconds.
    # @param name [String] The name for this IPsec policy. The name must not be used by another IPsec
    #   policies in the region. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_ipsec_policy(authentication_algorithm:, encryption_algorithm:, pfs:, key_lifetime: nil, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("authentication_algorithm must be provided") if authentication_algorithm.nil?

      raise ArgumentError.new("encryption_algorithm must be provided") if encryption_algorithm.nil?

      raise ArgumentError.new("pfs must be provided") if pfs.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_ipsec_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "authentication_algorithm" => authentication_algorithm,
        "encryption_algorithm" => encryption_algorithm,
        "pfs" => pfs,
        "key_lifetime" => key_lifetime,
        "name" => name,
        "resource_group" => resource_group
      }

      method_url = "/ipsec_policies"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_ipsec_policy(id:)
    # Delete an IPsec policy.
    # This request deletes an IPsec policy. This operation cannot be reversed. For this
    #   request to succeed, there must not be any VPN gateway connections using this
    #   policy.
    # @param id [String] The IPsec policy identifier.
    # @return [nil]
    def delete_ipsec_policy(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_ipsec_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/ipsec_policies/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_ipsec_policy(id:)
    # Retrieve an IPsec policy.
    # This request retrieves a single IPsec policy specified by the identifier in the
    #   URL.
    # @param id [String] The IPsec policy identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_ipsec_policy(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_ipsec_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/ipsec_policies/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_ipsec_policy(id:, i_psec_policy_patch:)
    # Update an IPsec policy.
    # This request updates the properties of an existing IPsec policy.
    # @param id [String] The IPsec policy identifier.
    # @param i_psec_policy_patch [Hash] The IPsec policy patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_ipsec_policy(id:, i_psec_policy_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("i_psec_policy_patch must be provided") if i_psec_policy_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_ipsec_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = i_psec_policy_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/ipsec_policies/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_ipsec_policy_connections(id:, start: nil, limit: nil)
    # List VPN gateway connections that use a specified IPsec policy.
    # This request lists VPN gateway connections that use a IPsec policy.
    # @param id [String] The IPsec policy identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_ipsec_policy_connections(id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_ipsec_policy_connections")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/ipsec_policies/%s/connections" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_vpn_gateways(start: nil, limit: nil, resource_group_id: nil, sort: nil, mode: nil)
    # List VPN gateways.
    # This request lists VPN gateways in the region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @param mode [String] Filters the collection to VPN gateways with a `mode` property matching the
    #   specified value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_gateways(start: nil, limit: nil, resource_group_id: nil, sort: nil, mode: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpn_gateways")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "sort" => sort,
        "mode" => mode
      }

      method_url = "/vpn_gateways"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_vpn_gateway(vpn_gateway_prototype:)
    # Create a VPN gateway.
    # This request creates a new VPN gateway.
    # @param vpn_gateway_prototype [VPNGatewayPrototype] The VPN gateway prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpn_gateway(vpn_gateway_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_prototype must be provided") if vpn_gateway_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_vpn_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = vpn_gateway_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/vpn_gateways"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpn_gateway(id:)
    # Delete a VPN gateway.
    # This request deletes a VPN gateway. This operation cannot be reversed. For this
    #   request to succeed, the VPN gateway must not have a `status` of `pending`, and
    #   there must not be any VPC routes using the VPN gateway's connections as a next
    #   hop.
    # @param id [String] The VPN gateway identifier.
    # @return [nil]
    def delete_vpn_gateway(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpn_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_vpn_gateway(id:)
    # Retrieve a VPN gateway.
    # This request retrieves a single VPN gateway specified by the identifier in the
    #   URL.
    # @param id [String] The VPN gateway identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpn_gateway(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpn_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_vpn_gateway(id:, vpn_gateway_patch:)
    # Update a VPN gateway.
    # This request updates the properties of an existing VPN gateway.
    # @param id [String] The VPN gateway identifier.
    # @param vpn_gateway_patch [Hash] The VPN gateway patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpn_gateway(id:, vpn_gateway_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("vpn_gateway_patch must be provided") if vpn_gateway_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_vpn_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = vpn_gateway_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/vpn_gateways/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_vpn_gateway_connections(vpn_gateway_id:, start: nil, limit: nil, status: nil)
    # List connections of a VPN gateway.
    # This request lists connections of a VPN gateway.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param status [String] Filters the collection to VPN gateway connections with a `status` property
    #   matching the specified value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_gateway_connections(vpn_gateway_id:, start: nil, limit: nil, status: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpn_gateway_connections")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "status" => status
      }

      method_url = "/vpn_gateways/%s/connections" % [ERB::Util.url_encode(vpn_gateway_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_vpn_gateway_connection(vpn_gateway_id:, vpn_gateway_connection_prototype:)
    # Create a connection for a VPN gateway.
    # This request creates a new VPN gateway connection.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param vpn_gateway_connection_prototype [VPNGatewayConnectionPrototype] The VPN gateway connection prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpn_gateway_connection(vpn_gateway_id:, vpn_gateway_connection_prototype:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("vpn_gateway_connection_prototype must be provided") if vpn_gateway_connection_prototype.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_vpn_gateway_connection")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = vpn_gateway_connection_prototype
      headers["Content-Type"] = "application/json"

      method_url = "/vpn_gateways/%s/connections" % [ERB::Util.url_encode(vpn_gateway_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpn_gateway_connection(vpn_gateway_id:, id:)
    # Delete a VPN gateway connection.
    # This request deletes a VPN gateway connection. This operation cannot be reversed.
    #   For this request to succeed, there must not be VPC routes using this VPN
    #   connection as a next hop.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @return [nil]
    def delete_vpn_gateway_connection(vpn_gateway_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpn_gateway_connection")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_vpn_gateway_connection(vpn_gateway_id:, id:)
    # Retrieve a VPN gateway connection.
    # This request retrieves a single VPN gateway connection specified by the identifier
    #   in the URL.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpn_gateway_connection(vpn_gateway_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpn_gateway_connection")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_vpn_gateway_connection(vpn_gateway_id:, id:, vpn_gateway_connection_patch:)
    # Update a VPN gateway connection.
    # This request updates the properties of an existing VPN gateway connection.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param vpn_gateway_connection_patch [Hash] The VPN gateway connection patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpn_gateway_connection(vpn_gateway_id:, id:, vpn_gateway_connection_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("vpn_gateway_connection_patch must be provided") if vpn_gateway_connection_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_vpn_gateway_connection")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = vpn_gateway_connection_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/vpn_gateways/%s/connections/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_vpn_gateway_connections_local_cidrs(vpn_gateway_id:, id:)
    # List local CIDRs for a VPN gateway connection.
    # This request lists local CIDRs for a VPN gateway connection.
    #
    #   This request is only supported for policy mode VPN gateways.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_gateway_connections_local_cidrs(vpn_gateway_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpn_gateway_connections_local_cidrs")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/local/cidrs" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method remove_vpn_gateway_connections_local_cidr(vpn_gateway_id:, id:, cidr:)
    # Remove a local CIDR from a VPN gateway connection.
    # This request removes a CIDR from a VPN gateway connection.
    #
    #   This request is only supported for policy mode VPN gateways.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr [String] The IP address range in CIDR block notation.
    # @return [nil]
    def remove_vpn_gateway_connections_local_cidr(vpn_gateway_id:, id:, cidr:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr must be provided") if cidr.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "remove_vpn_gateway_connections_local_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/local/cidrs/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method check_vpn_gateway_connections_local_cidr(vpn_gateway_id:, id:, cidr:)
    # Check if the specified local CIDR exists on a VPN gateway connection.
    # This request succeeds if a CIDR exists on the specified VPN gateway connection,
    #   and fails otherwise.
    #
    #   This request is only supported for policy mode VPN gateways.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr [String] The IP address range in CIDR block notation.
    # @return [nil]
    def check_vpn_gateway_connections_local_cidr(vpn_gateway_id:, id:, cidr:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr must be provided") if cidr.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "check_vpn_gateway_connections_local_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/local/cidrs/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr)]

      request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method add_vpn_gateway_connections_local_cidr(vpn_gateway_id:, id:, cidr:)
    # Set a local CIDR on a VPN gateway connection.
    # This request adds the specified CIDR to the specified VPN gateway connection. This
    #   request succeeds if the specified CIDR already exists. A request body is not
    #   required, and if provided, is ignored.
    #
    #   This request is only supported for policy mode VPN gateways.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr [String] The IP address range in CIDR block notation.
    # @return [nil]
    def add_vpn_gateway_connections_local_cidr(vpn_gateway_id:, id:, cidr:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr must be provided") if cidr.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "add_vpn_gateway_connections_local_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/local/cidrs/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr)]

      request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method list_vpn_gateway_connections_peer_cidrs(vpn_gateway_id:, id:)
    # List peer CIDRs for a VPN gateway connection.
    # This request lists peer CIDRs for a VPN gateway connection.
    #
    #   This request is only supported for policy mode VPN gateways.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_gateway_connections_peer_cidrs(vpn_gateway_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpn_gateway_connections_peer_cidrs")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/peer/cidrs" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method remove_vpn_gateway_connections_peer_cidr(vpn_gateway_id:, id:, cidr:)
    # Remove a peer CIDR from a VPN gateway connection.
    # This request removes a CIDR from a VPN gateway connection.
    #
    #   This request is only supported for policy mode VPN gateways.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr [String] The IP address range in CIDR block notation.
    # @return [nil]
    def remove_vpn_gateway_connections_peer_cidr(vpn_gateway_id:, id:, cidr:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr must be provided") if cidr.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "remove_vpn_gateway_connections_peer_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/peer/cidrs/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method check_vpn_gateway_connections_peer_cidr(vpn_gateway_id:, id:, cidr:)
    # Check if the specified peer CIDR exists on a VPN gateway connection.
    # This request succeeds if a CIDR exists on the specified VPN gateway connection,
    #   and fails otherwise.
    #
    #   This request is only supported for policy mode VPN gateways.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr [String] The IP address range in CIDR block notation.
    # @return [nil]
    def check_vpn_gateway_connections_peer_cidr(vpn_gateway_id:, id:, cidr:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr must be provided") if cidr.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "check_vpn_gateway_connections_peer_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/peer/cidrs/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr)]

      request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method add_vpn_gateway_connections_peer_cidr(vpn_gateway_id:, id:, cidr:)
    # Set a peer CIDR on a VPN gateway connection.
    # This request adds the specified CIDR to the specified VPN gateway connection. This
    #   request succeeds if the specified CIDR already exists. A request body is not
    #   required, and if provided, is ignored.
    #
    #   This request is only supported for policy mode VPN gateways.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr [String] The IP address range in CIDR block notation.
    # @return [nil]
    def add_vpn_gateway_connections_peer_cidr(vpn_gateway_id:, id:, cidr:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr must be provided") if cidr.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "add_vpn_gateway_connections_peer_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/peer/cidrs/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr)]

      request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end
    #########################
    # VPN servers
    #########################

    ##
    # @!method list_vpn_servers(name: nil, start: nil, limit: nil, resource_group_id: nil, sort: nil)
    # List VPN servers.
    # This request lists VPN servers.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_servers(name: nil, start: nil, limit: nil, resource_group_id: nil, sort: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpn_servers")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "name" => name,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "sort" => sort
      }

      method_url = "/vpn_servers"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_vpn_server(certificate:, client_authentication:, client_ip_pool:, subnets:, client_dns_server_ips: nil, client_idle_timeout: nil, enable_split_tunneling: nil, name: nil, port: nil, protocol: nil, resource_group: nil, security_groups: nil)
    # Create a VPN server.
    # This request creates a new VPN server.
    # @param certificate [CertificateInstanceIdentity] The certificate instance for this VPN server.
    # @param client_authentication [Array[VPNServerAuthenticationPrototype]] The methods used to authenticate VPN clients to this VPN server. VPN clients must
    #   authenticate against all specified methods.
    # @param client_ip_pool [String] The VPN client IPv4 address pool, expressed in CIDR format. The request must not
    #   overlap with any existing address prefixes in the VPC or any of the following
    #   reserved address ranges:
    #     - `127.0.0.0/8` (IPv4 loopback addresses)
    #     - `161.26.0.0/16` (IBM services)
    #     - `166.8.0.0/14` (Cloud Service Endpoints)
    #     - `169.254.0.0/16` (IPv4 link-local addresses)
    #     - `224.0.0.0/4` (IPv4 multicast addresses)
    #
    #   The prefix length of the client IP address pool's CIDR must be between
    #   `/9` (8,388,608 addresses) and `/22` (1024 addresses). A CIDR block that contains
    #   twice the number of IP addresses that are required to enable the maximum number of
    #   concurrent connections is recommended.
    # @param subnets [Array[SubnetIdentity]] The subnets to provision this VPN server in.  Use subnets in different zones for
    #   high availability.
    # @param client_dns_server_ips [Array[IP]] The DNS server addresses that will be provided to VPN clients connected to this
    #   VPN server.
    # @param client_idle_timeout [Fixnum] The seconds a VPN client can be idle before this VPN server will disconnect it.
    #   Specify `0` to prevent the server from disconnecting idle clients.
    # @param enable_split_tunneling [Boolean] Indicates whether the split tunneling is enabled on this VPN server.
    # @param name [String] The name for this VPN server. The name must not be used by another VPN server in
    #   the VPC. If unspecified, the name will be a hyphenated list of randomly-selected
    #   words.
    # @param port [Fixnum] The port number to use for this VPN server.
    # @param protocol [String] The transport protocol to use for this VPN server.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @param security_groups [Array[SecurityGroupIdentity]] The security groups to use for this VPN server. If unspecified, the VPC's default
    #   security group is used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpn_server(certificate:, client_authentication:, client_ip_pool:, subnets:, client_dns_server_ips: nil, client_idle_timeout: nil, enable_split_tunneling: nil, name: nil, port: nil, protocol: nil, resource_group: nil, security_groups: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("certificate must be provided") if certificate.nil?

      raise ArgumentError.new("client_authentication must be provided") if client_authentication.nil?

      raise ArgumentError.new("client_ip_pool must be provided") if client_ip_pool.nil?

      raise ArgumentError.new("subnets must be provided") if subnets.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_vpn_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "certificate" => certificate,
        "client_authentication" => client_authentication,
        "client_ip_pool" => client_ip_pool,
        "subnets" => subnets,
        "client_dns_server_ips" => client_dns_server_ips,
        "client_idle_timeout" => client_idle_timeout,
        "enable_split_tunneling" => enable_split_tunneling,
        "name" => name,
        "port" => port,
        "protocol" => protocol,
        "resource_group" => resource_group,
        "security_groups" => security_groups
      }

      method_url = "/vpn_servers"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpn_server(id:, if_match: nil)
    # Delete a VPN server.
    # This request deletes a VPN server. This operation cannot be reversed.
    # @param id [String] The VPN server identifier.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value.
    # @return [nil]
    def delete_vpn_server(id:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpn_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_servers/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_vpn_server(id:)
    # Retrieve a VPN server.
    # This request retrieves a single VPN server specified by the identifier in the URL.
    # @param id [String] The VPN server identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpn_server(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpn_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_servers/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_vpn_server(id:, vpn_server_patch:, if_match: nil)
    # Update a VPN server.
    # This request updates the properties of an existing VPN server. Any updates other
    #   than to `name` will cause all connected VPN clients to be disconnected.
    # @param id [String] The VPN server identifier.
    # @param vpn_server_patch [Hash] The VPN server patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpn_server(id:, vpn_server_patch:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("vpn_server_patch must be provided") if vpn_server_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_vpn_server")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = vpn_server_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/vpn_servers/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_vpn_server_client_configuration(id:)
    # Retrieve client configuration.
    # This request retrieves OpenVPN client configuration on a single VPN server
    #   specified by the identifier in the URL. This configuration includes directives
    #   compatible with OpenVPN releases 2.4 and 2.5.
    # @param id [String] The VPN server identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpn_server_client_configuration(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpn_server_client_configuration")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_servers/%s/client_configuration" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      response
    end

    ##
    # @!method list_vpn_server_clients(vpn_server_id:, start: nil, limit: nil, sort: nil)
    # List VPN clients for a VPN server.
    # This request retrieves connected VPN clients, and any disconnected VPN clients
    #   that the VPN server has not yet deleted based on its auto-deletion policy.
    # @param vpn_server_id [String] The VPN server identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_server_clients(vpn_server_id:, start: nil, limit: nil, sort: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_server_id must be provided") if vpn_server_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpn_server_clients")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "sort" => sort
      }

      method_url = "/vpn_servers/%s/clients" % [ERB::Util.url_encode(vpn_server_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpn_server_client(vpn_server_id:, id:)
    # Delete a VPN client.
    # This request disconnects and deletes the VPN client from the VPN server. The VPN
    #   client may reconnect unless its authentication permissions for the configured
    #   authentication methods (such as its client certificate) have been revoked.
    # @param vpn_server_id [String] The VPN server identifier.
    # @param id [String] The VPN client identifier.
    # @return [nil]
    def delete_vpn_server_client(vpn_server_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_server_id must be provided") if vpn_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpn_server_client")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_servers/%s/clients/%s" % [ERB::Util.url_encode(vpn_server_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_vpn_server_client(vpn_server_id:, id:)
    # Retrieve a VPN client.
    # This request retrieves a single VPN client specified by the identifier in the URL.
    # @param vpn_server_id [String] The VPN server identifier.
    # @param id [String] The VPN client identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpn_server_client(vpn_server_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_server_id must be provided") if vpn_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpn_server_client")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_servers/%s/clients/%s" % [ERB::Util.url_encode(vpn_server_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method disconnect_vpn_client(vpn_server_id:, id:)
    # Disconnect a VPN client.
    # This request disconnects the specified VPN client, and deletes the client
    #   according to the VPN server's auto-deletion policy. The VPN client may reconnect
    #   unless its authentication permissions for the configured authentication methods
    #   (such as its client certificate) have been revoked.
    # @param vpn_server_id [String] The VPN server identifier.
    # @param id [String] The VPN client identifier.
    # @return [nil]
    def disconnect_vpn_client(vpn_server_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_server_id must be provided") if vpn_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "disconnect_vpn_client")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_servers/%s/clients/%s/disconnect" % [ERB::Util.url_encode(vpn_server_id), ERB::Util.url_encode(id)]

      request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method list_vpn_server_routes(vpn_server_id:, start: nil, limit: nil, sort: nil)
    # List VPN routes for a VPN server.
    # This request lists VPN routes in a VPN server. All VPN routes are provided to the
    #   VPN client when the connection is established.  Packets received from the VPN
    #   client will be dropped by the VPN server if there is no VPN route matching their
    #   specified destinations. All VPN routes must be unique within the VPN server.
    # @param vpn_server_id [String] The VPN server identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_server_routes(vpn_server_id:, start: nil, limit: nil, sort: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_server_id must be provided") if vpn_server_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpn_server_routes")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "sort" => sort
      }

      method_url = "/vpn_servers/%s/routes" % [ERB::Util.url_encode(vpn_server_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_vpn_server_route(vpn_server_id:, destination:, action: nil, name: nil)
    # Create a VPN route for a VPN server.
    # This request creates a new VPN route in the VPN server. All VPN routes are
    #   provided to the VPN client when the connection is established. Packets received
    #   from the VPN client will be dropped by the VPN server if there is no VPN route
    #   matching their specified destinations. All VPN routes must be unique within the
    #   VPN server.
    # @param vpn_server_id [String] The VPN server identifier.
    # @param destination [String] The destination to use for this VPN route in the VPN server. Must be unique within
    #   the VPN server. If an incoming packet does not match any destination, it will be
    #   dropped.
    # @param action [String] The action to perform with a packet matching the VPN route:
    #   - `translate`: translate the source IP address to one of the private IP addresses
    #   of
    #     the VPN server, then deliver the packet to target.
    #   - `deliver`: deliver the packet to the target.
    #   - `drop`: drop the packet.
    # @param name [String] The name for this VPN server route. The name must not be used by another route for
    #   the VPN server. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpn_server_route(vpn_server_id:, destination:, action: nil, name: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_server_id must be provided") if vpn_server_id.nil?

      raise ArgumentError.new("destination must be provided") if destination.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_vpn_server_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "destination" => destination,
        "action" => action,
        "name" => name
      }

      method_url = "/vpn_servers/%s/routes" % [ERB::Util.url_encode(vpn_server_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_vpn_server_route(vpn_server_id:, id:)
    # Delete a VPN route.
    # This request deletes a VPN route. This operation cannot be reversed.
    # @param vpn_server_id [String] The VPN server identifier.
    # @param id [String] The VPN route identifier.
    # @return [nil]
    def delete_vpn_server_route(vpn_server_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_server_id must be provided") if vpn_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_vpn_server_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_servers/%s/routes/%s" % [ERB::Util.url_encode(vpn_server_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_vpn_server_route(vpn_server_id:, id:)
    # Retrieve a VPN route.
    # This request retrieves a single VPN route specified by the identifier in the URL.
    # @param vpn_server_id [String] The VPN server identifier.
    # @param id [String] The VPN route identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_vpn_server_route(vpn_server_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_server_id must be provided") if vpn_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_vpn_server_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_servers/%s/routes/%s" % [ERB::Util.url_encode(vpn_server_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_vpn_server_route(vpn_server_id:, id:, vpn_server_route_patch:)
    # Update a VPN route.
    # This request updates a VPN route with the information in a provided VPN route
    #   patch. The VPN route patch object is structured in the same way as a retrieved VPN
    #   route and contains only the information to be updated.
    # @param vpn_server_id [String] The VPN server identifier.
    # @param id [String] The VPN route identifier.
    # @param vpn_server_route_patch [Hash] The VPN route patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpn_server_route(vpn_server_id:, id:, vpn_server_route_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_server_id must be provided") if vpn_server_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("vpn_server_route_patch must be provided") if vpn_server_route_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_vpn_server_route")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = vpn_server_route_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/vpn_servers/%s/routes/%s" % [ERB::Util.url_encode(vpn_server_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Load balancers
    #########################

    ##
    # @!method list_load_balancer_profiles(start: nil, limit: nil)
    # List load balancer profiles.
    # This request lists load balancer profiles available in the region. A load balancer
    #   profile specifies the performance characteristics and pricing model for a load
    #   balancer.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_load_balancer_profiles(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_load_balancer_profiles")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/load_balancer/profiles"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_load_balancer_profile(name:)
    # Retrieve a load balancer profile.
    # This request retrieves a load balancer profile specified by the name in the URL.
    # @param name [String] The load balancer profile name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_load_balancer_profile(name:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("name must be provided") if name.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_load_balancer_profile")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancer/profiles/%s" % [ERB::Util.url_encode(name)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_load_balancers(start: nil, limit: nil)
    # List load balancers.
    # This request lists load balancers in the region.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_load_balancers(start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_load_balancers")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/load_balancers"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_load_balancer(is_public:, subnets:, dns: nil, listeners: nil, logging: nil, name: nil, pools: nil, profile: nil, resource_group: nil, route_mode: nil, security_groups: nil)
    # Create a load balancer.
    # This request creates and provisions a new load balancer.
    # @param is_public [Boolean] Indicates whether this load balancer is public.
    #
    #   At present, if route mode is enabled, the load balancer must not be public.
    # @param subnets [Array[SubnetIdentity]] The subnets to provision this load balancer in. The subnets must be in the same
    #   VPC. The load balancer's availability will depend on the availability of the zones
    #   that the subnets reside in.
    #
    #   Load balancers in the `network` family allow only one subnet to be specified.
    # @param dns [LoadBalancerDNSPrototype] The DNS configuration for this load balancer.
    #
    #   If unspecified, DNS `A` records for this load balancer's `hostname` property will
    #   be added
    #   to the public DNS zone `lb.appdomain.cloud`. Otherwise, those DNS `A` records will
    #   be
    #   added to the specified `zone`.
    # @param listeners [Array[LoadBalancerListenerPrototypeLoadBalancerContext]] The listeners of this load balancer.
    # @param logging [LoadBalancerLoggingPrototype] The logging configuration to use for this load balancer. See [VPC Datapath
    #   Logging](https://cloud.ibm.com/docs/vpc?topic=vpc-datapath-logging) on the logging
    #   format, fields and permitted values. If unspecified, `datapath.active` will be
    #   `false`.
    #
    #   To activate logging, the load balancer profile must support the specified logging
    #   type.
    # @param name [String] The name for this load balancer. The name must not be used by another load
    #   balancer in the VPC.  If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param pools [Array[LoadBalancerPoolPrototype]] The pools of this load balancer.
    # @param profile [LoadBalancerProfileIdentity] The profile to use for this load balancer.
    #
    #   If unspecified, `application` will be used.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @param route_mode [Boolean] Indicates whether route mode is enabled for this load balancer.
    #
    #   At present, public load balancers are not supported with route mode enabled.
    # @param security_groups [Array[SecurityGroupIdentity]] The security groups to use for this load balancer. If unspecified, the VPC's
    #   default security group is used.
    #
    #   The load balancer profile must support security groups.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_load_balancer(is_public:, subnets:, dns: nil, listeners: nil, logging: nil, name: nil, pools: nil, profile: nil, resource_group: nil, route_mode: nil, security_groups: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("is_public must be provided") if is_public.nil?

      raise ArgumentError.new("subnets must be provided") if subnets.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_load_balancer")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "is_public" => is_public,
        "subnets" => subnets,
        "dns" => dns,
        "listeners" => listeners,
        "logging" => logging,
        "name" => name,
        "pools" => pools,
        "profile" => profile,
        "resource_group" => resource_group,
        "route_mode" => route_mode,
        "security_groups" => security_groups
      }

      method_url = "/load_balancers"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_load_balancer(id:, if_match: nil)
    # Delete a load balancer.
    # This request deletes a load balancer. This operation cannot be reversed. A load
    #   balancer cannot be deleted if its `provisioning_status` is `delete_pending` or it
    #   is referenced by a resource.
    # @param id [String] The load balancer identifier.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value.
    # @return [nil]
    def delete_load_balancer(id:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_load_balancer")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_load_balancer(id:)
    # Retrieve a load balancer.
    # This request retrieves a single load balancer specified by the identifier in the
    #   URL path.
    # @param id [String] The load balancer identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_load_balancer(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_load_balancer")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_load_balancer(id:, load_balancer_patch:, if_match: nil)
    # Update a load balancer.
    # This request updates a load balancer with the information in a provided load
    #   balancer patch. The load balancer patch object is structured in the same way as a
    #   retrieved load balancer and contains only the information to be updated. A load
    #   balancer can only be updated if its `provisioning_status` is `active`.
    # @param id [String] The load balancer identifier.
    # @param load_balancer_patch [Hash] The load balancer patch.
    # @param if_match [String] If present, the request will fail if the specified ETag value does not match the
    #   resource's current ETag value. Required if the request body includes an array.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_load_balancer(id:, load_balancer_patch:, if_match: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("load_balancer_patch must be provided") if load_balancer_patch.nil?

      headers = {
        "If-Match" => if_match
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_load_balancer")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = load_balancer_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/load_balancers/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method get_load_balancer_statistics(id:)
    # List statistics of a load balancer.
    # This request lists statistics of a load balancer.
    # @param id [String] The load balancer identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_load_balancer_statistics(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_load_balancer_statistics")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/statistics" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_load_balancer_listeners(load_balancer_id:)
    # List listeners for a load balancer.
    # This request lists listeners for a load balancer.
    # @param load_balancer_id [String] The load balancer identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_load_balancer_listeners(load_balancer_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_load_balancer_listeners")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/listeners" % [ERB::Util.url_encode(load_balancer_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_load_balancer_listener(load_balancer_id:, protocol:, accept_proxy_protocol: nil, certificate_instance: nil, connection_limit: nil, default_pool: nil, https_redirect: nil, idle_connection_timeout: nil, policies: nil, port: nil, port_max: nil, port_min: nil)
    # Create a listener for a load balancer.
    # This request creates a new listener for a load balancer.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param protocol [String] The listener protocol. Each listener in the load balancer must have a unique
    #   `port` and `protocol` combination.
    #
    #   Load balancers in the `network` family support `tcp` and `udp` (if `udp_supported`
    #   is `true`). Load balancers in the `application` family support `tcp`, `http` and
    #   `https`.
    #
    #   Additional restrictions:
    #   - If `default_pool` is set, the pool's protocol must match, or be compatible with
    #     the listener's protocol. At present, the compatible protocols are `http` and
    #     `https`.
    #   - If `https_redirect` is set, the protocol must be `http`.
    # @param accept_proxy_protocol [Boolean] If set to `true`, this listener will accept and forward PROXY protocol
    #   information. Supported by load balancers in the `application` family (otherwise
    #   always `false`). Additional restrictions:
    #   - If this listener has `https_redirect` specified, its `accept_proxy_protocol`
    #   value must
    #     match the `accept_proxy_protocol` value of the `https_redirect` listener.
    #   - If this listener is the target of another listener's `https_redirect`, its
    #     `accept_proxy_protocol` value must match that listener's `accept_proxy_protocol`
    #   value.
    # @param certificate_instance [CertificateInstanceIdentity] The certificate instance to use for SSL termination. The listener must have a
    #   `protocol` of `https`.
    # @param connection_limit [Fixnum] The connection limit of the listener.
    # @param default_pool [LoadBalancerPoolIdentity] The default pool for this listener. If `https_redirect` is specified, the
    #   default pool will not be used.
    #   If specified, the pool must:
    #
    #   - Belong to this load balancer.
    #   - Have the same `protocol` as this listener, or have a compatible protocol.
    #     At present, the compatible protocols are `http` and `https`.
    #   - Not already be the `default_pool` for another listener.
    #
    #   If unspecified, this listener will be created with no default pool, but one may be
    #   subsequently set.
    # @param https_redirect [LoadBalancerListenerHTTPSRedirectPrototype] The target listener that requests will be redirected to if none of the listener's
    #   `policies` match.
    #
    #   If specified, this listener must have a `protocol` of `http`, and the target
    #   listener must have a `protocol` of `https`.
    # @param idle_connection_timeout [Fixnum] The idle connection timeout of the listener in seconds. Supported for load
    #   balancers in the `application` family.
    # @param policies [Array[LoadBalancerListenerPolicyPrototype]] The policy prototype objects for this listener. The load balancer must be in the
    #   `application` family.
    # @param port [Fixnum] The listener port number, or the inclusive lower bound of the port range. Each
    #   listener in the load balancer must have a unique `port` and `protocol`
    #   combination.
    #
    #   Not supported for load balancers operating with route mode enabled.
    # @param port_max [Fixnum] The inclusive upper bound of the range of ports used by this listener. Must not be
    #   less than `port_min`.
    #
    #   At present, only load balancers operating with route mode enabled, and public load
    #   balancers in the `network` family support different values for `port_min` and
    #   `port_max`. When route mode is enabled, the value `65535` must be specified.
    #
    #   The specified port range must not overlap with port ranges used by other listeners
    #   for this load balancer using the same protocol.
    # @param port_min [Fixnum] The inclusive lower bound of the range of ports used by this listener. Must not be
    #   greater than `port_max`.
    #
    #   At present, only load balancers operating with route mode enabled, and public load
    #   balancers in the `network` family support different values for `port_min` and
    #   `port_max`. When route mode is enabled, the value `1` must be specified.
    #
    #   The specified port range must not overlap with port ranges used by other listeners
    #   for this load balancer using the same protocol.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_load_balancer_listener(load_balancer_id:, protocol:, accept_proxy_protocol: nil, certificate_instance: nil, connection_limit: nil, default_pool: nil, https_redirect: nil, idle_connection_timeout: nil, policies: nil, port: nil, port_max: nil, port_min: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("protocol must be provided") if protocol.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_load_balancer_listener")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "protocol" => protocol,
        "accept_proxy_protocol" => accept_proxy_protocol,
        "certificate_instance" => certificate_instance,
        "connection_limit" => connection_limit,
        "default_pool" => default_pool,
        "https_redirect" => https_redirect,
        "idle_connection_timeout" => idle_connection_timeout,
        "policies" => policies,
        "port" => port,
        "port_max" => port_max,
        "port_min" => port_min
      }

      method_url = "/load_balancers/%s/listeners" % [ERB::Util.url_encode(load_balancer_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_load_balancer_listener(load_balancer_id:, id:)
    # Delete a load balancer listener.
    # This request deletes a load balancer listener. This operation cannot be reversed.
    #   For this operation to succeed, the listener must not be the target of another load
    #   balancer listener.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param id [String] The listener identifier.
    # @return [nil]
    def delete_load_balancer_listener(load_balancer_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_load_balancer_listener")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/listeners/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_load_balancer_listener(load_balancer_id:, id:)
    # Retrieve a load balancer listener.
    # This request retrieves a single listener specified by the identifier in the URL
    #   path.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param id [String] The listener identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_load_balancer_listener(load_balancer_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_load_balancer_listener")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/listeners/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_load_balancer_listener(load_balancer_id:, id:, load_balancer_listener_patch:)
    # Update a load balancer listener.
    # This request updates a load balancer listener from a listener patch.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param id [String] The listener identifier.
    # @param load_balancer_listener_patch [Hash] The load balancer listener patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_load_balancer_listener(load_balancer_id:, id:, load_balancer_listener_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("load_balancer_listener_patch must be provided") if load_balancer_listener_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_load_balancer_listener")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = load_balancer_listener_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/load_balancers/%s/listeners/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_load_balancer_listener_policies(load_balancer_id:, listener_id:)
    # List policies for a load balancer listener.
    # This request lists policies for a load balancer listener. A policy consists of
    #   rules to match against each incoming request, and an action to apply to the
    #   request if a rule matches.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_load_balancer_listener_policies(load_balancer_id:, listener_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("listener_id must be provided") if listener_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_load_balancer_listener_policies")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/listeners/%s/policies" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(listener_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_load_balancer_listener_policy(load_balancer_id:, listener_id:, action:, priority:, name: nil, rules: nil, target: nil)
    # Create a policy for a load balancer listener.
    # This request creates a new policy from a load balancer listener policy object. The
    #   prototype object is structured in the same way as a retrieved policy, and contains
    #   the information necessary to create the new policy. For this request to succeed,
    #   the listener must have a `protocol` of `http` or `https`.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @param action [String] The policy action.
    #
    #   - `forward`: Requests will be forwarded to the specified `target` pool
    #   - `https_redirect`: Requests will be redirected to the specified target listener.
    #   The
    #     listener must have a `protocol` of `http`, and the target listener must have a
    #     `protocol` of `https`
    #   - `redirect`: Requests will be redirected to the specified `target.url`
    #   - `reject`: Requests will be rejected with a `403` status code
    #
    #   The enumerated values for this property may
    #   [expand](https://cloud.ibm.com/apidocs/vpc#property-value-expansion) in the
    #   future.
    # @param priority [Fixnum] Priority of the policy. The priority is unique across all policies for this load
    #   balancer listener. Lower value indicates higher priority.
    # @param name [String] The name for this policy. The name must not be used by another policy for the load
    #   balancer listener. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param rules [Array[LoadBalancerListenerPolicyRulePrototype]] The rule prototype objects for this policy.
    # @param target [LoadBalancerListenerPolicyTargetPrototype] - If `action` is `forward`, specify a `LoadBalancerPoolIdentity`.
    #   - If `action` is `https_redirect`, specify a
    #   `LoadBalancerListenerPolicyHTTPSRedirectPrototype`.
    #   - If `action` is `redirect`, specify a
    #   `LoadBalancerListenerPolicyRedirectURLPrototype`.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_load_balancer_listener_policy(load_balancer_id:, listener_id:, action:, priority:, name: nil, rules: nil, target: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("listener_id must be provided") if listener_id.nil?

      raise ArgumentError.new("action must be provided") if action.nil?

      raise ArgumentError.new("priority must be provided") if priority.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_load_balancer_listener_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "action" => action,
        "priority" => priority,
        "name" => name,
        "rules" => rules,
        "target" => target
      }

      method_url = "/load_balancers/%s/listeners/%s/policies" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(listener_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_load_balancer_listener_policy(load_balancer_id:, listener_id:, id:)
    # Delete a load balancer listener policy.
    # Deletes a policy of the load balancer listener. This operation cannot be reversed.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @param id [String] The policy identifier.
    # @return [nil]
    def delete_load_balancer_listener_policy(load_balancer_id:, listener_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("listener_id must be provided") if listener_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_load_balancer_listener_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/listeners/%s/policies/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(listener_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_load_balancer_listener_policy(load_balancer_id:, listener_id:, id:)
    # Retrieve a load balancer listener policy.
    # Retrieve a single policy specified by the identifier in the URL path.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @param id [String] The policy identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_load_balancer_listener_policy(load_balancer_id:, listener_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("listener_id must be provided") if listener_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_load_balancer_listener_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/listeners/%s/policies/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(listener_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_load_balancer_listener_policy(load_balancer_id:, listener_id:, id:, load_balancer_listener_policy_patch:)
    # Update a load balancer listener policy.
    # This request updates a load balancer listener policy with the information in a
    #   provided policy patch. The policy patch object is structured in the same way as a
    #   retrieved policy and contains only the information to be updated.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @param id [String] The policy identifier.
    # @param load_balancer_listener_policy_patch [Hash] The listener policy patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_load_balancer_listener_policy(load_balancer_id:, listener_id:, id:, load_balancer_listener_policy_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("listener_id must be provided") if listener_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("load_balancer_listener_policy_patch must be provided") if load_balancer_listener_policy_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_load_balancer_listener_policy")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = load_balancer_listener_policy_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/load_balancers/%s/listeners/%s/policies/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(listener_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_load_balancer_listener_policy_rules(load_balancer_id:, listener_id:, policy_id:)
    # List rules of a load balancer listener policy.
    # This request lists rules of a load balancer listener policy.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @param policy_id [String] The policy identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_load_balancer_listener_policy_rules(load_balancer_id:, listener_id:, policy_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("listener_id must be provided") if listener_id.nil?

      raise ArgumentError.new("policy_id must be provided") if policy_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_load_balancer_listener_policy_rules")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/listeners/%s/policies/%s/rules" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(listener_id), ERB::Util.url_encode(policy_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_load_balancer_listener_policy_rule(load_balancer_id:, listener_id:, policy_id:, condition:, type:, value:, field: nil)
    # Create a rule for a load balancer listener policy.
    # Creates a new rule for the load balancer listener policy.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @param policy_id [String] The policy identifier.
    # @param condition [String] The condition of the rule.
    # @param type [String] The type of the rule.
    #
    #   Body rules are applied to form-encoded request bodies using the `UTF-8` character
    #   set.
    # @param value [String] Value to be matched for rule condition.
    #
    #   If the rule type is `query` and the rule condition is not `matches_regex`, the
    #   value must be percent-encoded.
    # @param field [String] The field. This is applicable to `header`, `query`, and `body` rule types.
    #
    #   If the rule type is `header`, this property is required.
    #
    #   If the rule type is `query`, this is optional. If specified and the rule condition
    #   is not
    #   `matches_regex`, the value must be percent-encoded.
    #
    #   If the rule type is `body`, this is optional.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_load_balancer_listener_policy_rule(load_balancer_id:, listener_id:, policy_id:, condition:, type:, value:, field: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("listener_id must be provided") if listener_id.nil?

      raise ArgumentError.new("policy_id must be provided") if policy_id.nil?

      raise ArgumentError.new("condition must be provided") if condition.nil?

      raise ArgumentError.new("type must be provided") if type.nil?

      raise ArgumentError.new("value must be provided") if value.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_load_balancer_listener_policy_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "condition" => condition,
        "type" => type,
        "value" => value,
        "field" => field
      }

      method_url = "/load_balancers/%s/listeners/%s/policies/%s/rules" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(listener_id), ERB::Util.url_encode(policy_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_load_balancer_listener_policy_rule(load_balancer_id:, listener_id:, policy_id:, id:)
    # Delete a load balancer listener policy rule.
    # Deletes a rule from the load balancer listener policy. This operation cannot be
    #   reversed.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @param policy_id [String] The policy identifier.
    # @param id [String] The rule identifier.
    # @return [nil]
    def delete_load_balancer_listener_policy_rule(load_balancer_id:, listener_id:, policy_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("listener_id must be provided") if listener_id.nil?

      raise ArgumentError.new("policy_id must be provided") if policy_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_load_balancer_listener_policy_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/listeners/%s/policies/%s/rules/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(listener_id), ERB::Util.url_encode(policy_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_load_balancer_listener_policy_rule(load_balancer_id:, listener_id:, policy_id:, id:)
    # Retrieve a load balancer listener policy rule.
    # Retrieves a single rule specified by the identifier in the URL path.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @param policy_id [String] The policy identifier.
    # @param id [String] The rule identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_load_balancer_listener_policy_rule(load_balancer_id:, listener_id:, policy_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("listener_id must be provided") if listener_id.nil?

      raise ArgumentError.new("policy_id must be provided") if policy_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_load_balancer_listener_policy_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/listeners/%s/policies/%s/rules/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(listener_id), ERB::Util.url_encode(policy_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_load_balancer_listener_policy_rule(load_balancer_id:, listener_id:, policy_id:, id:, load_balancer_listener_policy_rule_patch:)
    # Update a load balancer listener policy rule.
    # Updates a rule of the load balancer listener policy.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @param policy_id [String] The policy identifier.
    # @param id [String] The rule identifier.
    # @param load_balancer_listener_policy_rule_patch [Hash] The listener policy rule patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_load_balancer_listener_policy_rule(load_balancer_id:, listener_id:, policy_id:, id:, load_balancer_listener_policy_rule_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("listener_id must be provided") if listener_id.nil?

      raise ArgumentError.new("policy_id must be provided") if policy_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("load_balancer_listener_policy_rule_patch must be provided") if load_balancer_listener_policy_rule_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_load_balancer_listener_policy_rule")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = load_balancer_listener_policy_rule_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/load_balancers/%s/listeners/%s/policies/%s/rules/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(listener_id), ERB::Util.url_encode(policy_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_load_balancer_pools(load_balancer_id:)
    # List pools of a load balancer.
    # This request lists pools of a load balancer.
    # @param load_balancer_id [String] The load balancer identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_load_balancer_pools(load_balancer_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_load_balancer_pools")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/pools" % [ERB::Util.url_encode(load_balancer_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_load_balancer_pool(load_balancer_id:, algorithm:, health_monitor:, protocol:, members: nil, name: nil, proxy_protocol: nil, session_persistence: nil)
    # Create a load balancer pool.
    # This request creates a new pool from a pool prototype object.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param algorithm [String] The load balancing algorithm.
    # @param health_monitor [LoadBalancerPoolHealthMonitorPrototype] The health monitor of this pool.
    # @param protocol [String] The protocol used for this load balancer pool. Load balancers in the `network`
    #   family support `tcp` and `udp` (if `udp_supported` is `true`). Load balancers in
    #   the
    #   `application` family support `tcp`, `http`, and `https`.
    # @param members [Array[LoadBalancerPoolMemberPrototype]] The members for this load balancer pool. For load balancers in the `network`
    #   family, the same `port` and `target` tuple cannot be shared by a pool member of
    #   any other load balancer in the same VPC.
    # @param name [String] The name for this load balancer pool. The name must not be used by another pool
    #   for the load balancer. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param proxy_protocol [String] The PROXY protocol setting for this pool:
    #   - `v1`: Enabled with version 1 (human-readable header format)
    #   - `v2`: Enabled with version 2 (binary header format)
    #   - `disabled`: Disabled
    #
    #   Supported by load balancers in the `application` family (otherwise always
    #   `disabled`).
    # @param session_persistence [LoadBalancerPoolSessionPersistencePrototype] The session persistence of this pool. If unspecified, session persistence will be
    #   disabled, and traffic will be distributed across backend server members of the
    #   pool.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_load_balancer_pool(load_balancer_id:, algorithm:, health_monitor:, protocol:, members: nil, name: nil, proxy_protocol: nil, session_persistence: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("algorithm must be provided") if algorithm.nil?

      raise ArgumentError.new("health_monitor must be provided") if health_monitor.nil?

      raise ArgumentError.new("protocol must be provided") if protocol.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_load_balancer_pool")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "algorithm" => algorithm,
        "health_monitor" => health_monitor,
        "protocol" => protocol,
        "members" => members,
        "name" => name,
        "proxy_protocol" => proxy_protocol,
        "session_persistence" => session_persistence
      }

      method_url = "/load_balancers/%s/pools" % [ERB::Util.url_encode(load_balancer_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_load_balancer_pool(load_balancer_id:, id:)
    # Delete a load balancer pool.
    # This request deletes a load balancer pool. This operation cannot be reversed. The
    #   pool must not currently be the default pool for any listener in the load balancer.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param id [String] The pool identifier.
    # @return [nil]
    def delete_load_balancer_pool(load_balancer_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_load_balancer_pool")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/pools/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_load_balancer_pool(load_balancer_id:, id:)
    # Retrieve a load balancer pool.
    # This request retrieves a single pool specified by the identifier in the URL path.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param id [String] The pool identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_load_balancer_pool(load_balancer_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_load_balancer_pool")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/pools/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_load_balancer_pool(load_balancer_id:, id:, load_balancer_pool_patch:)
    # Update a load balancer pool.
    # This request updates a load balancer pool from a pool patch.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param id [String] The pool identifier.
    # @param load_balancer_pool_patch [Hash] The load balancer pool patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_load_balancer_pool(load_balancer_id:, id:, load_balancer_pool_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("load_balancer_pool_patch must be provided") if load_balancer_pool_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_load_balancer_pool")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = load_balancer_pool_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/load_balancers/%s/pools/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_load_balancer_pool_members(load_balancer_id:, pool_id:)
    # List members of a load balancer pool.
    # This request lists members of a load balancer pool.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param pool_id [String] The pool identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_load_balancer_pool_members(load_balancer_id:, pool_id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("pool_id must be provided") if pool_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_load_balancer_pool_members")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/pools/%s/members" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(pool_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_load_balancer_pool_member(load_balancer_id:, pool_id:, port:, target:, weight: nil)
    # Create a member in a load balancer pool.
    # This request creates a new member and adds the member to the pool.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param pool_id [String] The pool identifier.
    # @param port [Fixnum] The port the member will receive load balancer traffic on. Applies only to load
    #   balancer traffic received on a listener with a single port. (If the traffic is
    #   received on a listener with a port range, the member will receive the traffic on
    #   the same port the listener received it on.)
    #
    #   This port will also be used for health checks unless the `port` property of
    #   `health_monitor` property is specified.
    #
    #   The port must be unique across all members for all pools associated with this
    #   pool's listener.
    # @param target [LoadBalancerPoolMemberTargetPrototype] The pool member target. Load balancers in the `network` family support virtual
    #   server
    #   instances. Load balancers in the `application` family support IP addresses. If the
    #   load
    #   balancer has route mode enabled, the member must be in a zone the load balancer
    #   has a
    #   subnet in.
    # @param weight [Fixnum] Weight of the server member. Applicable only if the pool algorithm is
    #   `weighted_round_robin`.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_load_balancer_pool_member(load_balancer_id:, pool_id:, port:, target:, weight: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("pool_id must be provided") if pool_id.nil?

      raise ArgumentError.new("port must be provided") if port.nil?

      raise ArgumentError.new("target must be provided") if target.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_load_balancer_pool_member")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "port" => port,
        "target" => target,
        "weight" => weight
      }

      method_url = "/load_balancers/%s/pools/%s/members" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(pool_id)]

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method replace_load_balancer_pool_members(load_balancer_id:, pool_id:, members:)
    # Replace load balancer pool members.
    # This request replaces the existing members of the load balancer pool with new
    #   members created from the collection of member prototype objects.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param pool_id [String] The pool identifier.
    # @param members [Array[LoadBalancerPoolMemberPrototype]] The member prototype objects for this pool.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def replace_load_balancer_pool_members(load_balancer_id:, pool_id:, members:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("pool_id must be provided") if pool_id.nil?

      raise ArgumentError.new("members must be provided") if members.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "replace_load_balancer_pool_members")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "members" => members
      }

      method_url = "/load_balancers/%s/pools/%s/members" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(pool_id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_load_balancer_pool_member(load_balancer_id:, pool_id:, id:)
    # Delete a load balancer pool member.
    # This request deletes a member from the pool. This operation cannot be reversed.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param pool_id [String] The pool identifier.
    # @param id [String] The member identifier.
    # @return [nil]
    def delete_load_balancer_pool_member(load_balancer_id:, pool_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("pool_id must be provided") if pool_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_load_balancer_pool_member")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/pools/%s/members/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(pool_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_load_balancer_pool_member(load_balancer_id:, pool_id:, id:)
    # Retrieve a load balancer pool member.
    # This request retrieves a single member specified by the identifier in the URL
    #   path.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param pool_id [String] The pool identifier.
    # @param id [String] The member identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_load_balancer_pool_member(load_balancer_id:, pool_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("pool_id must be provided") if pool_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_load_balancer_pool_member")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/load_balancers/%s/pools/%s/members/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(pool_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_load_balancer_pool_member(load_balancer_id:, pool_id:, id:, load_balancer_pool_member_patch:)
    # Update a load balancer pool member.
    # This request updates an existing member from a member patch.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param pool_id [String] The pool identifier.
    # @param id [String] The member identifier.
    # @param load_balancer_pool_member_patch [Hash] The load balancer pool member patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_load_balancer_pool_member(load_balancer_id:, pool_id:, id:, load_balancer_pool_member_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("pool_id must be provided") if pool_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("load_balancer_pool_member_patch must be provided") if load_balancer_pool_member_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_load_balancer_pool_member")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = load_balancer_pool_member_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/load_balancers/%s/pools/%s/members/%s" % [ERB::Util.url_encode(load_balancer_id), ERB::Util.url_encode(pool_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Endpoint gateways
    #########################

    ##
    # @!method list_endpoint_gateways(name: nil, start: nil, limit: nil, resource_group_id: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil, allow_dns_resolution_binding: nil)
    # List endpoint gateways.
    # This request lists endpoint gateways in the region. An endpoint gateway maps one
    #   or more reserved IPs in a VPC to a target outside the VPC.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param vpc_id [String] Filters the collection to resources with a `vpc.id` property matching the
    #   specified identifier.
    # @param vpc_crn [String] Filters the collection to resources with a `vpc.crn` property matching the
    #   specified CRN.
    # @param vpc_name [String] Filters the collection to resources with a `vpc.name` property matching the exact
    #   specified name.
    # @param allow_dns_resolution_binding [Boolean] Filters the collection to endpoint gateways with an `allow_dns_resolution_binding`
    #   property matching the specified value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_endpoint_gateways(name: nil, start: nil, limit: nil, resource_group_id: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil, allow_dns_resolution_binding: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_endpoint_gateways")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "name" => name,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "vpc.id" => vpc_id,
        "vpc.crn" => vpc_crn,
        "vpc.name" => vpc_name,
        "allow_dns_resolution_binding" => allow_dns_resolution_binding
      }

      method_url = "/endpoint_gateways"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_endpoint_gateway(target:, vpc:, allow_dns_resolution_binding: nil, ips: nil, name: nil, resource_group: nil, security_groups: nil)
    # Create an endpoint gateway.
    # This request creates a new endpoint gateway. An endpoint gateway maps one or more
    #   reserved IPs in a VPC to a target outside the VPC.
    # @param target [EndpointGatewayTargetPrototype] The target to use for this endpoint gateway. Must not already be the target of
    #   another
    #   endpoint gateway in the VPC.
    # @param vpc [VPCIdentity] The VPC this endpoint gateway will reside in.
    # @param allow_dns_resolution_binding [Boolean] Indicates whether to allow DNS resolution for this endpoint gateway when the VPC
    #   this endpoint gateway resides in has a DNS resolution binding to a VPC with
    #   `dns.enable_hub` set to `true`.
    #
    #   Must be `true` if the VPC this endpoint gateway resides in has `dns.enable_hub`
    #   set to
    #   `true`.
    # @param ips [Array[EndpointGatewayReservedIP]] The reserved IPs to bind to this endpoint gateway. At most one reserved IP per
    #   zone is allowed.
    # @param name [String] The name for this endpoint gateway. The name must not be used by another endpoint
    #   gateway in the VPC. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @param security_groups [Array[SecurityGroupIdentity]] The security groups to use for this endpoint gateway. If unspecified, the VPC's
    #   default security group is used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_endpoint_gateway(target:, vpc:, allow_dns_resolution_binding: nil, ips: nil, name: nil, resource_group: nil, security_groups: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("target must be provided") if target.nil?

      raise ArgumentError.new("vpc must be provided") if vpc.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_endpoint_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "target" => target,
        "vpc" => vpc,
        "allow_dns_resolution_binding" => allow_dns_resolution_binding,
        "ips" => ips,
        "name" => name,
        "resource_group" => resource_group,
        "security_groups" => security_groups
      }

      method_url = "/endpoint_gateways"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method list_endpoint_gateway_ips(endpoint_gateway_id:, start: nil, limit: nil, sort: nil)
    # List reserved IPs bound to an endpoint gateway.
    # This request lists reserved IPs bound to an endpoint gateway.
    # @param endpoint_gateway_id [String] The endpoint gateway identifier.
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_endpoint_gateway_ips(endpoint_gateway_id:, start: nil, limit: nil, sort: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("endpoint_gateway_id must be provided") if endpoint_gateway_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_endpoint_gateway_ips")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "sort" => sort
      }

      method_url = "/endpoint_gateways/%s/ips" % [ERB::Util.url_encode(endpoint_gateway_id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method remove_endpoint_gateway_ip(endpoint_gateway_id:, id:)
    # Unbind a reserved IP from an endpoint gateway.
    # This request unbinds the specified reserved IP from the specified endpoint
    #   gateway. If the reserved IP has `auto_delete` set to `true`, the reserved IP will
    #   be deleted.
    # @param endpoint_gateway_id [String] The endpoint gateway identifier.
    # @param id [String] The reserved IP identifier.
    # @return [nil]
    def remove_endpoint_gateway_ip(endpoint_gateway_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("endpoint_gateway_id must be provided") if endpoint_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "remove_endpoint_gateway_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/endpoint_gateways/%s/ips/%s" % [ERB::Util.url_encode(endpoint_gateway_id), ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_endpoint_gateway_ip(endpoint_gateway_id:, id:)
    # Retrieve a reserved IP bound to an endpoint gateway.
    # This request retrieves the specified reserved IP address if it is bound to the
    #   endpoint gateway specified in the URL.
    # @param endpoint_gateway_id [String] The endpoint gateway identifier.
    # @param id [String] The reserved IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_endpoint_gateway_ip(endpoint_gateway_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("endpoint_gateway_id must be provided") if endpoint_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_endpoint_gateway_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/endpoint_gateways/%s/ips/%s" % [ERB::Util.url_encode(endpoint_gateway_id), ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method add_endpoint_gateway_ip(endpoint_gateway_id:, id:)
    # Bind a reserved IP to an endpoint gateway.
    # This request binds the specified reserved IP to the specified endpoint gateway.
    #   The reserved IP:
    #
    #   - must currently be unbound, or not required by its target
    #   - must not be in the same zone as any other reserved IP bound to the endpoint
    #   gateway.
    # @param endpoint_gateway_id [String] The endpoint gateway identifier.
    # @param id [String] The reserved IP identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def add_endpoint_gateway_ip(endpoint_gateway_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("endpoint_gateway_id must be provided") if endpoint_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "add_endpoint_gateway_ip")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/endpoint_gateways/%s/ips/%s" % [ERB::Util.url_encode(endpoint_gateway_id), ERB::Util.url_encode(id)]

      response = request(
        method: "PUT",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_endpoint_gateway(id:)
    # Delete an endpoint gateway.
    # This request deletes an endpoint gateway. This operation cannot be reversed.
    #
    #   Reserved IPs that were bound to the endpoint gateway will be released if their
    #   `auto_delete` property is set to true.
    # @param id [String] The endpoint gateway identifier.
    # @return [nil]
    def delete_endpoint_gateway(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_endpoint_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/endpoint_gateways/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_endpoint_gateway(id:)
    # Retrieve an endpoint gateway.
    # This request retrieves a single endpoint gateway specified by the identifier in
    #   the URL.
    # @param id [String] The endpoint gateway identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_endpoint_gateway(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_endpoint_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/endpoint_gateways/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_endpoint_gateway(id:, endpoint_gateway_patch:)
    # Update an endpoint gateway.
    # This request updates an endpoint gateway's name.
    # @param id [String] The endpoint gateway identifier.
    # @param endpoint_gateway_patch [Hash] The endpoint gateway patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_endpoint_gateway(id:, endpoint_gateway_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("endpoint_gateway_patch must be provided") if endpoint_gateway_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_endpoint_gateway")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = endpoint_gateway_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/endpoint_gateways/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
    #########################
    # Flow log collectors
    #########################

    ##
    # @!method list_flow_log_collectors(start: nil, limit: nil, resource_group_id: nil, name: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil, target_id: nil, target_resource_type: nil)
    # List flow log collectors.
    # This request lists flow log collectors in the region. A [flow log
    #   collector](https://cloud.ibm.com/docs/vpc?topic=vpc-flow-logs) summarizes data
    #   sent over the instance network interfaces and instance network attachments
    #   contained within its target. The collected flow logs are written to a cloud object
    #   storage bucket, where they can be
    #   [viewed](https://cloud.ibm.com/docs/vpc?topic=vpc-fl-analyze).
    # @param start [String] A server-provided token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources with a `resource_group.id` property matching
    #   the specified identifier.
    # @param name [String] Filters the collection to resources with a `name` property matching the exact
    #   specified name.
    # @param vpc_id [String] Filters the collection to resources with a `vpc.id` property matching the
    #   specified identifier.
    # @param vpc_crn [String] Filters the collection to resources with a `vpc.crn` property matching the
    #   specified CRN.
    # @param vpc_name [String] Filters the collection to resources with a `vpc.name` property matching the exact
    #   specified name.
    # @param target_id [String] Filters the collection to resources with a `target.id` property matching the
    #   specified identifier.
    # @param target_resource_type [String] Filters the collection to resources with a `target.resource_type` property
    #   matching the specified value.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_flow_log_collectors(start: nil, limit: nil, resource_group_id: nil, name: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil, target_id: nil, target_resource_type: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_flow_log_collectors")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "name" => name,
        "vpc.id" => vpc_id,
        "vpc.crn" => vpc_crn,
        "vpc.name" => vpc_name,
        "target.id" => target_id,
        "target.resource_type" => target_resource_type
      }

      method_url = "/flow_log_collectors"

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method create_flow_log_collector(storage_bucket:, target:, active: nil, name: nil, resource_group: nil)
    # Create a flow log collector.
    # This request creates and starts a new flow log collector from a flow log collector
    #   prototype object. The prototype object is structured in the same way as a
    #   retrieved flow log collector, and contains the information necessary to create and
    #   start the new flow log collector.
    # @param storage_bucket [LegacyCloudObjectStorageBucketIdentity] The Cloud Object Storage bucket where the collected flows will be logged.
    #   The bucket must exist and an IAM service authorization must grant
    #   `IBM Cloud Flow Logs` resources of `VPC Infrastructure Services` writer
    #   access to the bucket. For more information, see [Creating a flow log
    #   collector](https://cloud.ibm.com/docs/vpc?topic=vpc-ordering-flow-log-collector).
    # @param target [FlowLogCollectorTargetPrototype] The target this collector will collect flow logs for.
    #
    #   If the target is an instance, subnet, or VPC, flow logs will not be collected for
    #   any
    #   instance network attachments, virtual network interfaces or instance network
    #   interfaces
    #   within the target that are themselves the target of a more specific flow log
    #   collector.
    #
    #   The target must not be a virtual network interface that is attached to a bare
    #   metal server
    #   network attachment or to a file share mount target.
    # @param active [Boolean] Indicates whether this collector will be active upon creation.
    # @param name [String] The name for this flow log collector. The name must not be used by another flow
    #   log collector in the VPC. If unspecified, the name will be a hyphenated list of
    #   randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) will be used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_flow_log_collector(storage_bucket:, target:, active: nil, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("storage_bucket must be provided") if storage_bucket.nil?

      raise ArgumentError.new("target must be provided") if target.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_flow_log_collector")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "storage_bucket" => storage_bucket,
        "target" => target,
        "active" => active,
        "name" => name,
        "resource_group" => resource_group
      }

      method_url = "/flow_log_collectors"

      response = request(
        method: "POST",
        url: method_url,
        headers: headers,
        params: params,
        json: data,
        accept_json: true
      )
      response
    end

    ##
    # @!method delete_flow_log_collector(id:)
    # Delete a flow log collector.
    # This request stops and deletes a flow log collector. This operation cannot be
    #   reversed.
    #
    #   Collected flow logs remain available within the flow log collector's Cloud Object
    #   Storage bucket.
    # @param id [String] The flow log collector identifier.
    # @return [nil]
    def delete_flow_log_collector(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "delete_flow_log_collector")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/flow_log_collectors/%s" % [ERB::Util.url_encode(id)]

      request(
        method: "DELETE",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: false
      )
      nil
    end

    ##
    # @!method get_flow_log_collector(id:)
    # Retrieve a flow log collector.
    # This request retrieves a single flow log collector specified by the identifier in
    #   the URL.
    # @param id [String] The flow log collector identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_flow_log_collector(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_flow_log_collector")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/flow_log_collectors/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "GET",
        url: method_url,
        headers: headers,
        params: params,
        accept_json: true
      )
      response
    end

    ##
    # @!method update_flow_log_collector(id:, flow_log_collector_patch:)
    # Update a flow log collector.
    # This request updates a flow log collector with the information in a provided flow
    #   log collector patch. The flow log collector patch object is structured in the same
    #   way as a retrieved flow log collector and contains only the information to be
    #   updated.
    # @param id [String] The flow log collector identifier.
    # @param flow_log_collector_patch [Hash] The flow log collector patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_flow_log_collector(id:, flow_log_collector_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("flow_log_collector_patch must be provided") if flow_log_collector_patch.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "update_flow_log_collector")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = flow_log_collector_patch
      headers["Content-Type"] = "application/merge-patch+json"

      method_url = "/flow_log_collectors/%s" % [ERB::Util.url_encode(id)]

      response = request(
        method: "PATCH",
        url: method_url,
        headers: headers,
        params: params,
        data: data,
        accept_json: true
      )
      response
    end
  end
end
