class window.Helper
  constructor: ->
    @autoHideFlash()

  autoHideFlash: ->
    func =-> $('#flash-panel').fadeOut('slow')
    window.setTimeout func, 3000