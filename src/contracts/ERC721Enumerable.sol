// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";
import "./interfaces/IERC721Enumerable.sol";

contract ERC721Enumerable is ERC721, IERC721Enumerable {

    uint[] private _allTokens;

    // mapping from tokenId to postion in _allTokens array
    mapping(uint => uint) private _allTokensIndex;

    // mapping of owner to list of all owner token ids
    mapping(address => uint[]) private _ownedTokens;

    // mapping from token id index of the owner tokens list
    mapping(uint => uint) private _ownedTokensIndex;

    //function tokenByIndex(uint _index) external view returns (uint)

    //function tokenOfOwnerByIndex(address _owner, uint _index) external view returns (uint)

    constructor() {
        _registerInterface(bytes4(keccak256("totalSupply(bytes4)")));
        _registerInterface(bytes4(keccak256("tokenByIndex(bytes4)")));
        _registerInterface(bytes4(keccak256("tokenOfOwnerByIndex(bytes4)")));
    }

    function _mint(
        address _to, 
        uint _tokenId
    ) 
        override(ERC721)
        internal
    {
        super._mint(_to, _tokenId);

        _addTokensToAllTokenEnumeration(_tokenId);
        _addTokensToOwnerEnumeration(_to, _tokenId);
    }

    // add tokens to the _allTokens array and set the position of the tokens indexes
    function _addTokensToAllTokenEnumeration(uint _tokenId) private {
        _allTokensIndex[_tokenId] = _allTokens.length;
        _allTokens.push(_tokenId);
    }

    function _addTokensToOwnerEnumeration(address _to, uint _tokenId) private {
        _ownedTokensIndex[_tokenId] = _ownedTokens[_to].length;
        _ownedTokens[_to].push(_tokenId);
    }

        // return total supply of the _allTokens array
    function totalSupply() public view override returns (uint) {
        return _allTokens.length;
    }

    function tokenByIndex(uint _index) public view override returns (uint) {
        require(_index <= totalSupply(), "ERC721: global index is out of bounds");
        return _allTokens[_index];
    }

    function tokenOfOwnerByIndex (address _owner, uint _index) public view override returns (uint) {
        require(_index <= balanceOf(_owner), "ERC721: owner index is out of bounds");
        return _ownedTokens[_owner][_index];
    }
}