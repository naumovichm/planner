const per_page = document.getElementById('per_page')
per_page.addEventListener('change', (e) => {
    if (e.target.value) {
        window.location = '?per_page=' + e.target.value
    }
})
