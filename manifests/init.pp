# Public: Sets up the modern space cadet
#
# Usage:
#
#   include modern_space_cadet
class modern_space_cadet(
  $capslock_to_control_plus_escape = true,
  $force_correct_shifts            = true,
  $shifts_to_parens                = true,
  $left_control_to_hyper           = true,
  $fix_opt_arrows                  = true,
  $math_layer                      = true,
  $greek_layer                     = true
) {
  $left_control_to_hyper_val = $left_control_to_hyper ? { true => 1, false => 0 }
  $force_correct_shifts_val = $force_correct_shifts   ? { true => 1, false => 0 }
  $shifts_to_parens_val = $shifts_to_parens           ? { true => 1, false => 0 }
  $fix_opt_arrows_val = $fix_opt_arrows_val           ? { true => 1, false => 0 }
  $math_layer_val = $math_layer                       ? { true => 1, false => 0 }
  $greek_layer_val = $greek_layer                     ? { true => 1, false => 0 }

  include pckeyboardhack
  include pckeyboardhack::login_item

  include keyremap4macbook
  include keyremap4macbook::login_item

  if ($capslock_to_control_plus_escape) {
    file { '/tmp/capslock-to-control.scpt':
      ensure => 'present',
      source => 'puppet:///modules/modern_space_cadet/capslock-to-control.scpt'
    }

    exec { 'capslock to control':
      command => '/usr/bin/osascript /tmp/capslock-to-control.scpt',
      require => File['/tmp/capslock-to-control.scpt']
    }

    keyremap4macbook::remap{ 'controlL2controlL_escape': }
    keyremap4macbook::set{ 'parameter.keyoverlaidmodifier_timeout': value => 300 }
  }

  if ($left_control_to_hyper) {
    pckeyboardhack::bind { 'left control to F19': mappings => { 'control_l' => 80 } }
  }

  keyremap4macbook::set{ 'space_cadet.left_control_to_hyper': value => $left_control_to_hyper }
  keyremap4macbook::set{ 'space_cadet.force_correct_shifts':  value => $force_correct_shifts_val }
  keyremap4macbook::set{ 'space_cadet.shifts_to_parens':      value => $shifts_to_parens_val }
  keyremap4macbook::set{ 'space_cadet.fix_opt_arrows':        value => $fix_opt_arrows_val }
  keyremap4macbook::set{ 'space_cadet.math_layer':            value => $math_layer_val }
  keyremap4macbook::set{ 'space_cadet.greek_layer':           value => $greek_layer_val }

  keyremap4macbook::private_xml{ 'private.xml': content => 'puppet:///modules/modern_space_cadet/private.xml' }
}
