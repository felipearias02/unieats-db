import json
from pathlib import Path

cafes = {
    1: "Cafeteria Principal",
    2: "Cafeteria 6 Piso",
    3: "Cafeteria 4 Piso",
    4: "Cafeteria 4-2 Piso"
}


general_notifications = [
    "Tu pedido ya esta listo para recoger.",
    "El pago no pudo ser procesado. Intentalo nuevamente.",
    "Tienes un pago pendiente por tu ultimo pedido.",
    "El producto solicitado esta agotado, pero tenemos una alternativa.",
    "Tu pedido ha sido cancelado por falta de pago."
]


special_notifications = {
    1: [
        "El buffet de almuerzo esta disponible solo hasta las 2 PM.",
        "Se ha retrasado el despacho de pedidos por alta demanda.",
        "Recuerda traer tu recipiente para el almuerzo tipo buffet.",
        "Por mantenimiento, no se serviran bebidas calientes hoy.",
        "Evita filas: retira tu pedido por la ventanilla lateral."
    ],
    2: [
        "Hoy tenemos nueva lasaña con receta especial.",
        "Recuerda que aqui no servimos desayunos ni ensaladas.",
        "Nuestros jugos Hatsu estan con descuento por hoy.",
        "La cocina cerrara 15 minutos antes por limpieza.",
        "El sistema de pedidos esta lento, paciencia por favor."
    ],
    3: [
        "Promocion: donas 2x1 hasta agotar existencias.",
        "Los combos de snack con bebida fria estan activos.",
        "Recuerda que solo ofrecemos productos empacados.",
        "Tu sandwich de atún estara listo en 3 minutos.",
        "Por hoy solo aceptamos pagos digitales."
    ],
    4: [
        "Nos quedan pocas unidades del kit de frutas.",
        "No olvides hidratarte: tenemos H2O y té frio.",
        "Cierre anticipado por evento institucional.",
        "Se habilito una segunda fila para entrega rapida.",
        "Si pediste dulces, estan en caja 2."
    ]
}

notifications = []

for cafe_id in cafes:
    for msg in general_notifications:
        notifications.append({
            "CAFE_ID": cafe_id,
            "MESSAGE": msg,
            "TYPE": "estado"
        })
    for msg in special_notifications[cafe_id]:
        notifications.append({
            "CAFE_ID": cafe_id,
            "MESSAGE": msg,
            "TYPE": "especial"
        })

# Anuncios promocionales por cafeteria
announcements = {
    1: [
        "Promo: compra 2 empanadas y lleva una bebida gratis.",
        "Ultimos cupos para el almuerzo tipo buffet.",
        "Nuevo producto: arroz chino con pollo.",
        "Cierre anticipado mañana por jornada de limpieza.",
        "Descuento del 10% pagando con tarjeta EAN."
    ],
    2: [
        "Hoy combo: lasaña + jugo Hatsu a 12000.",
        "Nuevos productos vegetarianos disponibles.",
        "Promocion en pasteles hasta medio dia.",
        "Mañana se cambia el menu de pastas.",
        "No olvides probar el nuevo postre artesanal."
    ],
    3: [
        "Snacks saludables con 20% de descuento.",
        "Nuevas chocolatinas importadas disponibles.",
        "Cierre anticipado por evento en el piso 4.",
        "Oferta de sandwich + té por 5500.",
        "Galletas de avena recien horneadas, pregunta por ellas."
    ],
    4: [
        "Promo en kits de frutas hasta agotar inventario.",
        "Dulces surtidos a solo 1000 por unidad.",
        "Anuncio: mañana solo se venderan productos empacados.",
        "Cierre temprano por mantenimiento de la red electrica.",
        "Nueva presentacion de yogur con granola."
    ]
}

announcement_entries = []

for cafe_id in cafes:
    for msg in announcements[cafe_id]:
        announcement_entries.append({
            "CAFE_ID": cafe_id,
            "MESSAGE": msg,
            "TYPE": "anuncio"
        })