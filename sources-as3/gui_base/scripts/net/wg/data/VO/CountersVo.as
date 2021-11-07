package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CountersVo extends DAAPIDataClass
   {
       
      
      public var componentId:String = "";
      
      public var count:String = "";
      
      public var selectedIdx:int = 0;
      
      public function CountersVo(param1:Object = null)
      {
         super(param1);
      }
   }
}
