# (1, 0, 1, 5, 0, 0, 0, 0) => false
# (1, 0, 1, 5, 0, 0, 2, 4) => true
def solution(k, l, m, n, p, q, r, s)
    if p == r # segment 2 is vertical
        t, u, v, w = p, q, r, s
        p, q, r, s = k, l, m, n
        k, l, m, n = t, u, v, w
    end

    if k == m # at least segment 1 is vertical
        # note: could flip the plan and call again with horizontal lines
        if p == r # segment 2 is too
            return (k == p) && (l <= q && q <= n || l <= s && s <= n) # same X && partly common
        else # segment 2 is not vertical, so crosses
            a2 = (s-q).to_f / (r-p)
            b2 = q - a2 * p
            x = k
            y = a2 * x + b2
            return l <= y && y <= n && q <= y && y <= s
        end
    else # none of the segments is vertical
        a1 = (n-l).to_f / (m-k)
        a2 = (s-q).to_f / (r-p)
        b1 = l - a1 * k
        b2 = q - a2 * p

        #a1.x + b1 = a2.x + b2
        if a1 == a2 # parallel lines
            return (b1 == b2) && (k <= p && p <= m || k <= r && r <= m) # same line && partly common
        else # crossing lines
            x = (b2 - b1) / ( a1 - a2)
            return k <= x && x <= m && p <= x && x <= r
        end
    end

    false
end
