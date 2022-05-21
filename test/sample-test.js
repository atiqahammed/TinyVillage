const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TinyVillage Test", function() {
  it("Should mint village", async function() {

    const accounts = await ethers.getSigners();

    const atiqsAccount = accounts[1];
    console.log('my account ', atiqsAccount.address);

    const MuNFT = await ethers.getContractFactory("MuNFT");
    const muNFT = await MuNFT.deploy();


    console.log(muNFT.address);

    const tx = await muNFT.connect(atiqsAccount).safeMint(atiqsAccount.address);
    
    let owner = await muNFT.ownerOf(0);

    console.log('my account', owner)

    // const balance = await tinyVillage.balanceOf(atiqsAccount.address, 0);
    // console.log('Atiqs balance ', balance)
    // expect(1).to.equal(Number(balance.toString()));


    const NftStaker = await ethers.getContractFactory("NftStaker");
    const nftStaker = await NftStaker.deploy();

    console.log('NftStaker', nftStaker.address);


    await muNFT.connect(atiqsAccount).setApprovalForAll(nftStaker.address, true);
    console.log('approved');
    const tx2 = await nftStaker.connect(atiqsAccount).stake(0 , muNFT.address);
    console.log('staked');

    owner = await muNFT.ownerOf(0);

    console.log(owner);


    const tx3 = await nftStaker.connect(atiqsAccount).unstake(0);
    owner = await muNFT.ownerOf(0);
    console.log(owner);

    // console.log(nftStaker.address);

    // const balance1 = await tinyVillage.balanceOf(atiqsAccount.address, 0);
    // console.log('Atiqs balance after stake',balance1);

    // const balanceStacker = await tinyVillage.balanceOf(nftStaker.address, 0);
    // console.log('Stacker balance ',balanceStacker);

    // const tx2 = await nftStaker.connect(atiqsAccount).unstake();

    // const balance2 = await tinyVillage.balanceOf(atiqsAccount.address, 0);
    // console.log('Atiqs balance after unstake',balance2);

  });
});
