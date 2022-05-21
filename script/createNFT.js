const hre= require("hardhat");

// const fileoperations = require('../src/abi');

// const network = process.env.NETWORK || 'hardhat'
// const branch = process.env.BRANCH || 'develop'

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log(
    "Deploying contracts with the account:",
    deployer.address
  );

    const MuNFT = await hre.ethers.getContractFactory("MuNFT");
    // const muNFT = await MuNFT.deploy();

    // const CreaboFund = await ethers.getContractFactory("CreaboFund");
    const muNFT = MuNFT.attach('0xbE7663b6aFfe8f854F5E1ebFDC5EE132B7445B71');

    console.log(muNFT.address);

    const tx = await muNFT.connect(deployer).safeMint(deployer.address);
    
    let owner = await muNFT.ownerOf(0);

    console.log('my account', owner);

//   const AvalonNiftyToken = await hre.ethers.getContractFactory("AvalonNiftyToken");
//   const avalonNiftyToken = await hre.upgrades.deployProxy(AvalonNiftyToken, [200000, 20 ,10000]);

//   await avalonNiftyToken.deployed();

//   const jsonPath = fileoperations.getDeployedPath(network, branch);
//   const content = JSON.parse(fs.readFileSync(jsonPath).toString());
//   content.avalonNiftyToken = avalonNiftyToken.address;

//   fileoperations.writeJsonToFile(jsonPath, content);
//   console.log(colors.green("AvalonNiftyToken deployed to:", avalonNiftyToken.address));
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });