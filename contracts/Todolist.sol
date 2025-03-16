// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 *  TodoList
 *  A simple smart contract to manage a todo list with CRUD operations
 */
contract TodoList {
    struct Todo {
        uint256 id;
        string content;
        bool isCompleted;
        uint256 createdAt;
    }

    event TodoCreated(uint256 id, string content, bool isCompleted, uint256 createdAt);
    event TodoUpdated(uint256 id, string content);
    event TodoToggled(uint256 id, bool isCompleted);
    event TodoDeleted(uint256 id);

    mapping(uint256 => Todo) public todos;
    mapping(address => uint256[]) private userTodos;
    mapping(uint256 => address) private todoOwners; // Optimization for ownership check
    
    uint256 private todoCounter;

    function createTodo(string memory _content) public {
        require(bytes(_content).length > 0, "Todo content cannot be empty");
        
        uint256 todoId = todoCounter;
        todoCounter++;
        uint256 creationTime = block.timestamp;
        
        todos[todoId] = Todo({
            id: todoId,
            content: _content,
            isCompleted: false,
            createdAt: creationTime
        });
        
        userTodos[msg.sender].push(todoId);
        todoOwners[todoId] = msg.sender; // Track ownership
        
        emit TodoCreated(todoId, _content, false, creationTime);
    }

    function updateTodo(uint256 _id, string memory _content) public {
        require(bytes(_content).length > 0, "Todo content cannot be empty");
        require(_isTodoOwner(_id), "Only the todo owner can update it");
        require(_todoExists(_id), "Todo with this ID does not exist");
        require(keccak256(bytes(todos[_id].content)) != keccak256(bytes(_content)), "New content is the same as existing");
        
        todos[_id].content = _content;
        
        emit TodoUpdated(_id, _content);
    }

    function toggleCompleted(uint256 _id) public {
        require(_isTodoOwner(_id), "Only the todo owner can toggle it");
        require(_todoExists(_id), "Todo with this ID does not exist");
        
        todos[_id].isCompleted = !todos[_id].isCompleted;
        
        emit TodoToggled(_id, todos[_id].isCompleted);
    }

    function deleteTodo(uint256 _id) public {
        require(_isTodoOwner(_id), "Only the todo owner can delete it");
        require(_todoExists(_id), "Todo with this ID does not exist");
        
        uint256[] storage userTodoList = userTodos[msg.sender];
        for (uint256 i = 0; i < userTodoList.length; i++) {
            if (userTodoList[i] == _id) {
                userTodoList[i] = userTodoList[userTodoList.length - 1];
                userTodoList.pop();
                break;
            }
        }
        
        delete todos[_id];
        delete todoOwners[_id];
        
        emit TodoDeleted(_id);
    }

    function getUserTodos() public view returns (uint256[] memory) {
        return userTodos[msg.sender];
    }

    function getTodo(uint256 _id) public view returns (Todo memory) {
        require(_todoExists(_id), "Todo with this ID does not exist");
        return todos[_id];
    }

    function _todoExists(uint256 _id) private view returns (bool) {
        return todos[_id].createdAt > 0;
    }

    function _isTodoOwner(uint256 _id) private view returns (bool) {
        return todoOwners[_id] == msg.sender;
    }
}
