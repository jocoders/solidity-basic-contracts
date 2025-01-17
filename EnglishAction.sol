pragma solidity >=0.6.12 <0.9.0;

interface IERC721 {
  function transferFrom(address _from, address _to, uint _nftId) external;
}

contract EnglishAction {
  event Start();
  event Bid(address indexed sender, uint amount);
  event Withdraw(address indexed bidder, uint amount);
  event End(address highestBidder, uint amount);

  IERC721 public immutable nft;
  uint public immutable nftId;

  address payable public immutable seller;

  uint32 public endAt;
  bool public started;
  bool public ended;

  address public highestBidder;
  uint public highestBid;
  mapping(address => uint) public bids;

  constructor(address _nft, uint _nftId, uint _startBid) {
    nft = IERC721(_nft);
    nftId = _nftId;
    seller = payable(msg.sender);

    highestBid = _startBid;
  }

  function start() external {
    require(msg.sender == seller, "not seller");
    require(!started, "started");

    started = true;
    endAt = uint32(block.timestamp + 60);
    nft.transferFrom(seller, address(this), nftId);

    emit Start();
  }

  function bid() external payable {
    require(started, "not started");
    require(block.timestamp < endAt, "ended");
    require(msg.value > highestBid, "value < highest bid");

    if (highestBidder != address(0)) {
        bids[highestBidder] += highestBid;
    }


    highestBid = msg.value;
    highestBidder = msg.sender;

    emit Bid(msg.sender, msg.value);
  }

  function withdraw() external {
    uint bal = bids[msg.sender];
    bids[msg.sender] = 0;
    payable(msg.sender).transfer(bal);
    emit Withdraw(msg.sender, bal);
  }

  function end() external {
    require(started, "not started");
    require(!ended, "ended");
    require(block.timestamp >= endAt, "not ended");

    ended = true;
    if (highestBidder != address(0)) {
      nft.transferFrom(address(this), highestBidder, nftId);
      seller.transfer(highestBid); 
    } else {
      nft.transferFrom(address(this), seller, nftId);
    }

    emit End(highestBidder, highestBid);
  }

}