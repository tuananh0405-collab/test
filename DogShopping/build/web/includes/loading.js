function showLoading() {
    var loadingDiv = document.createElement('div');
    loadingDiv.id = 'loadingDiv';
    loadingDiv.style.position = 'fixed';
    loadingDiv.style.top = '0';
    loadingDiv.style.right = '0';
    loadingDiv.style.bottom = '0';
    loadingDiv.style.left = '0';
    loadingDiv.style.backgroundColor = 'rgba(0,0,0,0.5)';
    loadingDiv.style.display = 'flex';
    loadingDiv.style.justifyContent = 'center';
    loadingDiv.style.alignItems = 'center';

    var spinner = document.createElement('div');
    spinner.style.border = '16px solid #f3f3f3';
    spinner.style.borderTop = '16px solid #3498db';
    spinner.style.borderRadius = '50%';
    spinner.style.width = '120px';
    spinner.style.height = '120px';
    spinner.style.animation = 'spin 2s linear infinite';

    loadingDiv.appendChild(spinner);

    document.body.appendChild(loadingDiv);

    setTimeout(function() {
        loadingDiv.style.display = 'none';
    }, 1000);
}

var links = document.getElementsByTagName('a');
for (var i = 0; i < links.length; i++) {
    links[i].addEventListener('click', showLoading);
}

var style = document.createElement('style');
style.innerHTML = `
@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}`;
document.head.appendChild(style);
