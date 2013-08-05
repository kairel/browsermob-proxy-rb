module Browsermob
    class Client
      
      #ATTRIBUTES
      attr_reader :host, :port, :resource

      #CONSTANTS
      LIMITS = {
        :upstream_kbps => 'upstreamKbps',
        :downstream_kbps => 'downstreamKbps',
        :latency => 'latency'
      }

      #Create new proxy on browsermob
      def initialize(host, port)
        @host = host
        @har =  false
        uri = "http://#{host}:#{port}/proxy"
        proxy = RestClient::Resource.new uri
        @port = MultiJson.load(proxy.post '').fetch('port')
        @resource = RestClient::Resource.new("#{uri}/#{@port}")
      end
      
      #No record this request
      def blacklist(regexp, status_code)
        regex = Regexp === regexp ? regexp.source : regexp.to_s
        @resource['blacklist'].put :regex => regex, :status => status_code
      end

      #Auth http
      def basic_authentication(domain, username, password)
        data = { username: username, password: password }
        @resource["auth/basic/#{domain}"].post data.to_json, :content_type => "application/json"
      end

      # Close proxy
      def close
        retour = @resource.delete
        @resource = nil
        @har = false
        retour
      end

      #Get http archive 
      def har
        @resource["har"].get
      end

      def header(hash)
        @resource['headers'].post hash.to_json, :content_type => "application/json"
      end
      alias_method :headers, :header


      def limit(opts)
        params = {}

        opts.each do |key, value|
          unless LIMITS.member?(key)
            raise ArgumentError, "invalid: #{key.inspect} (valid options: #{LIMITS.keys.inspect})"
          end

          params[LIMITS[key]] = Integer(value)
        end

        if params.empty?
          raise ArgumentError, "must specify one of #{LIMITS.keys.inspect}"
        end

        @resource['limit'].put params
      end

      #Start to record a new http archive
      def new_har(ref = nil, opts = {})
        if opts.empty? && ref.kind_of?(Hash)
          opts = ref
          ref = nil
        end
        params = {}

        params[:initialPageRef] = ref if ref
        params[:captureHeaders] = true if opts[:capture_headers]
        @har = true
        @resource["har"].put params 
      end

      # Start attahc content to new page
      def new_page ref = nil
        @resource['har/pageRef'].put :pageRef => ref if @har
      end

      #Record ths request
      def whitelist(regexp, status_code)
        regex = Regexp === regexp ? regexp.source : regexp.to_s
        @resource['whitelist'].put :regex => regex, :status => status_code
      end
    end 
end
