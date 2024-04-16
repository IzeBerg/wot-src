package net.wg.gui.lobby.techtree.controls
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.techtree.data.BlueprintBalanceVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class BalanceContainer extends Sprite implements IDisposable
   {
      
      private static const BALANCE_OFFSET:int = -16;
      
      private static const TITLE_GAP:int = 12;
      
      private static const TF_GAP:int = 14;
       
      
      public var internationalItem:BlueprintBalanceItem = null;
      
      public var nationalItem:BlueprintBalanceItem = null;
      
      public var titleTF:TextField = null;
      
      private var _disposed:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function BalanceContainer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this.internationalItem.addEventListener(MouseEvent.ROLL_OVER,this.onFragmentRollOverHandler);
         this.internationalItem.addEventListener(MouseEvent.ROLL_OUT,this.onFragmentRollOutHandler);
         this.nationalItem.addEventListener(MouseEvent.ROLL_OVER,this.onFragmentRollOverHandler);
         this.nationalItem.addEventListener(MouseEvent.ROLL_OUT,this.onFragmentRollOutHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setBalance(param1:BlueprintBalanceVO) : void
      {
         this.titleTF.htmlText = param1.balanceStr;
         App.utils.commons.updateTextFieldSize(this.titleTF,true,true);
         this.internationalItem.setData(param1.internationalItemVO);
         this.nationalItem.setData(param1.nationalItemVO);
         this.nationalItem.x = BALANCE_OFFSET - this.nationalItem.width | 0;
         this.internationalItem.x = this.nationalItem.x - this.internationalItem.width - TF_GAP | 0;
         this.titleTF.x = this.internationalItem.x - this.titleTF.width - TITLE_GAP | 0;
      }
      
      protected function onDispose() : void
      {
         this.internationalItem.removeEventListener(MouseEvent.ROLL_OVER,this.onFragmentRollOverHandler);
         this.internationalItem.removeEventListener(MouseEvent.ROLL_OUT,this.onFragmentRollOutHandler);
         this.nationalItem.removeEventListener(MouseEvent.ROLL_OVER,this.onFragmentRollOverHandler);
         this.nationalItem.removeEventListener(MouseEvent.ROLL_OUT,this.onFragmentRollOutHandler);
         this.internationalItem = null;
         this.nationalItem = null;
         this.titleTF = null;
         this._toolTipMgr = null;
      }
      
      private function onFragmentRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = (param1.currentTarget as BlueprintBalanceItem).getFragmentCD();
         if(this._toolTipMgr == null || _loc2_ == -1)
         {
            return;
         }
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BLUEPRINT_FRAGMENT_INFO,null,_loc2_);
      }
      
      private function onFragmentRollOutHandler(param1:MouseEvent) : void
      {
         if(this._toolTipMgr)
         {
            this._toolTipMgr.hide();
         }
      }
   }
}
