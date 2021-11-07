package scaleform.clik.data
{
   import flash.external.ExternalInterface;
   
   public class DataBinding
   {
      
      public static var createBindingImpl:Object;
      
      public static var deleteBindingImpl:Object;
       
      
      public function DataBinding()
      {
         super();
      }
      
      public static function initialize() : void
      {
         ExternalInterface.call("dataBindingInit",DataBinding);
      }
      
      public static function createBinding(param1:String, param2:Object, param3:Object = null) : void
      {
         if(createBindingImpl)
         {
            createBindingImpl(param1,param2,param3);
         }
      }
      
      public static function deleteBinding(param1:String, param2:Object, param3:Object = null) : void
      {
         if(deleteBindingImpl)
         {
            deleteBindingImpl(param1,param2,param3);
         }
      }
   }
}
