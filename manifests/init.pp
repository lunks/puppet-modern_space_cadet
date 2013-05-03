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
  $fix_opt_arrows_val = $fix_opt_arrows               ? { true => 1, false => 0 }
  $math_layer_val = $math_layer                       ? { true => 1, false => 0 }
  $greek_layer_val = $greek_layer                     ? { true => 1, false => 0 }

  include pckeyboardhack
  include pckeyboardhack::login_item

  include keyremap4macbook
  include keyremap4macbook::login_item

  if ($capslock_to_control_plus_escape) {
    keyremap4macbook::remap{ 'controlL2controlL_escape': }
    keyremap4macbook::set{ 'parameter.keyoverlaidmodifier_timeout': value => 300 }

    $capslock_mappings = { 'capslock' => 59 }
  } else {
    $capslock_mappings = { }
  }

  if ($left_control_to_hyper) {
    $hyper_mappings = { 'control_l' => 80 }
  } else {
    $hyper_mappings = { }
  }

  pckeyboardhack::bind{ 'pckeyboardhack mappings': mappings => merge($hyper_mappings, $capslock_mappings) }

  keyremap4macbook::set{ 'space_cadet.left_control_to_hyper': value => $left_control_to_hyper_val }
  keyremap4macbook::set{ 'space_cadet.force_correct_shifts':  value => $force_correct_shifts_val }
  keyremap4macbook::set{ 'space_cadet.shifts_to_parens':      value => $shifts_to_parens_val }
  keyremap4macbook::set{ 'space_cadet.fix_opt_arrows':        value => $fix_opt_arrows_val }
  keyremap4macbook::set{ 'space_cadet.math_layer':            value => $math_layer_val }
  keyremap4macbook::set{ 'space_cadet.greek_layer':           value => $greek_layer_val }

  keyremap4macbook::private_xml{ 'private.xml': content => 'puppet:///modules/modern_space_cadet/private.xml' }
}
