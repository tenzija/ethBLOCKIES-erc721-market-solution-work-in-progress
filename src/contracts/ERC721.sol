// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";
import "./libraries/Counters.sol";

contract ERC721 is ERC165, IERC721 {

    using SafeMath for uint;
    using Counters for Counters.Counter;

    // event Transfer(
    //     address indexed from, 
    //     address indexed to, 
    //     uint indexed tokenId
    // );

    // event Approval(
    //     address indexed owner,
    //     address indexed approved,
    //     uint indexed tokenId
    // );
    
    // mapping from token id to the owner
    mapping(uint => address) private _tokenOwner;
    
    // mapping from owner to number of owned tokens
    mapping(address => Counters.Counter) private _ownedTokensCount;

    // mapping from token id to approved addresses
    mapping(uint => address) private _tokenApprovals;

    constructor() {
        _registerInterface(bytes4(keccak256("balanceOf(bytes4)")));
        _registerInterface(bytes4(keccak256("ownerOf(bytes4)")));
        _registerInterface(bytes4(keccak256("transferFrom(bytes4)")));
    }

    function balanceOf(address _owner) public view override returns(uint) {
        require(_owner != address(0), "ERC721: owner quary for non-existent token");
        return _ownedTokensCount[_owner].current();
    }

    function ownerOf(uint _tokenId) public view override returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "ERC721: owner quary for non-existent token");
        return owner;
    }    

    function _exists(
        uint _tokenId
    )
        internal
        view
        returns(bool)
    {
        // setting the address of nft owner to check the mapping
        // of the address from _tokeOwner at the _tokenId
        address _owner = _tokenOwner[_tokenId];
        // returns trurhiness the address is not zero
        return _owner != address(0);
    }

    function _mint(
        address _to, 
        uint _tokenId
    )
        internal
        virtual
    {
        // require that the address isnt zeto
        require(_to != address(0), "ERC721: minting to the zero address");
        // requires that the token does not already exist
        require(!_exists(_tokenId), "ERC721: token already minted");
        // we are adding a new address with a token id for minting
        _tokenOwner[_tokenId] = _to;
        // keeping track of each address that is minting and adding one
        _ownedTokensCount[_to].increment();

        emit Transfer(address(0), _to, _tokenId);
    }

    function _transferFrom(address _from, address _to, uint _tokenId) internal {
        require(_to != address(0), "ERC721: cant transfer to address with zero value");
        require(ownerOf(_tokenId) == _from, "ERC721: cant transfer a token that the address doesnt own");

        _ownedTokensCount[_from].decrement();
        _ownedTokensCount[_to].increment();

        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint _tokenId) public override {
        require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);
    }

    function approve(address _to, uint _tokenId) public override payable {
        address _owner = ownerOf(_tokenId);
        require(_to != _owner, "ERC721: cant approv current owner");
        require(msg.sender == _owner, "ERC721: current caller is not the owner of the token");
        _tokenApprovals[_tokenId] = _to;
        emit Approval(_owner, _to, _tokenId);

    }

    function isApprovedOrOwner(address _spender, uint _tokenId) internal view returns(bool) {
        require(_exists(_tokenId), "ERC721: token does not exist");
        address _owner = ownerOf(_tokenId);
        return(_spender == _owner);
    }

}