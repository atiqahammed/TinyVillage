// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.7;

// import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
// import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Receiver.sol";

// contract NftStaker {
//     IERC1155 public parentNFT;

//     struct Stake {
//         uint256 tokenId;
//         uint256 amount;
//         uint256 timestamp;
//     }

//     // map staker address to stake details
//     mapping(address => Stake) public stakes;

//     // map staker to total staking time 
//     mapping(address => uint256) public stakingTime;    

//     constructor(address contractAdddress) {
//         parentNFT = IERC1155(contractAdddress); // Change it to your NFT contract addr
//     }

//     function stake(uint256 _tokenId, uint256 _amount) public {
//         stakes[msg.sender] = Stake(_tokenId, _amount, block.timestamp); 
//         parentNFT.safeTransferFrom(msg.sender, address(this), _tokenId, _amount, "0x00");
//     } 

//     function unstake() public {
//         parentNFT.safeTransferFrom(address(this), msg.sender, stakes[msg.sender].tokenId, stakes[msg.sender].amount, "0x00");
//         stakingTime[msg.sender] += (block.timestamp - stakes[msg.sender].timestamp);
//         delete stakes[msg.sender];
//     }      

//      function onERC1155Received(
//         address operator,
//         address from,
//         uint256 id,
//         uint256 value,
//         bytes calldata data
//     ) external returns (bytes4) {
//         return bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"));
//     }

// }

// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;
// import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
// import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
// contract NftStaker {
//     //IERC721 public parentNFT;
//     uint256 public totalStaked;
//     struct Stake {
//         uint24 tokenId;
//         uint48 timestamp;
//         address owner;
//         address parentNft;
//     }
//     event NFTStaked(address owner, uint256 tokenId, uint256 value);
//     event NFTUnstaked(address owner, uint256 tokenId, uint256 value);
//     event Claimed(address owner, uint256 amount);
//     mapping(uint256 => Stake) public vault;
//     constructor() {
//         //parentNFT = IERC721(0x1482717Eb2eA8Ecd81d2d8C403CaCF87AcF04927);
//     }
//     function stake(uint256 tokenId ,address NftAddress) external {
//         totalStaked ++;
//         IERC721 parentNFT = IERC721(NftAddress);
//         require(parentNFT.ownerOf(tokenId) == msg.sender, "not your token");
//         require(vault[tokenId].tokenId == 0, 'already staked');
//         parentNFT.transferFrom(msg.sender, address(this), tokenId);
//         vault[tokenId] = Stake({
//             owner: msg.sender,
//             tokenId: uint24(tokenId),
//             timestamp: uint48(block.timestamp),
//             parentNft: address(NftAddress)
//         });
//     }
//     function unstake(uint256 tokenId) external {
//         totalStaked-- ;
//         Stake memory staked = vault[tokenId];
//         IERC721  parentNFT = IERC721(staked.parentNft);
//         require(staked.owner == msg.sender, "not an owner");
//         delete vault[tokenId];
//         parentNFT.transferFrom(address(this), msg.sender, tokenId);
//     }
//     function onERC721Received(
//         address,
//         address from,
//         uint256,
//         bytes calldata
//     ) external pure  returns (bytes4) {
//       require(from == address(0x0), "Cannot send nfts to Vault directly");
//       return IERC721Receiver.onERC721Received.selector;
//     }
// }

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
contract NftStaker {
    //IERC721 public parentNFT;
    uint256 public totalStaked;
    struct Stake {
        uint256 tokenId;
        uint256 timestamp;
        address owner;
        address parentNft;
    }
    event NFTStaked(address owner, uint256 tokenId, uint256 value);
    event NFTUnstaked(address owner, uint256 tokenId, uint256 value);
    event Claimed(address owner, uint256 amount);
    mapping(uint256 => Stake) public vault;
    constructor() {
        //parentNFT = IERC721(0x1482717Eb2eA8Ecd81d2d8C403CaCF87AcF04927);
    }
    function stake(uint256 tokenId ,address NftAddress) external {
        totalStaked ++;
        IERC721 parentNFT = IERC721(NftAddress);
        require(parentNFT.ownerOf(tokenId) == msg.sender, "not your token");
        require(vault[tokenId].tokenId == 0, "already staked");
        parentNFT.transferFrom(msg.sender, address(this), tokenId);
        vault[tokenId] = Stake({
            owner: msg.sender,
            tokenId: uint256(tokenId),
            timestamp: uint256(block.timestamp),
            parentNft: address(NftAddress)
        });
    }
    function unstake(uint256 tokenId) external {
        totalStaked-- ;
        Stake memory staked = vault[tokenId];
        IERC721  parentNFT = IERC721(staked.parentNft);
        require(staked.owner == msg.sender, "not an owner");
        delete vault[tokenId];
        parentNFT.transferFrom(address(this), msg.sender, tokenId);
    }
    function onERC721Received(
        address,
        address from,
        uint256,
        bytes calldata
    ) external pure  returns (bytes4) {
      require(from == address(0x0), "Cannot send nfts to Vault directly");
      return IERC721Receiver.onERC721Received.selector;
    }
}