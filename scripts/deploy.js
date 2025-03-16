const hre = require("hardhat");

async function main() {
    console.log("Fetching contract factory...");
    const TodoList = await hre.ethers.getContractFactory("TodoList");
    
    console.log("Deploying contract...");
    const todoList = await TodoList.deploy();

    console.log("Waiting for deployment...");
    await todoList.waitForDeployment();

    console.log("Getting contract address...");
    const contractAddress = await todoList.getAddress();
    
    console.log(`✅ TodoList deployed to: ${contractAddress}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error("🚨 Deployment error:", error);
        process.exit(1);
    });
