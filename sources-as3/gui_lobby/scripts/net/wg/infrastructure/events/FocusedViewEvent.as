package net.wg.infrastructure.events
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IView;
   
   public class FocusedViewEvent extends Event
   {
      
      public static const VIEW_FOCUSED:String = "viewFocused";
       
      
      private var _focusedView:IView = null;
      
      public function FocusedViewEvent(param1:String, param2:IView = null)
      {
         super(param1);
         this._focusedView = param2;
      }
      
      public function get focusedView() : IView
      {
         return this._focusedView;
      }
   }
}
