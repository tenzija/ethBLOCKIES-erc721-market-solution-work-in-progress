// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {
    
    // functions for SafeMath operations
    // overflow for addition and subtraction
    function add(
        uint a,
        uint b
    ) 
        internal 
        pure 
        returns(uint) 
    {
        uint r = a + b;
            require(r >= a, "SafeMath: Addition Overflow");
        return r;
    } 

    function sub(
        uint a, 
        uint b
    ) 
        internal 
        pure 
        returns(uint) 
    {
        require(b <= a, "SafeMath: Subtraction Overflow");
        uint r = a - b;
        return r;
    }

    function multi(
        uint a, 
        uint b
    ) 
        internal 
        pure 
        returns(uint) 
    {
        if(a == 0) {
            return 0;
        }

        uint r = a * b;
            require(r / a == b, "SafeMath: Multiplication Overflow");
        return r;
    }

    function divide(
        uint a, 
        uint b
    ) 
        internal 
        pure 
        returns(uint) 
    {
        require(b > 0, "SafeMath: Division by Zero");
        uint r = a / b;
        return r;
    }

    function mod(
        uint a, 
        uint b
    ) 
        internal 
        pure 
        returns(uint) 
    {
        require(b != 0, "SafeMath: Modulo by Zero");
        return a % b;
    }
}