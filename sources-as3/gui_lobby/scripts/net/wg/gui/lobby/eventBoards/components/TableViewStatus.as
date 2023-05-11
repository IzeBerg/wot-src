package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsTableViewStatusVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class TableViewStatus extends UIComponentEx
   {
      
      private static const PARTICIPATE_CLICK:String = "participateClick";
      
      private static const STATUS_CHANGE_HEIGHT:String = "statusChangeHeight";
      
      private static const PARTICIPATE_Y1:int = 14;
      
      private static const PARTICIPATE_Y2:int = 70;
      
      private static const INFORMATION_ICON_OFFSET:int = 5;
      
      private static const STATUS_HEIGHT_BIG:int = 108;
      
      private static const STATUS_HEIGHT_SMALL:int = 49;
      
      private static const TOOLTIP_MAX_WIDTH:int = 400;
      
      private static const TEXT_FIELD_YPOS:Number = 70;
       
      
      public var titleTf:TextField = null;
      
      public var informationIcon:Sprite = null;
      
      public var infoTf:TextField = null;
      
      public var value1Tf:TextField = null;
      
      public var value2Tf:TextField = null;
      
      public var value3Tf:TextField = null;
      
      public var valueTimeTf:TextField = null;
      
      public var btnParticipate:ISoundButtonEx = null;
      
      public var back:MovieClip = null;
      
      private var _data:EventBoardsTableViewStatusVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function TableViewStatus()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTf.addEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.titleTf.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.informationIcon.addEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.informationIcon.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.informationIcon.visible = false;
         this.btnParticipate.addEventListener(ButtonEvent.CLICK,this.onBtnParticipateClickHandler);
         this.btnParticipate.addEventListener(MouseEvent.ROLL_OVER,this.onButtonOverHandler);
         this.btnParticipate.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.btnParticipate.visible = false;
         this.btnParticipate.usePreventUpdateTextScale = true;
      }
      
      override protected function onDispose() : void
      {
         this.titleTf.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.titleTf.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.titleTf = null;
         this.infoTf = null;
         this.value1Tf = null;
         this.value2Tf = null;
         this.value3Tf = null;
         this.valueTimeTf = null;
         this.informationIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.informationIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.informationIcon = null;
         this.btnParticipate.removeEventListener(ButtonEvent.CLICK,this.onBtnParticipateClickHandler);
         this.btnParticipate.removeEventListener(MouseEvent.ROLL_OVER,this.onButtonOverHandler);
         this.btnParticipate.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.btnParticipate.dispose();
         this.btnParticipate = null;
         this.back = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.titleTf.htmlText = this._data.title;
            this.infoTf.htmlText = this._data.info;
            this.value1Tf.htmlText = this._data.value1;
            this.value2Tf.htmlText = this._data.value2;
            this.value3Tf.htmlText = this._data.value3;
            if(StringUtils.isNotEmpty(this._data.valueTime))
            {
               this.valueTimeTf.htmlText = this._data.valueTime;
               this.value2Tf.y = TEXT_FIELD_YPOS;
            }
            else
            {
               this.valueTimeTf.visible = false;
            }
            this.btnParticipate.label = this._data.buttonLabel;
            this.btnParticipate.visible = this._data.buttonVisible;
            this.btnParticipate.enabled = this._data.buttonEnabled;
            this.btnParticipate.y = !!this._data.buttonTop ? Number(PARTICIPATE_Y1) : Number(PARTICIPATE_Y2);
            if(StringUtils.isNotEmpty(this._data.info) || this.btnParticipate.visible && !this._data.buttonTop)
            {
               this.back.gotoAndStop(1);
            }
            else
            {
               this.back.gotoAndStop(2);
            }
            dispatchEvent(new Event(STATUS_CHANGE_HEIGHT,true));
            this.informationIcon.visible = StringUtils.isNotEmpty(this._data.titleTooltip);
            if(this.informationIcon.visible)
            {
               this.informationIcon.x = this.titleTf.x + (this.titleTf.textWidth + this.titleTf.width >> 1) + INFORMATION_ICON_OFFSET;
            }
         }
      }
      
      public function getHeight() : int
      {
         return this.back.currentFrame == 1 ? int(STATUS_HEIGHT_BIG) : int(STATUS_HEIGHT_SMALL);
      }
      
      public function update(param1:Object) : void
      {
         this._data = EventBoardsTableViewStatusVO(param1);
         invalidateData();
      }
      
      private function onBtnParticipateClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new Event(PARTICIPATE_CLICK,true));
         }
      }
      
      private function onTitleRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:TooltipProps = null;
         if(!this.informationIcon.visible || this.informationIcon.visible && param1.target == this.informationIcon)
         {
            _loc2_ = new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,-1,0,TOOLTIP_MAX_WIDTH);
            this._toolTipMgr.showComplex(this._data.titleTooltip,_loc2_);
         }
      }
      
      private function onButtonOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._data.buttonTooltip);
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
