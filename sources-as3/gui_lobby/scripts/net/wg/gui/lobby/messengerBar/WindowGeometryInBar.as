package net.wg.gui.lobby.messengerBar
{
   import net.wg.gui.events.MessengerBarEvent;
   import net.wg.infrastructure.base.DefaultWindowGeometry;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.infrastructure.interfaces.IWindow;
   
   public class WindowGeometryInBar extends DefaultWindowGeometry
   {
       
      
      private var eventType:String;
      
      private var clientID:Number;
      
      private var doPositionOnce:Boolean = true;
      
      public function WindowGeometryInBar(param1:String, param2:Number = 0)
      {
         super();
         this.eventType = param1;
         this.clientID = param2;
      }
      
      override public function setPosition(param1:IWindow) : Boolean
      {
         var _loc2_:IAbstractWindowView = param1.windowContent;
         if(_loc2_ && this.doPositionOnce)
         {
            _loc2_.dispatchEvent(new MessengerBarEvent(this.eventType,this.clientID));
            this.doPositionOnce = false;
         }
         return false;
      }
   }
}
