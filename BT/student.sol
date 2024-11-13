// SPDX-License-Identifier: Bhide License
pragma solidity ^0.8.0;

contract StudentRegistry {
    struct Student {
        string name;
        uint256 age;
    }

    Student[] private students;

    // Event emitted when a student is added
    event StudentAdded(string name, uint256 age);

    // Receive Ether and emit an event
    receive() external payable {}
    fallback() external payable {}

    function addStudent(string memory name, uint256 age) public {
        students.push(Student(name, age));
        emit StudentAdded(name, age);
    }

    function getStudent(uint256 index) public view returns (string memory, uint256) {
        require(index < students.length, "Student not found");
        Student memory student = students[index];
        return (student.name, student.age);
    }

    function getStudentCount() public view returns (uint256) {
        return students.length;
    }
}
