// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721Enumerable {

    function totalSupply() external view returns(uint);

    function tokenByIndex(uint _index) external view returns(uint);

    function tokenOfOwnerByIndex(address _owner, uint _index) external view returns(uint);
}