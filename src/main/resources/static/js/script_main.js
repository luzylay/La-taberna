// Datos de los vinos
const vinos = [
    {
        id: 1,
        nombre: "Vino Tinto Tempranillo Celeste Roble Botella 750ml",
        año: 2020,
        tipo: "Tinto Reserva",
        precio: "S/ 84.90",
        descripcion: "Un vino elegante con 18 meses en barrica de roble francés. Notas de frutos rojos maduros, especias y un final prolongado.",
        imagen: "https://wongfood.vtexassets.com/arquivos/ids/693464-600-auto?v=638454622254530000&width=600&height=auto&aspect=true",
        calificacion: 4.8,
        premios: ["Medalla de Oro - Concurso Internacional 2022"],
        disponible: true
    },
    {
        id: 2,
        nombre: "Robles Gran Reserva",
        año: 2018,
        tipo: "Tinto Gran Reserva",
        precio: "S/ 55",
        descripcion: "Nuestro vino más exclusivo. 24 meses en barrica y 36 meses en botella. Complejidad aromática excepcional.",
        imagen: "https://images.unsplash.com/photo-1506377247377-2a5b3b4171b8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        calificacion: 4.9,
        premios: ["95 Puntos Parker", "Mejor Vino Nacional 2023"],
        disponible: true
    },
    {
        id: 3,
        nombre: "Robles Blanco Verdejo",
        año: 2023,
        tipo: "Blanco Joven",
        precio: "S/ 18",
        descripcion: "Fresco y aromático, con notas cítricas y florales. Perfecto para maridar con pescados y mariscos.",
        imagen: "https://images.unsplash.com/photo-1506377247377-2a5b3b4171b8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        calificacion: 4.5,
        premios: ["Medalla de Plata - Concurso Regional 2023"],
        disponible: true
    },
    {
        id: 4,
        nombre: "Robles Rosé",
        año: 2023,
        tipo: "Rosado",
        precio: "S/ 22",
        descripcion: "Elegante rosado con color rosa pálido. Fresco, afrutado y con una acidez equilibrada. Ideal para el verano.",
        imagen: "https://images.unsplash.com/photo-1506377247377-2a5b3b4171b8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        calificacion: 4.6,
        premios: ["Recomendado Guía Peñín 2024"],
        disponible: false
    },
    {
        id: 5,
        nombre: "Robles Crianza",
        año: 2021,
        tipo: "Tinto Crianza",
        precio: "S/ 25",
        descripcion: "12 meses en barrica de roble americano. Vino equilibrado con taninos suaves y buen potencial de guarda.",
        imagen: "https://images.unsplash.com/photo-1506377247377-2a5b3b4171b8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        calificacion: 4.4,
        premios: ["Selección Sommelier 2023"],
        disponible: true
    },
    {
        id: 6,
        nombre: "Robles Espumoso Brut",
        año: 2021,
        tipo: "Espumoso",
        precio: "S/ 28",
        descripcion: "Método tradicional con 24 meses sobre lías. Burbuja fina y persistente con aromas a frutas blancas y panadería.",
        imagen: "https://images.unsplash.com/photo-1506377247377-2a5b3b4171b8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        calificacion: 4.7,
        premios: ["Medalla de Oro - Concurso Espumosos 2023"],
        disponible: true
    }
];

// Función para renderizar estrellas de calificación
function renderStars(rating) {
    let stars = '';
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 >= 0.5;
    
    for (let i = 0; i < fullStars; i++) {
        stars += '<i class="bi bi-star-fill text-warning"></i>';
    }
    
    if (hasHalfStar) {
        stars += '<i class="bi bi-star-half text-warning"></i>';
    }
    
    const emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    for (let i = 0; i < emptyStars; i++) {
        stars += '<i class="bi bi-star text-warning"></i>';
    }
    
    return stars;
}

// Función para cargar los vinos en el grid
function loadWines(filter = 'todos') {
    const wineGrid = document.getElementById('wine-grid');
    wineGrid.innerHTML = '';
    
    const filteredWines = filter === 'todos' 
        ? vinos 
        : vinos.filter(vino => vino.tipo === filter);
    
    filteredWines.forEach(vino => {
        const wineCard = document.createElement('div');
        wineCard.className = 'col-md-6 col-lg-4 mb-4';
        wineCard.innerHTML = `
            <div class="wine-card">
                <div class="position-relative">
                    <img src="${vino.imagen}" class="wine-image" alt="${vino.nombre}">
                    ${!vino.disponible ? '<span class="wine-badge">Agotado</span>' : ''}
                    <span class="wine-year">${vino.año}</span>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <span class="wine-type">${vino.tipo}</span>
                        <div class="wine-rating">
                            ${renderStars(vino.calificacion)}
                            <small class="text-muted">(${vino.calificacion})</small>
                        </div>
                    </div>
                    <h5 class="card-title">${vino.nombre}</h5>
                    <p class="card-text text-muted line-clamp-3">${vino.descripcion}</p>
                    ${vino.premios.length > 0 ? `
                        <div class="mb-3">
                            <small class="text-success">
                                <i class="bi bi-award-fill"></i> ${vino.premios[0]}
                                ${vino.premios.length > 1 ? ' +' + (vino.premios.length - 1) + ' más' : ''}
                            </small>
                        </div>
                    ` : ''}
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="wine-price">${vino.precio}</span>
                        <button class="btn btn-sm ${vino.disponible ? 'btn-danger' : 'btn-secondary'}" 
                            ${vino.disponible ? `onclick="openWineModal(${vino.id})"` : 'disabled'}>
                            ${vino.disponible ? 'Ver Detalles' : 'No Disponible'}
                        </button>
                    </div>
                </div>
            </div>
        `;
        wineGrid.appendChild(wineCard);
    });
}

// Función para abrir el modal con los detalles del vino
function openWineModal(wineId) {
    const wine = vinos.find(v => v.id === wineId);
    if (!wine) return;
    
    document.getElementById('modal-image').src = wine.imagen;
    document.getElementById('modal-type').textContent = wine.tipo;
    document.getElementById('modal-name').textContent = wine.nombre;
    document.getElementById('modal-rating').innerHTML = renderStars(wine.calificacion);
    document.getElementById('modal-rating-value').textContent = `(${wine.calificacion}/5)`;
    document.getElementById('modal-description').textContent = wine.descripcion;
    document.getElementById('modal-price').textContent = wine.precio;
    
    // Premios
    const awardsContainer = document.getElementById('modal-awards');
    awardsContainer.innerHTML = '';
    if (wine.premios.length > 0) {
        awardsContainer.innerHTML = '<h6 class="mb-3">Reconocimientos:</h6>';
        wine.premios.forEach(premio => {
            awardsContainer.innerHTML += `
                <div class="d-flex align-items-center mb-2">
                    <i class="bi bi-award-fill text-warning me-2"></i>
                    <span class="text-muted">${premio}</span>
                </div>
            `;
        });
    }
    
    // Mostrar el modal
    const wineModal = new bootstrap.Modal(document.getElementById('wineModal'));
    wineModal.show();
}

// Inicializar la página
document.addEventListener('DOMContentLoaded', function() {
    // Cargar vinos inicialmente
    loadWines();
    
    // Configurar filtros
    document.querySelectorAll('.filter-btn').forEach(button => {
        button.addEventListener('click', function() {
            // Quitar clase active de todos los botones
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            
            // Agregar clase active al botón clickeado
            this.classList.add('active');
            
            // Filtrar vinos
            const filter = this.getAttribute('data-filter');
            loadWines(filter);
        });
    });
    
    // Smooth scrolling para enlaces internos
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                // Cerrar navbar en móviles
                const navbarCollapse = document.getElementById('navbarNav');
                if (navbarCollapse.classList.contains('show')) {
                    new bootstrap.Collapse(navbarCollapse).hide();
                }
                
                // Scroll suave
                window.scrollTo({
                    top: targetElement.offsetTop - 80,
                    behavior: 'smooth'
                });
            }
        });
    });
});