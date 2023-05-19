class TiltProcessor
  def initialize(klass)
    @klass = klass
  end

  def call(input)
    filename = input[:filename]
    data     = input[:data]
    context  = input[:environment].context_class.new(input)

    data = @klass.new(filename) { data }.render(context, {})
    context.metadata.merge(data: data.to_str)
  end
end
