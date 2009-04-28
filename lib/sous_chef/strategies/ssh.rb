module SousChef
  module Strategies
    class SSH < Strategy
      called :ssh

      def deploy
        with_archive do |path|
          system("scp", path, "root@10.1.1.52:/tmp/chef/cookbooks.tgz") && \
          system("scp", node_config_path, "root@10.1.1.52:/tmp/chef/solo.json") && \
          system("ssh", "root@10.1.1.52", "chef-solo -r /tmp/chef/cookbooks.tgz " \
                                          "-j /tmp/chef/solo.json " \
                                          "-c /tmp/chef/solo.rb " \
                                          "-l debug")
        end
      end
    end
  end
end
