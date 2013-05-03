module Puppet::Parser::Functions
  newfunction(:caps_to_control_script, :type => :rvalue) do |args|
    scripts = find_domains.map(&method(:script))
    "/bin/sh -c \"#{scripts.join(' && ')}\""
  end
end

def find_domains
  base_domain = 'com.apple.keyboard.modifiermapping'
  counter = {}
  keyboards = `ioreg -n IOHIDKeyboard -r`.split("\n").grep(/(VendorID"|Product)/).map{ |e| e.split('=')[1].strip }.each_slice(3)
  keyboards.map do |(name, vendor, product)|
    counter[name] = (counter[name] || -1) + 1
    "#{base_domain}.#{vendor}-#{product}-#{counter[name]}"
  end
end

def script(domain)
  xml = '<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>'
  "defaults -currentHost write -g #{domain} -array '#{xml}'"
end
