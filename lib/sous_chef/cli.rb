module SousChef
  class CLI < Thor
    desc "deploy NODE", "Deploy the recipes for this specified node"
    method_options :strategy => "ssh"
    def deploy(node)
      strategy = options[:strategy].to_s
      unless strategy_klass = Strategy.available[strategy]
        raise ArgumentError, "Could not find a strategy for #{strategy}"
      end
      puts "deploying #{node.inspect} via #{strategy.inspect}"
      strategy_klass.deploy(node)
    end
  end
end
