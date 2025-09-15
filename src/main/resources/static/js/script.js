// JavaScript personalizado para tu licorería
document.addEventListener('DOMContentLoaded', function() {
    console.log('Página cargada y lista!');

    // Ejemplo de funcionalidad JS: Alerta al hacer clic en un botón
    const myButton = document.getElementById('myCustomButton');
    if (myButton) {
        myButton.addEventListener('click', function() {
            alert('¡Botón personalizado clickeado!');
        });
    }
});