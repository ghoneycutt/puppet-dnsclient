require 'spec_helper'
describe 'dnsclient', :type => :class do

  describe 'when using default values' do
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

  describe 'defaults with options unset' do
    let :facts do
      { :test_suite => 'defaults_with_options_unset',
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


nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'defaults with different name servers' do
    let :facts do
      { :test_suite => 'defaults_with_different_nameservers',
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


options rotate timeout:1
nameserver 4.2.2.1
nameserver 4.2.2.2
})
    }
  end

  describe 'defaults with different options' do
    let :facts do
      { :test_suite => 'defaults_with_different_options',
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


options debug ndots:2
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'defaults with only search' do
    let :facts do
      { :test_suite => 'defaults_with_only_search',
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

search one.example.com two.example.com

options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'defaults with only domain' do
    let :facts do
      { :test_suite => 'defaults_with_only_domain',
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

domain example.com


options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'defaults with serach and domain' do
    let :facts do
      { :test_suite => 'defaults_with_search_and_domain',
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

search one.example.com two.example.com

options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'defaults with sortlist' do
    let :facts do
      { :test_suite => 'defaults_with_sortlist',
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

sortlist 130.155.160.0/255.255.240.0 130.155.0.0

options rotate timeout:1
nameserver 8.8.8.8
nameserver 8.8.4.4
})
    }
  end

  describe 'defaults with different file attributes' do
    let :facts do
      { :test_suite => 'defaults_with_different_file_attributes',
      }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'file',
        'path'   => '/tmp/etc/resolv.conf',
        'owner'  => 'gh',
        'group'  => 'gh',
        'mode'   => '0600',
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

  describe 'absent file' do
    let :facts do
      { :test_suite => 'absent_file',
      }
    end

    it {
      should contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'absent',
      })
    }
  end

  describe 'fails on invalid file ensure' do
    let :facts do
      { :test_suite => 'fails_on_invalid_file_ensure',
      }
    end

    it do
      expect {
        should contain_file('dnsclient_resolver_config_file')
      }.to raise_error(Puppet::Error, /Valid values for \$resolver_config_file_ensure are 'absent', 'file', or 'present'/)
    end
  end
end
