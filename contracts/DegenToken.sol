// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    constructor() ERC20("Degen", "DGN") Ownable() {}

    function mint(address recipient, uint256 quantity) external onlyOwner {
        _mint(recipient, quantity);
    }

    function burn(uint256 quantity) public override {
        super.burn(quantity);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    event NFTTransfer(address indexed sender, address indexed recipient, uint256 indexed tokenId, string tokenName);

    struct NFT {
        uint256 tokenId;
        string tokenName;
        uint256 tokenPrice;
        address tokenOwner;
    }

    mapping(uint256 => NFT) private nftRegistry;
    uint256 private nftCounter;

    function registerNFT(string memory _tokenName, uint256 _tokenPrice) external onlyOwner {
        nftCounter++;
        NFT memory newNFT = NFT(nftCounter, _tokenName, _tokenPrice, msg.sender);
        nftRegistry[nftCounter] = newNFT;
    }

    function redeemNFT(uint256 _tokenId) external {
        require(_tokenId > 0 && _tokenId <= nftCounter, "Invalid token ID");
        NFT storage selectedNFT = nftRegistry[_tokenId];

        require(balanceOf(msg.sender) >= selectedNFT.tokenPrice, "Insufficient balance");
        require(selectedNFT.tokenOwner == owner(), "NFT already redeemed");

        _transfer(msg.sender, owner(), selectedNFT.tokenPrice);
        selectedNFT.tokenOwner = msg.sender;

        emit NFTTransfer(msg.sender, owner(), _tokenId, selectedNFT.tokenName);

        // Ensure the redeemed item (NFT) is added to the player's collection
        playerItems[msg.sender].push(selectedNFT);

        // Call to burn function to reduce the player's tokens after redeeming the NFT
        burn(selectedNFT.tokenPrice);
    }

    function getNFTDetails(uint256 _tokenId) external view returns (NFT memory) {
        require(_tokenId > 0 && _tokenId <= nftCounter, "Token ID does not exist");
        return nftRegistry[_tokenId];
    }

    // Mapping to track which items (NFTs) each player owns
    mapping(address => NFT[]) private playerItems;

    // Function to get the NFTs owned by a player
    function getOwnedNFTs() external view returns (NFT[] memory) {
        return playerItems[msg.sender];
    }
}
