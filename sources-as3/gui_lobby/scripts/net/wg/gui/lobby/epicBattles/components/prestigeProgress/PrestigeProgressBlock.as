package net.wg.gui.lobby.epicBattles.components.prestigeProgress
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesPrestigeProgressBlockVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class PrestigeProgressBlock extends UIComponentEx
   {
       
      
      public var textfield:TextField = null;
      
      public var icon:UILoaderAlt = null;
      
      protected var dataVO:EpicBattlesPrestigeProgressBlockVO = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      public function PrestigeProgressBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OUT,this.onPrestigeProgressBlockRollOutHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onPrestigeProgressBlockRollOverHandler);
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadingCompleteHandler);
         this.icon.dispose();
         this.icon = null;
         this.textfield = null;
         this._toolTipMgr = null;
         this.dataVO = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._toolTipMgr = App.toolTipMgr;
         addEventListener(MouseEvent.ROLL_OUT,this.onPrestigeProgressBlockRollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onPrestigeProgressBlockRollOverHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.dataVO != null && isInvalid(InvalidationType.DATA))
         {
            this.setInternalText();
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadingCompleteHandler,false,0,true);
            this.icon.source = this.dataVO.iconPath;
         }
      }
      
      public function setData(param1:EpicBattlesPrestigeProgressBlockVO) : void
      {
         this.dataVO = param1;
         invalidateData();
      }
      
      protected function setInternalText() : void
      {
         this.textfield.text = this.dataVO.levelText;
      }
      
      private function onPrestigeProgressBlockRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onPrestigeProgressBlockRollOverHandler(param1:MouseEvent) : void
      {
         if(this.dataVO != null)
         {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.EPIC_PRESTIGE_PROGRESS_BLOCK_INFO,null,this.dataVO.prestigeLevel);
         }
      }
      
      private function onIconLoadingCompleteHandler(param1:UILoaderEvent) : void
      {
         this.icon.x = -this.icon.width >> 1;
         this.icon.y = -this.icon.height >> 1;
         this.textfield.x = -this.icon.width >> 1;
      }
   }
}
