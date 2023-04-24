// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract $Hentai is ERC20, ERC20Burnable, Ownable {

    uint256 public buyTax = 0; // in basis points (1 basis point = 0.01%)
    uint256 public sellTax = 0; // in basis points

    constructor() ERC20("$Hentai", "Hnt") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

        function _transfer(address sender, address recipient, uint256 amount) internal virtual override {
    if (recipient == address(this)) {
        // apply sell tax
        uint256 taxAmount = amount * sellTax / 10000;
        super._transfer(sender, recipient, amount - taxAmount);
        super._transfer(sender, owner(), taxAmount);
    } else {
        super._transfer(sender, recipient, amount);
    }
    }


    function setBuyTax(uint256 newBuyTax) external onlyOwner {
    require(newBuyTax <= 10000, "Buy tax must be less than or equal to 10000");
    buyTax = newBuyTax;
    }

    function setSellTax(uint256 newSellTax) external onlyOwner {
    require(newSellTax <= 10000, "Sell tax must be less than or equal to 10000");
    sellTax = newSellTax;
    }

}