package net.wg.gui.lobby.eventBoards.components.headerComponents
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.data.HeaderConditionBlockVO;
   import net.wg.gui.lobby.eventBoards.events.TypeEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   import scaleform.gfx.TextFieldEx;
   
   public class HeaderConditionBlock extends UIComponentEx
   {
      
      private static const TECHNIQUE_CLICK:String = "techniqueClick";
      
      private static const INFORMATION_ICON_OFFSET:int = 5;
      
      private static const DESCRIPTION_WIDTH_OFFSET:int = 115;
      
      private static const ICON_POSITION_OFFSET:int = 5;
      
      private static const DESCRIPTION_POSITION_OFFSET:int = 45;
      
      private static const TOOLTIP_MAX_WIDTH:int = 400;
       
      
      public var title:TextFieldNoSound = null;
      
      public var uiIcon1:IImage = null;
      
      public var uiIcon2:IImage = null;
      
      public var uiIcon3:IImage = null;
      
      public var description1:TextField = null;
      
      public var description2:TextField = null;
      
      public var description3:TextField = null;
      
      public var btnTechnique:ISoundButtonEx = null;
      
      public var informationIcon:Sprite = null;
      
      private var _data:HeaderConditionBlockVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _eventID:String = "";
      
      public function HeaderConditionBlock()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.informationIcon.visible = false;
         this.btnTechnique.addEventListener(ButtonEvent.CLICK,this.onBtnTechniqueClickHandler);
         this.btnTechnique.usePreventUpdateTextScale = true;
         TextFieldEx.setVerticalAlign(this.description1,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.description2,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.description3,TextFieldEx.VALIGN_CENTER);
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
            this.uiIcon1.visible = StringUtils.isNotEmpty(this._data.uiIcon1);
            if(this.uiIcon1.visible)
            {
               this.uiIcon1.source = this._data.uiIcon1;
            }
            this.uiIcon2.visible = StringUtils.isNotEmpty(this._data.uiIcon2);
            if(this.uiIcon2.visible)
            {
               this.uiIcon2.source = this._data.uiIcon2;
            }
            this.uiIcon3.visible = StringUtils.isNotEmpty(this._data.uiIcon3);
            if(this.uiIcon3.visible)
            {
               this.uiIcon3.source = this._data.uiIcon3;
            }
            this.description1.htmlText = this._data.description1;
            this.description2.htmlText = this._data.description2;
            this.description3.htmlText = this._data.description3;
            this.btnTechnique.label = this._data.label;
            this.btnTechnique.visible = this._data.buttonVisible;
            this.informationIcon.visible = StringUtils.isNotEmpty(this._data.description2Tooltip);
         }
      }
      
      public function updateContentWidth(param1:int) : void
      {
         this.description1.width = this.description2.width = this.description3.width = param1 - DESCRIPTION_WIDTH_OFFSET;
         var _loc2_:int = Math.max(this.description1.textWidth,this.description2.textWidth,this.description3.textWidth);
         var _loc3_:int = -(DESCRIPTION_POSITION_OFFSET + _loc2_ >> 1) - ICON_POSITION_OFFSET;
         this.uiIcon1.x = this.uiIcon2.x = this.uiIcon3.x = _loc3_;
         this.description1.x = this.description2.x = this.description3.x = _loc3_ + DESCRIPTION_POSITION_OFFSET;
         if(this.informationIcon.visible)
         {
            this.informationIcon.x = this.description2.x + this.description2.textWidth + INFORMATION_ICON_OFFSET;
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
         this.title.dispose();
         this.title = null;
         this.uiIcon1.dispose();
         this.uiIcon1 = null;
         this.uiIcon2.dispose();
         this.uiIcon2 = null;
         this.uiIcon3.dispose();
         this.uiIcon3 = null;
         this.description1 = null;
         this.description2 = null;
         this.description3 = null;
         this.informationIcon = null;
         this.btnTechnique.removeEventListener(ButtonEvent.CLICK,this.onBtnTechniqueClickHandler);
         this.btnTechnique.dispose();
         this.btnTechnique = null;
         this._data = null;
         this._toolTipMgr = null;
         this._eventID = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         if(this._data != param1)
         {
            this._data = HeaderConditionBlockVO(param1);
            invalidateData();
         }
      }
      
      public function setEventID(param1:String) : void
      {
         this._eventID = param1;
      }
      
      private function onBtnTechniqueClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new TypeEvent(TECHNIQUE_CLICK,this._eventID,true));
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
            case this.uiIcon1:
            case this.description1:
               _loc3_ = this._data.description1Tooltip;
               break;
            case this.uiIcon2:
            case this.description2:
            case this.informationIcon:
               _loc3_ = this._data.description2Tooltip;
               break;
            case this.uiIcon3:
            case this.description3:
               _loc3_ = this._data.description3Tooltip;
               break;
            case this.btnTechnique:
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
