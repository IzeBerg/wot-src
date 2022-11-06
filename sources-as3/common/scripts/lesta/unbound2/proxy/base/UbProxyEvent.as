package lesta.unbound2.proxy.base
{
   import flash.events.Event;
   
   public class UbProxyEvent extends Event
   {
       
      
      public var data:Object;
      
      public function UbProxyEvent(param1:String, param2:Object)
      {
         super(param1);
         this.data = param2;
      }
   }
}
