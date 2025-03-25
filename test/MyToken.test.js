const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MyToken", function () {
  it("Should mint 1M tokens to deployer", async function () {
    const [deployer] = await ethers.getSigners();
    const MyToken = await ethers.getContractFactory("MyToken");
    const token = await MyToken.deploy();
    
    expect(await token.balanceOf(deployer.address)).to.equal(
      ethers.parseUnits("1000000", 18)
    );
  });
});