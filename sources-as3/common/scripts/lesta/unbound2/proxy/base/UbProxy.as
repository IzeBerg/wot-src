package lesta.unbound2.proxy.base
{
   import flash.events.EventDispatcher;
   
   public class UbProxy extends EventDispatcher
   {
       
      
      public var p_id:int;
      
      public var p_destroy:Function;
      
      public function UbProxy()
      {
         super();
      }
      
      public function destroy() : void
      {
         this.p_destroy();
      }
      
      public function get id() : int
      {
         return this.p_id;
      }
      
      public function from_cpp_dispatchEvent(param1:String, param2:Object = null) : void
      {
         dispatchEvent(new UbProxyEvent(param1,param2));
      }
   }
}
