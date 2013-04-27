View = require 'views/base/view'
#Set custom template settings
template = require 'views/templates/modal'

module.exports = class ModalView extends View
  className: 'modal'
  template: template
  closed:false


  ###
   * Creates an instance of a Bootstrap Modal
   *
   * @see http://twitter.github.com/bootstrap/javascript.html#modals
   *
   * @param {Object} options
   * @param {String|View} [options.content] Modal content. Default: none
   * @param {String} [options.title]        Title. Default: none
   * @param {String} [options.okText]       Text for the OK button. Default: 'OK'
   * @param {String} [options.cancelText]   Text for the cancel button. Default: 'Cancel'. If passed a falsey value, the button will be removed
   * @param {Boolean} [options.allowCancel  Whether the modal can be closed, other than by pressing OK. Default: true
   * @param {Boolean} [options.escape]      Whether the 'esc' key can dismiss the modal. Default: true, but false if options.cancellable is true
   * @param {Boolean} [options.animate]     Whether to animate in/out. Default: false
   * @param {Function} [options.template]   Compiled underscore template to override the default one
   ###
  initialize: (options)->
    super
    @options = _.extend({
      title: null,
      okText: 'OK',
      cancelText: 'Cancel',
      allowCancel: true,
      escape: true,
      animate: true,
      template: template,
      css:''
    }, options);
    @delegate 'click', '.close', (event)->
      event.preventDefault()
      @trigger('cancel')

    @delegate 'click', '.cancel', (event)->
      event.preventDefault()
      @trigger('cancel')

    @delegate 'click', '.ok', (event)->
      event.preventDefault()
      @trigger('ok')
      @close()


  ###
   * Creates the DOM element
   * 
   * @api private
  ###
  render: ()->
    $el = @$el
    options = @options
    self = @

    ##Create the modal container
    $el.html(options.template(options));
    @renderSubviews()
    

    if options.animate
      $el.addClass('fade')
    #Focus OK button
    $el.one 'shown', ()->
      $el.find('.btn.ok').focus();
      self.trigger('shown');

    @isRendered = true;

    return @

  renderSubviews: ->
    content = @options.content
    $content =  @$el.find('.modal-body')
    if @options.css?
      @$el.addClass(@options.css)
    content.container=$content;
    self=@
    content.exit=()->
      self.close()
    content.renderIsWrapped=false
    #Insert the main content if it's a view
    content.render()
  ###
   * Renders and shows the modal
   *
   * @param {Function} [cb]     Optional callback that runs only when OK is pressed.
  ###
  open: (cb)->
    if !@isRendered
      @render();

    self = @
    $el = @$el;
    $el.on 'hidden_two', ()->
      self.dispose()
      true
    #Create it
    $el.modal({
      keyboard: @options.allowCancel,
       
    });
    $el.on 'shown', ()->
      if self.options?.content?.start?
        self.options.content.start()


 
    if (@options.allowCancel)

      $(document).one 'keyup.dismiss.modal', (e)->
        e.which == 27 && self.trigger('cancel');
    

    @on 'cancel', ()->
      self.close();

    @on 'ok', ()->
      self.ok();
    #Run callback on OK if provided
    if cd?
      self.on('ok', cb);

    return @

  ok:()->
    if @options?.content?.saveData?
      @options.content.saveData()

  ###
   * Closes the modal
  ###
  close: ()->
    self = this
    $el = @$el

    #Check if the modal should stay open
    if @_preventClose
      @_preventClose = false;
      return
    $el.modal('hide')

  ###
   * Stop the modal from closing.
   * Can be called from within a 'close' or 'ok' event listener.
  ###
  preventClose: ()->
    @_preventClose = true;
  dispose:()->
    if @options?.content?
      @options.content.dispose()
    super