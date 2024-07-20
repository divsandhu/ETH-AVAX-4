const hre = require("hardhat");

async function main() {
    const DegenToken = await hre.ethers.getContractFactory("DegenToken");
    const degenToken = await DegenToken.deploy();

    await degenToken.deployed();

    console.log("DegenToken deployed to:", degenToken.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
