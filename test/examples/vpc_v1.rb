# frozen_string_literal: true

require_relative "../test_helper.rb"
require "minitest/hooks/test"
require "ibm_cloud_sdk_core"
require "json"

file_path = File.join(File.dirname(__FILE__), "../../vpc.env")
ENV["IBM_CREDENTIALS_FILE"] = file_path
if ENV["IBM_CREDENTIALS_FILE"]
  class VpcV1Test < Minitest::Test
    include Minitest::Hooks
    attr_accessor :service, :vpc_id

    def before_all
      authenticator = IbmVpc::Authenticators::ConfigBasedAuthenticatorFactory.new.get_authenticator(service_name: "vpc")
      config = get_service_properties("vpc")
      url = config[:url]
      self.service = IbmVpc::VpcV1.new(authenticator: authenticator, service_url: url)
    end

    def test_vpcs
      puts "create_vpc() result:"
      # begin-create_vpc

      vpc = service.create_vpc(name: "my-vpc").result
      # end-create_vpc

      vpc_id = vpc["id"]
      assert vpc_id != ""

      puts "get_vpc() result:"

      # begin-get_vpc

      vpc = service.get_vpc(id: vpc_id).result
      puts JSON.pretty_generate(vpc)
      # end-get_vpc

      assert !vpc.nil?
      assert vpc["id"] != ""

      puts "list_vpcs() result:"

      # begin-list_vpcs

      vpc_collection = service.list_vpcs.result

      puts JSON.pretty_generate(vpc_collection)

      # end-list_vpcs

      assert !vpc_collection.nil?

      puts "update_vpc() result:"
      # begin-update_vpc

      vpc_patch_model = { name: "my-vpc-updated" }

      vpc = service.update_vpc(
        id: vpc_id, vpc_patch: vpc_patch_model
      ).result

      puts JSON.pretty_generate(vpc)

      # end-update_vpc
      assert !vpc.nil?

      puts "get_vpc_default_network_acl() result:"
      # begin-get_vpc_default_network_acl

      default_network_acl = service.get_vpc_default_network_acl(id: vpc_id).result

      puts JSON.pretty_generate(default_network_acl)

      # end-get_vpc_default_network_acl
      assert !default_network_acl.nil?

      puts "get_vpc_default_routing_table() result:"
      # begin-get_vpc_default_routing_table

      default_routing_table = service.get_vpc_default_routing_table(id: vpc_id).result

      puts JSON.pretty_generate(default_routing_table)

      # end-get_vpc_default_routing_table
      assert !default_routing_table.nil?

      puts "get_vpc_default_security_group() result:"
      # begin-get_vpc_default_security_group

      default_security_group = service.get_vpc_default_security_group(id: vpc_id).result

      puts JSON.pretty_generate(default_security_group)

      # end-get_vpc_default_security_group
      assert !default_security_group.nil?

      # begin-delete_vpc

      service.delete_vpc(id: vpc_id)
      # end-delete_vpc
    end

    def test_vpcs_addess_prefix
      vpc = service.create_vpc(name: "my-vpc-address-prefix").result
      vpc_id = vpc["id"]

      puts "list_vpc_address_prefixes() result:"
      # begin-list_vpc_address_prefixes

      address_prefix_collection = service.list_vpc_address_prefixes(vpc_id: vpc_id).result

      puts JSON.pretty_generate(address_prefix_collection)

      # end-list_vpc_address_prefixes
      assert !address_prefix_collection.nil?

      puts "create_vpc_address_prefix() result:"
      # begin-create_vpc_address_prefix

      zone_identity_model = {
        'name': "us-east-1"
      }

      address_prefix = service.create_vpc_address_prefix(
        vpc_id: vpc_id,
        cidr: "10.0.0.0/24",
        zone: zone_identity_model
      ).result
      address_prefix_id = address_prefix["id"]
      puts JSON.pretty_generate(address_prefix)

      # end-create_vpc_address_prefix
      assert !address_prefix.nil?
      puts "get_vpc_address_prefix() result:"
      # begin-get_vpc_address_prefix

      address_prefix = service.get_vpc_address_prefix(
        vpc_id: vpc_id, id: address_prefix_id
      ).result

      puts JSON.pretty_generate(address_prefix)

      # end-get_vpc_address_prefix
      assert !address_prefix.nil?

      puts "update_vpc_address_prefix() result:"
      # begin-update_vpc_address_prefix

      address_prefix_patch_model = { name: "updated-my-vpc-address-prefix" }

      address_prefix = service.update_vpc_address_prefix(
        vpc_id: vpc_id,
        id: address_prefix_id,
        address_prefix_patch: address_prefix_patch_model
      ).result

      puts JSON.pretty_generate(address_prefix)

      # end-update_vpc_address_prefix
      assert !address_prefix.nil?

      # begin-delete_vpc_address_prefix

      service.delete_vpc_address_prefix(
        vpc_id: vpc_id, id: address_prefix_id
      )

      # end-delete_vpc_address_prefix

      service.delete_vpc(id: vpc_id)
    end

    def test_vpc_routing_tables_example
      vpc = service.create_vpc(name: "my-vpc-routing-table").result
      vpc_id = vpc["id"]

      puts "list_vpc_routing_tables() result:"
      # begin-list_vpc_routing_tables

      vpc_routing_table_collection = service.list_vpc_routing_tables(
        vpc_id: vpc_id
      ).result

      puts JSON.pretty_generate(vpc_routing_table_collection)

      # end-list_vpc_routing_tables
      assert !vpc_routing_table_collection.nil?

      puts "create_vpc_routing_table() result:"
      # begin-create_vpc_routing_table

      vpc_routing_table = service.create_vpc_routing_table(
        vpc_id: vpc_id,
        name: "my-vpc-routing-table"
      ).result

      puts JSON.pretty_generate(vpc_routing_table)

      # end-create_vpc_routing_table
      routing_table_id = vpc_routing_table["id"]
      assert !vpc_routing_table.nil?

      puts "get_vpc_routing_table() result:"
      # begin-get_vpc_routing_table

      vpc_routing_table = service.get_vpc_routing_table(
        vpc_id: vpc_id, id: routing_table_id
      ).result

      puts JSON.pretty_generate(vpc_routing_table)

      # end-get_vpc_routing_table
      assert !vpc_routing_table.nil?

      puts "update_vpc_routing_table() result:"
      # begin-update_vpc_routing_table

      routing_table_patch_model = { name: "updated-my-vpc-routing-table" }

      vpc_routing_table = service.update_vpc_routing_table(
        vpc_id: vpc_id,
        id: routing_table_id,
        routing_table_patch: routing_table_patch_model
      ).result

      puts JSON.pretty_generate(vpc_routing_table)

      # end-update_vpc_routing_table
      assert !vpc_routing_table.nil?

      # begin-delete_vpc_routing_table

      service.delete_vpc_routing_table(vpc_id: vpc_id,
                                       id: routing_table_id)

      # end-delete_vpc_routing_table

      service.delete_vpc(id: vpc_id)
    end

    def test_vpc_routing_table_routes_example
      vpc = service.create_vpc(name: "my-vpc-routing-table-route").result
      vpc_id = vpc["id"]
      vpc_routing_table = service.create_vpc_routing_table(
        vpc_id: vpc_id,
        name: "my-vpc-routing-table-route"
      ).result

      routing_table_id = vpc_routing_table["id"]

      puts "list_vpc_routing_table_routes() result:"
      # begin-list_vpc_routing_table_routes

      vpc_routing_table_route_collection = service.list_vpc_routing_table_routes(
        vpc_id: vpc_id,
        routing_table_id: routing_table_id
      ).result

      puts JSON.pretty_generate(vpc_routing_table_route_collection)

      # end-list_vpc_routing_table_routes
      assert !vpc_routing_table_route_collection.nil?

      puts "create_vpc_routing_table_route() result:"
      # begin-create_vpc_routing_table_route

      zone_identity_model = {
        'name': "us-east-1"
      }
      route_next_hop_ip = {
        "address": "192.168.3.4"
      }
      vpc_routing_table_route = service.create_vpc_routing_table_route(
        vpc_id: vpc_id,
        routing_table_id: routing_table_id,
        destination: "192.168.3.0/24",
        zone: zone_identity_model,
        name: "my-vpc-routing-table-route",
        next_hop: route_next_hop_ip
      ).result

      puts JSON.pretty_generate(vpc_routing_table_route)

      # end-create_vpc_routing_table_route
      routing_table_route_id = vpc_routing_table_route["id"]
      assert !vpc_routing_table_route.nil?

      puts "get_vpc_routing_table_route() result:"
      # begin-get_vpc_routing_table_route

      vpc_routing_table_route = service.get_vpc_routing_table_route(
        vpc_id: vpc_id,
        routing_table_id: routing_table_id,
        id: routing_table_route_id
      ).result

      puts JSON.pretty_generate(vpc_routing_table_route)

      # end-get_vpc_routing_table_route
      assert !vpc_routing_table_route.nil?

      puts "update_vpc_routing_table_route() result:"
      # begin-update_vpc_routing_table_route

      route_patch_model = { name: "updated-my-vpc-routing-table-route" }

      vpc_routing_table_route = service.update_vpc_routing_table_route(
        vpc_id: vpc_id,
        routing_table_id: routing_table_id,
        id: routing_table_route_id,
        route_patch: route_patch_model
      ).result

      puts JSON.pretty_generate(vpc_routing_table_route)

      # end-update_vpc_routing_table_route
      assert !vpc_routing_table_route.nil?

      # begin-delete_vpc_routing_table_route

      service.delete_vpc_routing_table_route(
        vpc_id: vpc_id,
        routing_table_id: routing_table_id,
        id: routing_table_route_id
      )

      # end-delete_vpc_routing_table_route

      service.delete_vpc_routing_table(vpc_id: vpc_id,
                                       id: routing_table_id)

      service.delete_vpc(id: vpc_id)
    end

    def test_subnets_example
      vpc = service.create_vpc(name: "my-vpc-subnet").result
      vpc_id = vpc["id"]

      puts "list_subnets() result"
      # begin-list_subnets

      subnet_collection = service.list_subnets.result

      puts JSON.pretty_generate(subnet_collection)

      # end-list_subnets
      assert !subnet_collection.nil?

      puts "create_subnet() result"
      # begin-create_subnet

      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-1"
        },
        'name': "my-subnet"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result

      puts JSON.pretty_generate(subnet)

      # end-create_subnet
      assert !subnet.nil?
      subnet_id = subnet["id"]

      puts "get_subnet() result"
      # begin-get_subnet

      subnet = service.get_subnet(id: subnet_id).result

      puts JSON.pretty_generate(subnet)

      # end-get_subnet
      assert !subnet.nil?

      puts "update_subnet() result"
      # begin-update_subnet

      subnet_patch_model = { 'name': "updated-my-subnet" }

      subnet = service.update_subnet(
        id: subnet_id, subnet_patch: subnet_patch_model
      ).result

      puts JSON.pretty_generate(subnet)

      # end-update_subnet

      vpc_identity_model = {
        'id': vpc_id
      }

      network_acl_prototype_model = {
        'name': "my-subnet-network-acl-",
        'vpc': vpc_identity_model
      }

      network_acl_id = service.create_network_acl(
        network_acl_prototype: network_acl_prototype_model
      ).result["id"]

      puts "get_subnet_network_acl() result"
      # begin-get_subnet_network_acl

      network_acl = service.get_subnet_network_acl(
        id: subnet_id
      ).result

      puts JSON.pretty_generate(network_acl)

      # end-get_subnet_network_acl

      puts "replace_subnet_network_acl() result"
      # begin-replace_subnet_network_acl

      network_acl_identity_model = {
        'id': network_acl_id
      }

      network_acl = service.replace_subnet_network_acl(
        id: subnet_id,
        network_acl_identity: network_acl_identity_model
      ).result

      puts JSON.pretty_generate(network_acl)

      # end-replace_subnet_network_acl

      vpc_identity_model = {
        'id': vpc_id
      }

      zone_identity_model = {
        'name': "us-south-1"
      }

      public_gateway_id = service.create_public_gateway(
        vpc: vpc_identity_model, zone: zone_identity_model,
        name: "my-subnet-public-gateway"
      ).result["id"]

      puts "set_subnet_public_gateway() result"
      # begin-set_subnet_public_gateway

      public_gateway_identity_model = {
        'id': public_gateway_id
      }

      public_gateway = service.set_subnet_public_gateway(
        id: subnet_id,
        public_gateway_identity: public_gateway_identity_model
      ).result

      puts JSON.pretty_generate(public_gateway)

      # end-set_subnet_public_gateway

      puts "get_subnet_public_gateway() result"
      # begin-get_subnet_public_gateway

      public_gateway = service.get_subnet_public_gateway(
        id: subnet_id
      ).result

      puts JSON.pretty_generate(public_gateway)

      # end-get_subnet_public_gateway

      puts "unset_subnet_public_gateway() result"
      # begin-unset_subnet_public_gateway
      service.unset_subnet_public_gateway(
        id: subnet_id
      )
      # end-unset_subnet_public_gateway

      vpc_routing_table_id = service.create_vpc_routing_table(
        vpc_id: vpc_id,
        name: "my-vpc-subnet-routing-table"
      ).result["id"]

      puts "get_subnet_routing_table() result"
      # begin-get_subnet_routing_table

      routing_table = service.get_subnet_routing_table(
        id: subnet_id
      ).result

      puts JSON.pretty_generate(routing_table)

      # end-get_subnet_routing_table

      puts "replace_subnet_routing_table() result"
      # begin-replace_subnet_routing_table

      routing_table_identity_model = {
        'id': vpc_routing_table_id
      }

      routing_table = service.replace_subnet_routing_table(
        id: subnet_id,
        routing_table_identity: routing_table_identity_model
      ).result

      puts JSON.pretty_generate(routing_table)

      # end-replace_subnet_routing_table

      # begin-list_subnet_reserved_ips

      reserved_ip_collection = service.list_subnet_reserved_ips(
        subnet_id: subnet_id
      ).result

      puts JSON.pretty_generate(reserved_ip_collection)

      # end-list_subnet_reserved_ips

      service.create_subnet_reserved_ip(
        subnet_id: subnet_id,
        name: "my-subnet-reservedip-dummy",
        auto_delete: false
      ).result

      # begin-create_subnet_reserved_ip

      reserved_ip = service.create_subnet_reserved_ip(
        subnet_id: subnet_id
      ).result

      puts JSON.pretty_generate(reserved_ip)

      # end-create_subnet_reserved_ip
      reserved_ip_id = reserved_ip["id"]

      # begin-get_subnet_reserved_ip

      reserved_ip = service.get_subnet_reserved_ip(
        subnet_id: subnet_id,
        id: reserved_ip_id
      ).result

      puts JSON.pretty_generate(reserved_ip)

      # end-get_subnet_reserved_ip

      # begin-update_subnet_reserved_ip

      reserved_ip_patch_model = {
        'name': "my-subnet-reserved-ip-updated"
      }

      reserved_ip = service.update_subnet_reserved_ip(
        subnet_id: subnet_id,
        id: reserved_ip_id,
        reserved_ip_patch: reserved_ip_patch_model
      ).result

      puts JSON.pretty_generate(reserved_ip)

      # end-update_subnet_reserved_ip

      # begin-delete_subnet_reserved_ip

      service.delete_subnet_reserved_ip(
        subnet_id: subnet_id,
        id: reserved_ip_id
      )

      # end-delete_subnet_reserved_ip

      puts "delete_subnet() result"
      # begin-delete_subnet

      service.delete_subnet(id: subnet_id)

      # end-delete_subnet

      # sleep(60)
      service.delete_vpc(id: vpc_id)
    end

    def test_subnets_reserved_ips_example
      vpc = service.create_vpc(name: "my-vpc-subnet-reservedips").result
      vpc_id = vpc["id"]

      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-1"
        },
        'name': "my-subnet-reserved-ips"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result

      subnet_id = subnet["id"]

      puts "list_subnet_reserved_ips() result"
      # begin-list_subnet_reserved_ips

      subnet_reserved_ip_collection = service.list_subnet_reserved_ips(
        subnet_id: subnet_id, sort: "name"
      ).result

      puts JSON.pretty_generate(subnet_reserved_ip_collection)

      # end-list_subnet_reserved_ips
      assert !subnet_reserved_ip_collection.nil?

      service.create_subnet_reserved_ip(
        subnet_id: subnet_id,
        name: "my-subnet-reservedip-dummy",
        auto_delete: false
      ).result

      puts "create_subnet_reserved_ip() result"
      # begin-create_subnet_reserved_ip

      subnet_reserved_ip = service.create_subnet_reserved_ip(
        subnet_id: subnet_id,
        name: "my-subnet-reservedip",
        auto_delete: false,
        address: "192.168.3.4"
      ).result

      puts JSON.pretty_generate(subnet_reserved_ip)

      # end-create_subnet_reserved_ip
      assert !subnet_reserved_ip.nil?
      subnet_reserved_ip_id = subnet_reserved_ip["id"]

      puts "get_subnet_reserved_ip() result"
      # begin-get_subnet_reserved_ip

      subnet_reserved_ip = service.get_subnet_reserved_ip(
        subnet_id: subnet_id, id: subnet_reserved_ip_id
      ).result

      puts JSON.pretty_generate(subnet_reserved_ip)

      # end-get_subnet_reserved_ip

      puts "update_subnet_reserved_ip() result"
      # begin-update_subnet_reserved_ip

      reserved_ip_patch_model = { name: "my-subnet-reservedip-updated" }

      subnet_reserved_ip = service.update_subnet_reserved_ip(
        subnet_id: subnet_id,
        id: subnet_reserved_ip_id,
        reserved_ip_patch: reserved_ip_patch_model
      ).result

      puts JSON.pretty_generate(subnet_reserved_ip)

      # end-update_subnet_reserved_ip
      assert !subnet_reserved_ip.nil?

      # begin-delete_subnet_reserved_ip

      service.delete_subnet_reserved_ip(
        subnet_id: subnet_id, id: subnet_reserved_ip_id
      )

      # end-delete_subnet_reserved_ip

      service.delete_subnet(id: subnet_id)

      # sleep(60)
      service.delete_vpc(id: vpc_id)
    end

    def test_images_example
      puts "list_images() result"
      # begin-list_images

      image_collection = service.list_images.result

      puts JSON.pretty_generate(image_collection)

      # end-list_images
      assert !image_collection.nil?

      puts "create_image() result"
      # begin-create_image

      image_file_prototype_model = {
        'href': "cos://us-east/my-bucket/my-image.qcow2"
      }

      operating_system_identity_model = {
        'name': "debian-9-amd64"
      }

      image_prototype_model = {
        'file': image_file_prototype_model,
        'operating_system': operating_system_identity_model,
        'name': "my-image"
      }

      image = service.create_image(
        image_prototype: image_prototype_model
      ).result

      puts JSON.pretty_generate(image)

      # end-create_image

      image_id = image["id"]

      puts "get_image() result"
      # begin-get_image

      image = service.get_image(id: image_id).result

      puts JSON.pretty_generate(image)

      # end-get_image
      assert !image.nil?

      puts "update_image() result"
      # begin-update_image

      image_patch_model = { name: "updated-my-image" }

      image = service.update_image(
        id: image_id, image_patch: image_patch_model
      ).result

      puts JSON.pretty_generate(image)

      # end-update_image
      assert !image.nil?

      # begin-delete_image

      service.delete_image(id: image_id)

      # end-delete_image

      puts "list_operating_systems() result"
      # begin-list_operating_systems

      operating_system_collection = service.list_operating_systems.result

      puts JSON.pretty_generate(operating_system_collection)

      # end-list_operating_systems
      assert !operating_system_collection.nil?
      operating_system = operating_system_collection["operating_systems"][0]["name"]
      puts "get_operating_system() result:"
      # begin-get_operating_system

      operating_system = service.get_operating_system(
        name: operating_system
      ).result

      puts JSON.pretty_generate(operating_system)

      # end-get_operating_system
    end

    def test_keys_example
      puts "list_keys() result"
      # begin-list_keys

      key_collection = service.list_keys.result

      puts JSON.pretty_generate(key_collection)

      # end-list_keys

      puts "create_key() result"
      # begin-create_key

      key = service.create_key(
        name: "my-key",
        public_key:
          "AAAAB3NzaC1yc2EAAAADAQABAAABAQDDGe50Bxa5T5NDddrrtbx2Y4/VGbiCgXqnBsYToIUKoFSHTQl5IX3PasGnneKanhcLwWz5M5MoCRvhxTp66NKzIfAz7r+FX9rxgR+ZgcM253YAqOVeIpOU408simDZKriTlN8kYsXL7P34tsWuAJf4MgZtJAQxous/2byetpdCv8ddnT4X3ltOg9w+LqSCPYfNivqH00Eh7S1Ldz7I8aw5WOp5a+sQFP/RbwfpwHp+ny7DfeIOokcuI42tJkoBn7UsLTVpCSmXr2EDRlSWe/1M/iHNRBzaT3CK0+SwZWd2AEjePxSnWKNGIEUJDlUYp7hKhiQcgT5ZAnWU121oc5En"
      ).result

      puts JSON.pretty_generate(key)

      # end-create_key

      key_id = key["id"]

      puts "get_key() result"
      # begin-get_key

      key = service.get_key(id: key_id).result

      puts JSON.pretty_generate(key)

      # end-get_key

      puts "update_key() result"
      # begin-update_key

      key_patch_model = { name: "updated-my-key" }

      key = service.update_key(
        id: key_id, key_patch: key_patch_model
      ).result

      puts JSON.pretty_generate(key)

      # end-update_key

      # begin-delete_key

      service.delete_key(id: key_id)

      # end-delete_key
    end

    def test_instance_profile_example
      puts "list_instance_profiles() result:"
      # begin-list_instance_profiles

      profile_collection = service.list_instance_profiles.result

      puts JSON.pretty_generate(profile_collection)

      # end-list_instance_profiles

      puts "get_instance_profile() result:"
      # begin-get_instance_profile

      profile = service.get_instance_profile(
        name: "bx2-2x8"
      ).result

      puts JSON.pretty_generate(profile)

      # end-get_instance_profile
    end

    def test_instance_template_example
      vpc = service.create_vpc(name: "my-vpc-template").result
      vpc_id = vpc["id"]

      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-1"
        },
        'name': "my-subnet-instance-template"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result

      subnet_id = subnet["id"]

      images = service.list_images.result["images"]
      image_id = images[5]["id"]

      profile_name = service.list_instance_profiles.result["profiles"][1]["name"]

      puts "list_instance_templates() result:"
      # begin-list_instance_templates

      instance_template_collection = service.list_instance_templates
                                            .result

      puts JSON.pretty_generate(instance_template_collection)

      # end-list_instance_templates

      puts "create_instance_template() result:"

      # begin-create_instance_template

      instance_profile_identity_model = {
        'name': profile_name
      }

      vpc_identity_model = {
        'id': vpc_id
      }

      image_identity_model = {
        'id': image_id
      }

      subnet_identity_model = {
        'id': subnet_id
      }

      network_interface_prototype_model = {
        'subnet': subnet_identity_model
      }

      zone_identity_model = {
        'name': "us-east-1"
      }

      instance_template_prototype_model = {
        'name': "my-instance-template",
        'profile': instance_profile_identity_model,
        'vpc': vpc_identity_model,
        'image': image_identity_model,
        'primary_network_interface': network_interface_prototype_model,
        'zone': zone_identity_model
      }

      instance_template = service.create_instance_template(
        instance_template_prototype: instance_template_prototype_model
      ).result

      puts JSON.pretty_generate(instance_template)

      # end-create_instance_template
      instance_template_id = instance_template["id"]
      puts "get_instance_template() result:"
      # begin-get_instance_template

      instance_template = service.get_instance_template(
        id: instance_template_id
      ).result

      puts JSON.pretty_generate(instance_template)

      # end-get_instance_template

      puts "update_instance_template() result:"
      # begin-update_instance_template

      instance_template_patch_model = { name: "updated-my-instance-template" }

      instance_template = service.update_instance_template(
        id: instance_template_id,
        instance_template_patch: instance_template_patch_model
      ).result

      puts JSON.pretty_generate(instance_template)

      # end-update_instance_template

      # begin-delete_instance_template

      service.delete_instance_template(id: instance_template_id)

      # end-delete_instance_template

      # sleep(30)

      service.delete_subnet(id: subnet_id)

      # sleep(60)
      service.delete_vpc(id: vpc_id)
    end

    def test_instance_example
      vpc = service.create_vpc(name: "my-vpc-instance").result
      vpc_id = vpc["id"]

      key = service.create_key(
        name: "my-key-instance",
        public_key:
          "AAAAB3NzaC1yc2EAAAADAQABAAABAQDDGe50Bxa5T5NDddrrtbx2Y4/VGbiCgXqnBsYToIUKoFSHTQl5IX3PasGnneKanhcLwWz5M5MoCRvhxTp66NKzIfAz7r+FX9rxgR+ZgcM253YAqOVeIpOU408simDZKriTlN8kYsXL7P34tsWuAJf4MgZtJAQxous/2byetpdCv8ddnT4X3ltOg9w+LqSCPYfNivqH00Eh7S1Ldz7I8aw5WOp5a+sQFP/RbwfpwHp+ny7DfeIOokcuI42tJkoBn7UsLTVpCSmXr2EDRlSWe/1M/iHNRBzaT3CK0+SwZWd2AEjePxSnWKNGIEUJDlUYp7hKhiQcgT5ZAnWU121oc5En"
      ).result

      key_id = key["id"]

      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-1"
        },
        'name': "my-subnet-instance"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result

      subnet_id = subnet["id"]

      images = service.list_images.result["images"]
      image_id = images[5]["id"]

      puts "list_instances() result:"
      # begin-list_instances

      instance_collection = service.list_instances.result

      puts JSON.pretty_generate(instance_collection)

      # end-list_instances

      puts "create_instance() result:"
      # begin-create_instance

      instance_profile_identity_model = {
        'name': "bx2d-8x32"
      }
      key_identity_model = {
        'id': key_id
      }

      vpc_identity_model = {
        'id': vpc_id
      }

      volume_attachment_prototype_instance_by_image_context_model = {
        'volume': {
          'name': "my-boot-volume",
          'profile': {
            'name': "general-purpose"
          }
        }
      }

      image_identity_model = {
        'id': image_id
      }

      subnet_identity_model = {
        'id': subnet_id
      }

      network_interface_prototype_model = {
        'name': "my-network-interface",
        'subnet': subnet_identity_model
      }

      zone_identity_model = {
        'name': "us-east-1"
      }

      volume_attachment_prototype_model = {
        'delete_volume_on_instance_delete': true,
        'volume': {
          'capacity': 1000,
          'name': "my-data-volume",
          'profile': {
            'name': "5iops-tier"
          }
        }
      }

      instance_prototype_model = {
        'keys': [key_identity_model],
        'name': "my-instance",

        'profile': instance_profile_identity_model,
        'volume_attachments': [volume_attachment_prototype_model],
        'vpc': vpc_identity_model,
        'boot_volume_attachment': volume_attachment_prototype_instance_by_image_context_model,
        'image': image_identity_model,
        'primary_network_interface': network_interface_prototype_model,
        'zone': zone_identity_model
      }

      instance = service.create_instance(
        instance_prototype: instance_prototype_model
      ).result

      puts JSON.pretty_generate(instance)

      # end-create_instance

      instance_id = instance["id"]

      puts "get_instance() result:"
      # begin-get_instance

      instance = service.get_instance(id: instance_id).result

      puts JSON.pretty_generate(instance)

      # end-get_instance

      puts "update_instance() result:"
      # begin-update_instance

      instance_patch_model = { name: "updated-my-instance" }

      instance = service.update_instance(
        id: instance_id,
        instance_patch: instance_patch_model
      ).result

      puts JSON.pretty_generate(instance)

      # end-update_instance

      puts "get_instance_initialization() result:"
      # begin-get_instance_initialization

      instance_initialization = service.get_instance_initialization(
        id: instance_id
      ).result

      puts JSON.pretty_generate(instance_initialization)

      # end-get_instance_initialization
      # sleep(30)
      puts "create_instance_action() result:"
      # begin-create_instance_action

      instance_action = service.create_instance_action(
        instance_id: instance_id, type: "stop"
      ).result

      puts JSON.pretty_generate(instance_action)

      # end-create_instance_action

      # puts "create_instance_console_access_token() result:"
      # begin-create_instance_console_access_token

      # instance_console_access_token = service.create_instance_console_access_token(
      #  instance_id: instance_id, console_type: "serial"
      # ).result

      # puts JSON.pretty_generate(instance_console_access_token)

      # end-create_instance_console_access_token

      puts "list_instance_disks() result:"
      # begin-list_instance_disks

      instance_disk_collection = service.list_instance_disks(
        instance_id: instance_id
      ).result

      puts JSON.pretty_generate(instance_disk_collection)

      # end-list_instance_disks

      disk_id = instance_disk_collection["disks"][0]["id"]

      puts "get_instance_disk() result:"
      # begin-get_instance_disk

      instance_disk = service.get_instance_disk(
        instance_id: instance_id, id: disk_id
      ).result

      puts JSON.pretty_generate(instance_disk)
      # end-get_instance_disk

      puts "update_instance_disk() result:"
      # begin-update_instance_disk

      instance_disk_patch_model = { name: "updated-instance-disk" }

      instance_disk = service.update_instance_disk(
        instance_id: instance_id,
        id: disk_id,
        instance_disk_patch: instance_disk_patch_model
      ).result

      puts JSON.pretty_generate(instance_disk)

      # end-update_instance_disk

      puts "list_instance_network_interfaces() result:"
      # begin-list_instance_network_interfaces

      network_interface_unpaginated_collection = service.list_instance_network_interfaces(
        instance_id: instance_id
      ).result

      puts JSON.pretty_generate(network_interface_unpaginated_collection)

      # end-list_instance_network_interfaces

      puts "create_instance_network_interface() result:"
      # begin-create_instance_network_interface

      subnet_identity_model = {
        'id': subnet_id
      }

      network_interface = service.create_instance_network_interface(
        instance_id: instance_id,
        subnet: subnet_identity_model
      ).result

      puts JSON.pretty_generate(network_interface)

      # end-create_instance_network_interface
      network_interface_id = network_interface["id"]

      puts "get_instance_network_interface() result:"
      # begin-get_instance_network_interface

      network_interface = service.get_instance_network_interface(
        instance_id: instance_id, id: network_interface_id
      ).result

      puts JSON.pretty_generate(network_interface)

      # end-get_instance_network_interface

      puts "update_instance_network_interface() result:"
      # begin-update_instance_network_interface

      network_interface_patch_model = {
        'name': "updated-network-interface"
      }

      network_interface = service.update_instance_network_interface(
        instance_id: instance_id,
        id: network_interface_id,
        network_interface_patch: network_interface_patch_model
      ).result

      puts JSON.pretty_generate(network_interface)

      # end-update_instance_network_interface

      zone_identity_model = {
        'name': "us-east-1"
      }

      floating_ip_prototype_model = {
        'zone': zone_identity_model
      }

      floating_ip = service.create_floating_ip(
        floating_ip_prototype: floating_ip_prototype_model
      ).result
      floating_ip_id = floating_ip["id"]

      puts "add_instance_network_interface_floating_ip() result:"
      # begin-add_instance_network_interface_floating_ip

      floating_ip = service.add_instance_network_interface_floating_ip(
        instance_id: instance_id,
        network_interface_id: network_interface_id,
        id: floating_ip_id
      ).result

      puts JSON.pretty_generate(floating_ip)

      # end-add_instance_network_interface_floating_ip

      puts "list_instance_network_interface_floating_ips() result:"
      # begin-list_instance_network_interface_floating_ips

      floating_ip_unpaginated_collection = service.list_instance_network_interface_floating_ips(
        instance_id: instance_id,
        network_interface_id: network_interface_id
      ).result

      puts JSON.pretty_generate(floating_ip_unpaginated_collection)

      # end-list_instance_network_interface_floating_ips

      puts "get_instance_network_interface_floating_ip() result:"
      # begin-get_instance_network_interface_floating_ip

      floating_ip = service.get_instance_network_interface_floating_ip(
        instance_id: instance_id,
        network_interface_id: network_interface_id,
        id: floating_ip_id
      ).result

      puts JSON.pretty_generate(floating_ip)

      # end-get_instance_network_interface_floating_ip

      puts "list_instance_volume_attachments() result:"
      # begin-list_instance_volume_attachments

      volume_attachment_collection = service.list_instance_volume_attachments(
        instance_id: instance_id
      ).result

      puts JSON.pretty_generate(volume_attachment_collection)

      # end-list_instance_volume_attachments

      puts "create_instance_volume_attachment() result:"
      # begin-create_instance_volume_attachment

      volume_attachment_prototype_model = {

        'capacity': 1000,
        'name': "my-data-volume-2",
        'profile': {
          'name': "5iops-tier"
        }

      }

      volume_attachment = service.create_instance_volume_attachment(
        instance_id: instance_id,
        volume: volume_attachment_prototype_model,
        delete_volume_on_instance_delete: true
      ).result

      puts JSON.pretty_generate(volume_attachment)

      # end-create_instance_volume_attachment
      volume_attachment_id = volume_attachment["id"]

      puts "get_instance_volume_attachment() result:"
      # begin-get_instance_volume_attachment

      volume_attachment = service.get_instance_volume_attachment(
        instance_id: instance_id, id: volume_attachment_id
      ).result

      puts JSON.pretty_generate(volume_attachment)

      # end-get_instance_volume_attachment

      puts "update_instance_volume_attachment() result:"
      # begin-update_instance_volume_attachment

      volume_attachment_patch_model = { name: "updated-volume-attachment" }

      volume_attachment = service.update_instance_volume_attachment(
        instance_id: instance_id,
        id: volume_attachment_id,
        volume_attachment_patch: volume_attachment_patch_model
      ).result

      puts JSON.pretty_generate(volume_attachment)

      # end-update_instance_volume_attachment

      puts "delete_instance_volume_attachment() result:"
      # begin-delete_instance_volume_attachment

      service.delete_instance_volume_attachment(
        instance_id: instance_id, id: volume_attachment_id
      )

      # end-delete_instance_volume_attachment

      puts "remove_instance_network_interface_floating_ip() result:"
      # begin-remove_instance_network_interface_floating_ip

      service.remove_instance_network_interface_floating_ip(
        instance_id: instance_id,
        network_interface_id: network_interface_id,
        id: floating_ip_id
      )

      # end-remove_instance_network_interface_floating_ip

      puts "delete_instance_network_interface() result:"
      # begin-delete_instance_network_interface

      service.delete_instance_network_interface(
        instance_id: instance_id, id: network_interface_id
      )

      # end-delete_instance_network_interface

      puts "delete_instance() result:"
      # begin-delete_instance

      response = service.delete_instance(id: instance_id)
      puts response
      # end-delete_instance
      # sleep(30)
      service.delete_subnet(id: subnet_id)

      # sleep(60)
      service.delete_vpc(id: vpc_id)
      service.delete_key(id: key_id)
    end

    def test_instance_group_example
      vpc = service.create_vpc(name: "my-vpc-group").result
      vpc_id = vpc["id"]

      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-2"
        },
        'name': "my-subnet-instance-group"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result

      subnet_id = subnet["id"]

      images = service.list_images.result["images"]
      image_id = images[5]["id"]

      profile_name = service.list_instance_profiles.result["profiles"][1]["name"]

      instance_profile_identity_model = {
        'name': profile_name
      }

      vpc_identity_model = {
        'id': vpc_id
      }

      image_identity_model = {
        'id': image_id
      }

      subnet_identity_model = {
        'id': subnet_id
      }

      network_interface_prototype_model = {
        'subnet': subnet_identity_model
      }

      zone_identity_model = {
        'name': "us-east-1"
      }

      instance_template_prototype_model = {
        'name': "my-instance-template-instance-group",
        'profile': instance_profile_identity_model,
        'vpc': vpc_identity_model,
        'image': image_identity_model,
        'primary_network_interface': network_interface_prototype_model,
        'zone': zone_identity_model
      }

      instance_template = service.create_instance_template(
        instance_template_prototype: instance_template_prototype_model
      ).result
      instance_template_id = instance_template["id"]
      puts "list_instance_groups() result:"
      # begin-list_instance_groups

      instance_group_collection = service.list_instance_groups
                                         .result

      puts JSON.pretty_generate(instance_group_collection)

      # end-list_instance_groups

      puts "create_instance_group() result:"
      # begin-create_instance_group

      instance_template_identity_model = {
        'id': instance_template_id
      }

      subnet_identity_model = {
        'id': subnet_id
      }

      instance_group = service.create_instance_group(
        instance_template: instance_template_identity_model,
        subnets: [subnet_identity_model],
        membership_count: 2,
        name: "my-instance-group"
      ).result

      puts JSON.pretty_generate(instance_group)

      # end-create_instance_group
      instance_group_id = instance_group["id"]
      # sleep(30)

      puts "get_instance_group() result:"
      # begin-get_instance_group

      instance_group = service.get_instance_group(
        id: instance_group_id
      ).result

      puts JSON.pretty_generate(instance_group)

      # end-get_instance_group

      puts "update_instance_group() result:"
      # begin-update_instance_group

      instance_group_patch_model = { name: "updated-instance-group" }

      instance_group = service.update_instance_group(
        id: instance_group_id,
        instance_group_patch: instance_group_patch_model
      ).result

      puts JSON.pretty_generate(instance_group)

      # end-update_instance_group

      # sleep(30)

      puts "list_instance_group_managers() result:"
      # begin-list_instance_group_managers

      instance_group_manager_collection = service.list_instance_group_managers(
        instance_group_id: instance_group_id
      ).result

      puts JSON.pretty_generate(instance_group_manager_collection)

      # end-list_instance_group_managers

      puts "create_instance_group_manager() result:"
      # begin-create_instance_group_manager

      instance_group_manager_prototype_model = {
        'manager_type': "scheduled"
      }

      instance_group_manager = service.create_instance_group_manager(
        instance_group_id: instance_group_id,
        instance_group_manager_prototype:
        instance_group_manager_prototype_model
      ).result

      puts JSON.pretty_generate(instance_group_manager)

      # end-create_instance_group_manager
      instance_group_manager_id = instance_group_manager["id"]
      # sleep(30)
      puts "get_instance_group_manager() result:"
      # begin-get_instance_group_manager

      instance_group_manager = service.get_instance_group_manager(
        instance_group_id: instance_group_id, id: instance_group_manager_id
      ).result

      puts JSON.pretty_generate(instance_group_manager)

      # end-get_instance_group_manager

      puts "update_instance_group_manager() result:"
      # begin-update_instance_group_manager

      instance_group_manager_patch_model = { name: "updated-instance-group-manager" }

      instance_group_manager = service.update_instance_group_manager(
        instance_group_id: instance_group_id,
        id: instance_group_manager_id,
        instance_group_manager_patch: instance_group_manager_patch_model
      ).result

      puts JSON.pretty_generate(instance_group_manager)

      # end-update_instance_group_manager
      # sleep(30)

      puts "list_instance_group_manager_actions() result:"
      # begin-list_instance_group_manager_actions

      instance_group_manager_actions_collection = service.list_instance_group_manager_actions(
        instance_group_id: instance_group_id,
        instance_group_manager_id: instance_group_manager_id
      ).result

      puts JSON.pretty_generate(instance_group_manager_actions_collection)

      # end-list_instance_group_manager_actions

      puts "create_instance_group_manager_action() result:"
      # begin-create_instance_group_manager_action

      instance_group_manager_scheduled_action_group_prototype_model = {
        'membership_count': 2
      }

      instance_group_manager_action_prototype_model = {
        'group':
            instance_group_manager_scheduled_action_group_prototype_model
      }

      instance_group_manager_action = service.create_instance_group_manager_action(
        instance_group_id: instance_group_id,
        instance_group_manager_id: instance_group_manager_id,
        instance_group_manager_action_prototype:
        instance_group_manager_action_prototype_model
      ).result

      puts JSON.pretty_generate(instance_group_manager_action)

      # end-create_instance_group_manager_action
      instance_group_manager_action_id = instance_group_manager_action["id"]
      # sleep(30)
      puts "get_instance_group_manager_action() result:"
      # begin-get_instance_group_manager_action

      instance_group_manager_action = service.get_instance_group_manager_action(
        instance_group_id: instance_group_id,
        instance_group_manager_id: instance_group_manager_id,
        id: instance_group_manager_action_id
      ).result

      puts JSON.pretty_generate(instance_group_manager_action)

      # end-get_instance_group_manager_action

      puts "update_instance_group_manager_action() result:"
      # begin-update_instance_group_manager_action

      instance_group_manager_action_patch_model = { name: "updated-instance-group-manager-action" }

      instance_group_manager_action = service.update_instance_group_manager_action(
        instance_group_id: instance_group_id,
        instance_group_manager_id: instance_group_manager_id,
        id: instance_group_manager_action_id,
        instance_group_manager_action_patch:
        instance_group_manager_action_patch_model
      ).result

      puts JSON.pretty_generate(instance_group_manager_action)

      # end-update_instance_group_manager_action
      # sleep(30)
      puts "list_instance_group_manager_policies() result:"
      # begin-list_instance_group_manager_policies

      instance_group_manager_policy_collection = service.list_instance_group_manager_policies(
        instance_group_id: instance_group_id,
        instance_group_manager_id: instance_group_manager_id
      ).result

      puts JSON.pretty_generate(instance_group_manager_policy_collection)

      # end-list_instance_group_manager_policies

      puts "create_instance_group_manager_policy() result:"
      # begin-create_instance_group_manager_policy

      instance_group_manager_policy_prototype_model = {
        'metric_type': "cpu",
        'metric_value': 38,
        'policy_type': "target"
      }

      instance_group_manager_policy = service.create_instance_group_manager_policy(
        instance_group_id: instance_group_id,
        instance_group_manager_id: instance_group_manager_id,
        instance_group_manager_policy_prototype:
        instance_group_manager_policy_prototype_model
      ).result

      puts JSON.pretty_generate(instance_group_manager_policy)

      # end-create_instance_group_manager_policy
      instance_group_manager_policy_id = instance_group_manager_policy["id"]
      # sleep(30)
      puts "get_instance_group_manager_policy() result:"
      # begin-get_instance_group_manager_policy

      instance_group_manager_policy = service.get_instance_group_manager_policy(
        instance_group_id: instance_group_id,
        instance_group_manager_id: instance_group_manager_id,
        id: instance_group_manager_policy_id
      ).result

      puts JSON.pretty_generate(instance_group_manager_policy)

      # end-get_instance_group_manager_policy

      puts "update_instance_group_manager_policy() result:"
      # begin-update_instance_group_manager_policy

      instance_group_manager_policy_patch_model = { name: "updated-instance-group-manager-policy" }

      instance_group_manager_policy = service.update_instance_group_manager_policy(
        instance_group_id: instance_group_id,
        instance_group_manager_id: instance_group_manager_id,
        id: instance_group_manager_policy_id,
        instance_group_manager_policy_patch:
        instance_group_manager_policy_patch_model
      ).result

      puts JSON.pretty_generate(instance_group_manager_policy)

      # end-update_instance_group_manager_policy
      # sleep(30)
      puts "list_instance_group_memberships() result:"
      # begin-list_instance_group_memberships

      instance_group_membership_collection = service.list_instance_group_memberships(
        instance_group_id: instance_group_id
      ).result

      puts JSON.pretty_generate(instance_group_membership_collection)

      # end-list_instance_group_memberships
      instance_group_membership_id = instance_group_membership_collection["memberships"][0]["id"]
      puts "get_instance_group_membership() result:"
      # begin-get_instance_group_membership

      instance_group_membership = service.get_instance_group_membership(
        instance_group_id: instance_group_id, id: instance_group_membership_id
      ).result

      puts JSON.pretty_generate(instance_group_membership)

      # end-get_instance_group_membership

      puts "update_instance_group_membership() result:"
      # begin-update_instance_group_membership

      instance_group_membership_patch_model = { name: "updated-instance-group-membership" }

      instance_group_membership = service.update_instance_group_membership(
        instance_group_id: instance_group_id,
        id: instance_group_membership_id,
        instance_group_membership_patch:
        instance_group_membership_patch_model
      ).result

      puts JSON.pretty_generate(instance_group_membership)

      # end-update_instance_group_membership
      # sleep(30)
      # begin-delete_instance_group_membership

      service.delete_instance_group_membership(
        instance_group_id: instance_group_id, id: instance_group_membership_id
      )

      # end-delete_instance_group_membership
      # sleep(30)
      # begin-delete_instance_group_memberships

      service.delete_instance_group_memberships(
        instance_group_id: instance_group_id
      )

      # end-delete_instance_group_memberships
      # sleep(30)
      # begin-delete_instance_group_manager_policy

      service.delete_instance_group_manager_policy(
        instance_group_id: instance_group_id,
        instance_group_manager_id: instance_group_manager_id,
        id: instance_group_manager_policy_id
      )

      # end-delete_instance_group_manager_policy
      # sleep(30)
      # begin-delete_instance_group_manager_action

      service.delete_instance_group_manager_action(
        instance_group_id: instance_group_id,
        instance_group_manager_id: instance_group_manager_id,
        id: instance_group_manager_action_id
      )

      # end-delete_instance_group_manager_action
      # sleep(30)
      # begin-delete_instance_group_manager

      service.delete_instance_group_manager(
        instance_group_id: instance_group_id, id: instance_group_manager_id
      )

      # end-delete_instance_group_manager
      # sleep(30)
      # begin-delete_instance_group_load_balancer

      service.delete_instance_group_load_balancer(
        instance_group_id: instance_group_id
      )

      # end-delete_instance_group_load_balancer
      # sleep(30)
      # begin-delete_instance_group

      service.delete_instance_group(id: instance_group_id)

      # end-delete_instance_group
    end

    def test_dedicated_host_example
      puts "list_dedicated_host_groups() result:"
      # begin-list_dedicated_host_groups

      dedicated_host_group_collection = service.list_dedicated_host_groups
                                               .result

      puts JSON.pretty_generate(dedicated_host_group_collection)

      # end-list_dedicated_host_groups

      puts "create_dedicated_host_group() result:"
      # begin-create_dedicated_host_group

      zone_identity_model = {
        'name': "us-east-1"
      }

      dedicated_host_group = service.create_dedicated_host_group(
        _class: "mx2", family: "balanced", zone: zone_identity_model,
        name: "example_dedicated_host_group"
      ).result

      puts JSON.pretty_generate(dedicated_host_group)

      # end-create_dedicated_host_group
      dedicated_host_group_id = dedicated_host_group["id"]

      puts "get_dedicated_host_group() result:"
      # begin-get_dedicated_host_group

      dedicated_host_group = service.get_dedicated_host_group(
        id: dedicated_host_group_id
      ).result

      puts JSON.pretty_generate(dedicated_host_group)

      # end-get_dedicated_host_group

      puts "update_dedicated_host_group() result:"
      # begin-update_dedicated_host_group

      dedicated_host_group_patch_model = {
        'name': "updated-my-host-group"
      }

      dedicated_host_group = service.update_dedicated_host_group(
        id: dedicated_host_group_id,
        dedicated_host_group_patch: dedicated_host_group_patch_model
      ).result

      puts JSON.pretty_generate(dedicated_host_group)

      # end-update_dedicated_host_group

      puts "list_dedicated_host_profiles() result:"
      # begin-list_dedicated_host_profiles

      dedicated_host_profile_collection = service.list_dedicated_host_profiles
                                                 .result

      puts JSON.pretty_generate(dedicated_host_profile_collection)

      # end-list_dedicated_host_profiles
      dedicated_host_profile = dedicated_host_profile_collection["profiles"][0]["name"]
      puts "get_dedicated_host_profile() result:"
      # begin-get_dedicated_host_profile

      dedicated_host_profile = service.get_dedicated_host_profile(
        name: dedicated_host_profile
      ).result

      puts JSON.pretty_generate(dedicated_host_profile)

      # end-get_dedicated_host_profile

      puts "list_dedicated_hosts() result:"
      # begin-list_dedicated_hosts

      dedicated_host_collection = service.list_dedicated_hosts
                                         .result

      puts JSON.pretty_generate(dedicated_host_collection)

      # end-list_dedicated_hosts

      puts "create_dedicated_host() result:"
      # begin-create_dedicated_host

      dedicated_host_profile_identity_model = {
        'name': "mx2d-host-152x1216"
      }

      dedicated_host_group_identity_model = {
        'id': dedicated_host_group_id
      }

      dedicated_host_prototype_model = {
        'profile': dedicated_host_profile_identity_model,
        'group': dedicated_host_group_identity_model,
        'name': "example_dedicated_host"
      }

      dedicated_host = service.create_dedicated_host(
        dedicated_host_prototype: dedicated_host_prototype_model
      ).result

      puts JSON.pretty_generate(dedicated_host)

      # end-create_dedicated_host
      dedicated_host_id = dedicated_host["id"]

      puts "list_dedicated_host_disks() result:"
      # begin-list_dedicated_host_disks

      dedicated_host_disk_collection = service.list_dedicated_host_disks(
        dedicated_host_id: dedicated_host_id
      ).result

      puts JSON.pretty_generate(dedicated_host_disk_collection)

      # end-list_dedicated_host_disks
      dedicated_host_disk_id = dedicated_host_disk_collection["disks"][0]["id"]

      puts "get_dedicated_host_disk() result:"
      # begin-get_dedicated_host_disk

      dedicated_host_disk = service.get_dedicated_host_disk(
        dedicated_host_id: dedicated_host_id, id: dedicated_host_disk_id
      ).result

      puts JSON.pretty_generate(dedicated_host_disk)

      # end-get_dedicated_host_disk

      puts "update_dedicated_host_disk() result:"
      # begin-update_dedicated_host_disk

      dedicated_host_disk_patch_model = { name: "updated-dedicated-host-disk" }

      dedicated_host_disk = service.update_dedicated_host_disk(
        dedicated_host_id: dedicated_host_id,
        id: dedicated_host_disk_id,
        dedicated_host_disk_patch: dedicated_host_disk_patch_model
      ).result

      puts JSON.pretty_generate(dedicated_host_disk)

      # end-update_dedicated_host_disk

      puts "get_dedicated_host() result:"
      # begin-get_dedicated_host

      dedicated_host = service.get_dedicated_host(
        id: dedicated_host_id
      ).result

      puts JSON.pretty_generate(dedicated_host)

      # end-get_dedicated_host

      puts "update_dedicated_host() result:"
      # begin-update_dedicated_host

      dedicated_host_patch_model = { name: "updated-my-dedicated-host" }

      dedicated_host = service.update_dedicated_host(
        id: dedicated_host_id,
        dedicated_host_patch: dedicated_host_patch_model
      ).result

      puts JSON.pretty_generate(dedicated_host)

      # end-update_dedicated_host

      # begin-delete_dedicated_host

      service.delete_dedicated_host(id: dedicated_host_id)

      # end-delete_dedicated_host

      # begin-delete_dedicated_host_group

      service.delete_dedicated_host_group(id: dedicated_host_group_id)

      # end-delete_dedicated_host_group
    end

    def test_placement_group_example
      puts "list_placement_groups() result:"
      # begin-list_placement_groups

      placement_group_collection = service.list_placement_groups
                                          .result

      puts JSON.pretty_generate(placement_group_collection)

      # end-list_placement_groups

      puts "create_placement_group() result:"
      # begin-create_placement_group

      placement_group = service.create_placement_group(
        strategy: "host_spread",
        name: "my-placement-grou["
      ).result

      puts JSON.pretty_generate(placement_group)

      # end-create_placement_group
      placement_group_id = placement_group["id"]

      puts "get_placement_group() result:"
      # begin-get_placement_group

      placement_group = service.get_placement_group(
        id: placement_group_id
      ).result

      puts JSON.pretty_generate(placement_group)

      # end-get_placement_group

      puts "update_placement_group() result:"
      # begin-update_placement_group

      placement_group_patch_model = { name: "updated-my-placement-group" }

      placement_group = service.update_placement_group(
        id: placement_group_id,
        placement_group_patch: placement_group_patch_model
      ).result

      puts JSON.pretty_generate(placement_group)

      # end-update_placement_group

      # begin-delete_placement_group

      service.delete_placement_group(
        id: placement_group_id
      )

      # end-delete_placement_group
    end

    def test_volumes_example
      puts "list_volume_profiles() result:"
      # begin-list_volume_profiles

      volume_profile_collection = service.list_volume_profiles
                                         .result

      puts JSON.pretty_generate(volume_profile_collection)

      # end-list_volume_profiles
      volume_profile = volume_profile_collection["profiles"][0]["id"]
      puts "get_volume_profile() result:"
      # begin-get_volume_profile

      volume_profile = service.get_volume_profile(
        name: volume_profile
      ).result

      puts JSON.pretty_generate(volume_profile)

      # end-get_volume_profile

      puts "list_volumes() result:"
      # begin-list_volumes

      volume_collection = service.list_volumes.result

      puts JSON.pretty_generate(volume_collection)

      # end-list_volumes

      puts "create_volume() result:"
      # begin-create_volume

      volume_profile_identity_model = {
        'name': "5iops-tier"
      }

      zone_identity_model = {
        'name': "us-east-1"
      }

      volume_prototype_model = {
        'profile': volume_profile_identity_model,
        'zone': zone_identity_model,
        'capacity': 100,
        'name': "my-volume"
      }

      volume = service.create_volume(
        volume_prototype: volume_prototype_model
      ).result

      puts JSON.pretty_generate(volume)

      # end-create_volume
      volume_id = volume["id"]

      puts "get_volume() result:"
      # begin-get_volume

      volume = service.get_volume(id: volume_id).result

      puts JSON.pretty_generate(volume)

      # end-get_volume

      puts "update_volume() result:"
      # begin-update_volume

      volume_patch_model = { name: "updated-my-volume" }

      volume = service.update_volume(
        id: volume_id, volume_patch: volume_patch_model
      ).result

      puts JSON.pretty_generate(volume)

      # end-update_volume

      # begin-delete_volume

      service.delete_volume(id: volume_id)

      # end-delete_volume
    end

    def test_snapshot_example
      volume_profile_identity_model = {
        'name': "5iops-tier"
      }

      zone_identity_model = {
        'name': "us-east-1"
      }

      volume_prototype_model = {
        'profile': volume_profile_identity_model,
        'zone': zone_identity_model,
        'capacity': 100,
        'name': "my-volume-snapshot"
      }

      volume = service.create_volume(
        volume_prototype: volume_prototype_model
      ).result
      volume_id = volume["id"]

      puts "list_snapshots() result:"
      # begin-list_snapshots

      snapshot_collection = service.list_snapshots(
        sort: "name"
      ).result

      puts JSON.pretty_generate(snapshot_collection)

      # end-list_snapshots

      puts "create_snapshot() result:"
      # begin-create_snapshot

      volume_identity_model = {
        'id': volume_id
      }

      snapshot_prototype_model = {
        'source_volume': volume_identity_model,
        'name': "my-snapshot"
      }

      snapshot = service.create_snapshot(
        snapshot_prototype: snapshot_prototype_model
      ).result

      puts JSON.pretty_generate(snapshot)

      # end-create_snapshot
      snapshot_id = snapshot["id"]
      snapshot_prototype_model_1 = {
        'source_volume': volume_identity_model,
        'name': "my-snapshot1"
      }
      service.create_snapshot(
        snapshot_prototype: snapshot_prototype_model_1
      )

      puts "get_snapshot() result:"
      # begin-get_snapshot

      snapshot = service.get_snapshot(id: snapshot_id).result

      puts JSON.pretty_generate(snapshot)

      # end-get_snapshot

      puts "update_snapshot() result:"
      # begin-update_snapshot

      snapshot_patch_model = { name: "updated-my-snapshot" }

      snapshot = service.update_snapshot(
        id: snapshot_id,
        snapshot_patch: snapshot_patch_model
      ).result

      puts JSON.pretty_generate(snapshot)

      # end-update_snapshot

      puts "delete_snapshot() result:"
      # begin-delete_snapshot

      service.delete_snapshot(id: snapshot_id)

      # end-delete_snapshot
      puts "delete_snapshots() result:"
      # begin-delete_snapshots

      service.delete_snapshots(
        source_volume_id: volume_id
      )

      # end-delete_snapshots
    end

    def test_regions_example
      puts "list_regions() result:"
      # begin-list_regions

      region_collection = service.list_regions.result

      puts JSON.pretty_generate(region_collection)

      # end-list_regions
      region_name = region_collection["regions"][2]["name"]

      puts "get_region() result:"
      # begin-get_region

      region = service.get_region(name: region_name).result

      puts JSON.pretty_generate(region)

      # end-get_region

      puts "list_region_zones() result:"
      # begin-list_region_zones

      zone_collection = service.list_region_zones(
        region_name: region_name
      ).result

      puts JSON.pretty_generate(zone_collection)

      # end-list_region_zones
      zone_name = zone_collection["zones"][0]["name"]

      puts "get_region_zone() result:"
      # begin-get_region_zone

      zone = service.get_region_zone(region_name: region_name,
                                     name: zone_name).result

      puts JSON.pretty_generate(zone)

      # end-get_region_zone
    end

    def test_public_gateway_example
      vpc = service.create_vpc(name: "my-vpc-public-gateway").result
      vpc_id = vpc["id"]
      puts "list_public_gateways() result:"
      # begin-list_public_gateways

      public_gateway_collection = service.list_public_gateways
                                         .result

      puts JSON.pretty_generate(public_gateway_collection)

      # end-list_public_gateways

      puts "create_public_gateway() result:"
      # begin-create_public_gateway

      vpc_identity_model = {
        'id': vpc_id
      }

      zone_identity_model = {
        'name': "us-east-1"
      }

      public_gateway = service.create_public_gateway(
        vpc: vpc_identity_model, zone: zone_identity_model,
        name: "my-public-gateway"
      ).result

      puts JSON.pretty_generate(public_gateway)

      # end-create_public_gateway
      public_gateway_id = public_gateway["id"]

      puts "get_public_gateway() result:"
      # begin-get_public_gateway

      public_gateway = service.get_public_gateway(
        id: public_gateway_id
      ).result

      puts JSON.pretty_generate(public_gateway)

      # end-get_public_gateway

      puts "update_public_gateway() result:"
      # begin-update_public_gateway

      public_gateway_patch_model = { name: "updated-my-public-gateway" }

      public_gateway = service.update_public_gateway(
        id: public_gateway_id,
        public_gateway_patch: public_gateway_patch_model
      ).result

      puts JSON.pretty_generate(public_gateway)

      # end-update_public_gateway

      puts "delete_public_gateway() result:"
      # begin-delete_public_gateway

      service.delete_public_gateway(id: public_gateway_id)

      # end-delete_public_gateway

      service.delete_vpc(id: vpc_id)
    end

    def test_floating_ip_example
      puts "list_floating_ips() result:"
      # begin-list_floating_ips

      floating_ip_collection = service.list_floating_ips.result

      puts JSON.pretty_generate(floating_ip_collection)

      # end-list_floating_ips

      puts "create_floating_ip() result:"
      # begin-create_floating_ip

      zone_identity_model = {
        'name': "us-east-1"
      }

      floating_ip_prototype_model = {
        'zone': zone_identity_model,
        'name': "my-floating-ip"
      }

      floating_ip = service.create_floating_ip(
        floating_ip_prototype: floating_ip_prototype_model
      ).result

      puts JSON.pretty_generate(floating_ip)

      # end-create_floating_ip
      floating_ip_id = floating_ip["id"]

      puts "get_floating_ip() result:"
      # begin-get_floating_ip

      floating_ip = service.get_floating_ip(
        id: floating_ip_id
      ).result

      puts JSON.pretty_generate(floating_ip)

      # end-get_floating_ip

      puts "Update_floating_ip() result:"
      # begin-update_floating_ip

      floating_ip_patch_model = { name: "updatd-my-floating-ip" }

      floating_ip = service.update_floating_ip(
        id: floating_ip_id,
        floating_ip_patch: floating_ip_patch_model
      ).result

      puts JSON.pretty_generate(floating_ip)

      # end-update_floating_ip

      # begin-delete_floating_ip

      service.delete_floating_ip(id: floating_ip_id)

      # end-delete_floating_ip
    end

    def test_network_acl_example
      vpc = service.create_vpc(name: "my-vpc-network-acl").result
      vpc_id = vpc["id"]
      puts "list_network_acls() result:"
      # begin-list_network_acls

      network_acl_collection = service.list_network_acls.result

      puts JSON.pretty_generate(network_acl_collection)

      # end-list_network_acls

      puts "create_network_acl() result:"
      # begin-create_network_acl

      vpc_identity_model = {
        'id': vpc_id
      }

      network_acl_prototype_model = {
        'name': "my-network-acl",
        'vpc': vpc_identity_model
      }

      network_acl = service.create_network_acl(
        network_acl_prototype: network_acl_prototype_model
      ).result

      puts JSON.pretty_generate(network_acl)

      # end-create_network_acl
      network_acl_id = network_acl["id"]

      puts "get_network_acl() result:"
      # begin-get_network_acl

      network_acl = service.get_network_acl(
        id: network_acl_id
      ).result

      puts JSON.pretty_generate(network_acl)

      # end-get_network_acl

      puts "update_network_acl() result:"
      # begin-update_network_acl

      network_acl_patch_model = { name: "updated-my-network-acl" }

      network_acl = service.update_network_acl(
        id: network_acl_id,
        network_acl_patch: network_acl_patch_model
      ).result

      puts JSON.pretty_generate(network_acl)

      # end-update_network_acl

      puts "list_network_acl_rules() result:"
      # begin-list_network_acl_rules

      network_acl_rule_collection = service.list_network_acl_rules(
        network_acl_id: network_acl_id
      ).result

      puts JSON.pretty_generate(network_acl_rule_collection)

      # end-list_network_acl_rules

      puts "create_network_acl_rule() result:"
      # begin-create_network_acl_rule

      network_acl_rule_prototype_model = {
        'action': "allow",
        'destination': "192.168.3.2/32",
        'direction': "inbound",
        'source': "192.168.3.2/32",
        'protocol': "icmp",
        'name': "my-network-acl-rule"
      }

      network_acl_rule = service.create_network_acl_rule(
        network_acl_id: network_acl_id,
        network_acl_rule_prototype: network_acl_rule_prototype_model
      ).result

      puts JSON.pretty_generate(network_acl_rule)

      # end-create_network_acl_rule
      network_acl_rule_id = network_acl_rule["id"]

      puts "get_network_acl_rule() result:"
      # begin-get_network_acl_rule

      network_acl_rule = service.get_network_acl_rule(
        network_acl_id: network_acl_id, id: network_acl_rule_id
      ).result

      puts JSON.pretty_generate(network_acl_rule)

      # end-get_network_acl_rule

      puts "update_network_acl_rule() result:"
      # begin-update_network_acl_rule

      network_acl_rule_patch_model = { name: "updated-my-network-acl-rule" }

      network_acl_rule = service.update_network_acl_rule(
        network_acl_id: network_acl_id,
        id: network_acl_rule_id,
        network_acl_rule_patch: network_acl_rule_patch_model
      ).result

      puts JSON.pretty_generate(network_acl_rule)

      # end-update_network_acl_rule

      # begin-delete_network_acl_rule

      service.delete_network_acl_rule(
        network_acl_id: network_acl_id, id: network_acl_rule_id
      )

      # end-delete_network_acl_rule

      # begin-delete_network_acl

      service.delete_network_acl(id: network_acl_id)

      # end-delete_network_acl
    end

    def test_security_group_example
      vpc = service.create_vpc(name: "my-vpc-security-group").result
      vpc_id = vpc["id"]
      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-1"
        },
        'name': "my-subnet-security-group"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result
      subnet_id = subnet["id"]

      images = service.list_images.result["images"]
      image_id = images[5]["id"]

      key = service.create_key(
        name: "my-key",
        public_key:
          "AAAAB3NzaC1yc2EAAAADAQABAAABAQDDGe50Bxa5T5NDddrrtbx2Y4/VGbiCgXqnBsYToIUKoFSHTQl5IX3PasGnneKanhcLwWz5M5MoCRvhxTp66NKzIfAz7r+FX9rxgR+ZgcM253YAqOVeIpOU408simDZKriTlN8kYsXL7P34tsWuAJf4MgZtJAQxous/2byetpdCv8ddnT4X3ltOg9w+LqSCPYfNivqH00Eh7S1Ldz7I8aw5WOp5a+sQFP/RbwfpwHp+ny7DfeIOokcuI42tJkoBn7UsLTVpCSmXr2EDRlSWe/1M/iHNRBzaT3CK0+SwZWd2AEjePxSnWKNGIEUJDlUYp7hKhiQcgT5ZAnWU121oc5En"
      ).result
      key_id = key["id"]

      instance_profile_identity_model = {
        'name': "bx2d-8x32"
      }
      key_identity_model = {
        'id': key_id
      }

      vpc_identity_model = {
        'id': vpc_id
      }

      volume_attachment_prototype_instance_by_image_context_model = {
        'volume': {
          'name': "my-boot-volume",
          'profile': {
            'name': "general-purpose"
          }
        }
      }

      image_identity_model = {
        'id': image_id
      }

      subnet_identity_model = {
        'id': subnet_id
      }

      network_interface_prototype_model = {
        'name': "my-network-interface",
        'subnet': subnet_identity_model
      }

      zone_identity_model = {
        'name': "us-east-1"
      }

      volume_attachment_prototype_model = {
        'delete_volume_on_instance_delete': true,
        'volume': {
          'capacity': 1000,
          'name': "my-data-volume",
          'profile': {
            'name': "5iops-tier"
          }
        }
      }

      instance_prototype_model = {
        'keys': [key_identity_model],
        'name': "my-security-group-instanc",

        'profile': instance_profile_identity_model,
        'volume_attachments': [volume_attachment_prototype_model],
        'vpc': vpc_identity_model,
        'boot_volume_attachment': volume_attachment_prototype_instance_by_image_context_model,
        'image': image_identity_model,
        'primary_network_interface': network_interface_prototype_model,
        'zone': zone_identity_model
      }

      instance = service.create_instance(
        instance_prototype: instance_prototype_model
      ).result

      network_interface_id = instance["primary_network_interface"]["id"]
      puts network_interface_id

      puts "list_security_groups() result:"
      # begin-list_security_groups

      security_group_collection = service.list_security_groups
                                         .result

      puts JSON.pretty_generate(security_group_collection)

      # end-list_security_groups

      puts "create_security_group() result:"
      # begin-create_security_group

      vpc_identity_model = {
        'id': vpc_id
      }

      security_group = service.create_security_group(vpc: vpc_identity_model,
                                                     name: "my-security-group").result

      puts JSON.pretty_generate(security_group)

      # end-create_security_group
      security_group_id = security_group["id"]

      puts "get_security_group() result:"
      # begin-get_security_group

      security_group = service.get_security_group(
        id: security_group_id
      ).result

      puts JSON.pretty_generate(security_group)

      # end-get_security_group

      puts "update_security_group() result:"
      # begin-update_security_group

      security_group_patch_model = { name: "updated-my-security-group" }

      security_group = service.update_security_group(
        id: security_group_id,
        security_group_patch: security_group_patch_model
      ).result

      puts JSON.pretty_generate(security_group)

      # end-update_security_group

      puts "list_security_group_rules() result:"
      # begin-list_security_group_rules

      security_group_rule_collection = service.list_security_group_rules(
        security_group_id: security_group_id
      ).result

      puts JSON.pretty_generate(security_group_rule_collection)

      # end-list_security_group_rules

      puts "create_security_group_rule() result:"
      # begin-create_security_group_rule

      security_group_rule_prototype_model = {
        'direction': "inbound",
        'protocol': "icmp",
        'name': "my-security-group-rule"
      }

      security_group_rule = service.create_security_group_rule(
        security_group_id: security_group_id,
        security_group_rule_prototype: security_group_rule_prototype_model
      ).result

      puts JSON.pretty_generate(security_group_rule)

      # end-create_security_group_rule
      security_group_rule_id = security_group_rule["id"]

      puts "get_security_group_rule() result:"
      # begin-get_security_group_rule

      security_group_rule = service.get_security_group_rule(
        security_group_id: security_group_id, id: security_group_rule_id
      ).result

      puts JSON.pretty_generate(security_group_rule)

      # end-get_security_group_rule

      puts "update_security_group_rule() result:"
      # begin-update_security_group_rule

      security_group_rule_patch_model = { name: "updated-my-security-group-rule" }

      security_group_rule = service.update_security_group_rule(
        security_group_id: security_group_id,
        id: security_group_rule_id,
        security_group_rule_patch: security_group_rule_patch_model
      ).result

      puts JSON.pretty_generate(security_group_rule)

      # end-update_security_group_rule

      puts "list_security_group_targets() result:"
      # begin-list_security_group_targets

      security_group_target_collection = service.list_security_group_targets(
        security_group_id: security_group_id
      ).result
      puts security_group_target_collection
      puts JSON.pretty_generate(security_group_target_collection)

      # end-list_security_group_targets

      puts "create_security_group_target_binding() result:"
      # begin-create_security_group_target_binding

      security_group_target_reference = service.create_security_group_target_binding(
        security_group_id: security_group_id, id: network_interface_id
      ).result
      puts security_group_target_reference
      puts JSON.pretty_generate(security_group_target_reference)

      # end-create_security_group_target_binding

      puts "get_security_group_target() result:"
      # begin-get_security_group_target

      security_group_target_reference = service.get_security_group_target(
        security_group_id: security_group_id, id: network_interface_id
      ).result

      puts security_group_target_reference
      puts JSON.pretty_generate(security_group_target_reference)

      # end-get_security_group_target

      puts "delete_security_group_target_binding() result:"
      # begin-delete_security_group_target_binding

      service.delete_security_group_target_binding(
        security_group_id: security_group_id, id: network_interface_id
      )

      # end-delete_security_group_target_binding

      puts "delete_security_group_rule() result:"
      # begin-delete_security_group_rule

      service.delete_security_group_rule(
        security_group_id: security_group_id, id: security_group_rule_id
      )

      # end-delete_security_group_rule

      puts "delete_security_group() result:"
      # begin-delete_security_group

      service.delete_security_group(id: security_group_id)

      # end-delete_security_group

      service.delete_key(id: key_id)
    end

    def test_vpn_gateways_example
      vpc = service.create_vpc(name: "my-vpc-vpn-gateway").result
      vpc_id = vpc["id"]
      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-1"
        },
        'name': "my-subnet-vpn-gateway"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result
      subnet_id = subnet["id"]

      puts "list_ike_policies() result:"
      # begin-list_ike_policies

      ike_policy_collection = service.list_ike_policies.result

      puts JSON.pretty_generate(ike_policy_collection)

      # end-list_ike_policies

      puts "create_ike_policy() result:"
      # begin-create_ike_policy

      ike_policy = service.create_ike_policy(
        authentication_algorithm: "sha256",
        dh_group: 14,
        encryption_algorithm: "aes128",
        ike_version: 1,
        name: "my-ike-policy"
      ).result

      puts JSON.pretty_generate(ike_policy)

      # end-create_ike_policy
      ike_id = ike_policy["id"]

      puts "get_ike_policy() result:"
      # begin-get_ike_policy

      ike_policy = service.get_ike_policy(
        id: ike_id
      ).result

      puts JSON.pretty_generate(ike_policy)

      # end-get_ike_policy

      puts "update_ike_policy() result:"
      # begin-update_ike_policy

      ike_policy_patch_model = { name: "updated-my-ike-policy" }

      ike_policy = service.update_ike_policy(
        id: ike_id,
        ike_policy_patch: ike_policy_patch_model
      ).result

      puts JSON.pretty_generate(ike_policy)

      # end-update_ike_policy

      puts "list_ike_policy_connections() result:"
      # begin-list_ike_policy_connections

      vpn_gateway_connection_collection = service.list_ike_policy_connections(
        id: ike_id
      ).result

      puts JSON.pretty_generate(vpn_gateway_connection_collection)

      # end-list_ike_policy_connections

      puts "list_ipsec_policies() result:"
      # begin-list_ipsec_policies

      i_psec_policy_collection = service.list_ipsec_policies
                                        .result

      puts JSON.pretty_generate(i_psec_policy_collection)

      # end-list_ipsec_policies

      puts "create_ipsec_policy() result:"
      # begin-create_ipsec_policy

      i_psec_policy = service.create_ipsec_policy(
        authentication_algorithm: "sha256",
        encryption_algorithm: "aes128",
        pfs: "disabled",
        name: "updated-my-ipsec-policy"
      ).result

      puts JSON.pretty_generate(i_psec_policy)

      # end-create_ipsec_policy
      i_psec_policy_id = i_psec_policy["id"]

      puts "get_ipsec_policy() result:"
      # begin-get_ipsec_policy

      i_psec_policy = service.get_ipsec_policy(
        id: i_psec_policy_id
      ).result

      puts JSON.pretty_generate(i_psec_policy)

      # end-get_ipsec_policy

      puts "update_ipsec_policy() result:"
      # begin-update_ipsec_policy

      i_psec_policy_patch_model = { name: "updated-my-ipsec-policy" }

      i_psec_policy = service.update_ipsec_policy(
        id: i_psec_policy_id,
        i_psec_policy_patch: i_psec_policy_patch_model
      ).result

      puts JSON.pretty_generate(i_psec_policy)

      # end-update_ipsec_policy

      puts "list_ipsec_policy_connections() result:"
      # begin-list_ipsec_policy_connections

      ipsec_policy_connection_collection = service.list_ipsec_policy_connections(
        id: i_psec_policy_id
      ).result

      puts JSON.pretty_generate(ipsec_policy_connection_collection)

      # end-list_ipsec_policy_connections

      puts "list_vpn_gateways() result:"
      # begin-list_vpn_gateways

      vpn_gateway_collection = service.list_vpn_gateways(
        mode: "route"
      ).result

      puts JSON.pretty_generate(vpn_gateway_collection)

      # end-list_vpn_gateways

      puts "create_vpn_gateway() result:"
      # begin-create_vpn_gateway

      subnet_identity_model = {
        'id': subnet_id
      }

      vpn_gateway_prototype_model = {
        'subnet': subnet_identity_model,
        'name': "my-vpn-gateway"
      }

      vpn_gateway = service.create_vpn_gateway(
        vpn_gateway_prototype: vpn_gateway_prototype_model
      ).result

      puts JSON.pretty_generate(vpn_gateway)

      # end-create_vpn_gateway
      vpn_gateway_id = vpn_gateway["id"]

      puts "get_vpn_gateway() result:"
      # begin-get_vpn_gateway

      vpn_gateway = service.get_vpn_gateway(
        id: vpn_gateway_id
      ).result

      puts JSON.pretty_generate(vpn_gateway)

      # end-get_vpn_gateway

      puts "update_vpn_gateway() result:"
      # begin-update_vpn_gateway

      vpn_gateway_patch_model = { name: "updated-my-vpn-gateway" }

      vpn_gateway = service.update_vpn_gateway(
        id: vpn_gateway_id,
        vpn_gateway_patch: vpn_gateway_patch_model
      ).result

      puts JSON.pretty_generate(vpn_gateway)

      # end-update_vpn_gateway

      puts "list_vpn_gateway_connections() result:"
      # begin-list_vpn_gateway_connections

      vpn_gateway_connection_collection = service.list_vpn_gateway_connections(
        vpn_gateway_id: vpn_gateway_id
      ).result

      puts JSON.pretty_generate(vpn_gateway_connection_collection)

      # end-list_vpn_gateway_connections

      puts "create_vpn_gateway_connection() result:"
      # begin-create_vpn_gateway_connection

      vpn_gateway_connection_prototype_model = {
        'peer_address': "169.21.50.5",
        'psk': "lkj14b1oi0alcniejkso",
        'name': "my-vpn-gateway-connection"
      }

      vpn_gateway_connection = service.create_vpn_gateway_connection(
        vpn_gateway_id: vpn_gateway_id,
        vpn_gateway_connection_prototype:
        vpn_gateway_connection_prototype_model
      ).result

      puts JSON.pretty_generate(vpn_gateway_connection)

      # end-create_vpn_gateway_connection

      vpn_gateway_connection_id = vpn_gateway_connection["id"]

      puts "get_vpn_gateway_connection() result:"
      # begin-get_vpn_gateway_connection

      vpn_gateway_connection = service.get_vpn_gateway_connection(
        vpn_gateway_id: vpn_gateway_id, id: vpn_gateway_connection_id
      ).result

      puts JSON.pretty_generate(vpn_gateway_connection)

      # end-get_vpn_gateway_connection

      puts "update_vpn_gateway_connection() result:"
      # begin-update_vpn_gateway_connection

      vpn_gateway_connection_patch_model = { name: "updated-my-vpn-gateway-connection" }

      vpn_gateway_connection = service.update_vpn_gateway_connection(
        vpn_gateway_id: vpn_gateway_id,
        id: vpn_gateway_connection_id,
        vpn_gateway_connection_patch: vpn_gateway_connection_patch_model
      ).result

      puts JSON.pretty_generate(vpn_gateway_connection)

      # end-update_vpn_gateway_connection

      puts "list_vpn_gateway_connection_local_cidrs() result:"
      # begin-list_vpn_gateway_connection_local_cidrs

      vpn_gateway_connection_local_cid_rs = service.list_vpn_gateway_connection_local_cidrs(
        vpn_gateway_id: vpn_gateway_id, id: vpn_gateway_connection_id
      ).result

      puts JSON.pretty_generate(vpn_gateway_connection_local_cid_rs)

      # end-list_vpn_gateway_connection_local_cidrs

      # begin-add_vpn_gateway_connection_local_cidr

      service.add_vpn_gateway_connection_local_cidr(
        vpn_gateway_id: vpn_gateway_id,
        id: vpn_gateway_connection_id,
        cidr_prefix: "192.168.0.15/24",
        prefix_length: 4
      )

      # end-add_vpn_gateway_connection_local_cidr

      # begin-check_vpn_gateway_connection_local_cidr

      service.check_vpn_gateway_connection_local_cidr(
        vpn_gateway_id: vpn_gateway_id,
        id: vpn_gateway_connection_id,
        cidr_prefix: "192.168.0.15/24",
        prefix_length: 4
      )

      # end-check_vpn_gateway_connection_local_cidr

      puts "list_vpn_gateway_connection_peer_cidrs() result:"
      # begin-list_vpn_gateway_connection_peer_cidrs

      vpn_gateway_connection_peer_cid_rs = service.list_vpn_gateway_connection_peer_cidrs(
        vpn_gateway_id: vpn_gateway_id, id: vpn_gateway_connection_id
      ).result

      puts JSON.pretty_generate(vpn_gateway_connection_peer_cid_rs)

      # end-list_vpn_gateway_connection_peer_cidrs

      # begin-add_vpn_gateway_connection_peer_cidr

      service.add_vpn_gateway_connection_peer_cidr(
        vpn_gateway_id: vpn_gateway_id,
        id: vpn_gateway_connection_id,
        cidr_prefix: "192.168.0.15/24",
        prefix_length: 4
      )

      # end-add_vpn_gateway_connection_peer_cidr

      # begin-check_vpn_gateway_connection_peer_cidr

      service.check_vpn_gateway_connection_peer_cidr(
        vpn_gateway_id: vpn_gateway_id,
        id: vpn_gateway_connection_id,
        cidr_prefix: "192.168.0.15/24",
        prefix_length: 4
      )

      # end-check_vpn_gateway_connection_peer_cidr

      # begin-delete_ike_policy

      service.delete_ike_policy(
        id: ike_id
      )

      # end-delete_ike_policy

      # begin-remove_vpn_gateway_connection_peer_cidr

      service.remove_vpn_gateway_connection_peer_cidr(
        vpn_gateway_id: vpn_gateway_id,
        id: vpn_gateway_connection_id,
        cidr_prefix: "192.168.0.15/24",
        prefix_length: 4
      )

      # end-remove_vpn_gateway_connection_peer_cidr

      # begin-remove_vpn_gateway_connection_local_cidr

      service.remove_vpn_gateway_connection_local_cidr(
        vpn_gateway_id: vpn_gateway_id,
        id: vpn_gateway_connection_id,
        cidr_prefix: "192.168.0.15/24",
        prefix_length: 4
      )

      # end-remove_vpn_gateway_connection_local_cidr

      # begin-delete_vpn_gateway_connection

      service.delete_vpn_gateway_connection(
        vpn_gateway_id: vpn_gateway_id, id: vpn_gateway_connection_id
      )

      # end-delete_vpn_gateway_connection

      # begin-delete_vpn_gateway

      service.delete_vpn_gateway(id: vpn_gateway_id)

      # end-delete_vpn_gateway

      service.delete_subnet(id: subnet_id)

      service.delete_vpc(id: vpc_id)
    end

    def test_back_up_policies
      puts "list_backup_policies() result:"
      # begin-list_backup_policies

      backup_policy_collection = service.list_backup_policies.result
      puts backup_policy_collection
      puts JSON.pretty_generate(backup_policy_collection)

      # end-list_backup_policies

      puts "create_backup_policy() result:"
      # begin-create_backup_policy
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

      backup_policy_prototype_model = {
        'match_user_tags': ["my-daily-backup-policy"],
        'match_resource_type': ["volume"],
        'name': "my-backup-policy",
        'plans': [backup_policy_plan_prototype_model]
      }
      backup_policy_response = service.create_backup_policy(
        backup_policy_prototype: backup_policy_prototype_model
      )
      backup_policy = backup_policy_response.result
      backup_policy_etag = backup_policy_response.headers["ETag"]
      puts backup_policy
      puts JSON.pretty_generate(backup_policy)

      # end-create_backup_policy
      backup_policy_id = backup_policy["id"]

      puts "list_backup_policy_plans() result:"
      # begin-list_backup_policy_plans

      backup_policy_plan_collection = service.list_backup_policy_plans(
        backup_policy_id: backup_policy_id
      ).result
      puts backup_policy_plan_collection
      puts JSON.pretty_generate(backup_policy_plan_collection)

      # end-list_backup_policy_plans

      puts "create_backup_policy_plan() result:"
      # begin-create_backup_policy_plan

      backup_policy_plan_deletion_trigger_prototype_model = {
        'delete_after': 20,
        'delete_over_count': 20
      }

      backup_policy_plan_response = service.create_backup_policy_plan(
        backup_policy_id: backup_policy_id,
        cron_spec: "*/5 1,2,3 * * *",
        active: true,
        attach_user_tags: ["my-daily-backup-plan"],
        copy_user_tags: true,
        deletion_trigger: backup_policy_plan_deletion_trigger_prototype_model,
        name: "my-backup-policy-plan"
      )
      backup_policy_plan = backup_policy_plan_response.result
      backup_policy_plan_etag = backup_policy_plan_response.headers["ETag"]
      puts backup_policy_plan
      puts JSON.pretty_generate(backup_policy_plan)

      # end-create_backup_policy_plan
      backup_policy_plan_id = backup_policy_plan["id"]

      puts "get_backup_policy_plan() result:"
      # begin-get_backup_policy_plan

      backup_policy_plan = service.get_backup_policy_plan(
        backup_policy_id: backup_policy_id,
        id: backup_policy_plan_id
      ).result
      puts backup_policy_plan
      puts JSON.pretty_generate(backup_policy_plan)

      # end-get_backup_policy_plan

      puts "update_backup_policy_plan() result:"
      # begin-update_backup_policy_plan

      backup_policy_plan_patch_model = {}
      backup_policy_plan_patch_model["name"] = "my-backup-policy-plan-updated"

      backup_policy_plan = service.update_backup_policy_plan(
        backup_policy_id: backup_policy_id,
        id: backup_policy_plan_id,
        backup_policy_plan_patch: backup_policy_plan_patch_model,
        if_match: backup_policy_plan_etag
      ).result
      puts backup_policy_plan
      puts JSON.pretty_generate(backup_policy_plan)

      # end-update_backup_policy_plan

      puts "get_backup_policy() result:"
      # begin-get_backup_policy

      backup_policy = service.get_backup_policy(
        id: backup_policy_id
      ).result
      puts backup_policy
      puts JSON.pretty_generate(backup_policy)

      # end-get_backup_policy

      puts "update_backup_policy() result:"
      # begin-update_backup_policy

      backup_policy_patch_model = {}
      backup_policy_patch_model["name"] = "my-backup-policy-updated"

      backup_policy = service.update_backup_policy(
        id: backup_policy_id,
        backup_policy_patch: backup_policy_patch_model,
        if_match: backup_policy_etag
      ).result
      puts backup_policy
      puts JSON.pretty_generate(backup_policy)

      # end-update_backup_policy

      puts "delete_backup_policy_plan() result:"
      # begin-delete_backup_policy_plan

      backup_policy_plan = service.delete_backup_policy_plan(
        backup_policy_id: backup_policy_id,
        id: backup_policy_plan_id,
        if_match: backup_policy_plan_etag
      ).result
      puts backup_policy_plan
      puts JSON.pretty_generate(backup_policy_plan)

      # end-delete_backup_policy_plan

      puts "delete_backup_policy() result:"
      # begin-delete_backup_policy

      backup_policy = service.delete_backup_policy(
        id: backup_policy_id,
        if_match: backup_policy_etag
      ).result
      puts backup_policy
      puts JSON.pretty_generate(backup_policy)

      # end-delete_backup_policy
    end

    def test_vpn_servers
      vpc = service.create_vpc(name: "my-vpc-vpn-server").result
      vpc_id = vpc["id"]
      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-1"
        },
        'name': "my-subnet-vpn-server"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result
      subnet_id = subnet["id"]
      puts "list_vpn_servers() result:"
      # begin-list_vpn_servers

      vpn_server_collection = service.list_vpn_servers(
        sort: "name"
      ).result

      puts JSON.pretty_generate(vpn_server_collection)

      # end-list_vpn_servers

      puts "create_vpn_server() result:"
      # begin-create_vpn_server

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
        'id': subnet_id
      }

      vpn_server = service.create_vpn_server(
        certificate: certificate_instance_identity_model,
        client_authentication: [vpn_server_authentication_prototype_model],
        client_ip_pool: "172.16.0.0/16",
        subnets: [subnet_identity_model],
        name: "my-example-vpn-server"
      ).result

      puts vpn_server
      puts JSON.pretty_generate(vpn_server)

      # end-create_vpn_server

      vpn_server_id = vpn_server["id"]

      puts "get_vpn_server() result:"
      # begin-get_vpn_server

      vpn_server_response = service.get_vpn_server(
        id: vpn_server_id
      )
      created_vpn_server_etag = vpn_server_response.headers["ETag"]
      vpn_server = vpn_server_response.result

      puts vpn_server
      puts JSON.pretty_generate(vpn_server)

      # end-get_vpn_server

      puts "update_vpn_server() result:"
      # begin-update_vpn_server

      vpn_server_patch_model = {}
      vpn_server_patch_model["name"] = "my-vpn-server-updated"

      vpn_server = service.update_vpn_server(
        id: vpn_server_id,
        vpn_server_patch: vpn_server_patch_model,
        if_match: created_vpn_server_etag
      ).result
      puts vpn_server
      puts JSON.pretty_generate(vpn_server)

      # end-update_vpn_server

      puts "get_vpn_server_client_configuration() result:"
      # begin-get_vpn_server_client_configuration

      vpn_server_client_configuration = service.get_vpn_server_client_configuration(
        id: vpn_server_id
      ).result
      puts vpn_server_client_configuration
      puts JSON.pretty_generate(vpn_server_client_configuration)

      # end-get_vpn_server_client_configuration

      puts "list_vpn_server_clients() result:"
      # begin-list_vpn_server_clients

      vpn_server_client_collection = service.list_vpn_server_clients(
        vpn_server_id: vpn_server_id,
        sort: "created_at"
      ).result
      puts vpn_server_client_collection
      puts JSON.pretty_generate(vpn_server_client_collection)

      # end-list_vpn_server_clients
      vpn_server_client_id = vpn_server_client_collection["clients"][0]["id"]

      puts "get_vpn_server_client() result:"
      # begin-get_vpn_server_client

      vpn_server_client = service.get_vpn_server_client(
        vpn_server_id: vpn_server_id,
        id: vpn_server_client_id
      ).result
      puts vpn_server_client
      puts JSON.pretty_generate(vpn_server_client)

      # end-get_vpn_server_client

      # begin-disconnect_vpn_client

      service.disconnect_vpn_client(
        vpn_server_id: vpn_server_id,
        id: vpn_server_client_id
      )

      # end-disconnect_vpn_client

      puts "list_vpn_server_routes() result:"
      # begin-list_vpn_server_routes

      vpn_server_route_collection = service.list_vpn_server_routes(
        vpn_server_id: vpn_server_id,
        sort: "name"
      ).result
      puts vpn_server_route_collection
      puts JSON.pretty_generate(vpn_server_route_collection)

      # end-list_vpn_server_routes

      puts "create_vpn_server_route() result:"
      # begin-create_vpn_server_route

      vpn_server_route = service.create_vpn_server_route(
        vpn_server_id: vpn_server_id,
        destination: "172.16.0.0/16",
        name: "my-vpn-server-route"
      ).result
      puts vpn_server_route
      puts JSON.pretty_generate(vpn_server_route)

      # end-create_vpn_server_route
      vpn_server_route_id = vpn_server_route["id"]

      puts "get_vpn_server_route() result:"
      # begin-get_vpn_server_route

      vpn_server_route = service.get_vpn_server_route(
        vpn_server_id: vpn_server_id,
        id: vpn_server_route_id
      ).result
      puts vpn_server_route
      puts JSON.pretty_generate(vpn_server_route)

      # end-get_vpn_server_route

      puts "update_vpn_server_route() result:"
      # begin-update_vpn_server_route

      vpn_server_route_patch_model = {}
      vpn_server_route_patch_model["name"] = "my-vpnserver-route-updated"

      vpn_server_route = service.update_vpn_server_route(
        vpn_server_id: vpn_server_id,
        id: vpn_server_route_id,
        vpn_server_route_patch: vpn_server_route_patch_model
      ).result
      puts vpn_server_route
      puts JSON.pretty_generate(vpn_server_route)
      # end-update_vpn_server_route

      # begin-delete_vpn_server_route

      service.delete_vpn_server_route(
        vpn_server_id: vpn_server_id,
        id: vpn_server_route_id
      )

      # end-delete_vpn_server_route

      # begin-delete_vpn_server_client

      response = service.delete_vpn_server_client(
        vpn_server_id: vpn_server_id,
        id: vpn_server_client_id
      )
      puts "delete_vpn_server_client response"
      puts response
      # end-delete_vpn_server_client

      # begin-delete_vpn_server

      service.delete_vpn_server(
        id: vpn_server_id,
        if_match: created_vpn_server_etag
      )

      # end-delete_vpn_server
    end

    def test_load_balancer_example
      vpc = service.create_vpc(name: "my-vpc-load-balancer").result
      vpc_id = vpc["id"]
      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-1"
        },
        'name': "my-subnet-load-balancer"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result
      subnet_id = subnet["id"]

      images = service.list_images.result["images"]
      image_id = images[5]["id"]

      key = service.create_key(
        name: "my-key-load-balancer",
        public_key:
          "AAAAB3NzaC1yc2EAAAADAQABAAABAQDDGe50Bxa5T5NDddrrtbx2Y4/VGbiCgXqnBsYToIUKoFSHTQl5IX3PasGnneKanhcLwWz5M5MoCRvhxTp66NKzIfAz7r+FX9rxgR+ZgcM253YAqOVeIpOU408simDZKriTlN8kYsXL7P34tsWuAJf4MgZtJAQxous/2byetpdCv8ddnT4X3ltOg9w+LqSCPYfNivqH00Eh7S1Ldz7I8aw5WOp5a+sQFP/RbwfpwHp+ny7DfeIOokcuI42tJkoBn7UsLTVpCSmXr2EDRlSWe/1M/iHNRBzaT3CK0+SwZWd2AEjePxSnWKNGIEUJDlUYp7hKhiQcgT5ZAnWU121oc5En"
      ).result
      key_id = key["id"]

      instance_profile_identity_model = {
        'name': "bx2d-8x32"
      }
      key_identity_model = {
        'id': key_id
      }

      vpc_identity_model = {
        'id': vpc_id
      }

      volume_attachment_prototype_instance_by_image_context_model = {
        'volume': {
          'name': "my-boot-volume",
          'profile': {
            'name': "general-purpose"
          }
        }
      }

      image_identity_model = {
        'id': image_id
      }

      subnet_identity_model = {
        'id': subnet_id
      }

      network_interface_prototype_model = {
        'name': "my-network-interface",
        'subnet': subnet_identity_model
      }

      zone_identity_model = {
        'name': "us-east-1"
      }

      volume_attachment_prototype_model = {
        'delete_volume_on_instance_delete': true,
        'volume': {
          'capacity': 1000,
          'name': "my-data-volume",
          'profile': {
            'name': "5iops-tier"
          }
        }
      }

      instance_prototype_model = {
        'keys': [key_identity_model],
        'name': "my-instance-load-balancer",

        'profile': instance_profile_identity_model,
        'volume_attachments': [volume_attachment_prototype_model],
        'vpc': vpc_identity_model,
        'boot_volume_attachment': volume_attachment_prototype_instance_by_image_context_model,
        'image': image_identity_model,
        'primary_network_interface': network_interface_prototype_model,
        'zone': zone_identity_model
      }

      instance = service.create_instance(
        instance_prototype: instance_prototype_model
      ).result
      instance_id = instance["id"]

      instance_profile_identity_model = {
        'name': "bx2d-8x32"
      }
      key_identity_model = {
        'id': key_id
      }

      vpc_identity_model = {
        'id': vpc_id
      }

      volume_attachment_prototype_instance_by_image_context_model = {
        'volume': {
          'name': "my-boot-volume",
          'profile': {
            'name': "general-purpose"
          }
        }
      }

      image_identity_model = {
        'id': image_id
      }

      subnet_identity_model = {
        'id': subnet_id
      }

      network_interface_prototype_model = {
        'name': "my-network-interface",
        'subnet': subnet_identity_model
      }

      zone_identity_model = {
        'name': "us-east-1"
      }

      volume_attachment_prototype_model = {
        'delete_volume_on_instance_delete': true,
        'volume': {
          'capacity': 1000,
          'name': "my-data-volume",
          'profile': {
            'name': "5iops-tier"
          }
        }
      }

      instance_prototype_model = {
        'keys': [key_identity_model],
        'name': "my-instance-load-balancer1",

        'profile': instance_profile_identity_model,
        'volume_attachments': [volume_attachment_prototype_model],
        'vpc': vpc_identity_model,
        'boot_volume_attachment': volume_attachment_prototype_instance_by_image_context_model,
        'image': image_identity_model,
        'primary_network_interface': network_interface_prototype_model,
        'zone': zone_identity_model
      }

      instance = service.create_instance(
        instance_prototype: instance_prototype_model
      ).result
      instance_id_1 = instance["id"]

      puts "list_load_balancer_profiles() result:"
      # begin-list_load_balancer_profiles

      load_balancer_profile_collection = service.list_load_balancer_profiles
                                                .result

      puts JSON.pretty_generate(load_balancer_profile_collection)

      # end-list_load_balancer_profiles

      load_balancer_profile = load_balancer_profile_collection["profiles"][0]["name"]
      puts "get_load_balancer_profile() result:"

      # begin-get_load_balancer_profile

      load_balancer_profile = service.get_load_balancer_profile(
        name: load_balancer_profile
      ).result

      puts JSON.pretty_generate(load_balancer_profile)

      # end-get_load_balancer_profile

      puts "list_load_balancers() result:"
      # begin-list_load_balancers

      load_balancer_collection = service.list_load_balancers
                                        .result

      puts JSON.pretty_generate(load_balancer_collection)

      # end-list_load_balancers

      puts "create_load_balancer() result:"
      # begin-create_load_balancer

      subnet_identity_model = {
        'id': subnet_id
      }

      load_balancer = service.create_load_balancer(
        is_public: true, subnets: [subnet_identity_model],
        name: "my-load-balancer"
      ).result

      puts JSON.pretty_generate(load_balancer)

      # end-create_load_balancer
      load_balancer_id = load_balancer["id"]

      puts "get_load_balancer() result:"
      # begin-get_load_balancer

      load_balancer = service.get_load_balancer(
        id: load_balancer_id
      ).result

      puts JSON.pretty_generate(load_balancer)

      # end-get_load_balancer

      puts "update_load_balancer() result:"
      # begin-update_load_balancer

      load_balancer_patch_model = { name: "updated-my-load-balancer" }

      load_balancer = service.update_load_balancer(
        id: load_balancer_id,
        load_balancer_patch: load_balancer_patch_model
      ).result

      puts JSON.pretty_generate(load_balancer)

      # end-update_load_balancer

      puts "get_load_balancer_statistics() result:"
      # begin-get_load_balancer_statistics

      load_balancer_statistics = service.get_load_balancer_statistics(
        id: load_balancer_id
      ).result

      puts JSON.pretty_generate(load_balancer_statistics)

      # end-get_load_balancer_statistics

      puts "list_load_balancer_listeners() result:"
      # begin-list_load_balancer_listeners

      load_balancer_listener_collection = service.list_load_balancer_listeners(
        load_balancer_id: load_balancer_id
      ).result

      puts JSON.pretty_generate(load_balancer_listener_collection)

      # end-list_load_balancer_listeners

      puts "create_load_balancer_listener() result:"
      # begin-create_load_balancer_listener

      load_balancer_listener = service.create_load_balancer_listener(
        load_balancer_id: load_balancer_id, port: 443,
        protocol: "http"
      ).result

      puts JSON.pretty_generate(load_balancer_listener)

      # end-create_load_balancer_listener
      load_balancer_listener_id = load_balancer_listener["id"]

      puts "get_load_balancer_listener() result:"
      # begin-get_load_balancer_listener

      load_balancer_listener = service.get_load_balancer_listener(
        load_balancer_id: load_balancer_id, id: load_balancer_listener_id
      ).result

      puts JSON.pretty_generate(load_balancer_listener)

      # end-get_load_balancer_listener

      puts "update_load_balancer_listener() result:"
      # begin-update_load_balancer_listener

      load_balancer_listener_patch_model = { name: "updated-my-load-balancer-listener" }

      load_balancer_listener = service.update_load_balancer_listener(
        load_balancer_id: load_balancer_id,
        id: load_balancer_listener_id,
        load_balancer_listener_patch: load_balancer_listener_patch_model
      ).result

      puts JSON.pretty_generate(load_balancer_listener)

      # end-update_load_balancer_listener

      puts "list_load_balancer_listener_policies() result:"
      # begin-list_load_balancer_listener_policies

      load_balancer_listener_policy_collection = service.list_load_balancer_listener_policies(
        load_balancer_id: load_balancer_id,
        listener_id: load_balancer_listener_id
      ).result

      puts JSON.pretty_generate(load_balancer_listener_policy_collection)

      # end-list_load_balancer_listener_policies

      puts "create_load_balancer_listener_policy() result:"
      # begin-create_load_balancer_listener_policy

      load_balancer_listener_policy = service.create_load_balancer_listener_policy(
        load_balancer_id: load_balancer_id,
        listener_id: load_balancer_listener_id,
        action: "forward",
        priority: 5,
        name: "my-load-balancer-listener-policy"
      ).result

      puts JSON.pretty_generate(load_balancer_listener_policy)

      # end-create_load_balancer_listener_policy
      load_balancer_listener_policy_id = load_balancer_listener_policy["id"]

      puts "get_load_balancer_listener_policy() result:"
      # begin-get_load_balancer_listener_policy

      load_balancer_listener_policy = service.get_load_balancer_listener_policy(
        load_balancer_id: load_balancer_id,
        listener_id: load_balancer_listener_id,
        id: load_balancer_listener_policy_id
      ).result

      puts JSON.pretty_generate(load_balancer_listener_policy)

      # end-get_load_balancer_listener_policy

      puts "list_load_balancer_listener_policy_rules() result:"
      # begin-list_load_balancer_listener_policy_rules

      load_balancer_listener_policy_rule_collection = service.list_load_balancer_listener_policy_rules(
        load_balancer_id: load_balancer_id,
        listener_id: load_balancer_listener_id,
        policy_id: load_balancer_listener_policy_id
      ).result

      puts JSON.pretty_generate(load_balancer_listener_policy_rule_collection)

      # end-list_load_balancer_listener_policy_rules

      puts "create_load_balancer_listener_policy_rule() result:"
      # begin-create_load_balancer_listener_policy_rule

      load_balancer_listener_policy_rule = service.create_load_balancer_listener_policy_rule(
        load_balancer_id: load_balancer_id,
        listener_id: load_balancer_listener_id,
        policy_id: load_balancer_listener_policy_id,
        condition: "contains",
        type: "header",
        value: "2",
        field: "1"
      ).result

      puts JSON.pretty_generate(load_balancer_listener_policy_rule)

      # end-create_load_balancer_listener_policy_rule
      load_balancer_listener_policy_rule_id = load_balancer_listener_policy_rule["id"]

      puts "get_load_balancer_listener_policy_rule() result:"
      # begin-get_load_balancer_listener_policy_rule

      load_balancer_listener_policy_rule = service.get_load_balancer_listener_policy_rule(
        load_balancer_id: load_balancer_id,
        listener_id: load_balancer_listener_id,
        policy_id: load_balancer_listener_policy_id,
        id: load_balancer_listener_policy_rule_id
      ).result

      puts JSON.pretty_generate(load_balancer_listener_policy_rule)

      # end-get_load_balancer_listener_policy_rule

      puts "update_load_balancer_listener_policy_rule() result:"
      # begin-update_load_balancer_listener_policy_rule

      load_balancer_listener_policy_rule_patch_model = { 'condition': "contains",
                                                         'type': "header",
                                                         'value': "2", 'field': "3" }

      load_balancer_listener_policy_rule = service.update_load_balancer_listener_policy_rule(
        load_balancer_id: load_balancer_id,
        listener_id: load_balancer_listener_id,
        policy_id: load_balancer_listener_policy_id,
        id: load_balancer_listener_policy_rule_id,
        load_balancer_listener_policy_rule_patch:
          load_balancer_listener_policy_rule_patch_model
      ).result

      puts JSON.pretty_generate(load_balancer_listener_policy_rule)

      # end-update_load_balancer_listener_policy_rule

      puts "list_load_balancer_pools() result:"
      # begin-list_load_balancer_pools

      load_balancer_pool_collection = service.list_load_balancer_pools(
        load_balancer_id: load_balancer_id
      ).result

      puts JSON.pretty_generate(load_balancer_pool_collection)

      # end-list_load_balancer_pools

      puts "create_load_balancer_pool() result:"
      # begin-create_load_balancer_pool

      load_balancer_pool_health_monitor_prototype_model = {
        'delay': 5,
        'max_retries': 2,
        'timeout': 2,
        'type': "http"
      }

      load_balancer_pool = service.create_load_balancer_pool(
        load_balancer_id: load_balancer_id,
        algorithm: "least_connections",
        health_monitor: load_balancer_pool_health_monitor_prototype_model,
        protocol: "http",
        name: "my-load-balancer-pool"
      ).result

      puts JSON.pretty_generate(load_balancer_pool)

      # end-create_load_balancer_pool
      load_balancer_pool_id = load_balancer_pool["id"]

      puts "get_load_balancer_pool() result:"
      # begin-get_load_balancer_pool

      load_balancer_pool = service.get_load_balancer_pool(
        load_balancer_id: load_balancer_id, id: load_balancer_pool_id
      ).result

      puts JSON.pretty_generate(load_balancer_pool)

      # end-get_load_balancer_pool

      puts "update_load_balancer_pool() result:"
      # begin-update_load_balancer_pool

      load_balancer_pool_patch_model = { name: "updated-my-load-balancer-pool" }

      load_balancer_pool = service.update_load_balancer_pool(
        load_balancer_id: load_balancer_id,
        id: load_balancer_pool_id,
        load_balancer_pool_patch: load_balancer_pool_patch_model
      ).result

      puts JSON.pretty_generate(load_balancer_pool)

      # end-update_load_balancer_pool

      puts "update_load_balancer_listener_policy() result:"
      # begin-update_load_balancer_listener_policy

      load_balancer_listener_policy_patch_model = { name: "updated-my-load-balancer-listener-policy",
                                                    priority: "1",
                                                    target: {
                                                      'id': load_balancer_pool_id
                                                    } }

      load_balancer_listener_policy = service.update_load_balancer_listener_policy(
        load_balancer_id: load_balancer_id,
        listener_id: load_balancer_listener_id,
        id: load_balancer_listener_policy_id,
        load_balancer_listener_policy_patch:
          load_balancer_listener_policy_patch_model
      ).result

      puts JSON.pretty_generate(load_balancer_listener_policy)

      # end-update_load_balancer_listener_policy

      puts "list_load_balancer_pool_members() result:"
      # begin-list_load_balancer_pool_members

      load_balancer_pool_member_collection = service.list_load_balancer_pool_members(
        load_balancer_id: load_balancer_id,
        pool_id: load_balancer_pool_id
      ).result

      puts JSON.pretty_generate(load_balancer_pool_member_collection)

      # end-list_load_balancer_pool_members

      puts "create_load_balancer_pool_member() result:"
      # begin-create_load_balancer_pool_member

      load_balancer_pool_member_target_prototype_model = {
        'id': instance_id,
        'name': "my-load-balancer-pool-member"
      }

      load_balancer_pool_member = service.create_load_balancer_pool_member(
        load_balancer_id: load_balancer_id,
        pool_id: load_balancer_pool_id,
        port: 80,
        target: load_balancer_pool_member_target_prototype_model
      ).result

      puts JSON.pretty_generate(load_balancer_pool_member)

      # end-create_load_balancer_pool_member
      load_balancer_pool_member_id = load_balancer_pool_member["id"]

      puts "get_load_balancer_pool_member() result:"
      # begin-get_load_balancer_pool_member

      load_balancer_pool_member = service.get_load_balancer_pool_member(
        load_balancer_id: load_balancer_id,
        pool_id: load_balancer_pool_id,
        id: load_balancer_pool_member_id
      ).result

      puts JSON.pretty_generate(load_balancer_pool_member)

      # end-get_load_balancer_pool_member

      puts "update_load_balancer_pool_member() result:"
      # begin-update_load_balancer_pool_member

      load_balancer_pool_member_patch_model = { name: "updated-my-load-balancer-pool-member" }

      load_balancer_pool_member = service.update_load_balancer_pool_member(
        load_balancer_id: load_balancer_id,
        pool_id: load_balancer_pool_id,
        id: load_balancer_pool_member_id,
        load_balancer_pool_member_patch:
        load_balancer_pool_member_patch_model
      ).result

      puts JSON.pretty_generate(load_balancer_pool_member)

      # end-update_load_balancer_pool_member

      puts "replace_load_balancer_pool_members() result:"
      # begin-replace_load_balancer_pool_members

      load_balancer_pool_member_target_prototype_model = {
        'id': instance_id_1
      }

      load_balancer_pool_member_prototype_model = {
        'port': 80,
        'target': load_balancer_pool_member_target_prototype_model
      }

      load_balancer_pool_member_collection = service.replace_load_balancer_pool_members(
        load_balancer_id: load_balancer_id,
        pool_id: load_balancer_pool_id,
        members: [load_balancer_pool_member_prototype_model]
      ).result

      puts JSON.pretty_generate(load_balancer_pool_member_collection)

      # end-replace_load_balancer_pool_members
      load_balancer_pool_member_id = load_balancer_pool_member_collection["members"][0]["id"]
      # begin-delete_load_balancer_pool_member

      service.delete_load_balancer_pool_member(
        load_balancer_id: load_balancer_id,
        pool_id: load_balancer_pool_id,
        id: load_balancer_pool_member_id
      )

      # end-delete_load_balancer_pool_member

      # begin-delete_load_balancer_pool

      service.delete_load_balancer_pool(
        load_balancer_id: load_balancer_id, id: load_balancer_pool_id
      )

      # end-delete_load_balancer_pool

      # begin-delete_load_balancer_listener_policy_rule

      service.delete_load_balancer_listener_policy_rule(
        load_balancer_id: load_balancer_id,
        listener_id: load_balancer_listener_id,
        policy_id: load_balancer_listener_policy_id,
        id: load_balancer_listener_policy_rule_id
      )

      # end-delete_load_balancer_listener_policy_rule

      # begin-delete_load_balancer_listener_policy

      service.delete_load_balancer_listener_policy(
        load_balancer_id: load_balancer_id,
        listener_id: load_balancer_listener_id,
        id: load_balancer_listener_policy_id
      )

      # end-delete_load_balancer_listener_policy

      # begin-delete_load_balancer_listener

      service.delete_load_balancer_listener(
        load_balancer_id: load_balancer_id, id: load_balancer_listener_id
      )

      # end-delete_load_balancer_listener

      # begin-delete_load_balancer

      service.delete_load_balancer(id: load_balancer_id)

      # end-delete_load_balancer
    end

    def test_endpoint_gateway_example
      vpc = service.create_vpc(name: "my-vpc-endpoint-gateway").result
      vpc_id = vpc["id"]
      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-1"
        },
        'name': "my-subnet-endpoint-gateway"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result
      subnet_id = subnet["id"]
      reserved_ip = service.create_subnet_reserved_ip(
        subnet_id: subnet_id
      ).result
      reserved_ip_id = reserved_ip["id"]
      puts "list_endpoint_gateways() result:"
      # begin-list_endpoint_gateways

      endpoint_gateway_collection = service.list_endpoint_gateways
                                           .result

      puts JSON.pretty_generate(endpoint_gateway_collection)

      # end-list_endpoint_gateways

      puts "create_endpoint_gateway() result:"
      # begin-create_endpoint_gateway

      endpoint_gateway_target_prototype_model = {
        'resource_type':
              "provider_infrastructure_service",
        'crn':
              "crn:v1:bluemix:public:cloudant:us-east:a/123456:3527280b-9327-4411-8020-591092e60353::"
      }

      vpc_identity_model = {
        'id': vpc_id
      }

      endpoint_gateway = service.create_endpoint_gateway(
        target: endpoint_gateway_target_prototype_model,
        vpc: vpc_identity_model
      ).result

      puts JSON.pretty_generate(endpoint_gateway)

      # end-create_endpoint_gateway
      endpoint_gateway_id = endpoint_gateway["id"]

      puts "list_endpoint_gateway_ips() result:"
      # begin-list_endpoint_gateway_ips

      reserved_ip_collection_endpoint_gateway_context = service.list_endpoint_gateway_ips(
        endpoint_gateway_id: endpoint_gateway_id
      ).result

      puts JSON.pretty_generate(reserved_ip_collection_endpoint_gateway_context)

      # end-list_endpoint_gateway_ips

      puts "add_endpoint_gateway_ip() result:"
      # begin-add_endpoint_gateway_ip

      reserved_ip = service.add_endpoint_gateway_ip(
        endpoint_gateway_id: endpoint_gateway_id, id: reserved_ip_id
      ).result

      puts JSON.pretty_generate(reserved_ip)

      # end-add_endpoint_gateway_ip

      puts "get_endpoint_gateway_ip() result:"
      # begin-get_endpoint_gateway_ip

      reserved_ip = service.get_endpoint_gateway_ip(
        endpoint_gateway_id: endpoint_gateway_id, id: reserved_ip_id
      ).result

      puts JSON.pretty_generate(reserved_ip)

      # end-get_endpoint_gateway_ip

      puts "get_endpoint_gateway() result:"
      # begin-get_endpoint_gateway

      endpoint_gateway = service.get_endpoint_gateway(
        id: endpoint_gateway_id
      ).result

      puts JSON.pretty_generate(endpoint_gateway)

      # end-get_endpoint_gateway

      puts "update_endpoint_gateway() result:"
      # begin-update_endpoint_gateway

      endpoint_gateway_patch_model = { name: "updated-my-endpoint-gateway" }

      endpoint_gateway = service.update_endpoint_gateway(
        id: endpoint_gateway_id,
        endpoint_gateway_patch: endpoint_gateway_patch_model
      ).result

      puts JSON.pretty_generate(endpoint_gateway)

      # end-update_endpoint_gateway

      # begin-remove_endpoint_gateway_ip

      service.remove_endpoint_gateway_ip(
        endpoint_gateway_id: endpoint_gateway_id, id: reserved_ip_id
      )

      # end-remove_endpoint_gateway_ip

      # begin-delete_endpoint_gateway

      service.delete_endpoint_gateway(id: endpoint_gateway_id)

      # end-delete_endpoint_gateway
    end

    def test_flowlog_example
      vpc = service.create_vpc(name: "my-vpc-flow-log").result
      vpc_id = vpc["id"]
      puts "list_flow_log_collectors() result:"
      # begin-list_flow_log_collectors

      flow_log_collector_collection = service.list_flow_log_collectors
                                             .result

      puts JSON.pretty_generate(flow_log_collector_collection)

      # end-list_flow_log_collectors

      puts "create_flow_log_collector() result:"
      # begin-create_flow_log_collector

      cloud_object_storage_bucket_identity_model = {
        'name': "bucket-27200-lwx4cfvcue"
      }

      flow_log_collector_target_prototype_model = {
        'id': vpc_id
      }

      flow_log_collector = service.create_flow_log_collector(
        storage_bucket: cloud_object_storage_bucket_identity_model,
        target: flow_log_collector_target_prototype_model,
        name: "my-flow-log"
      ).result

      puts JSON.pretty_generate(flow_log_collector)

      # end-create_flow_log_collector
      flow_log_collector_id = flow_log_collector["id"]
      puts "get_flow_log_collector() result:"
      # begin-get_flow_log_collector

      flow_log_collector = service.get_flow_log_collector(
        id: flow_log_collector_id
      ).result

      puts JSON.pretty_generate(flow_log_collector)

      # end-get_flow_log_collector

      puts "update_flow_log_collector() result:"
      # begin-update_flow_log_collector

      flow_log_collector_patch_model = { name: "updated-my-flow-log" }

      flow_log_collector = service.update_flow_log_collector(
        id: flow_log_collector_id,
        flow_log_collector_patch: flow_log_collector_patch_model
      ).result

      puts JSON.pretty_generate(flow_log_collector)

      # end-update_flow_log_collector

      # begin-delete_flow_log_collector

      service.delete_flow_log_collector(id: flow_log_collector_id)

      # end-delete_flow_log_collector
    end

    def test_bare_metal_servers
      vpc = service.create_vpc(name: "my-vpc-bare-metal").result
      vpc_id = vpc["id"]

      subnet_prototype_model = {
        'vpc': {
          'id': vpc_id
        },
        'total_ipv4_address_count': 256,
        'zone': {
          'name': "us-east-1"
        },
        'name': "my-subnet-bare-metal"
      }

      subnet = service.create_subnet(
        subnet_prototype: subnet_prototype_model
      ).result

      subnet_id = subnet["id"]

      puts "list_bare_metal_server_profiles() result "
      # begin-list_bare_metal_server_profiles

      bare_metal_server_profile_collection = service.list_bare_metal_server_profiles.result

      # end-list_bare_metal_server_profiles
      assert !bare_metal_server_profile_collection.nil?

      puts "get_bare_metal_server_profile() result "
      # begin-get_bare_metal_server_profile

      bare_metal_server_profile = service.get_bare_metal_server_profile(
        name: "bmhbx2-24x384"
      ).result

      # end-get_bare_metal_server_profile
      assert !bare_metal_server_profile.nil?

      puts "list_bare_metal_servers() result "
      # begin-list_bare_metal_servers

      bare_metal_server_collection = service.list_bare_metal_servers.result

      # end-list_bare_metal_servers
      assert !bare_metal_server_collection.nil?

      image_file_prototype_model = {}
      image_file_prototype_model["href"] = "cos://us-south/my-bucket/my-image.qcow2"

      operating_system_identity_model = {}
      operating_system_identity_model["name"] = "debian-9-amd64"

      image_prototype_model = {}
      image_prototype_model["file"] = image_file_prototype_model
      image_prototype_model["operating_system"] = operating_system_identity_model
      image_prototype_model["name"] = "my-image-baremetal"

      image = service.create_image(image_prototype: image_prototype_model).result
      image_id = image["id"]

      key = service.create_key(
        public_key:
          "AAAAB3NzaC1yc2EAAAADAQABAAABAQDDGe50Bxa5T5NDddrrtbx2Y4/VGbiCgXqnBsYToIUKoFSHTQl5IX3PasGnneKanhcLwWz5M5MoCRvhxTp66NKzIfAz7r+FX9rxgR+ZgcM253YAqOVeIpOU408simDZKriTlN8kYsXL7P34tsWuAJf4MgZtJAQxous/2byetpdCv8ddnT4X3ltOg9w+LqSCPYfNivqH00Eh7S1Ldz7I8aw5WOp5a+sQFP/RbwfpwHp+ny7DfeIOokcuI42tJkoBn7UsLTVpCSmXr2EDRlSWe/1M/iHNRBzaT3CK0+SwZWd2AEjePxSnWKNGIEUJDlUYp7hKhiQcgT5ZAnWU121oc5En",
        name: "my-ssh-key-bare-metal"
      ).result
      key_id = key["id"]
      puts "create_bare_metal_server() result "
      # begin-create_bare_metal_server

      image_identity_model = {
        'id': image_id
      }

      key_identity_model = {
        'id': key_id
      }

      bare_metal_server_initialization_prototype_model = {
        'image': image_identity_model,
        'keys': [key_identity_model]
      }

      bare_metal_server_primary_network_interface_prototype_model = {
        'subnet': {
          'id': subnet_id
        }
      }

      zone_identity_model = {
        'name': "us-east-1"
      }
      profile = {
        'name': "bmx2-48x768"
      }
      bare_metal_server_prototype = {
        'initialization': bare_metal_server_initialization_prototype_model,
        'primary_network_interface':
          bare_metal_server_primary_network_interface_prototype_model,
        'profile': profile,
        'name': "my-baremetal-server",
        'zone': zone_identity_model
      }
      bare_metal_server = service.create_bare_metal_server(
        bare_metal_server_prototype: bare_metal_server_prototype
      ).result

      # end-create_bare_metal_server
      assert !bare_metal_server.nil?

      bare_metal_id = bare_metal_server["id"]

      puts "get_bare_metal_server_initialization() result"
      # begin-get_bare_metal_server_initialization

      bare_metal_server_initialization = service.get_bare_metal_server_initialization(
        id: bare_metal_id
      ).result

      # end-get_bare_metal_server_initialization
      assert !bare_metal_server_initialization.nil?

      puts "create_bare_metal_server_console_access_token() result "
      # begin-create_bare_metal_server_console_access_token

      # bare_metal_server_console_access_token = service.create_bare_metal_server_console_access_token(
      #   bare_metal_server_id: bare_metal_id,
      #   console_type: "serial"
      # ).result

      # end-create_bare_metal_server_console_access_token
      # assert !bare_metal_server_console_access_token.nil?

      puts "list_bare_metal_server_disks() result "
      # begin-list_bare_metal_server_disks

      bare_metal_server_disk_collection = service.list_bare_metal_server_disks(
        bare_metal_server_id: bare_metal_id
      ).result
      # end-list_bare_metal_server_disks
      assert bare_metal_server_disk_collection
      bare_metal_disk_id = bare_metal_server_disk_collection["disks"][0]["id"]

      puts "get_bare_metal_server_disk() result"
      # begin-get_bare_metal_server_disk

      bare_metal_server_disk = service.get_bare_metal_server_disk(
        bare_metal_server_id: bare_metal_id,
        id: bare_metal_disk_id
      ).result

      # end-get_bare_metal_server_disk
      assert !bare_metal_server_disk.nil?

      puts "create_bare_metal_server_console_access_token() result"
      # begin-create_bare_metal_server_console_access_token

      # bare_metal_server_console_access_token = service.create_bare_metal_server_console_access_token(
      #   bare_metal_server_id: bare_metal_id,
      #   console_type: "serial"
      # ).result

      # puts JSON.pretty_generate(bare_metal_server_console_access_token)

      # end-create_bare_metal_server_console_access_token

      puts "update_bare_metal_server_disk() result"
      # begin-update_bare_metal_server_disk

      bare_metal_server_disk_patch_model = {}

      bare_metal_server_disk = service.update_bare_metal_server_disk(
        bare_metal_server_id: bare_metal_id,
        id: bare_metal_disk_id,
        bare_metal_server_disk_patch: bare_metal_server_disk_patch_model
      ).result

      # end-update_bare_metal_server_disk
      assert !bare_metal_server_disk.nil?

      puts "list_bare_metal_server_network_interfaces() result"
      # begin-list_bare_metal_server_network_interfaces

      bare_metal_server_network_interface_collection = service.list_bare_metal_server_network_interfaces(
        bare_metal_server_id: bare_metal_id
      ).result

      # end-list_bare_metal_server_network_interfaces
      assert !bare_metal_server_network_interface_collection.nil?

      puts "create_bare_metal_server_network_interface() result"
      # begin-create_bare_metal_server_network_interface

      bare_metal_server_network_interface_prototype_model = {
        'interface_type': "vlan",
        'subnet': {
          'id': subnet_id
        },
        'vlan': 4
      }

      bare_metal_server_network_interface = service.create_bare_metal_server_network_interface(
        bare_metal_server_id: bare_metal_id,
        bare_metal_server_network_interface_prototype:
          bare_metal_server_network_interface_prototype_model
      ).result

      # end-create_bare_metal_server_network_interface
      assert !bare_metal_server_network_interface.nil?
      bm_nic_id = bare_metal_server_network_interface["id"]

      puts "get_bare_metal_server_network_interface() result"
      # begin-get_bare_metal_server_network_interface

      bare_metal_server_network_interface = service.get_bare_metal_server_network_interface(
        bare_metal_server_id: bare_metal_id,
        id: bm_nic_id
      ).result

      # end-get_bare_metal_server_network_interface
      assert !bare_metal_server_network_interface.nil?

      puts "update_bare_metal_server_network_interface() result"
      # begin-update_bare_metal_server_network_interface

      bare_metal_server_network_interface_patch_model = {
        'name': "my-network-interface-updated"
      }

      bare_metal_server_network_interface = service.update_bare_metal_server_network_interface(
        bare_metal_server_id: bare_metal_id,
        id: bm_nic_id,
        bare_metal_server_network_interface_patch:
        bare_metal_server_network_interface_patch_model
      ).result

      # end-update_bare_metal_server_network_interface
      assert !bare_metal_server_network_interface.nil?

      zone_identity_model = {
        'name': "us-east-1"
      }

      floating_ip_prototype_model = {
        'zone': zone_identity_model
      }

      floating_ip = service.create_floating_ip(
        floating_ip_prototype: floating_ip_prototype_model
      ).result
      floating_ip_id = floating_ip["id"]

      print(
        '\nadd_bare_metal_server_network_interface_floating_ip() result:'
      )
      # begin-add_bare_metal_server_network_interface_floating_ip

      floating_ip = service.add_bare_metal_server_network_interface_floating_ip(
        bare_metal_server_id: bare_metal_id,
        network_interface_id: bm_nic_id,
        id: floating_ip_id
      ).result

      # end-add_bare_metal_server_network_interface_floating_ip
      assert !floating_ip.nil?

      print(
        '\nlist_bare_metal_server_network_interface_floating_ips() result:'
      )
      # begin-list_bare_metal_server_network_interface_floating_ips

      floating_ip_unpaginated_collection = service.list_bare_metal_server_network_interface_floating_ips(
        bare_metal_server_id: bare_metal_id,
        network_interface_id: bm_nic_id
      ).result

      # end-list_bare_metal_server_network_interface_floating_ips
      assert !floating_ip_unpaginated_collection.nil?
      bm_nic_fip_id = floating_ip_unpaginated_collection["floating_ips"][0]["id"]

      puts "get_bare_metal_server_network_interface_floating_ip() result:"
      # begin-get_bare_metal_server_network_interface_floating_ip

      floating_ip = service.get_bare_metal_server_network_interface_floating_ip(
        bare_metal_server_id: bare_metal_id,
        network_interface_id: bm_nic_id,
        id: bm_nic_fip_id
      ).result

      # end-get_bare_metal_server_network_interface_floating_ip
      assert !floating_ip.nil?

      puts "get_bare_metal_server() result"
      # begin-get_bare_metal_server

      bare_metal_server = service.get_bare_metal_server(
        id: bare_metal_id
      ).result

      # end-get_bare_metal_server
      assert !bare_metal_server.nil?

      puts "update_bare_metal_server() result"
      # begin-update_bare_metal_server

      bare_metal_server_patch_model = {
        'name': "my-baremetal-server-updated"
      }

      bare_metal_server = service.update_bare_metal_server(
        id: bare_metal_id,
        bare_metal_server_patch: bare_metal_server_patch_model
      ).result

      # end-update_bare_metal_server
      assert !bare_metal_server.nil?

      # begin-restart_bare_metal_server

      service.restart_bare_metal_server(
        id: bare_metal_id
      )

      # end-restart_bare_metal_server

      # begin-start_bare_metal_server

      service.start_bare_metal_server(
        id: bare_metal_id
      )

      # end-start_bare_metal_server

      # begin-stop_bare_metal_server

      service.stop_bare_metal_server(
        id: bare_metal_id, type: "soft"
      )

      # end-stop_bare_metal_server

      # begin-remove_bare_metal_server_network_interface_floating_ip

      service.remove_bare_metal_server_network_interface_floating_ip(
        bare_metal_server_id: bare_metal_id,
        network_interface_id: bm_nic_id,
        id: bm_nic_fip_id
      )

      # end-remove_bare_metal_server_network_interface_floating_ip

      # begin-delete_bare_metal_server_network_interface

      service.delete_bare_metal_server_network_interface(
        bare_metal_server_id: bare_metal_id, id: bm_nic_id
      )

      # end-delete_bare_metal_server_network_interface

      # begin-delete_bare_metal_server

      service.delete_bare_metal_server(id: bare_metal_id)

      # end-delete_bare_metal_server
    end
  end
else
  class VpcV1Test < Minitest::Test
    def test_missing_credentials_skip_example
      skip "Skip VPC example tests because credentials have not been provided"
    end
  end
end
