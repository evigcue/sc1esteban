#!/bin/bash

declare -A colores

while IFS=':' read -r color hexa; do
    colores[$color]=$hexa
done<colores.txt

echo "número de colores: ${#colores[@]}"

echo "Los colores que puedes elegir son: "
for key in "${!colores[@]}"; do
    echo "$key"
done

read -rp "¿Qué color quieres para el fondo de la página?: " backcolor
read -rp "¿Qué color quieres para el parrafo de la página?: " pcolor
read -rp "¿Qué color quieres para el texto de la página?: " textcolor
read -rp "¿Quieres añadir una foto? (s/n): " foto
if [ $foto = "s" ] || [ $foto = "S" ]; then
    read -rp "¿Cuál es la dirección de la foto?: " dir_foto
fi

ip=$(ip addr | tail -n4 | head -n1)

if [ -f "index_esteban.html" ]; then
    rm "index_esteban.html"
fi

cat > "index_esteban.html" <<EOF
<!DOCTYPE html>
    <head>
        <style>
            *{
                background-color: ${colores[$backcolor]};

                p{
                    background-color: ${colores[$pcolor]};
                    color: ${colores[$textcolor]};
                }
            } 
        </style>
        <title>pagina</title>
    </head>
    <body>
        <img src="$dir_foto" alt="foto">
        <p>
            $ip
        </p>
    </body>
</html>
EOF