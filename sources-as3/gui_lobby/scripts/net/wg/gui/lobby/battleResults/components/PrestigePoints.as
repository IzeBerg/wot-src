package net.wg.gui.lobby.battleResults.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.lobby.battleResults.data.PrestigePointsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class PrestigePoints extends UIComponentEx
   {
      
      private static const LABEL_TF_X_SHIFT:int = 5;
      
      private static const INFO_ICON_GAP:int = 2;
       
      
      public var valueTf:TextField = null;
      
      public var labelTf:TextField = null;
      
      public var infoIcon:Sprite = null;
      
      private var _data:PrestigePointsVO = null;
      
      private var _commons:ICommons;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function PrestigePoints()
      {
         this._commons = App.utils.commons;
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.infoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
         this.infoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.valueTf.htmlText = this._data.value;
               this.labelTf.htmlText = this._data.label;
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this._commons.updateTextFieldSize(this.valueTf,true,false);
               this._commons.updateTextFieldSize(this.labelTf,true,false);
               _loc1_ = this.labelTf.width + this.infoIcon.width + INFO_ICON_GAP;
               this.labelTf.x = (this.valueTf.width - _loc1_ >> 1) + this.valueTf.x + LABEL_TF_X_SHIFT | 0;
               this.infoIcon.x = this.labelTf.x + this.labelTf.width + INFO_ICON_GAP | 0;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
         this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler);
         this.infoIcon = null;
         this.valueTf = null;
         this.labelTf = null;
         this._data = null;
         this._commons = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function setData(param1:PrestigePointsVO) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      private function onInfoIconRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(this._data.tooltip,null);
      }
      
      private function onInfoIconRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
