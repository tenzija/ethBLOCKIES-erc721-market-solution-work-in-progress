import React, { Component } from "react";
import Web3 from "web3";
import ethBLOCKIE from '../abis/ethBLOCKIE.json'
import {MDBCard, MDBCardBody, MDBCardTitle, MDBCardText, MDBCardImage} from 'mdb-react-ui-kit';
import './App.css';

const contractABI = require("../abis/ethBLOCKIE.json")
const contractAddress = "0xc4C2b9e9BbB702b46290eD0b6Bf8f7597801d2A7"


class App extends Component {

    async componentDidMount() {
        await this.loadWeb3();
        await this.loadBlockchainData();
    }

    // first up is to detect ethereum provider
    async loadWeb3() {

        window.web3 = new Web3(window.ethereum)

        let provider = window.ethereum

        if (typeof provider !== "undefined") {

            provider.request({ method: "eth_requestAccounts" }).then(accounts => {
                //console.log(accounts)
            }).catch(err => {
                //console.log(err)
            })
        }

        const accounts = await provider.request({method: "eth_accounts"})
        this.setState({account:accounts[0]})
    }

    async loadBlockchainData() {
        const web3 = window.ethereum

        // create a constant js variable networkId which 
        //is set to blockchain network id 
        const networkId = await web3.request({ method: "net_version"})
        const networkData = ethBLOCKIE.networks[networkId]
         if(networkData) {

            //  const abi = ethBLOCKIE.abi;
            //  const address = networkData.address; 
             const contract = await new window.web3.eth.Contract(contractABI.abi, contractAddress)
             this.setState({contract})

             const totalSupply = await contract.methods.totalSupply().call()
            this.setState({totalSupply})
            // load ethBLOCKIES
            for(let i = 1; i <= totalSupply; i++) {
                const ethBLOCKIE = await contract.methods.ethBLOCKIES(i - 1).call()
                this.setState({
                    ethBLOCKIES:[...this.state.ethBLOCKIES, ethBLOCKIE]
                })
            }
         } else {
             window.alert('Smart contract not deployed')
         }
    }

    mint = (ethBLOCKIE) => {
        this.state.contract.methods.mint(ethBLOCKIE).send("eth_sendTransaction", {from:this.state.account})
        .once('receipt', (receipt)=> {
            this.setState({
                ethBLOCKIES:[...this.state.ethBLOCKIES, ethBLOCKIE]
            })
        })  
    }

    constructor(props) {
         super(props);
         this.state = {
             account: '',
             contract:null,
             totalSupply:0,
             ethBLOCKIES:[]
         }
    }

    render() {
        
        return (
            <div
                className="container-filled"    
            >
                {console.log(this.state.ethBLOCKIES)}
                <nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-2 shadow justify-content-justify">
                    <div className="navbar-brend mr-2 justify-content-center" style={{color:"white"}}>
                        <b>ethBLOCKIES</b> - NFTs "(Non Fungible Tokens)"
                    </div>
                    <div className="d-inline-flex">
                        <div className="text-white p-2 d-inline-flex">
                            <span>
                                Connected account: <b>{this.state.account}</b>
                            </span>
                        </div>
                        <div className="pl-2">
                            <button onClick={this.loadWeb3()} className="btn btn-outline-light rounded p-1">fix this - stateChange</button>
                        </div>
                    </div>
                </nav>
                <hr></hr>
                <div className="container-fluid" style={{marginTop:"50px"}}>
                    <div className="row">
                        <main role="main" className="col-lg-12 d-flex text-center justify-content-center">
                            <div className="content mr-auto ml-auto" style={{opacity:"0.8"}}>
                                <h1 style={{color:"black"}}>
                                    <b className="text-weight-bold">ethBLOCKIES</b> <p style={{fontWeight: 220}}>NFT Marketplace</p>
                                </h1>
                                <form onSubmit={(event) => {
                                    event.preventDefault()
                                    const ethBLOCKIE = this.ethBLOCKIE.value
                                    this.mint(ethBLOCKIE)
                                }}>
                                    <input
                                        type="text"
                                        placeholder="File location"
                                        className="form-control mb-1"
                                        ref={(input) => this.ethBLOCKIE = input}
                                    />
                                    <input
                                        style={{margin:"6px"}}
                                        type="submit"
                                        className="btn btn-dark btn-black"
                                        value="MINT"
                                    />
                                </form>
                            </div>
                        </main>
                    </div>
                        <hr></hr>
                        <div className="d-flex flex-wrap justify-content-center text-center">
                                {this.state.ethBLOCKIES.map((ethBLOCKIE, key) => {
                                    return(
                                        <div>
                                            <div>
                                                <MDBCard 
                                                    className="token img" 
                                                    style={{maxWidth:"22rem"}}
                                                >
                                                    <MDBCardImage
                                                        src={ethBLOCKIE}
                                                        position="top"
                                                        style={{marginRight:"4px"}}
                                                        height="250rem"
                                                    />
                                                    <MDBCardBody>
                                                        <MDBCardTitle>
                                                            ethBLOCKIE
                                                        </MDBCardTitle>
                                                        <MDBCardText>
                                                            ethBLOCKIES are 20 uniquely generated profile signatures from the cyberpunk hex multiverse called Dextopia! There is only one of each ethBLOCKIE and each ethBLOCKIE can be owned by a single person on the Ethereum blockchain!
                                                        </MDBCardText>
                                                        <button
                                                            href={ethBLOCKIE}
                                                            className="btn btn-dark btn-black"
                                                        >
                                                            Download NFT
                                                        </button>
                                                    </MDBCardBody>
                                                </MDBCard>
                                            </div>
                                        </div>
                                    )
                                })}
                        </div>
                </div>
            </div>
        )
    }
}

export default App;