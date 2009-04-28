module SousChef
  class Strategy
    def self.available
      @available ||= {}
    end

    def self.called(value)
      Strategy.available[value.to_s] = self
    end

    def self.deploy(node)
      new(node).deploy
    end

    def initialize(node)
      @node = node
      node_config_path
    end

    def deploy
      raise "Implement #deploy in #{self.class}"
    end

    def node_config_path
      path = "nodes/#{@node}.json"
      raise Errno::ENOENT, "Could not find the node: #{@node}" unless File.exist?(path)
      path
    end

    def with_archive
      puts "archiving"
      Tempfile.open("recipes.tgz") do |tgz|
        Dir.chdir("cookbooks") do
          system("git archive --format=tar --prefix=cookbooks/ HEAD | gzip > #{tgz.path}")
        end
        tgz.close
        yield tgz.path
      end
    end
  end
end
