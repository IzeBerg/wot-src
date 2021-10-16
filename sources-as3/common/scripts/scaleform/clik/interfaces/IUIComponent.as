package scaleform.clik.interfaces
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IMovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IIdentifiable;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.InputEvent;
   
   public interface IUIComponent extends IMovieClip, IDisposable, IIdentifiable
   {
       
      
      function get focusTarget() : UIComponent;
      
      function set focusTarget(param1:UIComponent) : void;
      
      function validateNow(param1:Event = null) : void;
      
      function handleInput(param1:InputEvent) : void;
   }
}
