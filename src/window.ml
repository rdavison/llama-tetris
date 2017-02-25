type t =
  | WINDOWMainMenu
  | WINDOWSplash

let dispatch_event event = function
  | WINDOWMainMenu -> MainMenu.handle event
  | WINDOWSplash -> Splash.handle event
