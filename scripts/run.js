const main = async() => {

    const [owner,random] = await hre.ethers.getSigners();
    // console.log(owner.address);

    console.log(random.address);
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    // console.log(waveContractFactory);
    const waveFactory = await waveContractFactory.deploy({value: hre.ethers.utils.parseEther("0.1")});
    await waveFactory.deployed();

    // console.log(waveFactory.address);

    let contractBalance = await hre.ethers.provider.getBalance(waveFactory.address);

    console.log("Contract Balance: ",hre.ethers.utils.formatEther(contractBalance));

    let wavesTotal = await waveFactory.getTotalWaves();

    // let wave = await waveFactory.wave();
    let wave = await waveFactory.wave("A message","0xsdksckssadaq");
    wave = await waveFactory.connect(random).wave("A message","0xsdksckssadaq");

    wavesTotal = await waveFactory.getTotalWaves();
    console.log(wavesTotal);

    let allWaves = await waveFactory.getAllWaves();
    console.log(allWaves);

    contractBalance = await hre.ethers.provider.getBalance(waveFactory.address);

    console.log("Contract Balance: ",hre.ethers.utils.formatEther(contractBalance));
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