% test Permutation

%% Test 1 Static Method Non Longitudinal
values_1 = ['a' 'b' 'c'];
values_2 = ['d' 'e' 'f'];
values = [values_1 values_2];

[permutation_1, permutation_2] = Permutation.permute(values_1, values_2, 0);
permutated_values = [permutation_1  permutation_2];

assert(~isempty(permutation_1), ...
    ['BRAPH:AnalysisDTI:Permutation'], ...
    ['Permutation.getPermutation() not working']) %#ok<*NBRAK>

assert(~isempty(permutation_2), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['Permutation.getPermutation() not working'])

assert(~isequal(permutation_1, permutation_2), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['Permutation.getPermutation() output repeats'])

assert(isequal(numel(permutation_1), numel(permutation_2)), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['Permutation.getPermutation() size of output is different'])

assert(isequal(numel(permutation_1), numel(values_1)), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['Permutation.getPermutation() size of output is not correct'])

assert(isequal(numel(values), numel(permutated_values)), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['Permutation.getPermutation() size of all output is not correct'])

for i = 1:1:numel(values)
    assert(any(ismember(permutated_values, values(i))), ...
        ['BRAPH:AnalysisDTI:getMeasurementID'], ...
        ['Permutation.getPermutation() not all elements are present'])
end

%% Test 2 Longitudinal
group_1 = ['a' 'b' 'c' 'd' 'e' 'f'];
group_2 = ['s' 't' 'u' 'v' 'w' 'x'];

[permutation_1, permutation_2] = Permutation.permute(group_1, group_2, 1);

indexes = zeros(1, numel(group_1));  % get Permutation internal random indexes from group 1
for i = 1:1:numel(group_1)
    if permutation_1(i) == group_1(i)
        indexes(i) = -1;
    else
        indexes(i) = 1;
    end
end

assert(~isempty(permutation_1) && ~isempty(permutation_2), ...
    ['BRAPH:AnalysisDTI:Permutation'], ...
    ['Permutation.getPermutation() not working']) %#ok<*NBRAK>
assert(isequal(numel(permutation_1), numel(permutation_2)), ...
    ['BRAPH:AnalysisDTI:Permutation'], ...
    ['Permutation.getPermutation() not working']) %#ok<*NBRAK>
assert(isequal(numel(permutation_1), numel(group_1)), ...
    ['BRAPH:AnalysisDTI:Permutation'], ...
    ['Permutation.getPermutation() not working']) %#ok<*NBRAK>

for i = 1:1:numel(group_2)  % assert group 2 complies with indexes vector
    if indexes(i) == 1
        assert(~isequal(group_2(i), permutation_2(i)), ...
            ['BRAPH:AnalysisDTI:Permutation'], ...
            ['Permutation.getPermutation() not working']) %#ok<*NBRAK>
    else
        assert(isequal(group_2(i), permutation_2(i)), ...
            ['BRAPH:AnalysisDTI:Permutation'], ...
            ['Permutation.getPermutation() not working']) %#ok<*NBRAK>
    end
end