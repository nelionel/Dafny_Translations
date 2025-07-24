datatype IndexedNum = IndexedNum(index: int, value: int, digitSum: int)

method order_by_points(nums: seq<int>) returns (result: seq<int>)
    ensures |result| == |nums|
    ensures multiset(result) == multiset(nums)
{
    if |nums| == 0 {
        return [];
    }
    
    // Create indexed numbers with digit sums
    var indexedNums := seq(|nums|, i requires 0 <= i < |nums| => 
        IndexedNum(i, nums[i], digit_sum(nums[i])));
    
    // Sort the indexed numbers
    var sortedIndexed := sort_indexed_nums(indexedNums);
    
    // Extract just the values
    result := seq(|sortedIndexed|, i requires 0 <= i < |sortedIndexed| => 
        sortedIndexed[i].value);
}

function digit_sum(n: int): int
{
    if n >= 0 then
        digit_sum_positive(n)
    else
        digit_sum_negative(n)
}

function digit_sum_positive(n: int): int
    requires n >= 0
    decreases n
{
    if n < 10 then n
    else (n % 10) + digit_sum_positive(n / 10)
}

function digit_sum_negative(n: int): int
    requires n < 0
{
    var abs_n := -n;
    var total := digit_sum_positive(abs_n);
    var first_digit := get_first_digit(abs_n);
    total - 2 * first_digit
}

function get_first_digit(n: int): int
    requires n > 0
    decreases n
{
    if n < 10 then n
    else get_first_digit(n / 10)
}

method sort_indexed_nums(nums: seq<IndexedNum>) returns (sorted: seq<IndexedNum>)
    ensures |sorted| == |nums|
    ensures multiset(sorted) == multiset(nums)
    ensures forall i, j :: 0 <= i < j < |sorted| ==> 
        (sorted[i].digitSum < sorted[j].digitSum || 
         (sorted[i].digitSum == sorted[j].digitSum && sorted[i].index < sorted[j].index))
{
    if |nums| <= 1 {
        return nums;
    }
    
    sorted := merge_sort_indexed(nums);
}

method merge_sort_indexed(nums: seq<IndexedNum>) returns (sorted: seq<IndexedNum>)
    ensures |sorted| == |nums|
    ensures multiset(sorted) == multiset(nums)
    ensures forall i, j :: 0 <= i < j < |sorted| ==> 
        (sorted[i].digitSum < sorted[j].digitSum || 
         (sorted[i].digitSum == sorted[j].digitSum && sorted[i].index < sorted[j].index))
    decreases nums
{
    if |nums| <= 1 {
        return nums;
    }
    
    var mid := |nums| / 2;
    var left := nums[..mid];
    var right := nums[mid..];
    
    var sorted_left := merge_sort_indexed(left);
    var sorted_right := merge_sort_indexed(right);
    
    sorted := merge_indexed(sorted_left, sorted_right);
}

method merge_indexed(left: seq<IndexedNum>, right: seq<IndexedNum>) returns (merged: seq<IndexedNum>)
    requires forall i, j :: 0 <= i < j < |left| ==> 
        (left[i].digitSum < left[j].digitSum || 
         (left[i].digitSum == left[j].digitSum && left[i].index < left[j].index))
    requires forall i, j :: 0 <= i < j < |right| ==> 
        (right[i].digitSum < right[j].digitSum || 
         (right[i].digitSum == right[j].digitSum && right[i].index < right[j].index))
    ensures |merged| == |left| + |right|
    ensures multiset(merged) == multiset(left) + multiset(right)
    ensures forall i, j :: 0 <= i < j < |merged| ==> 
        (merged[i].digitSum < merged[j].digitSum || 
         (merged[i].digitSum == merged[j].digitSum && merged[i].index < merged[j].index))
{
    merged := [];
    var i, j := 0, 0;
    
    while i < |left| || j < |right|
        invariant 0 <= i <= |left|
        invariant 0 <= j <= |right|
        invariant |merged| == i + j
        invariant multiset(merged) == multiset(left[..i]) + multiset(right[..j])
        invariant forall k, l :: 0 <= k < l < |merged| ==> 
            (merged[k].digitSum < merged[l].digitSum || 
             (merged[k].digitSum == merged[l].digitSum && merged[k].index < merged[l].index))
    {
        if i >= |left| {
            merged := merged + [right[j]];
            j := j + 1;
        } else if j >= |right| {
            merged := merged + [left[i]];
            i := i + 1;
        } else if should_come_first(left[i], right[j]) {
            merged := merged + [left[i]];
            i := i + 1;
        } else {
            merged := merged + [right[j]];
            j := j + 1;
        }
    }
}

predicate should_come_first(a: IndexedNum, b: IndexedNum)
{
    a.digitSum < b.digitSum || (a.digitSum == b.digitSum && a.index < b.index)
}