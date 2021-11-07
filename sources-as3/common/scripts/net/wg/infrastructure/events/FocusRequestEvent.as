package net.wg.infrastructure.events
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   
   public class FocusRequestEvent extends Event
   {
      
      public static const REQUEST_FOCUS:String = "REQUEST_FOCUS";
       
      
      private var _focusContainer:IFocusContainer = null;
      
      public function FocusRequestEvent(param1:String, param2:IFocusContainer)
      {
         super(param1,true,false);
         this._focusContainer = param2;
      }
      
      public function get focusContainer() : IFocusContainer
      {
         return this._focusContainer;
      }
   }
}
