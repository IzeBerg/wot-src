package net.wg.gui.bootcamp.battleResult.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RewardDataVO extends DAAPIDataClass
   {
       
      
      public var value:int = -1;
      
      public var str:String = "";
      
      public function RewardDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
