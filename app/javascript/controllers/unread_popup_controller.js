import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { ids: Array, userId: Number }

  connect() {
    const newIds = this.idsValue.filter((id) => !this.dismissedIds.includes(id))

    if (newIds.length === 0) {
      this.element.classList.add("hidden")
    }
  }

  dismiss() {
    localStorage.setItem(this.storageKey, JSON.stringify(this.idsValue))
  }

  get dismissedIds() {
    const stored = localStorage.getItem(this.storageKey)
    return stored ? JSON.parse(stored) : []
  }

  get storageKey() {
    return `dismissed_care_records_user_${this.userIdValue}`
  }
}
