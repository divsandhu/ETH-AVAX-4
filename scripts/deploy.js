const hre = require("hardhat");

async function main() {
  // Get the contract to deploy
  const DegenToken = await hre.ethers.getContractFactory("DegenToken");

  // Deploy the contract
  const degenToken = await DegenToken.deploy();
  await degenToken.deployed();

  // Display the contract address
  console.log(`DegenToken deployed to ${degenToken.address}`);
}

// Execute the main function and handle errors
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
