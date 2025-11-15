// Load all ArtisansUi Stimulus controllers

import { application } from "@hotwired/stimulus"

// Import controllers
import AccordionController from "./accordion_controller"
import AnimatedNumberController from "./animated_number_controller"
import AutogrowController from "./autogrow_controller"
import BannerController from "./banner_controller"
import CarouselController from "./carousel_controller"
import ClipboardController from "./clipboard_controller"
import ConfirmationController from "./confirmation_controller"
import DockController from "./dock_controller"
import DropdownController from "./dropdown_controller"
import EmojiPickerController from "./emoji_picker_controller"
import HotkeyController from "./hotkey_controller"
import LightboxController from "./lightbox_controller"
import ModalController from "./modal_controller"
import NavbarController from "./navbar_controller"
import OsDetectController from "./os_detect_controller"
import PasswordController from "./password_controller"
import SelectController from "./select_controller"
import TooltipController from "./tooltip_controller"

// Register controllers
application.register("artisans-ui--accordion", AccordionController)
application.register("artisans-ui--animated-number", AnimatedNumberController)
application.register("artisans-ui--autogrow", AutogrowController)
application.register("artisans-ui--banner", BannerController)
application.register("artisans-ui--carousel", CarouselController)
application.register("artisans-ui--clipboard", ClipboardController)
application.register("artisans-ui--confirmation", ConfirmationController)
application.register("artisans-ui--dock", DockController)
application.register("artisans-ui--dropdown", DropdownController)
application.register("artisans-ui--emoji-picker", EmojiPickerController)
application.register("artisans-ui--hotkey", HotkeyController)
application.register("artisans-ui--lightbox", LightboxController)
application.register("artisans-ui--modal", ModalController)
application.register("artisans-ui--navbar", NavbarController)
application.register("artisans-ui--os-detect", OsDetectController)
application.register("artisans-ui--password", PasswordController)
application.register("artisans-ui--select", SelectController)
application.register("artisans-ui--tooltip", TooltipController)

export { AccordionController, AnimatedNumberController, AutogrowController, BannerController, CarouselController, ClipboardController, ConfirmationController, DockController, DropdownController, EmojiPickerController, HotkeyController, LightboxController, ModalController, NavbarController, OsDetectController, PasswordController, SelectController, TooltipController }
