// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract UniswapV2SwapExamples {
    address private constant UNISWAP_V2_ROUTER =;

    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    IUniswapV2Router  private router = IUniswapV2Router(UNISWAP_V2_ROUTER);
    IERC20 private weth = IERC20(WETH);
    IERC20 private dai = IERC20(DAI);

    //Swap WETH to DAI
    function swapSingleHopExactAmountIn( uint amountIn, uint amountOutMin) {
        weth.transferFrom(msg.sender, address(this), amountIn);
        weth.approve(address(router), amountIn);

        address[] memory path;
        path = new address[](2);
        path[0] = WETH;
        path[1] = DAI;

        uint[] memory amounts = router.swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            path,
            msg.sender,
            block.timestamp
        );

        // amounts[0] =WETH amount, amounts[1] = DAI amount
        return amounts[1];

        //Swap DAI -> WETH -> USDC
        function swapMultiHopExactAmountIn( uint amountIn, uint amountOutMin) external returns (uint amountOut){
            dai.transferFrom(msg.sender, address(this), amountIn);
            dai.approve(address(router), amountIn);

            address[] memory path;
            path = new address[](3);
            path[0] = DAI;
            path[1] = WETH;
        }
    }
}