class ShowController extends Stimulus.Controller {
  connect() {
    let self = this.element;
    $(self).mouseenter(function(){
      $(self).children('.image').children('.xxx').css('visibility', 'visible');
      $(self).children('.content').children('.right.floated').children('.xxx').css('visibility', 'visible')
    });
    $(self).mouseleave(function(){
      $(self).children('.image').children('.xxx').css('visibility', 'hidden');
      $(self).children('.content').children('.right.floated').children('.xxx').css('visibility', 'hidden')
    });
  }
}
ShowController.targets = ['src'];
application.register('show', ShowController);


