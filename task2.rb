def solution(s, t)
    # write your code in Ruby 2.2
    if s == t
        'NOTHING'
    elsif t.length == s.length
        recurse_swap(s, t)
    elsif t.length == s.length - 1
        recurse_delete(s, t)
    elsif t.length == s.length + 1
        recurse_insert(s, t)
    else
        'IMPOSSIBLE'
    end
end

def recurse_swap(s, t)
    if s[0] == t[0]
        recurse_swap(s[1..-1], t[1..-1])
    elsif s[0] == t[1] && s[1] == t[0]
        "SWAP #{s[0]} #{s[1]}"
    end
end

def recurse_delete(s, t)
    if s[0] == t[0]
        recurse_delete(s[1..-1], t[1..-1])
    elsif s[1..-1] == t
        "DELETE #{s[0]}"
    end
end

def recurse_insert(s, t)
    if s[0] == t[0]
        recurse_insert(s[1..-1], t[1..-1])
    elsif t[0] + s == t
        "INSERT #{t[0]}"
    end
end
