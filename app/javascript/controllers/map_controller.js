import { Controller } from "@hotwired/stimulus"
import * as L from "leaflet"

export default class extends Controller {
  static values = { assets: Array }

  connect() {
    console.log("map controller connected")
    this.map = L.map(this.element).setView([37.8, -96], 4) 

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      maxZoom: 19,
      attribution: '&copy; OpenStreetMap contributors'
    }).addTo(this.map)

    const points = []
    for (const a of (this.assetsValue || [])) {
      if (a.latitude == null || a.longitude == null) continue

      const color = this.colorForStatus(a.status)
      const marker = L.circleMarker([a.latitude, a.longitude], {
        radius: 8, weight: 2, color, fillColor: color, fillOpacity: 0.7
      }).addTo(this.map)

      marker.bindPopup(`
        <div><strong>${this.escape(a.name)}</strong></div>
        <div>Status: ${this.escape(a.status || "-")}</div>
        <div><a href="/assets/${a.id}" class="underline">View asset</a></div>
        <div><a href="/assets/${a.id}/incidents" class="underline">Incidents</a></div>
      `)

      points.push([a.latitude, a.longitude])
    }

    if (points.length) {
      this.map.fitBounds(points, { padding: [30, 30] })
    }
  }

  colorForStatus(status) {
    switch ((status || "").toString()) {
      case "active": return "#16a34a" 
      case "maintenance": return "#ca8a04" 
      case "down":
      case "outage":
      case "resolved": return "#dc2626" 
      default: return "#475569"      
    }
  }

  escape(str) {
    return (str ?? "").toString()
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
  }
}
