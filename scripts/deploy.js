async function main() {
  const NFTCollection = await ethers.getContractFactory("NFTCollection");
  const nftCollection = await NFTCollection.deploy("Your prompt description here");
  await nftCollection.deployed();
  console.log("NFTCollection deployed to:", nftCollection.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
