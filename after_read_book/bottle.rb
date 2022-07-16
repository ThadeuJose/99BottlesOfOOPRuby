# frozen_string_literal: true
class CountdownSong
  attr_reader :verse_template, :max, :min

  def initialize(verse_template:, max: 999_999, min: 0)
    @verse_template = verse_template
    @max = max
    @min = min
  end

  def song
    verses(max, min)
  end

  def verses(starting, ending)
    starting.downto(ending).map { |i| verse(i) }.join("\n")
  end

  def verse(number)
    verse_template.lyrics(number)
  end
end

class BottleVerse
  attr_reader :bottle_number

  def self.lyrics(number)
    new(BottleNumber.for(number)).lyrics
  end

  def initialize(bottle_number)
    @bottle_number = bottle_number
  end

  def lyrics
    "#{bottle_number} of milk on the wall, ".capitalize +
    "#{bottle_number} of milk.\n" +
    "#{bottle_number.action}, " +
    "#{bottle_number.sucessor} of milk on the wall.\n"
  end
end

class BottleNumber
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def sucessor
    BottleNumber.for(number - 1)
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def quantity
    number.to_s
  end

  def pronoun
    'one'
  end

  def container
    'bottles'
  end 

  def to_s
    "#{quantity} #{container}"
  end

  def self.for(number)
    registry.find{ |candidate| candidate.handles?(number) }.new(number)
  end

  def self.handles?(number)
    true
  end

  def self.registry
    @registry ||= [BottleNumber]
  end

  def self.register(candidate)
    registry.prepend(candidate)
  end

  def self.inherited(candidate)
    register(candidate)
  end
end

class BottleNumber0 < BottleNumber
  def sucessor
    BottleNumber.for(99)
  end

  def action
    'Go to the store and buy some more'
  end

  def quantity
    'no more'
  end

  def self.handles?(number)
    number.zero?
  end
end

class BottleNumber1 < BottleNumber
  def container
    'bottle'
  end

  def pronoun
    'it'
  end

  def self.handles?(number)
    number == 1
  end
end 

class BottleNumber6 < BottleNumber
  def quantity
    '1'
  end

  def container
    'six-pack'
  end

  def self.handles?(number)
    number == 6
  end
end