package net.wg.gui.lobby.dialogs.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.lobby.tankman.vo.TankmanSkillsInfoBlockVO;
   
   public class TankmanOperationDialogVO extends DAAPIDataClass
   {
      
      private static const ACTION_PRICE_VO:String = "actionPriceVO";
      
      private static const TANKMAN_BLOCK_VO:String = "tankmanBlockVO";
       
      
      public var alertText:String = "";
      
      public var alertTooltip:String = "";
      
      public var alertImgSrc:String = "";
      
      public var questionText:String = "";
      
      public var restoreCurrency:String = "";
      
      public var restorePrice:String = "";
      
      public var isEnoughMoneyForRestore:Boolean = true;
      
      public var actionPriceVO:ActionPriceVO = null;
      
      public var tankmanBlockVO:TankmanSkillsInfoBlockVO = null;
      
      public var isProtectedState:Boolean = true;
      
      public var warningText:String = "";
      
      public function TankmanOperationDialogVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ACTION_PRICE_VO && param2 != null)
         {
            this.actionPriceVO = new ActionPriceVO(param2);
            return false;
         }
         if(param1 == TANKMAN_BLOCK_VO)
         {
            this.tankmanBlockVO = new TankmanSkillsInfoBlockVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.actionPriceVO != null)
         {
            this.actionPriceVO.dispose();
            this.actionPriceVO = null;
         }
         this.tankmanBlockVO.dispose();
         this.tankmanBlockVO = null;
         super.onDispose();
      }
   }
}
