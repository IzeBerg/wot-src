package net.wg.gui.lobby.eventBoards.components.headerComponents
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.data.HeaderAwardBlockVO;
   import net.wg.gui.lobby.eventBoards.events.TypeEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class HeaderAwardBlock extends UIComponentEx
   {
      
      private static const AWARD_CLICK:String = "awardClick";
      
      private static const TOOLTIP_MAX_WIDTH:int = 400;
       
      
      public var title:TextFieldNoSound = null;
      
      public var uiIcon:IImage = null;
      
      public var btnAward:ISoundButtonEx = null;
      
      private var _data:HeaderAwardBlockVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _eventID:String = "";
      
      public function HeaderAwardBlock()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnAward.addEventListener(ButtonEvent.CLICK,this.onBtnAwardClickHandler);
         this.btnAward.usePreventUpdateTextScale = true;
         addEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
         this.title.textField.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.title.textField.htmlText = this._data.title;
            this.uiIcon.visible = StringUtils.isNotEmpty(this._data.uiIcon);
            if(this.uiIcon.visible)
            {
               this.uiIcon.source = this._data.uiIcon;
            }
            this.btnAward.label = this._data.label;
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
         this.title.dispose();
         this.title = null;
         this.uiIcon.dispose();
         this.uiIcon = null;
         this.btnAward.removeEventListener(ButtonEvent.CLICK,this.onBtnAwardClickHandler);
         this.btnAward.dispose();
         this.btnAward = null;
         this._data = null;
         this._toolTipMgr = null;
         this._eventID = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         if(this._data != param1)
         {
            this._data = HeaderAwardBlockVO(param1);
            invalidateData();
         }
      }
      
      public function setEventID(param1:String) : void
      {
         this._eventID = param1;
      }
      
      private function onBtnAwardClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new TypeEvent(AWARD_CLICK,this._eventID,true));
         }
      }
      
      private function onComponentRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._data)
         {
            return;
         }
         var _loc2_:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,-1,0,TOOLTIP_MAX_WIDTH);
         var _loc3_:String = Values.EMPTY_STR;
         switch(param1.target)
         {
            case this.uiIcon:
               _loc3_ = this._data.iconTooltip;
               break;
            case this.btnAward:
               _loc3_ = this._data.buttonTooltip;
               break;
            default:
               return;
         }
         this._toolTipMgr.showComplex(_loc3_,_loc2_);
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
