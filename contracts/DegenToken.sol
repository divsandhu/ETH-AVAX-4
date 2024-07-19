// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    // Initialize the token with a name and symbol
    constructor() ERC20("Degen", "DGN") {}

    // Only the owner can mint new tokens
    function mint(address recipient, uint256 quantity) external onlyOwner {
        _mint(recipient, quantity);
    }

    // Function to burn tokens
    function burn(uint256 quantity) public override {
        super.burn(quantity);
    }

    // Function to transfer tokens
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    // Custom event to log NFT-based transactions
    event NFTTransfer(address indexed sender, address indexed recipient, uint256 indexed tokenId, string tokenName);

    // Structure to define an NFT
    struct NFT {
        uint256 tokenId;
        string tokenName;
        uint256 tokenPrice;
        address tokenOwner;
    }

    // Mapping from tokenId to NFT details
    mapping(uint256 => NFT) private nftRegistry;
    uint256 private nftCounter;

    // Function to add a new NFT to the registry
    function registerNFT(string memory _tokenName, uint256 _tokenPrice) external onlyOwner {
        nftCounter++;
        NFT memory newNFT = NFT(nftCounter, _tokenName, _tokenPrice, msg.sender);
        nftRegistry[nftCounter] = newNFT;
    }
    function redeemNFT(uint256 _tokenId) external {
        require(_tokenId > 0 && _tokenId <= nftCounter, "Invalid token ID");
        NFT memory selectedNFT = nftRegistry[_tokenId];

        require(balanceOf(msg.sender) >= selectedNFT.tokenPrice, "Insufficient balance");

        _transfer(msg.sender, owner(), selectedNFT.tokenPrice); // Transfer tokens to the owner
        selectedNFT.tokenOwner = msg.sender; // Update NFT owner

        emit NFTTransfer(msg.sender, owner(), _tokenId, selectedNFT.tokenName); // Log the NFT transfer
    }
    function getNFTDetails(uint256 _tokenId) external view returns (NFT memory) {
        require(_tokenId > 0 && _tokenId <= nftCounter, "Token ID does not exist");
        return nftRegistry[_tokenId];
    }
}
