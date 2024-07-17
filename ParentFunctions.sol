// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract E {
  event Log(string message);

  function foo() public virtual {
    emit Log("E.foo");
  }

  function bar() public virtual {
    emit Log("E.bar");
  }
}

contract F is E {
  function foo() public virtual override {
    emit Log("E.foo");
    E.foo();
  }

  function bar() public virtual override {
    emit Log("E.bar");
    super.bar();
  }
}

contract G is E {
  function foo() public virtual override {
    emit Log("G.foo");
    E.foo();
  }

  function bar() public virtual override {
    emit Log("G.bar");
    super.bar();
  }
}

contract H is F, G {
  function foo() public override(F, G) {
    emit Log("H.foo");
    F.foo();
  }

  function bar() public override(F, G) {
    emit Log("H.bar");
    super.bar();
  }
}
      