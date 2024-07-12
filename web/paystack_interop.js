function paystackPopUp(pkTest, email, amount, ref, onClosed, callback) {
  let handler = PaystackPop.setup({
    key: pkTest, // Replace with your public key
    email: email,
    amount: amount*100,
    currency:"GHS",
    channels: ['card', 'bank', 'ussd', 'qr', 'mobile_money', 'bank_transfer'],
    ref: ref, // generates a pseudo-unique reference. Please replace with a reference you generated. Or remove the line entirely so our API will generate one for you
    onClose: function () {
      alert("Window closed.");
      onClosed();
    },
    callback: function (response) {
      callback();
      let message = "Payment complete! Reference: " + response.reference;
      console.log(response);
      alert(message);
    },
  });
  return handler.openIframe();
}
