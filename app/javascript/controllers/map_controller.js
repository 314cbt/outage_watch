import { Controller } from "@hotwired/stimulus"
import * as L from "leaflet"

export default class extends Controller {
  static values = {
    assets: Array,
    assetsBase64: String,
    centerLat: Number,
    centerLng: Number,
    zoom: { type: Number, default: 11 },
    autoFit: { type: Boolean, default: true }
  }

  connect() {
    console.log("map controller connected")

    if (!this.element.style.height) this.element.style.height = "500px"
    this.map = L.map(this.element, { preferCanvas: true })

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      maxZoom: 19,
      attribution: "© OpenStreetMap",
    }).addTo(this.map)

    this.assetLayer = L.layerGroup().addTo(this.map)

    let assets = this.assetsValue
    if (!assets || assets.length === 0) {
      if (this.hasAssetsBase64Value) {
        try {
          assets = JSON.parse(atob(this.assetsBase64Value)) || []
        } catch (e) {
          console.error("Failed to parse assetsBase64:", e)
          assets = []
        }
      }
    }
    if (!assets || assets.length === 0) {
      try {
        const jsonEl = this.element.querySelector('script[type="application/json"][data-map-assets]')
        if (jsonEl) assets = JSON.parse(jsonEl.textContent || "[]")
      } catch (e) {
        console.error("Failed to parse inline assets JSON:", e)
      }
    }
    assets = assets || []
    console.log("map assets count:", assets.length)

    const icon = (url) => L.icon({ iconUrl: url, iconSize: [28, 28], iconAnchor: [14, 28] })
    const ICONS = {
      assetActive:      icon("https://maps.google.com/mapfiles/ms/icons/green-dot.png"),
      assetMaintenance: icon("https://maps.google.com/mapfiles/ms/icons/yellow-dot.png"),
      assetDown:        icon("https://maps.google.com/mapfiles/ms/icons/red-dot.png"),
    }
    const iconFor = (statusRaw) => {
      const s = (statusRaw || "").toString().toLowerCase()
      if (s === "active") return ICONS.assetActive
      if (s === "maintenance") return ICONS.assetMaintenance
      if (s === "down" || s === "outage" || s === "resolved") return ICONS.assetDown
      return ICONS.assetActive
    }

    assets.forEach(a => {
      if (a.latitude == null || a.longitude == null) return
      const popupHtml = `
        <div class="p-2">
          <div class="font-semibold text-gray-800">${this.escape(a.name || "Asset")}</div>
          <div class="text-xs text-gray-600">${this.escape(a.category || "Unknown type")}</div>
          <div class="mt-1 text-xs"><span class="font-medium">Status:</span> ${this.escape(a.status || "unknown")}</div>
          <div class="mt-2">
            <a href="/assets/${a.id}" class="text-blue-600 hover:underline text-xs">View Asset →</a>
          </div>
        </div>
      `
      L.marker([a.latitude, a.longitude], { icon: iconFor(a.status) })
        .addTo(this.assetLayer)
        .bindPopup(popupHtml)
    })

    const hasCenter = this.hasCenterLatValue && this.hasCenterLngValue
    this.map.setView(hasCenter ? [this.centerLatValue, this.centerLngValue] : [37.8, -96], this.zoomValue)

    if (this.autoFitValue) {
      const latlngs = []
      this.assetLayer.eachLayer(m => latlngs.push(m.getLatLng()))
      if (latlngs.length > 0) this.map.fitBounds(L.latLngBounds(latlngs), { padding: [30, 30] })
    }

    requestAnimationFrame(() => this.map && this.map.invalidateSize())
  }

  escape(str) {
    return (str ?? "").toString().replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;")
  }
}
