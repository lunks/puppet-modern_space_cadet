# Public: Sets up the modern space cadet
#
# Usage:
#
#   include modern_space_cadet
class modern_space_cadet {
  $force_correct_shift_keys = true
  $shifts_to_parentheses = true
  $left_control_to_hyper = true
  $math_layer = true
  $greek_layer = true

  file { '/tmp/capslock-to-control.scpt':
    ensure => 'present',
    source => 'puppet:///modules/modern_space_cadet/capslock-to-control.scpt'
  }

  exec { 'capslock to control':
    command => '/usr/bin/osascript /tmp/capslock-to-control.scpt',
    require => File['/tmp/capslock-to-control.scpt']
  }

  include pckeyboardhack
  include pckeyboardhack::login_item
  pckeyboardhack::bind { 'left control to F19': mappings => { 'control_l' => 80 } }

  include keyremap4macbook
  include keyremap4macbook::login_item
  keyremap4macbook::remap{ 'controlL2controlL_escape': }
  keyremap4macbook::set{ 'parameter.keyoverlaidmodifier_timeout': value => 300 }
  keyremap4macbook::private_xml{ 'private.xml': content => template('modern_space_cadet/private.erb') }
}
