#!/usr/bin/env ruby
#
require 'yaml'

ARGV.length == 2 or abort "Usage: #{$0} <lb-setup.yaml> <keepalived.conf.template>"
ARGV.each {|f|
  File.exist?(f) or abort "File #{f} does not exist"
}

data = open(ARGV[0], "r") { |f| YAML.load(f) }
info = data["lb-setup"]["nodes"][`uname -n`.strip]

open(ARGV[1], "r") { |f|
  kconf = f.read

  puts kconf.sub("WW", info['priority'].to_s)
    .sub("YYY", info['auth_pass'])
    .sub("XXX", info['router_id'].to_s)
    .gsub("ZZZ", info['vip'].split(".")[3])
}
