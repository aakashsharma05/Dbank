import {dbank} from "../../declarations/dbank";

window.addEventListener("load", async function(){
    update();
})

document.querySelector("form").addEventListener("submit", async function (evt){
    
    evt.preventDefault();
    document.getElementById("submit-btn").setAttribute("disabled",true);

    const inputAmount = parseFloat(document.getElementById("input-amount").value);
    const withdrawAmount = parseFloat(document.getElementById("withdrawal-amount").value);

    if(document.getElementById("input-amount").value.length != 0){
        await dbank.topUp(inputAmount);
    }
    if(document.getElementById("withdrawal-amount").value.length != 0){
        await dbank.withdraw(withdrawAmount);
    }

    await dbank.compound();
    update();
    
    document.getElementById("submit-btn").removeAttribute("disabled");
    document.getElementById("input-amount").value = "";
    document.getElementById("withdrawal-amount").value = "";
    
})

async function  update(){
    document.getElementById("value").innerText = (await dbank.checkBalance()).toFixed(2);
}
