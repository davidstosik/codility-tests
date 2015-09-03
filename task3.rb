# (1, 0, 1, 5, 0, 0, 0, 0) => false
# (1, 0, 1, 5, 0, 0, 2, 4) => true
# (1,0,1,1,0,0,-1,0) => false
# (1,0,2,0,0,0,3,0) => true
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
    x1low, x1high = [k,m].sort
    x2low, x2high = [p,r].sort
    y1low, y1high = [l,n].sort
    y2low, y2high = [q,s].sort

    x1low <= x && x <= x1high && x2low <= x && x <= x2high && \
    y1low <= y && y <= y1high && y2low <= y && y <= y2high
end

class Point
  attr_accessor :x, :y

  def initialize x, y
    self.x = x
    self.y = y
  end
end

class Segment
  attr_accessor :ends

  def initialize *args
    case args.count
    when 2
      self.ends = args
    when 4
      self.ends = []
      self.ends << Point.new(*args[0..1])
      self.ends << Point.new(*args[2..3])
    end
  end
end

def test
  a = Point.new 0, 4
  b = Point.new 1, 4
  c = Point.new 2, 4
  d = Point.new 3, 4
  e = Point.new 4, 4
  f = Point.new 2, 3
  g = Point.new 3, 3
  h = Point.new 4, 3
  i = Point.new 4, 2
  j = Point.new 5, 2
  k = Point.new 1, 1
  l = Point.new 2, 1
  m = Point.new 2, 0
  n = Point.new 3, 0
  o = Point.new 4, 0
  p = Point.new 0, 0
  q = Point.new 5, 5

  segments = [
    Segment.new(p, q),
    Segment.new(a, c),
    Segment.new(b, l),
    Segment.new(d, j),
    Segment.new(e, i),
    Segment.new(f, h),
    Segment.new(g, k),
    Segment.new(g, n),
    Segment.new(m, o),
  ]

  tests = {
    [ segments[1], segments[2] ] => true,
    [ segments[1], segments[6] ] => false,
    [ segments[2], segments[6] ] => true,
    [ segments[5], segments[6] ] => true,
    [ segments[7], segments[6] ] => true,
    [ segments[7], segments[5] ] => true,
    [ segments[7], segments[8] ] => true,
    [ segments[5], segments[3] ] => true,
    [ segments[5], segments[4] ] => true,
    [ segments[5], segments[0] ] => true,
    [ segments[1], segments[3] ] => false,
    [ segments[1], segments[4] ] => false,
    [ segments[1], segments[0] ] => false,
    [ segments[2], segments[3] ] => false,
    [ segments[2], segments[4] ] => false,
    [ segments[1], segments[8] ] => false,
    [ segments[5], segments[8] ] => false,
    # Codility's example test cases:
    [ Segment.new(0, 1, 4, 3), Segment.new(1, 3, 2, 1) ] => true,
    [ Segment.new(0, 1, 4, 3), Segment.new(3, 2, 5, 1) ] => false,
  }

  tests.each do |pair, result|
    args = pair.map do |segment|
      segment.ends.map do |end_pt|
        [end_pt.x, end_pt.y]
      end
    end.flatten

    if solution(*args) == result
      puts 'passed'
    else
      puts 'failed'
    end
  end
  nil
end
