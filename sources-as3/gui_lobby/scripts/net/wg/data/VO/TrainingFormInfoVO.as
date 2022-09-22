package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TrainingFormInfoVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var descr:String = "";
      
      public var battleTypeID:String = "";
      
      public function TrainingFormInfoVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
