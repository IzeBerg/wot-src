package lesta.unbound2.proxy
{
   import lesta.unbound2.UBPopoverCallerWrapper;
   import lesta.unbound2.UbBackgroundPainter;
   import lesta.unbound2.proxy.base.UbProxy;
   import lesta.unbound2.type_system.UbNumber;
   
   public class UbPlayerProxy extends UbProxy
   {
      
      private static const clazz:Class = UbBackgroundPainter;
      
      private static const popoverWrapperClazz:Class = UBPopoverCallerWrapper;
      
      private static const numberClazz:Class = UbNumber;
       
      
      public var p_addFile:Function;
      
      public var p_buildElement:Function;
      
      public var p_destroyElement:Function;
      
      public var p_registerAsClass:Function;
      
      public function UbPlayerProxy()
      {
         super();
      }
      
      public function addFile(param1:String) : void
      {
         this.p_addFile(param1);
      }
      
      public function buildElement(param1:String, param2:Object = null, param3:Object = null) : UbElementProxy
      {
         return this.p_buildElement(param1,param2,param3);
      }
      
      public function destroyElement(param1:int) : void
      {
         this.p_destroyElement(param1);
      }
      
      public function registerAsClass(param1:String, param2:String, param3:Array = null) : void
      {
         this.p_registerAsClass(param1,param2,param3);
      }
   }
}
