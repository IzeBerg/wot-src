package net.wg.infrastructure.events
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IView;
   
   public class ContainerManagerEvent extends Event
   {
      
      public static const VIEW_ADDED:String = "viewAdded";
      
      public static const VIEW_REMOVED:String = "viewRemoved";
       
      
      private var _view:IView;
      
      private var _layer:int;
      
      public function ContainerManagerEvent(param1:String, param2:IView, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._view = param2;
         this._layer = param3;
      }
      
      override public function clone() : Event
      {
         return new ContainerManagerEvent(type,this._view,this._layer,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ContainerManagerEvent","type","view","containerName","bubbles","cancelable","eventPhase");
      }
      
      public function get view() : IView
      {
         return this._view;
      }
      
      public function get layer() : int
      {
         return this._layer;
      }
   }
}
