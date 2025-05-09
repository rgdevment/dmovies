# 🎬 Stack Automatizado: Radarr + Sonarr + Prowlarr + qBittorrent (Mac + Docker)

Este stack en Docker permite automatizar completamente la descarga y organización de películas y series, guardándolas localmente en tu Mac (por ejemplo en `/Documents/Media/`) y opcionalmente moviéndolas a Google Drive.

---

## 📁 Estructura recomendada

```
/Users/rgdevment/Documents/Media/
├── Movies/     # Usado por Radarr
└── Series/     # Usado por Sonarr
```

> Puedes mover los archivos manualmente a Google Drive si deseas sincronizarlos con la nube.

---

## 🚀 Comandos disponibles

Desde el directorio donde está el `Makefile` y el `docker-compose.auto.yml`:

```bash
make up-auto         # Levanta todo el stack
make down-auto       # Detiene todos los servicios
make logs-auto       # Muestra logs en tiempo real
make status-auto     # Muestra el estado de los contenedores
```

---

## 🧱 Servicios incluidos

| Servicio     | Puerto | Función                                 |
| ------------ | ------ | --------------------------------------- |
| qBittorrent  | 8080   | Cliente torrent principal               |
| Radarr       | 7878   | Gestor de películas                     |
| Sonarr       | 8989   | Gestor de series                        |
| Prowlarr     | 9696   | Motor de búsqueda para torrents         |
| FlareSolverr | 8191   | (Opcional) Proxy para bypass Cloudflare |

> Puedes probar FlareSolverr accediendo a: [http://localhost:8191](http://localhost:8191) o [http://flaresolverr:8191](http://flaresolverr:8191) desde Prowlarr

---

## 🔐 Usuario/contraseña por defecto

- Usuario: `admin`
- Contraseña: `adminadmin`

---

## ⚙️ Configuración inicial (una sola vez)

### 1. Configura qBittorrent

- Accede a http://localhost:8080
- Usuario: `admin`, Contraseña: `adminadmin`
- Ve a ⚙️ Settings > Downloads
- Cambia la ruta de descarga a:

```
/downloads
```

---

### 2. Configura Radarr

- http://localhost:7878
- Settings > Download Clients → `+` → qBittorrent
  - Host: `qbittorrent`
  - Puerto: `8080`
  - Usuario/Clave: `admin` / `adminadmin`
- Settings > Media Management > Root folders → `+` `/movies`

---

### 3. Configura Sonarr

- http://localhost:8989
- Mismos pasos que Radarr pero con `/tv` como carpeta raíz

---

### 4. Configura Prowlarr

- http://localhost:9696
- Agrega indexadores públicos desde Presets (YTS, 1337x, etc.)
- Settings > Apps → `+` → Radarr / Sonarr
- Dirección: `http://radarr:7878` y `http://sonarr:8989`
- Agrega sus API Keys (desde `Settings > General` en cada app)

Si algún indexador requiere FlareSolverr:

- Asegúrate que el servicio esté activo en `http://localhost:8191`
- En Prowlarr → `Settings > Indexers > FlareSolverr` usa la URL:

```
http://flaresolverr:8191
```

Haz clic en "Test" y luego en "Save" si todo está OK ✅

---

## 🎯 Flujo completo

```
Prowlarr (indexadores) → Radarr/Sonarr → qBittorrent → /downloads → /movies o /tv → (opcional: Google Drive)
```

---

## 🧪 Ejemplo real

1. Abres Radarr
2. Click en `Add Movie`, buscas "Inception"
3. Lo agregas con calidad 1080p y carpeta `/movies`
4. Se descarga y organiza solo
5. Aparece automáticamente en Jellyfin (si Jellyfin apunta a esa carpeta)

---

Hecho con ❤️ por el Rodrigo del presente para el del futuro.
Ahora sí: _que empiece la película..._ 🍿
