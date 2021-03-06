pragma solidity ^0.5.0;

// Chainlink requires solidity 0.4. This is a working solution if willing to drop to older Solidity.
/*

import "../../node_modules/chainlink/contracts/ChainlinkClient.sol";

contract ConvertLib is ChainlinkClient {

	address public owner;
	uint256 public minLinkBalance;
	uint256 public currentPrice; // Stores the answer from the Chainlink oracle
	uint256 private payment; // Current payment for price request jobs

	constructor(address _link, address _oracle) public {
		// Set the address for the LINK token for the network.
		if(_link == address(0)) {
			// Useful for deploying to public networks.
			setPublicChainlinkToken();
		} else {
			// Useful if you're deploying to a local network.
			setChainlinkToken(_link);
		}
		setChainlinkOracle(_oracle);
	}

	function setPayment(uint256 amount) public onlyOwner {
		payment = amount;
	}

	// Converts the amount in one token to another, danger: Web3 BigNumber
	function convert(uint256 amount, string inputSymbol, string outputSymbol) public pure returns (uint256 convertedAmount) {
		// TODO Wait for data to be available from request (wait for Event fire?)
		requestPriceInETH(inputSymbol);
		uint256 priceInputETH = currentPrice;
		requestPriceInETH(outputSymbol);
		uint256 priceOutputETH = currentPrice;
		return (priceInputETH / priceOutputETH) * amount;
	}

	// Returns the number of tokens for a given USD input in 10^-18 of a token, danger: Web3 BigNumber
	function usdToTokens(uint256 amountInCents, string symbol) public pure returns (uint256 price) {
		requestUSDtoTokens(symbol);
		uint256 dollarValInGigaSD = currentPrice;
		uint256 numberOfTokens = (amountInCents * dollarValInGigaSD) / 100;
		return numberOfTokens;
	}

	// Creates a Chainlink request with the uint256 multiplier job
	function requestPriceInETH(string symbol) public onlyOwner {
		// Check LINK balance is sufficient
		require(Interface(address("0x514910771af9ca656af840dff83e8264ecf986ca")).balanceOf(address(this)) >= minLinkBalance,
				"LINK balance of conversion contract is insufficient");
		bytes32 jobId = keccak256(block.number, msg.data, nonce++);
		// newRequest takes a JobID, a callback address, and callback function as input
		Chainlink.Request memory req = buildChainlinkRequest(jobId, this, this.fulfill.selector);
		// Adds a URL with the key "get" to the request parameters
		req.add("get", "https://min-api.cryptocompare.com/data/price?fsym=" + symbol + "&tsyms=ETH");
		// Uses input param (dot-delimited string) as the "path" in the request parameters
		req.add("path", "ETH");
		// Request integer value in wei - may cause issues with web3 BigNumber
		req.addInt("times", 1000000000000000000);
		// Sends the request with the amount of payment specified to the oracle
		sendChainlinkRequest(req, payment);
	}

	// Creates a Chainlink request with the uint256 multiplier job
	function requestUSDtoTokens(string symbol) public onlyOwner {
		// Check LINK balance is sufficient
		require(Interface(address("0x514910771af9ca656af840dff83e8264ecf986ca")).balanceOf(address(this)) >= minLinkBalance,
				"LINK balance of conversion contract is insufficient");
		bytes32 jobId = keccak256(block.number, msg.data, nonce++);
		// newRequest takes a JobID, a callback address, and callback function as input
		Chainlink.Request memory req = buildChainlinkRequest(jobId, this, this.fulfill.selector);
		// Adds a URL with the key "get" to the request parameters
		req.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USD&tsyms=" + symbol);
		// Uses input param (dot-delimited string) as the "path" in the request parameters
		req.add("path", symbol);
		// Request integer value in smallest denomination  - may cause issues with web3 BigNumber
		req.addInt("times", 1000000000000000000);
		// Sends the request with the amount of payment specified to the oracle
		sendChainlinkRequest(req, payment);
	}

	// Use recordChainlinkFulfillment to ensure only the requesting oracle can fulfill. Outputs uint256.
	function fulfill(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId) {
		currentPrice = _price;
	}

	// withdrawLink allows the owner to withdraw any extra LINK on the contract
	function withdrawLink() public onlyOwner {
		LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
		require(link.transfer(msg.sender, link.balanceOf(address(this))), "Unable to transfer");
	}

	// Set the minimumLinkBalance of the contract to cover jobs.
    function setMinLinkBalance(uint256 amount) public onlyOwner {
        minLinkBalance = amount;
    }

	modifier onlyOwner() {
		require(msg.sender == owner, "Message sender must be contract owner");
		_;
	}
}
*/