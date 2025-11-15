// Load all ArtisansUi Stimulus controllers

import { application } from "@hotwired/stimulus"

// Import controllers
import AccordionController from "./accordion_controller"
import AutogrowController from "./autogrow_controller"
import ModalController from "./modal_controller"
import DropdownController from "./dropdown_controller"
import TooltipController from "./tooltip_controller"

// Register controllers
application.register("artisans-ui--accordion", AccordionController)
application.register("artisans-ui--autogrow", AutogrowController)
application.register("artisans-ui--modal", ModalController)
application.register("artisans-ui--dropdown", DropdownController)
application.register("artisans-ui--tooltip", TooltipController)

export { AccordionController, AutogrowController, ModalController, DropdownController, TooltipController }
