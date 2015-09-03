# (1, 0, 1, 5, 0, 0, 0, 0) => false
# (1, 0, 1, 5, 0, 0, 2, 4) => true
# (1,0,1,1,0,0,-1,0) => false
# (1,0,2,0,0,0,3,0) => true
#
def solution(k, l, m, n, p, q, r, s)
    if p == r # segment 2 is vertical
        t, u, v, w = p, q, r, s
        p, q, r, s = k, l, m, n
        k, l, m, n = t, u, v, w
    end

    if k == m # at least segment 1 is vertical
        # note: could flip the plan and call again with horizontal lines
        if p == r # segment 2 is too
            return (k == p) && !(q>[l,n].max && q>[l,n].max || q<[l,n].min && s<[l,n].min) # same X && partly common
        else # segment 2 is not vertical, so crosses
          puts 'in here'
            a2 = (s-q).to_f / (r-p)
            b2 = q - a2 * p
            x = k
            y = a2 * x + b2
            return between(x, y, k, l, m, n, p, q, r, s)
        end
    else # none of the segments is vertical
        a1 = (n-l).to_f / (m-k)
        a2 = (s-q).to_f / (r-p)
        b1 = l - a1 * k
        b2 = q - a2 * p

        #a1.x + b1 = a2.x + b2
        if a1 == a2 # parallel lines
            return (b1 == b2) && !(p>[k,m].max && r>[k,m].max || p<[k,m].min && r<[k,m].min) # same line && partly common
        else # crossing lines
            x = (b2 - b1) / ( a1 - a2)
            y = a1 * x + b1
            return between(x, y, k, l, m, n, p, q, r, s)
        end
    end

    false
end

def between(x, y, k, l, m, n, p, q, r, s)
    k <= x && x <= m && p <= x && x <= r && \
    l <= y && y <= n && q <= y && y <= s
end
