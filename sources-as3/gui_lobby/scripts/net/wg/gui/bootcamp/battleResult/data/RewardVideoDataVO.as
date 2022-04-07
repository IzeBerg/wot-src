package net.wg.gui.bootcamp.battleResult.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RewardVideoDataVO extends DAAPIDataClass
   {
       
      
      public var image:String = "";
      
      public var totalCount:int = 0;
      
      public function RewardVideoDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
