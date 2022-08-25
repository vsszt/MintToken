// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
   B   A
    \ /
     AB
*/

contract B {
    function foo() public virtual returns (string memory) { return 'B'; }
}

contract A {
    function foo() public virtual returns (string memory) { return 'A'; }
}

contract AB is B, A {
    // return 'A', because parent contract A on the right
    function foo() public override(B, A) returns (string memory) {
        return super.foo();
    }
}

/**
         C
        / 
       D
      /
     F 
*/

contract C {
    function foo() public virtual returns (string memory) { return 'C'; }
}

contract D is C {
    function foo() public virtual override returns (string memory) { return 'D'; }
}

contract E is C, D {
    // return 'D'
    function foo() public virtual override(D, C) returns (string memory) {
        return super.foo();
    }
}