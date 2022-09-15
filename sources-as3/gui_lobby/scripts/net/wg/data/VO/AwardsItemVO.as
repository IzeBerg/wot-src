package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.BoosterSlotVO;
   
   public class AwardsItemVO extends DAAPIDataClass
   {
      
      private static const BOOSTER_VO:String = "boosterVO";
       
      
      public var value:String = "";
      
      public var itemSource:String = "";
      
      public var tooltip:String = "";
      
      public var boosterVO:BoosterSlotVO = null;
      
      public function AwardsItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BOOSTER_VO && param2 != null)
         {
            this.boosterVO = new BoosterSlotVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.boosterVO != null)
         {
            this.boosterVO.dispose();
            this.boosterVO = null;
         }
         super.onDispose();
      }
   }
}
