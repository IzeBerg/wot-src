package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ShopNationFilterDataVo extends DAAPIDataClass
   {
       
      
      public var actionsSelected:Boolean = false;
      
      public var language:Number = -1;
      
      public var tabType:String = "";
      
      public var fittingType:String = "";
      
      public function ShopNationFilterDataVo(param1:Object)
      {
         super(param1);
      }
   }
}
