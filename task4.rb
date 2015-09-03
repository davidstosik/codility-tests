def solution(a)
  return -2 if a.count < 2

  # mergesort is O(N*log(N))
  sorted = mergesort a

  # browse the array, O(N)
  distances = (sorted.count-1).times.map do |i|
    (sorted[i+1] - sorted[i]).abs
  end

  # mergesort is O(N*log(N))
  sorted_distances = mergesort distances

  min_distance = sorted_distances[0]
  min_distance > 1e8 ? -1 : min_distance
end

# mergesort is O(N*log(N))
def mergesort(list)
  return list if list.size <= 1
  mid   = list.size / 2
  left  = list[0, mid]
  right = list[mid, list.size]
  merge(mergesort(left), mergesort(right))
end

def merge(left, right)
  sorted = []
  until left.empty? || right.empty?
    if left.first <= right.first
      sorted << left.shift
    else
      sorted << right.shift
    end
  end
  sorted.concat(left).concat(right)
end
