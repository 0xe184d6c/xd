const hre = require("hardhat");

async function main() {
  const MyToken = await hre.ethers.getContractFactory("MyToken");
  const token = await MyToken.deploy();
  await token.waitForDeployment();
  console.log("MyToken deployed to:", token.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});