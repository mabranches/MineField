class BitSetSimple
  attr_accessor :value, :size
  def initialize(size)
    @size = size
    #don't let set grow bigger than size
    @set_mask = (1 << size) -1
    @value = 0
  end

  def [](pos)
    @value[pos]
  end

  def []=(bit, bit_value)
    if bit_value == 0
      clear_bit(bit)
    else
      set_bit(bit)
    end
  end

  def &(mask)
    bit_set = BitSetSimple.new(@size)
    case mask
    when Fixnum, Bignum
      bit_set.value = @value & mask
    else
      bit_set.value = @value & mask.value
    end
    bit_set
  end

  def |(mask)
    bit_set = BitSetSimple.new(@size)
    case mask
    when Fixnum, Bignum
      bit_set.value = @value | mask
    else
      bit_set.value = @value | mask.value
    end
    bit_set
  end

  def <<(n)
    (@value << n) & @set_mask
  end

  def ~
    bit_set = BitSetSimple.new(@size)
    bit_set.value = ~@value
    bit_set
  end

  def all_set?
    @value == (1 << @size ) - 1
  end

  def all_clear?
    @value == 0
  end

  def to_s
    @value.to_s(2).rjust(@size, '0')
  end

  def self.random(n, size)
    (['0']*(size - n) + ['1'] * n).
      shuffle.join.to_i 2
  end

  private
    def set_bit(bit)
      @value |= 1 << bit;
    end

    def clear_bit(bit)
      @value &= ~(1 << bit)
    end
end
