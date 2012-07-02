require 'spec_helper'
describe 'dnsclient' do

  describe 'when using default values for class' do
    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with parameter nameservers set' do
    let :params do
      { :nameservers => ['4.2.2.2', '4.2.2.1'] }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
options rotate timeout:1
nameserver 4.2.2.2
nameserver 4.2.2.1
})
    }
  end

  describe 'with parameter nameservers set to a single nameserver as a string ' do
    let :params do
      { :nameservers => '4.2.2.2' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
options rotate timeout:1
nameserver 4.2.2.2
})
    }
  end

  describe 'with no options' do
    let :params do
      { :options => 'UNSET' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with options set to a single value' do
    let :params do
      { :options => 'ndots:2' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
options ndots:2
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with options set to multiple values' do
    let :params do
      { :options => ['ndots:2', 'rotate'] }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
options ndots:2 rotate
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with search set to multiple values' do
    let :params do
      { :search => ['foo.example.tld', 'example.tld'] }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
search foo.example.tld example.tld
options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with search set to a single value' do
    let :params do
      { :search => 'example.tld' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
search example.tld
options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with search and domain set' do
    let :params do
      {
        :search => ['foo.example.tld', 'example.tld'],
        :domain => 'valid.tld',
      }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
search foo.example.tld example.tld
options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with domain set' do
    let :params do
      { :domain => 'valid.tld' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
domain valid.tld
options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with domain and no options set' do
    let :params do
      {
        :domain  => 'valid.tld',
        :options => 'UNSET',
      }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
domain valid.tld
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  # TODO - does not actually catch the fail()
  describe 'with search set to an invalid single value' do
    let :params do
      { :search => '-notvalid.tld' }
    end

    it {
      # GH: this does not seem to work. if search is valid it should fail and does not
      should raise_error()
    }
  end

  # TODO - does not actually catch the fail()
  describe 'with search set to an invalid value in an array' do
    let :params do
      { :search => ['valid.tld', '-notvalid.tld'] }
    end

    it {
      # GH: this does not seem to work. if search is valid it should fail and does not
      should raise_error()
    }
  end

  describe 'with only search' do
    let :params do
      {
        :search  => 'valid.tld',
        :options => 'UNSET',
      }
    end
    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
search valid.tld
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with search and sortlist' do
    let :params do
      {
        :search   => 'valid.tld',
        :sortlist => ['10.10.10.0/24', '10.10.11.0/24'],
        :options  => 'UNSET',
      }
    end
    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
search valid.tld
sortlist 10.10.10.0/24 10.10.11.0/24
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with search, sortlist, and options' do
    let :params do
      {
        :search   => 'valid.tld',
        :sortlist => ['10.10.10.0/24', '10.10.11.0/24'],
      }
    end
    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
search valid.tld
sortlist 10.10.10.0/24 10.10.11.0/24
options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with sortlist set to an array of values' do
    let :params do
      { :sortlist => ['10.10.10.0/24', '10.10.11.0/24'] }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
sortlist 10.10.10.0/24 10.10.11.0/24
options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with sortlist, options, and domain' do
    let :params do
      {
        :sortlist => ['10.10.10.0/24', '10.10.11.0/24'],
        :domain   => 'valid.tld',
      }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
sortlist 10.10.10.0/24 10.10.11.0/24
domain valid.tld
options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with sortlist, no options, and domain' do
    let :params do
      {
        :sortlist => ['10.10.10.0/24', '10.10.11.0/24'],
        :domain   => 'valid.tld',
        :options  => 'UNSET',
      }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
sortlist 10.10.10.0/24 10.10.11.0/24
domain valid.tld
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with sortlist set to a single value' do
    let :params do
      { :sortlist => '10.10.10.0/24' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
sortlist 10.10.10.0/24
options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  # TODO - write test
  describe 'with parameter resolver_config_file_ensure not set to \'file\' \'present\' or \'absent\'' do
    let :params do
      { :resolver_config_file_ensure => 'invalid' }
    end

    it {
      # GH: code to catch fail()
    }
  end

  describe 'with parameter resolver_config_file_ensure set to present' do
    let :params do
      { :resolver_config_file_ensure => 'present' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'present',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
      should contain_file('dnsclient_resolver_config_file').with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT
options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'with parameter resolver_config_file_ensure set to absent' do
    let :params do
      { :resolver_config_file_ensure => 'absent' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'absent',
      })
    }
  end

  describe 'with parameter resolver_config_file set' do
    let :params do
      { :resolver_config_file => '/tmp/resolv.conf' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'path' => '/tmp/resolv.conf',
      })
    }
  end

  describe 'with parameter resolver_config_file_owner set' do
    let :params do
      { :resolver_config_file_owner => 'foo' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'owner' => 'foo',
      })
    }
  end

  describe 'with parameter resolver_config_file_group set' do
    let :params do
      { :resolver_config_file_group => 'bar' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'group' => 'bar',
      })
    }
  end

  describe 'with parameter resolver_config_file_mode set' do
    let :params do
      { :resolver_config_file_mode => '0777' }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'mode' => '0777',
      })
    }
  end
end
