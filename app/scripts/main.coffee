do ($ = jQuery) ->

  panel =
    isDevice          : false
    isMinNavActive    : false
    isOffCanvasActive : false
    deviceWidth       : 700
    windowWidth       : 0
    $navTrigger       : $('span.nav-trigger')
    $body             : $(document.body)
    $menuBar          : $('.site-nav li')
    $menuActive       : null

    init : ()->
      self = @
      self.$menuActive = self.$menuBar.find('.active')
      self.bindEvents()
      return @

    bindEvents :() ->
      self = @
      $(window).smartresize () ->
        self.windowWidth = $(this).width()
        self.checkPanel()

        if self.windowWidth <= self.deviceWidth
          self.disableAll()
          return

        return

      self.$navTrigger.on 'click' , (e) ->
        e.preventDefault()
        self.checkPanel()

        if self.isDevice is on and self.isMinNavActive is off
          self.openOffCanvas()
        if self.isDevice is on and self.isMinNavActive is off and self.isOffCanvasActive is on
          self.closeOffCanvas()

        if self.isDevice is off and self.isMinNavActive is off
          self.enableNav()
        if self.isDevice is off and self.isMinNavActive is true
          self.disableNav()
        return false

      self.enableDropdown()

      return

    checkPanel : () ->
      self                   = @
      self.isDevice          = if self.windowWidth<= self.deviceWidth then true else false
      self.isMinNavActive    = self.$body.hasClass('nav-min')
      self.isOffCanvasActive = self.$body.hasClass('off-canvas')
      return

    disableAll : () ->
      self = @
      self.$body.removeClass().addClass('admin')
      return

    enableNav : () ->
      self = @
      self.$body.removeClass('off-canvas').addClass('nav-min')
      self.disableDropdown()
      return

    disableNav : () ->
      self = @
      self.$body.removeClass('nav-min').addClass('off-canvas')
      self.enableDropdown()
      return

    openOffCanvas : () ->
      self = @
      self.$body.removeClass('nav-min').addClass('off-canvas')
      return

    closeOffCanvas : ()->
      self = @
      self.$body.removeClass().addClass('admin')
      return

    disableDropdown : () ->
      self = @
      self.$menuBar.removeClass('active')
      self.$menuBar.off('click')
      return

    enableDropdown : () ->
      self = @
      self.$menuBar.on 'click' , (e) ->

        that = $(this)
        self.$menuActive.removeClass('active')
        if that.hasClass('active') is on
          that.removeClass('active').find('ul.sub-nav-list').slideUp('fast')
        else if self.$menuBar.hasClass('active') is off
          that.addClass('active').find('ul.sub-nav-list').slideDown('fast')
        else
          self.$menuBar.removeClass('active').find('ul.sub-nav-list').slideUp('fast')
          that.addClass('active').find('ul.sub-nav-list').slideDown('fast')



  panel.init()


  $('.dropdown-toggle').dropdown()
  $('.noti-menu').perfectScrollbar
    suppressScrollX : true

  links = $('a')
  $.each links , (index , el)->
    el.onmousedown = ->
      @blur()
      false
    el.onclick = ->
      @blur()
      return
    if /msie/i.test(navigator.userAgent) and not /opera/i.test(navigator.userAgent)
      el.onfocus = ->
        @blur()
        return
  return