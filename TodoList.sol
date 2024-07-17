// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract TodoList {
  struct Todo {
    string text;
    bool completed;
  }

  Todo[] public todos;

  function create(string calldata _text) external {
    todos.push(Todo({
      text: _text,
      completed: false
    }));
  }

  function updateText(uint _index, string calldata _text) external {
    // for just one todos it is cheaper
    todos[_index].text = _text;

    // for multiple todos it is cheaper
    Todo storage todo = todos[_index];
    todo.text = _text;
  }

  function get(uint _index) external view returns (string memory, bool){
     Todo storage todo = todos[_index];
     return (todo.text, todo.completed);
  }

  function toggleCompleted(uint _index) external {
    todos[_index].completed = !todos[_index].completed;
  }
}
      