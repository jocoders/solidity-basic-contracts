// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract TimeLock {
  error NotOwnerError();
  error TxFailedError();
  error AlreadyQueuedError(bytes32 txId);
  error TimeStampNotInRangeError(uint blockTimestamp, uint timestamp);
  error NotQueuedTxid(bytes32 txId);
  error TimestampNotPassedError(uint blockTimestamp, uint timestamp);
  error TimestampExpiredError(uint blockTimestamp, uint timestamp);


  uint public constant MIN_DELAY = 10;
  uint public constant MAX_DELAY = 1000;
  uint public constant GRACE_PERIOD = 1000;

  event Queue(
    bytes32 indexed txId,
    address indexed target, 
    uint value, 
    string func, 
    bytes data, 
    uint timestamp
  );

  event Execute(    
    bytes32 indexed txId,
    address indexed target, 
    uint value, 
    string func, 
    bytes data, 
    uint timestamp
  );

  event Cancel(bytes32 indexed txId);


  address public owner;
  mapping(bytes32 => bool) public queued;

  constructor() {
    owner = msg.sender;
  }

  receive() external payable {}

  modifier onlyOwner() {
    if (msg.sender != owner) {
      revert NotOwnerError();
    }
    _;
  }

  function getTxId(
    address _target, 
    uint _value, 
    string calldata _func, 
    bytes calldata _data,
    uint _timestamp
  ) public pure returns (bytes32 txId) {
    return keccak256(
      abi.encode(
        _target, _value, _func, _data, _timestamp
      )
    );
  }

  function queue(
    address _target, 
    uint _value, 
    string calldata _func, 
    bytes calldata _data,
    uint _timestamp
    ) external onlyOwner {
      // create tx id
       bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
      // check tx id unique
      if (queued[txId]) {
        revert AlreadyQueuedError(txId);
      }
      // check timestamp 
      if (_timestamp < block.timestamp + MIN_DELAY || _timestamp > block.timestamp + MAX_DELAY) {
        revert TimeStampNotInRangeError(block.timestamp, _timestamp);
      }
      // queue transaction
      queued[txId] = true;

      emit Queue(txId, _target, _value, _func, _data, _timestamp);

    }


  function execute(    address _target, 
    uint _value, 
    string calldata _func, 
    bytes calldata _data,
    uint _timestamp) external payable onlyOwner returns (bytes memory) {
      bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
      // check tx is queued
      if (!queued[txId]) {
        revert NotQueuedTxid(txId);
      }
      // check block.timestamp > _timestamp
      if (block.timestamp < _timestamp) {
        revert TimestampNotPassedError(block.timestamp, _timestamp);
      }
      if (block.timestamp > _timestamp + GRACE_PERIOD) {
        revert TimestampExpiredError(block.timestamp, _timestamp + GRACE_PERIOD);
      }
      // delete tx from queue
      queued[txId] = false;

      bytes memory data;
      if (bytes(_func).length > 0) {
        data = abi.encodePacked(
          bytes4(keccak256(bytes(_func))), _data 
        );
      } else {
        data = _data;
      }
 
      // execute the tx
      (bool ok, bytes memory res) = _target.call{value: _value}(data);
      if (!ok) {
        revert TxFailedError();
      }

      emit Execute(txId, _target, _value, _func, _data, _timestamp);

      return res;
    }

    function cancel(bytes32 _txId) external onlyOwner {
      if (!queued[_txId]) {
        revert NotQueuedTxid(_txId);
      }
      queued[_txId] = false;
      emit Cancel(_txId);
    }
}

contract TestTimeLock {
  address public timeLock;

  constructor(address _timeLock) {
    timeLock = _timeLock;
  } 

  function test() external {
    require(msg.sender == timeLock);
    // more code here such as
    
    // - upgrade contract
    // - transfer funds
    // - switch price oracle
  }

  function getTimestamp() external view returns (uint) {
    return block.timestamp + 100;
  }
}
      