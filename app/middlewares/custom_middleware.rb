class CustomMiddleware
    def initialize(app)
      @app = app
    end
  
    def call(env)
      # Your custom logic here
      status, headers, response = @app.call(env)
      [status, headers, response]
    end
  end
  