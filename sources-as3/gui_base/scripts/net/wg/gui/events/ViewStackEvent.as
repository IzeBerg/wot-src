package net.wg.gui.events
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   
   public class ViewStackEvent extends Event
   {
      
      public static var NEED_UPDATE:String = "need_update";
      
      public static var VIEW_CHANGED:String = "view_changed";
       
      
      private var _view:IViewStackContent;
      
      private var _viewId:String;
      
      public function ViewStackEvent(param1:String, param2:IViewStackContent, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._view = param2;
         this._viewId = param3;
      }
      
      override public function clone() : Event
      {
         return new ViewStackEvent(type,this._view,this._viewId,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ViewStackEvent","type","view","viewId","bubbles","cancelable","eventPhase");
      }
      
      public function get view() : IViewStackContent
      {
         return this._view;
      }
      
      public function get viewId() : String
      {
         return this._viewId;
      }
   }
}
