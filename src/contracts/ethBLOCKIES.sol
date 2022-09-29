// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";

contract ethBLOCKIE is ERC721Connector {

    // array to store our NFTs
    string [] public ethBLOCKIES;

    mapping(string => bool) private _ethBLOCKIESexists;

    constructor () 
        ERC721Connector("ethBLOCKIE", "ethBLCK") 
    {

    }

    function mint(
        string memory _ethBLOCKIE
    )
        public
        payable
    {
        require(!_ethBLOCKIESexists[_ethBLOCKIE], "ERC721: cant mint already minted nfts");
        // this is depricated - uint _id = ethBLOCKIES.push(_ethBLOCKIE);
        ethBLOCKIES.push(_ethBLOCKIE);
        uint _id = ethBLOCKIES.length - 1;

        // .push no longer returns the length but ref to the added element   
        _mint(msg.sender, _id);

        _ethBLOCKIESexists[_ethBLOCKIE] = true;
    }

    receive() external payable {

    }
}