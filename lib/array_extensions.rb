class Array

	def inject_with_index(injected)
		each_with_index{|obj, index| injected = yield(injected, obj, index) }
		injected
	end

  # divide an array into multiple arrays, e.g. [1,2,3,4,5]/2 => [[1,2],[3,4],[5]]
  def / len
    a = []
    each_with_index do |x,i|
      a << [] if i % len == 0
      a.last << x
    end
    a
  end
end


