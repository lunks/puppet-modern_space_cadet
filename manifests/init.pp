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
  $force_correct_shifts_val  = $force_correct_shifts  ? { true => 1, false => 0 }
  $shifts_to_parens_val      = $shifts_to_parens      ? { true => 1, false => 0 }
  $fix_opt_arrows_val        = $fix_opt_arrows        ? { true => 1, false => 0 }
  $math_layer_val            = $math_layer            ? { true => 1, false => 0 }
  $greek_layer_val           = $greek_layer           ? { true => 1, false => 0 }

  include seil
  include seil::login_item

  include karabiner
  karabiner::profile{ 'Default': }

  if ($capslock_to_control_plus_escape) {
    karabiner::remap{ 'controlL2controlL_escape': }
    karabiner::set{ 'parameter.keyoverlaidmodifier_timeout': value => 300 }

    seil::map { 'capslock': value => 59}
  }

  if ($left_control_to_hyper) {
    seil::map { 'control_l': value => 80}
  }

  karabiner::set{ 'space_cadet.left_control_to_hyper': value => $left_control_to_hyper_val }
  karabiner::set{ 'space_cadet.force_correct_shifts':  value => $force_correct_shifts_val }
  karabiner::set{ 'space_cadet.shifts_to_parens':      value => $shifts_to_parens_val }
  karabiner::set{ 'space_cadet.fix_opt_arrows':        value => $fix_opt_arrows_val }
  karabiner::set{ 'space_cadet.math_layer':            value => $math_layer_val }
  karabiner::set{ 'space_cadet.greek_layer':           value => $greek_layer_val }

  karabiner::private_xml{ 'private.xml': source => 'puppet:///modules/modern_space_cadet/private.xml' }
}
