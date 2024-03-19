const keyframesStyles = `
  @keyframes slide-in {
    0% {
      transform: translateY(-100px);
    }
    100% {
      transform: translateY(0);
    }
  }

  @keyframes slide-out {
    0% {
      transform: translateY(0);
    }
    100% {
      transform: translateY(-100px);
    }
  }
`;

const styleElement = document.createElement('style');
styleElement.textContent = keyframesStyles;
document.head.appendChild(styleElement);

window.alert = function (message, timeout = 1000) {
    const alert = document.createElement('div');
    const alertButton = document.createElement('button');

    alertButton.innerHTML = 'X';
    alert.classList.add('alert');
    alert.setAttribute('style', `
    position: fixed;
    top: 20px;
    left: 40%;
    transform: translateX(-50%);
    width: 350px;
    height: 50px;
    padding: 10px;
    border-radius: 5px;
    box-shadow: 0 10px 5px 0 #00000022;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #5ced73;
    animation: slide-in 0.5s ease-out forwards, slide-out 0.5s ease-out forwards ${timeout / 1000}s;
    z-index: 9999;
  `);

    alertButton.setAttribute('style', `
    border: none;
    background: none;
    font-weight: bold;
    cursor: pointer;
  `);

    const alertMessage = document.createElement('span');
    alertMessage.innerHTML = message;
    alertMessage.setAttribute('style', `
    flex-grow: 1;
    text-align: center;
  `);

    alert.appendChild(alertMessage);
    alert.appendChild(alertButton);

    alertButton.addEventListener('click', (e) => {
        alert.style.animation = 'slide-out 0.5s ease-out forwards';
        setTimeout(() => {
            alert.remove();
        }, 500);
    });

    document.body.appendChild(alert);
};
