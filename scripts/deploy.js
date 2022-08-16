const main = async() => {

    const [owner,random] = await hre.ethers.getSigners();
    const accountBalance = await owner.getBalance();

    // console.log(owner.address);
    const waveFactory = await hre.ethers.getContractFactory("WavePortal");
    // console.log(waveFactory);
    const waveContract = await waveFactory.deploy({value:hre.ethers.utils.parseEther("0.01")});
    await waveContract.deployed();

    console.log("Deployed contract address: ",waveContract.address);
    console.log("Deployer address: ",owner.address);
    console.log("Account Balance: ",accountBalance.toString());
}

const runMain = async() => {
    try{
        await main();
        process.exit(0);
    }
    catch(err){
        console.log(err);
        process.exit(1);
    }
}

runMain();