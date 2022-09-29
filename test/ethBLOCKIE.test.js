const {assert} = require('chai')
const ethBLOCKIE = artifacts.require('./ethBLOCKIE')

require('chai')
.use(require('chai-as-promised'))
.should()

contract("ethBLOCKIE", (accounts) => {
    let contract // = await ethBLOCKIE.deployed()

    // testing conteiner - describe

    describe("Deployment: ", async() => {
        // test samples with writing it

        it("deploys successfuly", async() => {
            contract = await ethBLOCKIE.deployed()
            const address = contract.address

            assert.notEqual(address, "")
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)
        })

        it("name and symbol match", async() => {
            contract = await ethBLOCKIE.deployed()
            contractName = await contract.name()
            contractSymbol = await contract.symbol()

            assert.equal(contractName, "ethBLOCKIE")
            assert.equal(contractSymbol, "ethBLCK")
        })

    })

    describe("Minting: ", async() => {

        it("creates a new NFT / checks totalSupply / checks _from and _to address", async() => {
            contract = await ethBLOCKIE.deployed()
            mint = await contract.mint("https...1")
            totalSupply = await contract.totalSupply()
            addressVerification = await mint.logs[0].args

            // Success
            assert.equal(totalSupply, 1)
            assert.equal(addressVerification._from, 
                "0x0000000000000000000000000000000000000000",
                "from the contract")
            assert.equal(addressVerification._to, accounts[0], "to is the msg.sender")

            // Failure
            await contract.mint("https...1").should.be.rejected
        })
    })

    describe("Indexing: ", async() => {
        
        it('lists ethBLOCKIES', async() => {
            // Mint three new tokens
            await contract.mint('https...2')
            await contract.mint('https...3')
            await contract.mint('https...4')
            const totalSupply = await contract.totalSupply()
            // Loop through list and grab KBirdz from list
            let result = []
            let ethBLOCKIE
            for(i = 1; i <= totalSupply; i++) {
                ethBLOCKIE = await contract.ethBLOCKIES(i - 1)
                result.push(ethBLOCKIE)
            }
        })
    })
})