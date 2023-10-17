package net.wg.infrastructure.events
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IManagedContent;
   
   public class ManagedContainerEvent extends Event
   {
      
      public static const CONTENT_REMOVED:String = "contentRemoved";
       
      
      private var _content:IManagedContent;
      
      private var _layer:int;
      
      public function ManagedContainerEvent(param1:String, param2:IManagedContent, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._content = param2;
         this._layer = param3;
      }
      
      override public function clone() : Event
      {
         return new ManagedContainerEvent(type,this._content,this._layer,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ManagedContainerEvent","type","content","containerName","bubbles","cancelable","eventPhase");
      }
      
      public function get content() : IManagedContent
      {
         return this._content;
      }
      
      public function get layer() : int
      {
         return this._layer;
      }
   }
}
