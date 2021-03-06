(function($) {
  skel.breakpoints({
    xlarge: '(max-width: 1680px)',
    large: '(max-width: 1280px)',
    medium: '(max-width: 980px)',
    small: '(max-width: 736px)',
    xsmall: '(max-width: 480px)',
    'xlarge-to-max': '(min-width: 1681px)',
    'small-to-xlarge': '(min-width: 481px) and (max-width: 1680px)'
  });
  $(function() {
    var $window = $(window),
      $head = $('head'),
      $body = $('body');
    $body.addClass('is-loading');
    $window.on('load', function() {
      setTimeout(function() {
        $body.removeClass('is-loading');
      }, 100);
    });
    var resizeTimeout;
    $window.on('resize', function() {
      $body.addClass('is-resizing');
      clearTimeout(resizeTimeout);
      resizeTimeout = setTimeout(function() {
        $body.removeClass('is-resizing');
      }, 100);
    });
    $('form').placeholder();
    skel.on('+medium -medium', function() {
      $.prioritize(
        '.important\\28 medium\\29',
        skel.breakpoint('medium').active
      );
    });
    if (!skel.canUse('object-fit') ||
      skel.vars.browser == 'safari')
      $('.image.object').each(function() {
        var $this = $(this),
          $img = $this.children('img');
        $img.css('opacity', '0');
        $this
          .css('background-image', 'url("' + $img.attr('src') + '")')
          .css('background-size', $img.css('object-fit') ? $img.css('object-fit') : 'cover')
          .css('background-position', $img.css('object-position') ? $img.css('object-position') : 'center');
      });
    var $sidebar = $('#sidebar'),
      $sidebar_inner = $sidebar.children('.inner');
    skel
      .on('+large', function() {
        $sidebar.addClass('inactive');
      })
      .on('-large !large', function() {
        $sidebar.removeClass('inactive');
      });
    if (skel.vars.os == 'android' &&
      skel.vars.browser == 'chrome')
      $('<style>#sidebar .inner::-webkit-scrollbar { display: none; }</style>')
      .appendTo($head);
    if (skel.vars.IEVersion > 9) {
      $('<a href="#sidebar" class="toggle">Toggle</a>')
        .appendTo($sidebar)
        .on('click', function(event) {
          event.preventDefault();
          event.stopPropagation();
          $sidebar.toggleClass('inactive');
        });
    }
    $sidebar.on('click', 'a', function(event) {
      if (!skel.breakpoint('large').active)
        return;
      var $a = $(this),
        href = $a.attr('href'),
        target = $a.attr('target');
      event.preventDefault();
      event.stopPropagation();
      if (!href || href == '#' || href == '')
        return;
      $sidebar.addClass('inactive');
      setTimeout(function() {
        if (target == '_blank')
          window.open(href);
        else
          window.location.href = href;
      }, 500);
    });
    $sidebar.on('click touchend touchstart touchmove', function(event) {
      if (!skel.breakpoint('large').active)
        return;
      event.stopPropagation();
    });
    $body.on('click touchend', function(event) {
      if (!skel.breakpoint('large').active)
        return;
      $sidebar.addClass('inactive');
    });
    $window.on('load.sidebar-lock', function() {
      var sh, wh, st;
      if ($window.scrollTop() == 1)
        $window.scrollTop(0);
      $window
        .on('scroll.sidebar-lock', function() {
          var x, y;
          if (skel.vars.IEVersion < 10)
            return;
          if (skel.breakpoint('large').active) {
            $sidebar_inner
              .data('locked', 0)
              .css('position', '')
              .css('top', '');
            return;
          }
          x = Math.max(sh - wh, 0);
          y = Math.max(0, $window.scrollTop() - x);
          if ($sidebar_inner.data('locked') == 1) {
            if (y <= 0)
              $sidebar_inner
              .data('locked', 0)
              .css('position', '')
              .css('top', '');
            else
              $sidebar_inner
              .css('top', -1 * x);
          } else {
            if (y > 0)
              $sidebar_inner
              .data('locked', 1)
              .css('position', 'fixed')
              .css('top', -1 * x);
          }
        })
        .on('resize.sidebar-lock', function() {
          wh = $window.height();
          sh = $sidebar_inner.outerHeight() + 30;
          $window.trigger('scroll.sidebar-lock');
        })
        .trigger('resize.sidebar-lock');
    });
    var $menu = $('#menu'),
      $menu_openers = $menu.children('ul').find('.opener');
    $menu_openers.each(function() {
      var $this = $(this);
      $this.on('click', function(event) {
        event.preventDefault();
        $menu_openers.not($this).removeClass('active');
        $this.toggleClass('active');
        $window.triggerHandler('resize.sidebar-lock');
      });
    });
  });
})(jQuery);
