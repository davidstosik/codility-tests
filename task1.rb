def solution(n)
    # write your code in Ruby 2.2
    replace = {
        3 => 'Fizz',
        5 => 'Buzz',
        7 => 'Woof',
    }

    n.times do |i|
        it = i+1
        string = ''
        replace.each do |div, word|
            string << word if (it%div == 0)
        end
        string << it.to_s if string.empty?
        print string + "\n"
    end
    nil
end
