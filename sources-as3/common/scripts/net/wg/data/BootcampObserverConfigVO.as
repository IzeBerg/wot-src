package net.wg.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BootcampObserverConfigVO extends DAAPIDataClass
   {
       
      
      public var viewClassName:String = "";
      
      public var observerClassName:String = "";
      
      public var daapiAlias:String = "";
      
      public function BootcampObserverConfigVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
