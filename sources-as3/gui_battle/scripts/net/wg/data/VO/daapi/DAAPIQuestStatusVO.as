package net.wg.data.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIQuestStatusVO extends DAAPIDataClass
   {
       
      
      public var status:String = "";
      
      public var statusLabel:String = "";
      
      public function DAAPIQuestStatusVO(param1:Object)
      {
         super(param1);
      }
   }
}
