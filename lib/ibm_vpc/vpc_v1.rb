# frozen_string_literal: true

# (C) Copyright IBM Corp. 2020, 2021.
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
# IBM OpenAPI SDK Code Generator Version: 3.37.0-a85661cd-20210802-190136
#
# The IBM Cloud Virtual Private Cloud (VPC) API can be used to programmatically
# provision and manage infrastructure resources, including virtual server instances,
# subnets, volumes, and load balancers.

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
    DEFAULT_SERVICE_VERSION = "2021-08-03"
    attr_accessor :version
    attr_accessor :generation
    ##
    # @!method initialize(args)
    # Construct a new client for the vpc service.
    #
    # @param args [Hash] The args to initialize with
    # @option args version [String] Requests the version of the API as of a date in the format `YYYY-MM-DD`. Any date
    #   up to the current date may be provided. Specify the current date to request the
    #   latest version.
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
      @version = args[:version]
      raise ArgumentError.new("version must be provided") if @version.nil?

      @generation = args[:generation]

      super
      @service_url = user_service_url unless user_service_url.nil?
    end

    #########################
    # VPCs
    #########################

    ##
    # @!method list_vpcs(start: nil, limit: nil, resource_group_id: nil, classic_access: nil)
    # List all VPCs.
    # This request lists all VPCs in the region. A VPC is a virtual network that belongs
    #   to an account and provides logical isolation from other networks. A VPC is made up
    #   of resources in one or more zones. VPCs are regional, and each VPC can contain
    #   resources in multiple zones in a region.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @param classic_access [Boolean] Filters the collection to VPCs with the specified `classic_access` value.
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
    # @!method create_vpc(address_prefix_management: nil, classic_access: nil, name: nil, resource_group: nil)
    # Create a VPC.
    # This request creates a new VPC from a VPC prototype object. The prototype object
    #   is structured in the same way as a retrieved VPC, and contains the information
    #   necessary to create the new VPC.
    # @param address_prefix_management [String] Indicates whether a default address prefix should be automatically created for
    #   each zone in this VPC. If `manual`, this VPC will be created with no default
    #   address prefixes.
    # @param classic_access [Boolean] Indicates whether this VPC should be connected to Classic Infrastructure. If true,
    #   this VPC's resources will have private network connectivity to the account's
    #   Classic Infrastructure resources. Only one VPC, per region, may be connected in
    #   this way. This value is set at creation and subsequently immutable.
    # @param name [String] The unique user-defined name for this VPC. If unspecified, the name will be a
    #   hyphenated list of randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpc(address_prefix_management: nil, classic_access: nil, name: nil, resource_group: nil)
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
    # @!method delete_vpc(id:)
    # Delete a VPC.
    # This request deletes a VPC. This operation cannot be reversed. For this request to
    #   succeed, the VPC must not contain any instances, subnets, or public gateways. All
    #   security groups and network ACLs associated with the VPC are automatically
    #   deleted. All flow log collectors with `auto_delete` set to `true` targeting the
    #   VPC or any resource in the VPC are automatically deleted.
    # @param id [String] The VPC identifier.
    # @return [nil]
    def delete_vpc(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
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
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

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
    # @!method update_vpc(id:, vpc_patch:)
    # Update a VPC.
    # This request updates a VPC's name.
    # @param id [String] The VPC identifier.
    # @param vpc_patch [Hash] The VPC patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpc(id:, vpc_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("vpc_patch must be provided") if vpc_patch.nil?

      headers = {
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
    #   the VPC which have not been explicitly associated with a user-defined routing
    #   table.
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
    #   identifier in the URL. The default security group is applied to any new network
    #   interfaces in the VPC that do not specify a security group.
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
    # List all address prefixes for a VPC.
    # This request lists all address pool prefixes for a VPC.
    # @param vpc_id [String] The VPC identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # @param cidr [String] The IPv4 range of the address prefix, expressed in CIDR format. The request must
    #   not overlap with any existing address prefixes in the VPC or any of the following
    #   reserved address ranges:
    #     - `127.0.0.0/8` (IPv4 loopback addresses)
    #     - `161.26.0.0/16` (IBM services)
    #     - `166.8.0.0/14` (Cloud Service Endpoints)
    #     - `169.254.0.0/16` (IPv4 link-local addresses)
    #     - `224.0.0.0/4` (IPv4 multicast addresses)
    #
    #   The prefix length of the address prefix's CIDR must be between `/9` (8,388,608
    #   addresses) and `/29` (8 addresses).
    # @param zone [ZoneIdentity] The zone this address prefix will reside in.
    # @param is_default [Boolean] Indicates whether this is the default prefix for this zone in this VPC. If true,
    #   this prefix will become the default prefix for this zone in this VPC. This fails
    #   if the VPC currently has a default address prefix for this zone.
    # @param name [String] The user-defined name for this address prefix. Names must be unique within the VPC
    #   the address prefix resides in. If unspecified, the name will be a hyphenated list
    #   of randomly-selected words.
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
    # @!method list_vpc_routes(vpc_id:, zone_name: nil, start: nil, limit: nil)
    # List all routes in a VPC's default routing table.
    # This request lists all routes in the VPC's default routing table. Each route is
    #   zone-specific and directs any packets matching its destination CIDR block to a
    #   `next_hop` IP address. The most specific route matching a packet's destination
    #   will be used. If multiple equally-specific routes exist, traffic will be
    #   distributed across them.
    # @param vpc_id [String] The VPC identifier.
    # @param zone_name [String] Filters the collection to resources in the zone with the exact specified name.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # @!method create_vpc_route(vpc_id:, destination:, zone:, action: nil, name: nil, next_hop: nil)
    # Create a route in a VPC's default routing table.
    # This request creates a new route in the VPC's default routing table. The route
    #   prototype object is structured in the same way as a retrieved route, and contains
    #   the information necessary to create the new route. The request will fail if the
    #   new route will cause a loop.
    # @param vpc_id [String] The VPC identifier.
    # @param destination [String] The destination of the route. At most two routes per `zone` in a table can have
    #   the same destination, and only if both routes have an `action` of `deliver` and
    #   the
    #   `next_hop` is an IP address.
    # @param zone [ZoneIdentity] The zone to apply the route to. (Traffic from subnets in this zone will be
    #   subject to this route.).
    # @param action [String] The action to perform with a packet matching the route:
    #   - `delegate`: delegate to the system's built-in routes
    #   - `delegate_vpc`: delegate to the system's built-in routes, ignoring
    #   Internet-bound
    #     routes
    #   - `deliver`: deliver the packet to the specified `next_hop`
    #   - `drop`: drop the packet.
    # @param name [String] The user-defined name for this route. If unspecified, the name will be a
    #   hyphenated list of randomly-selected words. Names must be unique within the VPC
    #   routing table the route resides in.
    # @param next_hop [RouteNextHopPrototype] If `action` is `deliver`, the next hop that packets will be delivered to.  For
    #   other `action` values, it must be omitted or specified as `0.0.0.0`.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpc_route(vpc_id:, destination:, zone:, action: nil, name: nil, next_hop: nil)
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
        "name" => name,
        "next_hop" => next_hop
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
    # List all routing tables for a VPC.
    # This request lists all user-defined routing tables for a VPC.  Each subnet in a
    #   VPC is associated with a routing table, which controls delivery of packets sent on
    #   that subnet according to the action of the most specific matching route in the
    #   table.  If multiple equally-specific routes exist, traffic will be distributed
    #   across them.  If no routes match, delivery will be controlled by the system's
    #   built-in routes.
    # @param vpc_id [String] The VPC identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param is_default [Boolean] If the supplied value is `true`, filters the routing table collection to only the
    #   default routing table. If the supplied value is `false`, filters the routing table
    #   collection to exclude the default routing table.
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
    # @!method create_vpc_routing_table(vpc_id:, name: nil, route_direct_link_ingress: nil, route_transit_gateway_ingress: nil, route_vpc_zone_ingress: nil, routes: nil)
    # Create a routing table for a VPC.
    # This request creates a user-defined routing table from a routing table prototype
    #   object. The prototype object is structured in the same way as a retrieved routing
    #   table, and contains the information necessary to create the new routing table.
    # @param vpc_id [String] The VPC identifier.
    # @param name [String] The user-defined name for this routing table. Names must be unique within the VPC
    #   the routing table resides in. If unspecified, the name will be a hyphenated list
    #   of randomly-selected words.
    # @param route_direct_link_ingress [Boolean] If set to `true`, this routing table will be used to route traffic that originates
    #   from [Direct Link](https://cloud.ibm.com/docs/dl/) to this VPC. For this to
    #   succeed, the VPC must not already have a routing table with this property set to
    #   `true`.
    #
    #   Incoming traffic will be routed according to the routing table with one exception:
    #   routes with an `action` of `deliver` are treated as `drop` unless the `next_hop`
    #   is an IP address within the VPC's address prefix ranges. Therefore, if an incoming
    #   packet matches a route with a `next_hop` of an internet-bound IP address or a VPN
    #   gateway connection, the packet will be dropped.
    # @param route_transit_gateway_ingress [Boolean] If set to `true`, this routing table will be used to route traffic that originates
    #   from [Transit Gateway](https://cloud.ibm.com/cloud/transit-gateway/) to this VPC.
    #   For this to succeed, the VPC must not already have a routing table with this
    #   property set to `true`.
    #
    #   Incoming traffic will be routed according to the routing table with one exception:
    #   routes with an `action` of `deliver` are treated as `drop` unless the `next_hop`
    #   is an IP address within the VPC's address prefix ranges. Therefore, if an incoming
    #   packet matches a route with a `next_hop` of an internet-bound IP address or a VPN
    #   gateway connection, the packet will be dropped.
    #
    #   If [Classic
    #   Access](https://cloud.ibm.com/docs/vpc?topic=vpc-setting-up-access-to-classic-infrastructure)
    #   is enabled for this VPC, and this property is set to `true`, its incoming traffic
    #   will also be routed according to this routing table.
    # @param route_vpc_zone_ingress [Boolean] If set to `true`, this routing table will be used to route traffic that originates
    #   from subnets in other zones in this VPC. For this to succeed, the VPC must not
    #   already have a routing table with this property set to `true`.
    #
    #   Incoming traffic will be routed according to the routing table with one exception:
    #   routes with an `action` of `deliver` are treated as `drop` unless the `next_hop`
    #   is an IP address within the VPC's address prefix ranges. Therefore, if an incoming
    #   packet matches a route with a `next_hop` of an internet-bound IP address or a VPN
    #   gateway connection, the packet will be dropped.
    # @param routes [Array[RoutePrototype]] The prototype objects for routes to create for this routing table. If unspecified,
    #   the routing table will be created with no routes.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpc_routing_table(vpc_id:, name: nil, route_direct_link_ingress: nil, route_transit_gateway_ingress: nil, route_vpc_zone_ingress: nil, routes: nil)
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
        "name" => name,
        "route_direct_link_ingress" => route_direct_link_ingress,
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
    # @!method delete_vpc_routing_table(vpc_id:, id:)
    # Delete a VPC routing table.
    # This request deletes a routing table.  A routing table cannot be deleted if it is
    #   associated with any subnets in the VPC. Additionally, a VPC's default routing
    #   table cannot be deleted. This operation cannot be reversed.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The routing table identifier.
    # @return [nil]
    def delete_vpc_routing_table(vpc_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
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
    # @!method update_vpc_routing_table(vpc_id:, id:, routing_table_patch:)
    # Update a VPC routing table.
    # This request updates a routing table with the information in a provided routing
    #   table patch. The patch object is structured in the same way as a retrieved table
    #   and contains only the information to be updated.
    # @param vpc_id [String] The VPC identifier.
    # @param id [String] The routing table identifier.
    # @param routing_table_patch [Hash] The routing table patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_vpc_routing_table(vpc_id:, id:, routing_table_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpc_id must be provided") if vpc_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("routing_table_patch must be provided") if routing_table_patch.nil?

      headers = {
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
    # List all routes in a VPC routing table.
    # This request lists all routes in a VPC routing table. If a subnet has been
    #   associated with this routing table, delivery of packets sent on a subnet is
    #   performed according to the action of the most specific matching route in the table
    #   (provided the subnet and route are in the same zone). If multiple equally-specific
    #   routes exist, traffic will be distributed across them. If no routes match,
    #   delivery will be controlled by the system's built-in routes.
    # @param vpc_id [String] The VPC identifier.
    # @param routing_table_id [String] The routing table identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # @!method create_vpc_routing_table_route(vpc_id:, routing_table_id:, destination:, zone:, action: nil, name: nil, next_hop: nil)
    # Create a route in a VPC routing table.
    # This request creates a new VPC route from a VPC route prototype object. The
    #   prototype object is structured in the same way as a retrieved VPC route and
    #   contains the information necessary to create the route.
    # @param vpc_id [String] The VPC identifier.
    # @param routing_table_id [String] The routing table identifier.
    # @param destination [String] The destination of the route. At most two routes per `zone` in a table can have
    #   the same destination, and only if both routes have an `action` of `deliver` and
    #   the
    #   `next_hop` is an IP address.
    # @param zone [ZoneIdentity] The zone to apply the route to. (Traffic from subnets in this zone will be
    #   subject to this route.).
    # @param action [String] The action to perform with a packet matching the route:
    #   - `delegate`: delegate to the system's built-in routes
    #   - `delegate_vpc`: delegate to the system's built-in routes, ignoring
    #   Internet-bound
    #     routes
    #   - `deliver`: deliver the packet to the specified `next_hop`
    #   - `drop`: drop the packet.
    # @param name [String] The user-defined name for this route. If unspecified, the name will be a
    #   hyphenated list of randomly-selected words. Names must be unique within the VPC
    #   routing table the route resides in.
    # @param next_hop [RouteNextHopPrototype] If `action` is `deliver`, the next hop that packets will be delivered to.  For
    #   other `action` values, it must be omitted or specified as `0.0.0.0`.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_vpc_routing_table_route(vpc_id:, routing_table_id:, destination:, zone:, action: nil, name: nil, next_hop: nil)
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
        "name" => name,
        "next_hop" => next_hop
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
    # This request deletes a VPC route. This operation cannot be reversed.
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
    #   and needs to contain only the information to be updated.
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
    # @!method list_subnets(start: nil, limit: nil, resource_group_id: nil, routing_table_id: nil, routing_table_name: nil)
    # List all subnets.
    # This request lists all subnets in the region. Subnets are contiguous ranges of IP
    #   addresses specified in CIDR block notation. Each subnet is within a particular
    #   zone and cannot span multiple zones or regions.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @param routing_table_id [String] Filters the collection to subnets attached to the routing table with the specified
    #   identifier.
    # @param routing_table_name [String] Filters the collection to subnets attached to the routing table with the specified
    #   name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_subnets(start: nil, limit: nil, resource_group_id: nil, routing_table_id: nil, routing_table_name: nil)
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
    #   to succeed, the subnet must not be referenced by any network interfaces, VPN
    #   gateways, or load balancers. A delete operation automatically detaches the subnet
    #   from any network ACLs, public gateways, or endpoint gateways. All flow log
    #   collectors with `auto_delete` set to `true` targeting the subnet or any resource
    #   in the subnet are automatically deleted.
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
    # Attach a network ACL to a subnet.
    # This request attaches the network ACL, specified in the request body, to the
    #   subnet specified by the subnet identifier in the URL. This replaces the existing
    #   network ACL on the subnet.
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
    # Attach a routing table to a subnet.
    # This request attaches the routing table, specified in the request body, to the
    #   subnet specified by the subnet identifier in the URL. This replaces the existing
    #   routing table on the subnet.
    #
    #   For this request to succeed, the routing table `route_direct_link_ingress`,
    #   `route_transit_gateway_ingress`, and `route_vpc_zone_ingress` properties must be
    #   `false`.
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
    # @!method list_subnet_reserved_ips(subnet_id:, start: nil, limit: nil, sort: nil)
    # List all reserved IPs in a subnet.
    # This request lists reserved IPs in a subnet that are unbound or bound to an
    #   endpoint gateway.
    # @param subnet_id [String] The subnet identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_subnet_reserved_ips(subnet_id:, start: nil, limit: nil, sort: nil)
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
        "sort" => sort
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
    # @!method create_subnet_reserved_ip(subnet_id:, auto_delete: nil, name: nil, target: nil)
    # Reserve an IP in a subnet.
    # This request reserves a system-selected IP address in a subnet.
    # @param subnet_id [String] The subnet identifier.
    # @param auto_delete [Boolean] If set to `true`, this reserved IP will be automatically deleted when the target
    #   is deleted or when the reserved IP is unbound. The value cannot be set to `true`
    #   if the reserved IP is unbound.
    # @param name [String] The user-defined name for this reserved IP. If not specified, the name will be a
    #   hyphenated list of randomly-selected words. Names must be unique within the subnet
    #   the reserved IP resides in. Names beginning with `ibm-` are reserved for
    #   provider-owned resources.
    # @param target [ReservedIPTargetPrototype] The target this reserved IP is to be bound to.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_subnet_reserved_ip(subnet_id:, auto_delete: nil, name: nil, target: nil)
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
    # Release a reserved IP.
    # This request releases a reserved IP. This operation cannot be reversed.
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
    # @!method list_images(start: nil, limit: nil, resource_group_id: nil, name: nil, visibility: nil)
    # List all images.
    # This request lists all provisionable images available in the region. An image
    #   provides source data for a volume. Images are either system-provided, or created
    #   from another source, such as importing from object storage.
    #
    #   The images will be sorted by their `created_at` property values, with the newest
    #   first. Images with identical `created_at` values will be secondarily sorted by
    #   ascending `id` property values.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @param name [String] Filters the collection to resources with the exact specified name.
    # @param visibility [String] Filters the collection to images with the specified `visibility`.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_images(start: nil, limit: nil, resource_group_id: nil, name: nil, visibility: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_images")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit,
        "resource_group.id" => resource_group_id,
        "name" => name,
        "visibility" => visibility
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
    # This request deletes an image. This operation cannot be reversed. A
    #   system-provided image is not allowed to be deleted. Additionally, an image cannot
    #   be deleted if it has a
    #   `status` of `pending`, `tentative`, or `deleting`.
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
    # @!method list_operating_systems(start: nil, limit: nil)
    # List all operating systems.
    # This request lists all operating systems in the region.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # @!method list_keys(start: nil, limit: nil, resource_group_id: nil)
    # List all keys.
    # This request lists all keys in the region. A key contains a public SSH key which
    #   may be installed on instances when they are created. Private keys are not stored.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_keys(start: nil, limit: nil, resource_group_id: nil)
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
        "limit" => limit,
        "resource_group.id" => resource_group_id
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
    # @param public_key [String] A unique public SSH key to import, encoded in PEM format. The key (prior to
    #   encoding) must be either 2048 or 4096 bits long.
    # @param name [String] The unique user-defined name for this key. If unspecified, the name will be a
    #   hyphenated list of randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
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
    # List all instance profiles.
    # This request lists provisionable instance profiles in the region. An instance
    #   profile specifies the performance characteristics and pricing model for an
    #   instance.
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
    # List all instance templates.
    # This request lists all instance templates in the region.
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
    # This request creates a new instance template.
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
    # @!method list_instances(start: nil, limit: nil, resource_group_id: nil, name: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil, dedicated_host_id: nil, dedicated_host_crn: nil, dedicated_host_name: nil)
    # List all instances.
    # This request lists all instances in the region.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @param name [String] Filters the collection to resources with the exact specified name.
    # @param vpc_id [String] Filters the collection to resources in the VPC with the specified identifier.
    # @param vpc_crn [String] Filters the collection to resources in the VPC with the specified CRN.
    # @param vpc_name [String] Filters the collection to resources in the VPC with the exact specified name.
    # @param dedicated_host_id [String] Filters the collection to instances on the dedicated host with the specified
    #   identifier.
    # @param dedicated_host_crn [String] Filters the collection to instances on the dedicated host with the specified CRN.
    # @param dedicated_host_name [String] Filters the collection to instances on the dedicated host with the specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_instances(start: nil, limit: nil, resource_group_id: nil, name: nil, vpc_id: nil, vpc_crn: nil, vpc_name: nil, dedicated_host_id: nil, dedicated_host_crn: nil, dedicated_host_name: nil)
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
        "vpc.id" => vpc_id,
        "vpc.crn" => vpc_crn,
        "vpc.name" => vpc_name,
        "dedicated_host.id" => dedicated_host_id,
        "dedicated_host.crn" => dedicated_host_crn,
        "dedicated_host.name" => dedicated_host_name
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
    # @!method delete_instance(id:)
    # Delete an instance.
    # This request deletes an instance. This operation cannot be reversed. Any floating
    #   IPs associated with the instance's network interfaces are implicitly
    #   disassociated. All flow log collectors with `auto_delete` set to `true` targeting
    #   the instance and/or the instance's network interfaces are automatically deleted.
    # @param id [String] The instance identifier.
    # @return [nil]
    def delete_instance(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
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
    # @param id [String] The instance identifier.
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
    # @!method update_instance(id:, instance_patch:)
    # Update an instance.
    # This request updates an instance with the information in a provided instance
    #   patch. The instance patch object is structured in the same way as a retrieved
    #   instance and contains only the information to be updated.
    # @param id [String] The instance identifier.
    # @param instance_patch [Hash] The instance patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_instance(id:, instance_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("instance_patch must be provided") if instance_patch.nil?

      headers = {
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
    # This request retrieves configuration variables used to initialize the instance,
    #   such as SSH keys and the Windows administrator password.
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
    # @param instance_id [String] The instance identifier.
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
    # @param instance_id [String] The instance identifier.
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
    # List all disks on an instance.
    # This request lists all disks on an instance.  A disk is a block device that is
    #   locally attached to the instance's physical host and is also referred to as
    #   instance storage. By default, the listed disks are sorted by their `created_at`
    #   property values, with the newest disk first.
    # @param instance_id [String] The instance identifier.
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
    # @param instance_id [String] The instance identifier.
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
    # @param instance_id [String] The instance identifier.
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
    # @!method list_instance_network_interfaces(instance_id:)
    # List all network interfaces on an instance.
    # This request lists all network interfaces on an instance. A network interface is
    #   an abstract representation of a network interface card and connects an instance to
    #   a subnet. While each network interface can attach to only one subnet, multiple
    #   network interfaces can be created to attach to multiple subnets. Multiple
    #   interfaces may also attach to the same subnet.
    # @param instance_id [String] The instance identifier.
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
    # @!method create_instance_network_interface(instance_id:, subnet:, allow_ip_spoofing: nil, name: nil, primary_ipv4_address: nil, security_groups: nil)
    # Create a network interface on an instance.
    # This request creates a new network interface from a network interface prototype
    #   object. The prototype object is structured in the same way as a retrieved network
    #   interface, and contains the information necessary to create the new network
    #   interface. Any subnet in the instance's VPC may be specified, even if it is
    #   already attached to another network interface. Addresses on the network interface
    #   must be within the specified subnet's CIDR blocks.
    # @param instance_id [String] The instance identifier.
    # @param subnet [SubnetIdentity] The associated subnet.
    # @param allow_ip_spoofing [Boolean] Indicates whether source IP spoofing is allowed on this interface. If false,
    #   source IP spoofing is prevented on this interface. If true, source IP spoofing is
    #   allowed on this interface.
    # @param name [String] The user-defined name for this network interface. If unspecified, the name will be
    #   a hyphenated list of randomly-selected words.
    # @param primary_ipv4_address [String] The primary IPv4 address. If specified, it must be an available address on the
    #   network interface's subnet. If unspecified, an available address on the subnet
    #   will be automatically selected.
    # @param security_groups [Array[SecurityGroupIdentity]] Collection of security groups.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_instance_network_interface(instance_id:, subnet:, allow_ip_spoofing: nil, name: nil, primary_ipv4_address: nil, security_groups: nil)
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
        "primary_ipv4_address" => primary_ipv4_address,
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
    # Delete a network interface.
    # This request deletes a network interface. This operation cannot be reversed. Any
    #   floating IPs associated with the network interface are implicitly disassociated.
    #   All flow log collectors with `auto_delete` set to `true` targeting the network
    #   interface are automatically deleted. The primary network interface is not allowed
    #   to be deleted.
    # @param instance_id [String] The instance identifier.
    # @param id [String] The network interface identifier.
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
    # Retrieve a network interface.
    # This request retrieves a single network interface specified by the identifier in
    #   the URL.
    # @param instance_id [String] The instance identifier.
    # @param id [String] The network interface identifier.
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
    # Update a network interface.
    # This request updates a network interface with the information provided in a
    #   network interface patch object. The network interface patch object is structured
    #   in the same way as a retrieved network interface and needs to contain only the
    #   information to be updated.
    # @param instance_id [String] The instance identifier.
    # @param id [String] The network interface identifier.
    # @param network_interface_patch [Hash] The network interface patch.
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
    # List all floating IPs associated with a network interface.
    # This request lists all floating IPs associated with a network interface.
    # @param instance_id [String] The instance identifier.
    # @param network_interface_id [String] The network interface identifier.
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
    # Disassociate a floating IP from a network interface.
    # This request disassociates the specified floating IP from the specified network
    #   interface.
    # @param instance_id [String] The instance identifier.
    # @param network_interface_id [String] The network interface identifier.
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
    # This request a retrieves a specified floating IP address if it is associated with
    #   the network interface and instance specified in the URL.
    # @param instance_id [String] The instance identifier.
    # @param network_interface_id [String] The network interface identifier.
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
    # Associate a floating IP with a network interface.
    # This request associates the specified floating IP with the specified network
    #   interface, replacing any existing association. For this request to succeed, the
    #   existing floating IP must not be required by another resource, such as a public
    #   gateway. A request body is not required, and if supplied, is ignored.
    # @param instance_id [String] The instance identifier.
    # @param network_interface_id [String] The network interface identifier.
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
    # @!method list_instance_volume_attachments(instance_id:)
    # List all volumes attachments on an instance.
    # This request lists all volume attachments on an instance. A volume attachment
    #   connects a volume to an instance. Each instance may have many volume attachments
    #   but each volume attachment connects exactly one instance to exactly one volume.
    # @param instance_id [String] The instance identifier.
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
    #   object. The prototype object is structured in the same way as a retrieved volume
    #   attachment, and contains the information necessary to create the new volume
    #   attachment. The creation of a new volume attachment connects a volume to an
    #   instance.
    # @param instance_id [String] The instance identifier.
    # @param volume [VolumeAttachmentPrototypeVolume] An existing volume to attach to the instance, or a prototype object for a new
    #   volume.
    # @param delete_volume_on_instance_delete [Boolean] If set to true, when deleting the instance the volume will also be deleted.
    # @param name [String] The user-defined name for this volume attachment. If unspecified, the name will be
    #   a hyphenated list of randomly-selected words.
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
    # This request deletes a volume attachment. The deletion of a volume attachment
    #   detaches a volume from an instance.
    # @param instance_id [String] The instance identifier.
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
    # @param instance_id [String] The instance identifier.
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
    # @param instance_id [String] The instance identifier.
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
    # List all instance groups.
    # This request lists all instance groups in the region.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # @param subnets [Array[SubnetIdentity]] The subnets to use when creating new instances.
    # @param application_port [Fixnum] Required if specifying a load balancer pool only. Used by the instance group when
    #   scaling up instances to supply the port for the load balancer pool member.
    # @param load_balancer [LoadBalancerIdentity] The load balancer that the load balancer pool used by this group
    #   is in. Must be supplied when using a load balancer pool.
    # @param load_balancer_pool [LoadBalancerPoolIdentity] When specified, the load balancer pool will be managed by this
    #   group. Instances created by this group will have a new load
    #   balancer pool member in that pool created. Must be used with
    #   `application_port`.
    # @param membership_count [Fixnum] The number of instances in the instance group.
    # @param name [String] The user-defined name for this instance group.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
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
    # List all managers for an instance group.
    # This request lists all managers for an instance group.
    # @param instance_group_id [String] The instance group identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # List all actions for an instance group manager.
    # This request lists all instance group actions for an instance group manager.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # List all policies for an instance group manager.
    # This request lists all policies for an instance group manager.
    # @param instance_group_id [String] The instance group identifier.
    # @param instance_group_manager_id [String] The instance group manager identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # Delete all memberships from an instance group.
    # This request deletes all memberships of an instance group. This operation cannot
    #   be reversed. reversed. Any memberships that have
    #   `delete_instance_on_membership_delete` set to `true` will also have their
    #   instances deleted.
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
    # List all memberships for an instance group.
    # This request lists all instance group memberships for an instance group.
    # @param instance_group_id [String] The instance group identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # Dedicated hosts
    #########################

    ##
    # @!method list_dedicated_host_groups(start: nil, limit: nil, resource_group_id: nil, zone_name: nil)
    # List all dedicated host groups.
    # This request lists all dedicated host groups in the region. Host groups are a
    #   collection of dedicated hosts for placement of instances. Each dedicated host must
    #   belong to one and only one group. Host groups do not span zones.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @param zone_name [String] Filters the collection to resources in the zone with the exact specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_dedicated_host_groups(start: nil, limit: nil, resource_group_id: nil, zone_name: nil)
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
        "zone.name" => zone_name
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
    # @!method create_dedicated_host_group(_class: nil, family: nil, zone: nil, name: nil, resource_group: nil)
    # Create a dedicated host group.
    # This request creates a new dedicated host group.
    # @param _class [String] The dedicated host profile class for hosts in this group.
    # @param family [String] The dedicated host profile family for hosts in this group.
    # @param zone [ZoneIdentity] The zone this dedicated host group will reside in.
    # @param name [String] The unique user-defined name for this dedicated host group. If unspecified, the
    #   name will be a hyphenated list of randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_dedicated_host_group(_class: nil, family: nil, zone: nil, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

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
    # List all dedicated host profiles.
    # This request lists all provisionable dedicated host profiles in the region. A
    #   dedicated host profile specifies the hardware characteristics for a dedicated
    #   host.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # @!method list_dedicated_hosts(dedicated_host_group_id: nil, start: nil, limit: nil, resource_group_id: nil, zone_name: nil)
    # List all dedicated hosts.
    # This request lists all dedicated hosts in the region.
    # @param dedicated_host_group_id [String] Filters the collection to dedicated host groups with the specified identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @param zone_name [String] Filters the collection to resources in the zone with the exact specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_dedicated_hosts(dedicated_host_group_id: nil, start: nil, limit: nil, resource_group_id: nil, zone_name: nil)
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
        "zone.name" => zone_name
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
    # List all disks on a dedicated host.
    # This request lists all disks on a dedicated host.  A disk is a physical device
    #   that is locally attached to the compute node. By default, the listed disks are
    #   sorted by their
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
    # Volumes
    #########################

    ##
    # @!method list_volume_profiles(start: nil, limit: nil)
    # List all volume profiles.
    # This request lists all volume profiles available in the region. A volume profile
    #   specifies the performance characteristics and pricing model for a volume.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # @!method list_volumes(start: nil, limit: nil, name: nil, zone_name: nil)
    # List all volumes.
    # This request lists all volumes in the region. Volumes are network-connected block
    #   storage devices that may be attached to one or more instances in the same region.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param name [String] Filters the collection to resources with the exact specified name.
    # @param zone_name [String] Filters the collection to resources in the zone with the exact specified name.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_volumes(start: nil, limit: nil, name: nil, zone_name: nil)
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
        "zone.name" => zone_name
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
    # @!method delete_volume(id:)
    # Delete a volume.
    # This request deletes a volume. This operation cannot be reversed. For this request
    #   to succeed, the volume must not be attached to any instances.
    # @param id [String] The volume identifier.
    # @return [nil]
    def delete_volume(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
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
    # @!method update_volume(id:, volume_patch:)
    # Update a volume.
    # This request updates a volume with the information in a provided volume patch. The
    #   volume patch object is structured in the same way as a retrieved volume and
    #   contains only the information to be updated.
    # @param id [String] The volume identifier.
    # @param volume_patch [Hash] The volume patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_volume(id:, volume_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("volume_patch must be provided") if volume_patch.nil?

      headers = {
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
    # @!method delete_snapshots(source_volume_id:)
    # Delete a filtered collection of snapshots.
    # This request deletes all snapshots created from a specific source volume.
    # @param source_volume_id [String] Filters the collection to resources with the source volume with the specified
    #   identifier.
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
    # @!method list_snapshots(start: nil, limit: nil, resource_group_id: nil, name: nil, source_volume_id: nil, source_volume_crn: nil, source_image_id: nil, source_image_crn: nil, sort: nil)
    # List all snapshots.
    # This request lists all snapshots in the region. A snapshot preserves the data of a
    #   volume at the time the snapshot is created.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @param name [String] Filters the collection to resources with the exact specified name.
    # @param source_volume_id [String] Filters the collection to resources with the source volume with the specified
    #   identifier.
    # @param source_volume_crn [String] Filters the collection to resources with the source volume with the specified CRN.
    # @param source_image_id [String] Filters the collection to resources with the source image with the specified
    #   identifier.
    #
    #   This parameter also supports the values `null` and `not:null` which filter the
    #   collection to resources which have no source image or any existent source image,
    #   respectively.
    # @param source_image_crn [String] Filters the collection to resources with the source volume with the specified CRN.
    #
    #   This parameter also supports the values `null` and `not:null` which filter the
    #   collection to resources which have no source image or any existent source image,
    #   respectively.
    # @param sort [String] Sorts the returned collection by the specified property name in ascending order. A
    #   `-` may be prepended to the name to sort in descending order. For example, the
    #   value `-created_at` sorts the collection by the `created_at` property in
    #   descending order, and the value `name` sorts it by the `name` property in
    #   ascending order.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_snapshots(start: nil, limit: nil, resource_group_id: nil, name: nil, source_volume_id: nil, source_volume_crn: nil, source_image_id: nil, source_image_crn: nil, sort: nil)
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
        "resource_group.id" => resource_group_id,
        "name" => name,
        "source_volume.id" => source_volume_id,
        "source_volume.crn" => source_volume_crn,
        "source_image.id" => source_image_id,
        "source_image.crn" => source_image_crn,
        "sort" => sort
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
    # @!method create_snapshot(source_volume:, name: nil, resource_group: nil)
    # Create a snapshot.
    # This request creates a new snapshot from a snapshot prototype object.  The
    #   prototype object is structured in the same way as a retrieved snapshot, and
    #   contains the information necessary to provision the new snapshot.
    # @param source_volume [VolumeIdentity] The volume to snapshot.
    # @param name [String] The unique user-defined name for this snapshot. If unspecified, the name will be a
    #   hyphenated list of randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_snapshot(source_volume:, name: nil, resource_group: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("source_volume must be provided") if source_volume.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "create_snapshot")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      data = {
        "source_volume" => source_volume,
        "name" => name,
        "resource_group" => resource_group
      }

      method_url = "/snapshots"

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
    # @!method delete_snapshot(id:)
    # Delete a snapshot.
    # This request deletes a snapshot. This operation cannot be reversed.
    # @param id [String] The snapshot identifier.
    # @return [nil]
    def delete_snapshot(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
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
    # @!method update_snapshot(id:, snapshot_patch:)
    # Update a snapshot.
    # This request updates a snapshot's name.
    # @param id [String] The snapshot identifier.
    # @param snapshot_patch [Hash] The snapshot patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_snapshot(id:, snapshot_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("snapshot_patch must be provided") if snapshot_patch.nil?

      headers = {
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
    #########################
    # Geography
    #########################

    ##
    # @!method list_regions
    # List all regions.
    # This request lists all regions. Each region is a separate geographic area that
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
    # List all zones in a region.
    # This request lists all zones in a region. Zones represent logically-isolated data
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
    # Public gateways
    #########################

    ##
    # @!method list_public_gateways(start: nil, limit: nil, resource_group_id: nil)
    # List all public gateways.
    # This request lists all public gateways in the region. A public gateway is a
    #   virtual network device associated with a VPC, which allows access to the Internet.
    #   A public gateway resides in a zone and can be connected to subnets in the same
    #   zone only.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
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
    # @param vpc [VPCIdentity] The VPC this public gateway will serve.
    # @param zone [ZoneIdentity] The zone this public gateway will reside in.
    # @param floating_ip [PublicGatewayFloatingIPPrototype]
    # @param name [String] The user-defined name for this public gateway. Names must be unique within the VPC
    #   the public gateway resides in. If unspecified, the name will be a hyphenated list
    #   of randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
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
    # @!method list_floating_ips(start: nil, limit: nil, resource_group_id: nil)
    # List all floating IPs.
    # This request lists all floating IPs in the region. Floating IPs allow inbound and
    #   outbound traffic from the Internet to an instance.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_floating_ips(start: nil, limit: nil, resource_group_id: nil)
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
        "resource_group.id" => resource_group_id
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
    # Release a floating IP.
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
    # List all network ACLs.
    # This request lists all network ACLs in the region. A network ACL defines a set of
    #   packet filtering (5-tuple) rules for all traffic in and out of a subnet. Both
    #   allow and deny rules can be defined, and rules are stateless such that reverse
    #   traffic in response to allowed traffic is not automatically permitted.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
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
    # @!method create_network_acl(network_acl_prototype: nil)
    # Create a network ACL.
    # This request creates a new network ACL from a network ACL prototype object. The
    #   prototype object is structured in the same way as a retrieved network ACL, and
    #   contains the information necessary to create the new network ACL.
    # @param network_acl_prototype [NetworkACLPrototype] The network ACL prototype object.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_network_acl(network_acl_prototype: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

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
    # List all rules for a network ACL.
    # This request lists all rules for a network ACL. These rules can allow or deny
    #   traffic between a source CIDR block and a destination CIDR block over a particular
    #   protocol and port range.
    # @param network_acl_id [String] The network ACL identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param direction [String] Filters the collection to rules with the specified direction.
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
    # List all security groups.
    # This request lists all security groups in the region. Security groups provide a
    #   way to apply IP filtering rules to instances in the associated VPC. With security
    #   groups, all traffic is denied by default, and rules added to security groups
    #   define which traffic the security group permits. Security group rules are stateful
    #   such that reverse traffic in response to allowed traffic is automatically
    #   permitted.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @param vpc_id [String] Filters the collection to resources in the VPC with the specified identifier.
    # @param vpc_crn [String] Filters the collection to resources in the VPC with the specified CRN.
    # @param vpc_name [String] Filters the collection to resources in the VPC with the exact specified name.
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
    #   network interfaces on instances in that VPC can be added to the security group.
    # @param vpc [VPCIdentity] The VPC this security group is to be a part of.
    # @param name [String] The user-defined name for this security group. If unspecified, the name will be a
    #   hyphenated list of randomly-selected words. Names must be unique within the VPC
    #   the security group resides in.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
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
    #   referenced by any network interfaces or other security group rules. Additionally,
    #   a VPC's default security group cannot be deleted. This operation cannot be
    #   reversed.
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
    # @!method list_security_group_network_interfaces(security_group_id:, start: nil, limit: nil)
    # List all network interfaces associated with a security group.
    # This request lists all network interfaces associated with a security group, to
    #   which the rules in the security group are applied.
    # @param security_group_id [String] The security group identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_security_group_network_interfaces(security_group_id:, start: nil, limit: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_security_group_network_interfaces")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation,
        "start" => start,
        "limit" => limit
      }

      method_url = "/security_groups/%s/network_interfaces" % [ERB::Util.url_encode(security_group_id)]

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
    # @!method remove_security_group_network_interface(security_group_id:, id:)
    # Remove a network interface from a security group.
    # This request removes a network interface from a security group. Security groups
    #   are stateful, so any changes to a network interface's security groups are applied
    #   to new connections. Existing connections are not affected. If the network
    #   interface being removed has no other security groups, it will be attached to the
    #   VPC's default security group.
    # @param security_group_id [String] The security group identifier.
    # @param id [String] The network interface identifier.
    # @return [nil]
    def remove_security_group_network_interface(security_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "remove_security_group_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s/network_interfaces/%s" % [ERB::Util.url_encode(security_group_id), ERB::Util.url_encode(id)]

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
    # @!method get_security_group_network_interface(security_group_id:, id:)
    # Retrieve a network interface in a security group.
    # This request retrieves a single network interface specified by the identifier in
    #   the URL path. The network interface must be an existing member of the security
    #   group.
    # @param security_group_id [String] The security group identifier.
    # @param id [String] The network interface identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def get_security_group_network_interface(security_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "get_security_group_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s/network_interfaces/%s" % [ERB::Util.url_encode(security_group_id), ERB::Util.url_encode(id)]

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
    # @!method add_security_group_network_interface(security_group_id:, id:)
    # Add a network interface to a security group.
    # This request adds an existing network interface to an existing security group.
    #   When a network interface is added to a security group, the security group rules
    #   are applied to the network interface. A request body is not required, and if
    #   supplied, is ignored.
    # @param security_group_id [String] The security group identifier.
    # @param id [String] The network interface identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def add_security_group_network_interface(security_group_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("security_group_id must be provided") if security_group_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "add_security_group_network_interface")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/security_groups/%s/network_interfaces/%s" % [ERB::Util.url_encode(security_group_id), ERB::Util.url_encode(id)]

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
    # @!method list_security_group_rules(security_group_id:)
    # List all rules in a security group.
    # This request lists all rules in a security group. These rules define what traffic
    #   the security group permits. Security group rules are stateful, such that reverse
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
    #   traffic a security group should allow. Security group rules are stateful, such
    #   that reverse traffic in response to allowed traffic is automatically permitted. A
    #   rule allowing inbound TCP traffic on port 80 also allows outbound TCP traffic on
    #   port 80 without the need for an additional rule.
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
    # List all targets associated with a security group.
    # This request lists all targets associated with a security group, to which the
    #   rules in the security group are applied.
    # @param security_group_id [String] The security group identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    #   the target must be attached to at least one other security group.  The supplied
    #   target identifier can be:
    #
    #   - A network interface identifier
    #   - An application load balancer identifier
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
    # This request adds a resource to an existing security group. The supplied target
    #   identifier can be:
    #
    #   - A network interface identifier
    #   - An application load balancer identifier
    #
    #   When a target is added to a security group, the security group rules are applied
    #   to the target. A request body is not required, and if supplied, is ignored.
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
    # List all IKE policies.
    # This request lists all IKE policies in the region.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # @param name [String] The user-defined name for this IKE policy.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
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
    # This request deletes an IKE policy. This operation cannot be reversed.
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
    # @!method list_ike_policy_connections(id:)
    # List all VPN gateway connections that use a specified IKE policy.
    # This request lists all VPN gateway connections that use a policy.
    # @param id [String] The IKE policy identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_ike_policy_connections(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_ike_policy_connections")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
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
    # List all IPsec policies.
    # This request lists all IPsec policies in the region.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # @param authentication_algorithm [String] The authentication algorithm.
    # @param encryption_algorithm [String] The encryption algorithm.
    # @param pfs [String] Perfect Forward Secrecy.
    # @param key_lifetime [Fixnum] The key lifetime in seconds.
    # @param name [String] The user-defined name for this IPsec policy.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
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
    # This request deletes an IPsec policy. This operation cannot be reversed.
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
    # @!method list_ipsec_policy_connections(id:)
    # List all VPN gateway connections that use a specified IPsec policy.
    # This request lists all VPN gateway connections that use a policy.
    # @param id [String] The IPsec policy identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_ipsec_policy_connections(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_ipsec_policy_connections")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
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
    # @!method list_vpn_gateways(start: nil, limit: nil, resource_group_id: nil, mode: nil)
    # List all VPN gateways.
    # This request lists all VPN gateways in the region.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @param mode [String] Filters the collection to VPN gateways with the specified mode.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_gateways(start: nil, limit: nil, resource_group_id: nil, mode: nil)
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
    # This request deletes a VPN gateway. A VPN gateway with a `status` of `pending`
    #   cannot be deleted. This operation deletes all VPN gateway connections associated
    #   with this VPN gateway.  This operation cannot be reversed.
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
    # @!method list_vpn_gateway_connections(vpn_gateway_id:, status: nil)
    # List all connections of a VPN gateway.
    # This request lists all connections of a VPN gateway.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param status [String] Filters the collection to VPN gateway connections with the specified status.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_gateway_connections(vpn_gateway_id:, status: nil)
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
    # @!method list_vpn_gateway_connection_local_cidrs(vpn_gateway_id:, id:)
    # List all local CIDRs for a VPN gateway connection.
    # This request lists all local CIDRs for a VPN gateway connection.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_gateway_connection_local_cidrs(vpn_gateway_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpn_gateway_connection_local_cidrs")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/local_cidrs" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id)]

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
    # @!method remove_vpn_gateway_connection_local_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
    # Remove a local CIDR from a VPN gateway connection.
    # This request removes a CIDR from a VPN gateway connection.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr_prefix [String] The address prefix part of the CIDR.
    # @param prefix_length [String] The prefix length part of the CIDR.
    # @return [nil]
    def remove_vpn_gateway_connection_local_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr_prefix must be provided") if cidr_prefix.nil?

      raise ArgumentError.new("prefix_length must be provided") if prefix_length.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "remove_vpn_gateway_connection_local_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/local_cidrs/%s/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr_prefix), ERB::Util.url_encode(prefix_length)]

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
    # @!method check_vpn_gateway_connection_local_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
    # Check if the specified local CIDR exists on a VPN gateway connection.
    # This request succeeds if a CIDR exists on the specified VPN gateway connection and
    #   fails otherwise.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr_prefix [String] The address prefix part of the CIDR.
    # @param prefix_length [String] The prefix length part of the CIDR.
    # @return [nil]
    def check_vpn_gateway_connection_local_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr_prefix must be provided") if cidr_prefix.nil?

      raise ArgumentError.new("prefix_length must be provided") if prefix_length.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "check_vpn_gateway_connection_local_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/local_cidrs/%s/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr_prefix), ERB::Util.url_encode(prefix_length)]

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
    # @!method add_vpn_gateway_connection_local_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
    # Set a local CIDR on a VPN gateway connection.
    # This request adds the specified CIDR to the specified VPN gateway connection. A
    #   request body is not required, and if supplied, is ignored. This request succeeds
    #   if the CIDR already exists on the specified VPN gateway connection.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr_prefix [String] The address prefix part of the CIDR.
    # @param prefix_length [String] The prefix length part of the CIDR.
    # @return [nil]
    def add_vpn_gateway_connection_local_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr_prefix must be provided") if cidr_prefix.nil?

      raise ArgumentError.new("prefix_length must be provided") if prefix_length.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "add_vpn_gateway_connection_local_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/local_cidrs/%s/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr_prefix), ERB::Util.url_encode(prefix_length)]

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
    # @!method list_vpn_gateway_connection_peer_cidrs(vpn_gateway_id:, id:)
    # List all peer CIDRs for a VPN gateway connection.
    # This request lists all peer CIDRs for a VPN gateway connection.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_vpn_gateway_connection_peer_cidrs(vpn_gateway_id:, id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "list_vpn_gateway_connection_peer_cidrs")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/peer_cidrs" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id)]

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
    # @!method remove_vpn_gateway_connection_peer_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
    # Remove a peer CIDR from a VPN gateway connection.
    # This request removes a CIDR from a VPN gateway connection.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr_prefix [String] The address prefix part of the CIDR.
    # @param prefix_length [String] The prefix length part of the CIDR.
    # @return [nil]
    def remove_vpn_gateway_connection_peer_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr_prefix must be provided") if cidr_prefix.nil?

      raise ArgumentError.new("prefix_length must be provided") if prefix_length.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "remove_vpn_gateway_connection_peer_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/peer_cidrs/%s/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr_prefix), ERB::Util.url_encode(prefix_length)]

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
    # @!method check_vpn_gateway_connection_peer_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
    # Check if the specified peer CIDR exists on a VPN gateway connection.
    # This request succeeds if a CIDR exists on the specified VPN gateway connection and
    #   fails otherwise.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr_prefix [String] The address prefix part of the CIDR.
    # @param prefix_length [String] The prefix length part of the CIDR.
    # @return [nil]
    def check_vpn_gateway_connection_peer_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr_prefix must be provided") if cidr_prefix.nil?

      raise ArgumentError.new("prefix_length must be provided") if prefix_length.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "check_vpn_gateway_connection_peer_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/peer_cidrs/%s/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr_prefix), ERB::Util.url_encode(prefix_length)]

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
    # @!method add_vpn_gateway_connection_peer_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
    # Set a peer CIDR on a VPN gateway connection.
    # This request adds the specified CIDR to the specified VPN gateway connection. A
    #   request body is not required, and if supplied, is ignored. This request succeeds
    #   if the CIDR already exists on the specified VPN gateway connection.
    # @param vpn_gateway_id [String] The VPN gateway identifier.
    # @param id [String] The VPN gateway connection identifier.
    # @param cidr_prefix [String] The address prefix part of the CIDR.
    # @param prefix_length [String] The prefix length part of the CIDR.
    # @return [nil]
    def add_vpn_gateway_connection_peer_cidr(vpn_gateway_id:, id:, cidr_prefix:, prefix_length:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("vpn_gateway_id must be provided") if vpn_gateway_id.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("cidr_prefix must be provided") if cidr_prefix.nil?

      raise ArgumentError.new("prefix_length must be provided") if prefix_length.nil?

      headers = {
      }
      sdk_headers = Common.new.get_sdk_headers("vpc", "V1", "add_vpn_gateway_connection_peer_cidr")
      headers.merge!(sdk_headers)

      params = {
        "version" => @version,
        "generation" => @generation
      }

      method_url = "/vpn_gateways/%s/connections/%s/peer_cidrs/%s/%s" % [ERB::Util.url_encode(vpn_gateway_id), ERB::Util.url_encode(id), ERB::Util.url_encode(cidr_prefix), ERB::Util.url_encode(prefix_length)]

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
    # Load balancers
    #########################

    ##
    # @!method list_load_balancer_profiles(start: nil, limit: nil)
    # List all load balancer profiles.
    # This request lists all load balancer profiles available in the region. A load
    #   balancer profile specifies the performance characteristics and pricing model for a
    #   load balancer.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # List all load balancers.
    # This request lists all load balancers in the region.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # @!method create_load_balancer(is_public:, subnets:, listeners: nil, logging: nil, name: nil, pools: nil, profile: nil, resource_group: nil, security_groups: nil)
    # Create a load balancer.
    # This request creates and provisions a new load balancer.
    # @param is_public [Boolean] Indicates whether this load balancer is public or private.
    # @param subnets [Array[SubnetIdentity]] The subnets to provision this load balancer.
    # @param listeners [Array[LoadBalancerListenerPrototypeLoadBalancerContext]] The listeners of this load balancer.
    # @param logging [LoadBalancerLogging] The logging configuration to use for this load balancer. See [VPC Datapath
    #   Logging](https://cloud.ibm.com/docs/vpc?topic=vpc-datapath-logging)
    #   on the logging format, fields and permitted values.
    #
    #   To activate logging, the load balancer profile must support the specified logging
    #   type.
    # @param name [String] The user-defined name for this load balancer. If unspecified, the name will be a
    #   hyphenated list of randomly-selected words.
    # @param pools [Array[LoadBalancerPoolPrototype]] The pools of this load balancer.
    # @param profile [LoadBalancerProfileIdentity] The profile to use for this load balancer.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
    # @param security_groups [Array[SecurityGroupIdentity]] The security groups to use for this load balancer.
    #
    #   The load balancer profile must support security groups.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_load_balancer(is_public:, subnets:, listeners: nil, logging: nil, name: nil, pools: nil, profile: nil, resource_group: nil, security_groups: nil)
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
        "listeners" => listeners,
        "logging" => logging,
        "name" => name,
        "pools" => pools,
        "profile" => profile,
        "resource_group" => resource_group,
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
    # @!method delete_load_balancer(id:)
    # Delete a load balancer.
    # This request deletes a load balancer. This operation cannot be reversed.
    # @param id [String] The load balancer identifier.
    # @return [nil]
    def delete_load_balancer(id:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      headers = {
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
    # @!method update_load_balancer(id:, load_balancer_patch:)
    # Update a load balancer.
    # This request updates a load balancer.
    # @param id [String] The load balancer identifier.
    # @param load_balancer_patch [Hash] The load balancer patch.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def update_load_balancer(id:, load_balancer_patch:)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("id must be provided") if id.nil?

      raise ArgumentError.new("load_balancer_patch must be provided") if load_balancer_patch.nil?

      headers = {
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
    # List all statistics of a load balancer.
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
    # List all listeners for a load balancer.
    # This request lists all listeners for a load balancer.
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
    # @!method create_load_balancer_listener(load_balancer_id:, port:, protocol:, accept_proxy_protocol: nil, certificate_instance: nil, connection_limit: nil, default_pool: nil, policies: nil)
    # Create a listener for a load balancer.
    # This request creates a new listener for a load balancer.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param port [Fixnum] The listener port number. Each listener in the load balancer must have a unique
    #   `port` and `protocol` combination.
    # @param protocol [String] The listener protocol. Load balancers in the `network` family support `tcp`. Load
    #   balancers in the `application` family support `tcp`, `http`, and `https`. Each
    #   listener in the load balancer must have a unique `port` and `protocol`
    #   combination.
    # @param accept_proxy_protocol [Boolean] If set to `true`, this listener will accept and forward PROXY protocol
    #   information. Supported by load balancers in the `application` family (otherwise
    #   always `false`).
    # @param certificate_instance [CertificateInstanceIdentity] The certificate instance used for SSL termination. It is applicable only to
    #   `https`
    #   protocol.
    # @param connection_limit [Fixnum] The connection limit of the listener.
    # @param default_pool [LoadBalancerPoolIdentity] The default pool associated with the listener. The specified pool must:
    #
    #   - Belong to this load balancer
    #   - Have the same `protocol` as this listener
    #   - Not already be the default pool for another listener.
    # @param policies [Array[LoadBalancerListenerPolicyPrototype]] The policy prototype objects for this listener.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_load_balancer_listener(load_balancer_id:, port:, protocol:, accept_proxy_protocol: nil, certificate_instance: nil, connection_limit: nil, default_pool: nil, policies: nil)
      raise ArgumentError.new("version must be provided") if version.nil?

      raise ArgumentError.new("generation must be provided") if generation.nil?

      raise ArgumentError.new("load_balancer_id must be provided") if load_balancer_id.nil?

      raise ArgumentError.new("port must be provided") if port.nil?

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
        "port" => port,
        "protocol" => protocol,
        "accept_proxy_protocol" => accept_proxy_protocol,
        "certificate_instance" => certificate_instance,
        "connection_limit" => connection_limit,
        "default_pool" => default_pool,
        "policies" => policies
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
    # List all policies for a load balancer listener.
    # This request lists all policies for a load balancer listener.
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
    # Creates a new policy for a load balancer listener.
    # @param load_balancer_id [String] The load balancer identifier.
    # @param listener_id [String] The listener identifier.
    # @param action [String] The policy action.
    #
    #   The enumerated values for this property are expected to expand in the future. When
    #   processing this property, check for and log unknown values. Optionally halt
    #   processing and surface the error, or bypass the policy on which the unexpected
    #   property value was encountered.
    # @param priority [Fixnum] Priority of the policy. Lower value indicates higher priority.
    # @param name [String] The user-defined name for this policy. Names must be unique within the load
    #   balancer listener the policy resides in.
    # @param rules [Array[LoadBalancerListenerPolicyRulePrototype]] The rule prototype objects for this policy.
    # @param target [LoadBalancerListenerPolicyTargetPrototype] - If `action` is `forward`, specify a `LoadBalancerPoolIdentity`.
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
    # Updates a policy from a policy patch.
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
    # List all rules of a load balancer listener policy.
    # This request lists all rules of a load balancer listener policy.
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
    # List all pools of a load balancer.
    # This request lists all pools of a load balancer.
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
    #   family support `tcp`. Load balancers in the `application` family support `tcp`,
    #   `http`, and
    #   `https`.
    # @param members [Array[LoadBalancerPoolMemberPrototype]] The members for this load balancer pool. For load balancers in the `network`
    #   family, the same `port` and `target` tuple cannot be shared by a pool member of
    #   any other load balancer in the same VPC.
    # @param name [String] The user-defined name for this load balancer pool. If unspecified, the name will
    #   be a hyphenated list of randomly-selected words.
    # @param proxy_protocol [String] The PROXY protocol setting for this pool:
    #   - `v1`: Enabled with version 1 (human-readable header format)
    #   - `v2`: Enabled with version 2 (binary header format)
    #   - `disabled`: Disabled
    #
    #   Supported by load balancers in the `application` family (otherwise always
    #   `disabled`).
    # @param session_persistence [LoadBalancerPoolSessionPersistencePrototype] The session persistence of this pool.
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
    # List all members of a load balancer pool.
    # This request lists all members of a load balancer pool.
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
    # @param port [Fixnum] The port number of the application running in the server member.
    # @param target [LoadBalancerPoolMemberTargetPrototype] The pool member target. Load balancers in the `network` family support virtual
    #   server
    #   instances. Load balancers in the `application` family support IP addresses.
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
    # @!method list_endpoint_gateways(name: nil, start: nil, limit: nil, resource_group_id: nil)
    # List all endpoint gateways.
    # This request lists all endpoint gateways in the region. An endpoint gateway maps
    #   one or more reserved IPs in a VPC to a target outside the VPC.
    # @param name [String] Filters the collection to resources with the exact specified name.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def list_endpoint_gateways(name: nil, start: nil, limit: nil, resource_group_id: nil)
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
        "resource_group.id" => resource_group_id
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
    # @!method create_endpoint_gateway(target:, vpc:, ips: nil, name: nil, resource_group: nil)
    # Create an endpoint gateway.
    # This request creates a new endpoint gateway. An endpoint gateway maps one or more
    #   reserved IPs in a VPC to a target outside the VPC.
    # @param target [EndpointGatewayTargetPrototype] The target for this endpoint gateway.
    # @param vpc [VPCIdentity] The VPC this endpoint gateway will serve.
    # @param ips [Array[EndpointGatewayReservedIP]] The reserved IPs to bind to this endpoint gateway. At most one reserved IP per
    #   zone is allowed.
    # @param name [String] The user-defined name for this endpoint gateway. If unspecified, the name will be
    #   a hyphenated list of randomly-selected words. Names must be unique within the VPC
    #   this endpoint gateway is serving.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
    # @return [IBMCloudSdkCore::DetailedResponse] A `IBMCloudSdkCore::DetailedResponse` object representing the response.
    def create_endpoint_gateway(target:, vpc:, ips: nil, name: nil, resource_group: nil)
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
        "ips" => ips,
        "name" => name,
        "resource_group" => resource_group
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
    # List all reserved IPs bound to an endpoint gateway.
    # This request lists all reserved IPs bound to an endpoint gateway.
    # @param endpoint_gateway_id [String] The endpoint gateway identifier.
    # @param start [String] A server-supplied token determining what resource to start the page on.
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
    # This request a retrieves the specified reserved IP address if it is bound to the
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
    #   - must currently be unbound
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
    # List all flow log collectors.
    # This request lists all flow log collectors in the region. A flow log collector
    #   summarizes data sent over one or more network interfaces within a VPC, depending
    #   on the chosen target.
    # @param start [String] A server-supplied token determining what resource to start the page on.
    # @param limit [Fixnum] The number of resources to return on a page.
    # @param resource_group_id [String] Filters the collection to resources within one of the resource groups identified
    #   in a comma-separated list of resource group identifiers.
    # @param name [String] Filters the collection to resources with the exact specified name.
    # @param vpc_id [String] Filters the collection to resources in the VPC with the specified identifier.
    # @param vpc_crn [String] Filters the collection to resources in the VPC with the specified CRN.
    # @param vpc_name [String] Filters the collection to resources in the VPC with the exact specified name.
    # @param target_id [String] Filters the collection to flow log collectors that target the specified resource.
    # @param target_resource_type [String] Filters the collection to flow log collectors that target the specified resource
    #   type.
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
    # @param storage_bucket [CloudObjectStorageBucketIdentity] The Cloud Object Storage bucket where the collected flows will be logged.
    #   The bucket must exist and an IAM service authorization must grant
    #   `IBM Cloud Flow Logs` resources of `VPC Infrastructure Services` writer
    #   access to the bucket.
    # @param target [FlowLogCollectorTargetPrototype] The target this collector will collect flow logs for. If the target is an
    #   instance,
    #   subnet, or VPC, flow logs will not be collected for any network interfaces within
    #   the
    #   target that are themselves the target of a more specific flow log collector.
    # @param active [Boolean] Indicates whether this collector will be active upon creation.
    # @param name [String] The unique user-defined name for this flow log collector. If unspecified, the name
    #   will be a hyphenated list of randomly-selected words.
    # @param resource_group [ResourceGroupIdentity] The resource group to use. If unspecified, the account's [default resource
    #   group](https://cloud.ibm.com/apidocs/resource-manager#introduction) is used.
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
    # This request stops and deletes a flow log collector. Collected flow logs remain
    #   available within the flow log collector's bucket.
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
