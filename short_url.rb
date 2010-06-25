module ShortUrl
  def self.included(base)
    base.extend ClassMethods
  end

  def secret_id
    return ShortUrl.id2code(self.id)
  end

  module ClassMethods
    def find_by_secret_id(code)
      return self.find(ShortUrl.code2id(code.strip))
    end
  end

  #######

  def self.url_chars
    return %w(b c d f g h j k l m n p q r s t v w x y z) + ('0' .. '9').to_a + %w(B C D F G H J K L M N P Q R S T V W X Y Z - _)
  end

  def self.baselength
    return self.url_chars.length
  end

  def self.code2id(code)
    return nil unless code
    return code.strip.split('').reverse.inject_with_index(0){|sum, c, i|
      sum += (self.baselength**i * self.url_chars.index(c))
    }
  end

  def self.id2code(number)
    return nil unless number
    number = Integer(number);
    ret_code = '';
    while(number != 0)
      ret_code = String(self.url_chars[number % self.baselength ]) + ret_code;
      number = number / self.baselength;
    end
    return ret_code; 
  end

end
