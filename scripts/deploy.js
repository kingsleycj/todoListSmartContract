const hre = require("hardhat");

async function main() {
    console.log("Fetching contract factory...");
    const TodoList = await hre.ethers.getContractFactory("TodoList");
    
    console.log("Deploying contract...");
    const todoList = await TodoList.deploy();

    console.log("Waiting for deployment...");
    await todoList.deployed();

    console.log("Getting contract address...");
    const contractAddress = await todoList.address;
    
    console.log(`✅ TodoList deployed to: ${contractAddress}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log("🚨 Deployment error:", error);
        process.exit(1);
    });
