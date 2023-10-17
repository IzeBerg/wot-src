package net.wg.gui.lobby.eventBoards.components.battleComponents
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.eventBoards.data.BattleStatisticsBlockVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleStatisticsBlock extends UIComponentEx
   {
       
      
      public var statistic1Icon:IImage = null;
      
      public var statistic1ValueTf:TextField = null;
      
      public var statistic1Tf:TextField = null;
      
      public var statistic2Icon:IImage = null;
      
      public var statistic2ValueTf:TextField = null;
      
      public var statistic2Tf:TextField = null;
      
      public var statistic3Icon:IImage = null;
      
      public var statistic3ValueTf:TextField = null;
      
      public var statistic3Tf:TextField = null;
      
      public var statistic4Icon:IImage = null;
      
      public var statistic4ValueTf:TextField = null;
      
      public var statistic4Tf:TextField = null;
      
      private var _data:BattleStatisticsBlockVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function BattleStatisticsBlock()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.statistic1ValueTf.htmlText = App.utils.locale.integer(this._data.statistic1Value);
            this.statistic1Tf.htmlText = this._data.statistic1;
            this.statistic2ValueTf.htmlText = App.utils.locale.integer(this._data.statistic2Value);
            this.statistic2Tf.htmlText = this._data.statistic2;
            this.statistic3ValueTf.htmlText = App.utils.locale.integer(this._data.statistic3Value);
            this.statistic3Tf.htmlText = this._data.statistic3;
            this.statistic4ValueTf.htmlText = App.utils.locale.integer(this._data.statistic4Value);
            this.statistic4Tf.htmlText = this._data.statistic4;
            this.statistic1Icon.visible = StringUtils.isNotEmpty(this._data.statistic1Icon);
            if(this.statistic1Icon.visible)
            {
               this.statistic1Icon.source = this._data.statistic1Icon;
            }
            this.statistic2Icon.visible = StringUtils.isNotEmpty(this._data.statistic2Icon);
            if(this.statistic2Icon.visible)
            {
               this.statistic2Icon.source = this._data.statistic2Icon;
            }
            this.statistic3Icon.visible = StringUtils.isNotEmpty(this._data.statistic3Icon);
            if(this.statistic3Icon.visible)
            {
               this.statistic3Icon.source = this._data.statistic3Icon;
            }
            this.statistic4Icon.visible = StringUtils.isNotEmpty(this._data.statistic4Icon);
            if(this.statistic4Icon.visible)
            {
               this.statistic4Icon.source = this._data.statistic4Icon;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
         this.statistic1ValueTf = null;
         this.statistic1Tf = null;
         this.statistic2ValueTf = null;
         this.statistic2Tf = null;
         this.statistic3ValueTf = null;
         this.statistic3Tf = null;
         this.statistic4ValueTf = null;
         this.statistic4Tf = null;
         this.statistic1Icon.dispose();
         this.statistic1Icon = null;
         this.statistic2Icon.dispose();
         this.statistic2Icon = null;
         this.statistic3Icon.dispose();
         this.statistic3Icon = null;
         this.statistic4Icon.dispose();
         this.statistic4Icon = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         if(this._data != param1)
         {
            this._data = BattleStatisticsBlockVO(param1);
            invalidateData();
         }
      }
      
      private function onComponentRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._data)
         {
            return;
         }
         var _loc2_:String = Values.EMPTY_STR;
         switch(param1.target)
         {
            case this.statistic1Icon:
            case this.statistic1ValueTf:
            case this.statistic1Tf:
               _loc2_ = this._data.statistic1Tooltip;
               break;
            case this.statistic2Icon:
            case this.statistic2ValueTf:
            case this.statistic2Tf:
               _loc2_ = this._data.statistic2Tooltip;
               break;
            case this.statistic3Icon:
            case this.statistic3ValueTf:
            case this.statistic3Tf:
               _loc2_ = this._data.statistic3Tooltip;
               break;
            case this.statistic4Icon:
            case this.statistic4ValueTf:
            case this.statistic4Tf:
               _loc2_ = this._data.statistic4Tooltip;
               break;
            default:
               return;
         }
         this._toolTipMgr.showComplex(_loc2_);
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
