package net.wg.gui.lobby.techtree.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BlueprintBalanceVO extends DAAPIDataClass
   {
      
      private static const INTERNATIONAL_ITEM_VO:String = "internationalItemVO";
      
      private static const NATIONAL_ITEM_VO:String = "nationalItemVO";
       
      
      public var balanceStr:String = "";
      
      public var internationalItemVO:BlueprintBalanceItemVO = null;
      
      public var nationalItemVO:BlueprintBalanceItemVO = null;
      
      public function BlueprintBalanceVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == INTERNATIONAL_ITEM_VO)
         {
            this.internationalItemVO = new BlueprintBalanceItemVO(param2);
            return false;
         }
         if(param1 == NATIONAL_ITEM_VO)
         {
            this.nationalItemVO = new BlueprintBalanceItemVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.internationalItemVO.dispose();
         this.internationalItemVO = null;
         this.nationalItemVO.dispose();
         this.nationalItemVO = null;
         super.onDispose();
      }
   }
}
