# frozen_string_literal: true

class Bottles
  def initialize; end

  def song
    verses(99, 0)
  end

  def verses(last, first)
    resp = ''
    (last).downto(first).each do |i|
      resp += "#{verse(i)}\n"
    end
    resp.chomp("\n")
  end

  def verse(idx)
    "#{verse_number(idx).to_s.capitalize} #{pluralize_bottle(idx)} of milk on the wall, "\
    "#{verse_number(idx)} #{pluralize_bottle(idx)} of milk.\n"\
    "#{bottom_verse_begin(idx)}, #{verse_number(idx-1)} #{pluralize_bottle(idx-1)} of milk on the wall.\n"
  end

  def bottom_verse_begin(idx)
    case idx - 1
    when -1
      'Go to the store and buy some more'
    when 0
      'Take it down and pass it around'
    else
      'Take one down and pass it around'
    end
  end

  def verse_number(idx)
    case idx
    when -1
      '99'
    when 0
      'no more'
    else
      idx
    end
  end

  def pluralize_bottle(idx)
    idx == 1 ? 'bottle' : 'bottles'
  end

end
