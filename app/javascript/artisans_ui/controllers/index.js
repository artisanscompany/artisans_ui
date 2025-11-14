// Load all ArtisansUi Stimulus controllers

import { application } from "@hotwired/stimulus"

// Import controllers
import ModalController from "./modal_controller"
import DropdownController from "./dropdown_controller"
import TooltipController from "./tooltip_controller"

// Register controllers
application.register("artisans-ui--modal", ModalController)
application.register("artisans-ui--dropdown", DropdownController)
application.register("artisans-ui--tooltip", TooltipController)

export { ModalController, DropdownController, TooltipController }
