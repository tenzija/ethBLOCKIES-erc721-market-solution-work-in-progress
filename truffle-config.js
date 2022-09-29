
const HDWalletProvider = require("@truffle/hdwallet-provider")
const keys =  require("./keys.json")

module.exports = {

  networks: {
    development: {
    host: "127.0.0.1",     // Localhost (default: none)
    port: 7545,            // Standard Ethereum port (default: none)
    network_id: "*",       // Any network (default: none)
    },

    ropsten: {
      provider: function() {
        return new HDWalletProvider(
          keys.MNEMONIC,
          `https://ropsten.infura.io/v3/${keys.INFURA_PROJECT_ID}`
        )
      },
      network_id: 3,
      gas: 5500000, // Gas Limit, How much gas we are willing to spent
      gasPrice: 20000000000,
    }
  },

  contracts_directory: './src/contracts/',
  contracts_build_directory: "./src/abis/", //ispravno

  compilers: {
    solc: {
     version:'^0.8.0',
     optimizer:{
       enabled:'true',
       runs: 200
     }
    }
  },

};

// probaj contract abis da prebacis u public i probaj app.js faucet da metod da primenis ovde