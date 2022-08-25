// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

contract ERC20MultiFunction is
    ERC20,
    ERC20Burnable,
    ERC20Capped,
    ERC20Pausable,
    Ownable
{
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 cap_
    ) ERC20(name_, symbol_) ERC20Capped(cap_ * (10**decimals())) {}

    function mint(uint256 amount)
        public
        onlyOwner
    {
        super._mint(_msgSender(), amount * 10 ** decimals());
    }

    // TODO: add Pause/Unpause Switch

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);
    }

    function _mint(address account, uint256 amount)
        internal
        virtual
        override(ERC20, ERC20Capped)
    {
        super._mint(account, amount);
    }
}
