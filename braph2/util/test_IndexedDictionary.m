% test IndexedDictionary

key1 = 'Key 1';
value1 = DummyCopiableObject('Obj 1');

key2 = 'Key 2';
value2 = DummyCopiableObject('Obj 2');

key3 = 'Key 3';
value3 = DummyCopiableObject('Obj 3');

key4 = 'Key 4';
value4 = DummyCopiableObject('Obj 4');

key5 = 'Key 5';
value5 = DummyCopiableObject('Obj 5');

key6 = 'Key 6';
value6 = DummyCopiableObject('Obj 6');

%% Test 1: Basic Functions
keys = {key1, key2, key3, key4};
values = {value1, value2, value3, value4};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

assert(ischar(idict.tostring()), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.tostring() must return a string.')
assert(isequal(idict.getValueClass(), 'DummyCopiableObject'), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getValueClass() does not work.')

%% Test 2: Inspection Functions
keys = {key1, key2, key3, key4};
values = {value1, value2, value3, value4};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

assert(isequal(idict.length(), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.length() does not work.')

assert(isequal(idict.containsIndex(2), 1), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.containsIndex() does not work.')
assert(isequal(idict.contains(2), 1), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.contains() does not work.')
assert(isequal(idict.containsKey('Key 3'), 1), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.containsKey() does not work.')
assert(isequal(idict.contains('Key 3'), 1), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.contains() does not work.')
assert(isequal(idict.containsValue(value4), 1), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.containsValue() does not work.')
assert(isequal(idict.contains(value4), 1), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.contains() does not work.')

assert(isequal(idict.getIndexFromKey('Key 1'), 1), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getIndexFromKey() does not work.')
assert(isequal(idict.getIndex('Key 1'), 1), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getIndex() does not work.')
assert(isequal(idict.getIndexFromValue(value4), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getIndexFromValue() does not work.')
assert(isequal(idict.getIndexFromValueAll(value4), {4}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getIndexFromValueAll() does not work.')
assert(isequal(idict.getIndex(value4), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getIndex() does not work.')

assert(isequal(idict.getKeys(), keys), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getKeys() does not work.')
assert(isequal(idict.getKeyFromIndex(2), 'Key 2'), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getKeyFromIndex() does not work.')
assert(isequal(idict.getKey(2), 'Key 2'), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getKey() does not work.')
assert(isequal(idict.getKeyFromValue(value2), 'Key 2'), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getKeyFromValue() does not work.')
assert(isequal(idict.getKey(value2), 'Key 2'), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getKey() does not work.')
assert(isequal(idict.getKeyFromValueAll(value2), {'Key 2'}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getKeyFromValueAll() does not work.')

assert(isequal(idict.getValues(), values), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getValues() does not work.')
assert(isequal(idict.getValueFromIndex(3), value3), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getValueFromIndex() does not work.')
assert(isequal(idict.getValue(3), value3), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getValueFromIndex() does not work.')
assert(isequal(idict.getValueFromKey('Key 3'), value3), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getValueFromKey() does not work.')
assert(isequal(idict.getValue('Key 3'), value3), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_OUTPUT], ...
    'IndexedDictionary.getValue() does not work.')
 
%% Test 3: Add
keys = {key1, key2, key3, key4};
values = {value1, value2, value3, value4};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

idict.add(key6, value6)
assert(isequal(idict.length(), 5), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.add() does not work.')
assert(isequal(idict.getValue(5), value6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.add() does not work.')

idict.add(key5, value5, 5)
assert(isequal(idict.length(), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.add() does not work.')
assert(isequal(idict.getValue(5), value5) && isequal(idict.getValue(6), value6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.add() does not work.')

%% Test 4: Remove
keys = {key1, key2, key3, key4, key5, key6};
values = {value1, value2, value3, value4, value5, value6};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

idict.remove(4);
assert(isequal(idict.length(), 5), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.remove() does not work.')
assert(isequal(idict.getValue(idict.length()), value6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.remove() does not work.')

idict.remove(1);
idict.remove(5);
assert(isequal(idict.getValues(), {value2, value3, value5}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.remove() does not work.')

%% Test 5: Replace
keys = {key1, key2, key3, key4};
values = {value1, value2, value3, value4};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

idict.replace(key5, value5, 4);

idict.replace(key5, value5, 4);
assert(isequal(idict.length(), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.replace() does not work.')
assert(isequal(idict.getKey(4), key5) && isequal(idict.getValue(4), value5), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.replace() does not work.')

idict.replaceKey(key5, key4);
assert(isequal(idict.length(), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.replaceKey() does not work.')
assert(isequal(idict.getKey(4), key4) && isequal(idict.getValue(4), value5), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.replaceKey() does not work.')

idict.replaceValue(value5, value4);
assert(isequal(idict.length(), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.replaceValue() does not work.')
assert(isequal(idict.getKey(4), key4) && isequal(idict.getValue(4), value4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.replaceValue() does not work.')

idict.replaceValueAll(value4, value6);
assert(isequal(idict.length(), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.replaceValueAll() does not work.')
assert(isequal(idict.getKey(4), key4) && isequal(idict.getValue(4), value6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.replaceValueAll() does not work.')

%% Test 6: Invert
keys = {key1, key2, key3, key4};
values = {value1, value2, value3, value4};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

idict.invert(1, 4);
idict.invert(3, 2);
assert(isequal(idict.length(), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.invert() does not work.')
assert(isequal(idict.getKeys(), {key4, key3, key2, key1}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.invert() does not work.')
 
%% Test 7: Move to
keys = {key1, key2, key3, key4};
values = {value1, value2, value3, value4};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

idict.move_to(1, 4);
idict.move_to(1, 3);
idict.move_to(1, 2);
assert(isequal(idict.length(), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_to() does not work.')
assert(isequal(idict.getKeys(), {key4, key3, key2, key1}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_to() does not work.')

%% Test 8: Remove all
keys = {key1, key2, key3, key4, key5, key6};
values = {value1, value2, value3, value4, value5, value6};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

selected = idict.remove_all([1 3 6]);
assert(isequal(idict.length(), 3), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.remove_all() does not work.')
assert(isequal(idict.getKeys(), {key2, key4, key5}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.remove_all() does not work.')
assert(isequal(selected, []), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.remove_all() does not work.')

%% Test 9: Move up
keys = {key1, key2, key3, key4, key5, key6};
values = {value1, value2, value3, value4, value5, value6};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

selected = idict.move_up([1 2 4 6]);
assert(isequal(idict.length(), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_up() does not work.')
assert(isequal(idict.getKeys(), {key1, key2, key4, key3, key6, key5}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_up() does not work.')
assert(isequal(selected, [1 2 3 5]), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_up() does not work.')

%% Test 10: Move down
keys = {key1, key2, key3, key4, key5, key6};
values = {value1, value2, value3, value4, value5, value6};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

selected = idict.move_down([1 3 5 6]);
assert(isequal(idict.length(), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_down() does not work.')
assert(isequal(idict.getKeys(), {key2, key1, key4, key3, key5, key6}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_down() does not work.')
assert(isequal(selected, [2 4 5 6]), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_down() does not work.')

%% Test 11: Move to top
keys = {key1, key2, key3, key4, key5, key6};
values = {value1, value2, value3, value4, value5, value6};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

selected = idict.move_to_top([1 3 5 6]);
assert(isequal(idict.length(), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_to_top() does not work.')
assert(isequal(idict.getKeys(), {key1, key3, key5, key6, key2, key4}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_to_top() does not work.')
assert(isequal(selected, [1 2 3 4]), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_to_top() does not work.')

%% Test 12: Move to bottom
keys = {key1, key2, key3, key4, key5, key6};
values = {value1, value2, value3, value4, value5, value6};
idict = IndexedDictionary('DummyCopiableObject', keys, values);

selected = idict.move_to_bottom([1 3 5 6]);
assert(isequal(idict.length(), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_to_top() does not work.')
assert(isequal(idict.getKeys(), {key2, key4, key1, key3, key5, key6}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_to_top() does not work.')
assert(isequal(selected, [3 4 5 6]), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_FUNC], ...
    'IndexedDictionary.move_to_top() does not work.')

%% Test 13: Deep copy
key100 = 'Key 100';
value100 = DummyCopiableObject(DummyObject('Deep Obj 100'));

key200 = 'Key 200';
value200 = DummyCopiableObject(DummyObject('Deep Obj 200'));

idict = IndexedDictionary('DummyCopiableObject', {key100, key200}, {value100, value200});

idict_copy = idict.copy();
assert(all(cellfun(@(value_copy) isa(value_copy, 'DummyCopiableObject'), idict_copy.getValues())), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_COPY], ...
    'IndexedDictionary.copy() does not work. Copied values should be all of class DummyCopiableObject.')
assert(all(cellfun(@(value, value_copy) value ~= value_copy, idict.getValues(), idict_copy.getValues())), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_COPY], ...
    'IndexedDictionary.copy() does not work. Copied values should point to a copied object.')
assert(all(cellfun(@(key, key_copy) isequal(key, key_copy), idict.getKeys(), idict_copy.getKeys())), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_COPY], ...
    'IndexedDictionary.copy() does not work. Copied keys should be the same as the original.')

value100_copy = idict_copy.getValue(1);
value100_copy.name = 'Deep Obj 100 CHANGED to STR';
value200_copy = idict_copy.getValue(2);
value200_copy.name = 'Deep Obj 200 CHANGED to STR';
assert(all(cellfun(@(value) isa(value.name, 'DummyObject'), idict.getValues())), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_COPY], ...
    'IndexedDictionary.copy() does not work. Original values should still be all of class DummyObject.')
assert(all(cellfun(@(value_copy) ischar(value_copy.name), idict_copy.getValues())), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.BUG_COPY], ...
    'IndexedDictionary.copy() does not work. Copied values should be all strings.')
