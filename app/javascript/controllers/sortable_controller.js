import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
  }
}

import { Application } from '@hotwired/stimulus'
import Sortable from 'stimulus-sortable'

const application = Application.start()
application.register('sortable', Sortable)
