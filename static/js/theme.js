(function(){
    const savedTheme = localStorage.getItem("theme");
    if(savedTheme==="dark"){
        document.body.classList.add("dark-mode");
    }
})();

function toggleTheme(){
    document.body.classList.toggle("dark-mode");

    if(document.body.classList.contains("dark-mode")){
        localStorage.setItem("theme","dark");
    }else{
        localStorage.setItem("theme","light");
    }
}




var options = {
    "key": "{{ key_id }}",
    "amount": "{{ amount * 100 }}",
    "currency": "INR",
    "name": "SmartCart",
    "order_id": "{{ order_id }}",
    "handler": function (response){

        document.getElementById('razorpay_payment_id').value = response.razorpay_payment_id;
        document.getElementById('razorpay_order_id').value = response.razorpay_order_id;
        document.getElementById('razorpay_signature').value = response.razorpay_signature;

        document.getElementById('payment-form').submit();
    }
};
