// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SafeMath.sol";

library Counters {
    using SafeMath for uint;

    struct Counter {
        uint _value;
    }

    function current(Counter storage _counter) internal view returns(uint) {
        return _counter._value;
    }

    function increment(Counter storage _counter) internal {
        _counter._value += 1;
    } 

    function decrement(Counter storage _counter) internal {
        _counter._value = _counter._value.sub(1);
    }
}

