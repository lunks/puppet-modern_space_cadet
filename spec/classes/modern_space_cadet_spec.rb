require 'spec_helper'

describe 'modern_space_cadet' do
  it do
    should contain_file('/tmp/capslock-to-control.scpt').with({
      :source => 'puppet:///modules/modern_space_cadet/capslock-to-control.scpt',
      :ensure => 'present'
    })

    should contain_exec('capslock to control').with({
      :command => '/usr/bin/osascript /tmp/capslock-to-control.scpt',
      :require => 'File[/tmp/capslock-to-control.scpt]'
    })

    should include_class('pckeyboardhack')
    should include_class('pckeyboardhack::login_item')
    should contain_pckeyboardhack__bind('left control to F19').with({
      :mappings => { 'control_l' => '80' }
    })

    should include_class('keyremap4macbook')
    should include_class('keyremap4macbook::login_item')
    should contain_keyremap4macbook__remap('controlL2controlL_escape')
    should contain_keyremap4macbook__set('parameter.keyoverlaidmodifier_timeout').with({
      :value => 300
    })
    should contain_keyremap4macbook__private_xml('private.xml')
    should contain_keyremap4macbook__set('space_cadet.left_control_to_hyper').with_value(1)
    should contain_keyremap4macbook__set('space_cadet.force_correct_shifts').with_value(1)
    should contain_keyremap4macbook__set('space_cadet.shifts_to_parens').with_value(1)
    should contain_keyremap4macbook__set('space_cadet.fix_opt_arrows').with_value(1)
    should contain_keyremap4macbook__set('space_cadet.math_layer').with_value(1)
    should contain_keyremap4macbook__set('space_cadet.greek_layer').with_value(1)
  end
end
