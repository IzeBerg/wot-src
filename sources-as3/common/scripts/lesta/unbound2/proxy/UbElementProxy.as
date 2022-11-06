package lesta.unbound2.proxy
{
   import flash.display.DisplayObject;
   import lesta.unbound2.proxy.base.UbProxy;
   
   public class UbElementProxy extends UbProxy
   {
      
      public static const EVENT_CLEANUP:String = "eventCleanup";
      
      public static const EVENT_REBUILT:String = "eventRebuilt";
       
      
      public var p_elementId:int;
      
      public var p_view:DisplayObject;
      
      public var p_setScopeValue:Function;
      
      public function UbElementProxy()
      {
         super();
      }
      
      public function get elementId() : int
      {
         return this.p_elementId;
      }
      
      public function get view() : DisplayObject
      {
         return this.p_view;
      }
      
      public function setScopeValue(param1:String, param2:*) : void
      {
         this.p_setScopeValue(param1,param2);
      }
   }
}
