package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.interfaces.IReusableListItemRenderer;
   import net.wg.gui.lobby.eventBoards.data.MissionEventBoardsCardVO;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ListEvent;
   
   public class MissionsEventBoardsCardRenderer extends SoundListItemRenderer implements IReusableListItemRenderer
   {
      
      private static const RIBBON_OFFSET:int = 39;
      
      private static const DESCRIPTION_OFFSET:int = 63;
      
      private static const DESCRIPTION_OFFSET2:int = 56;
      
      private static const DISABLED_ALPHA:Number = 0.7;
      
      private static const INVALID_DATA:String = "invalidData";
      
      private static const PICTURE_OFFSET_X:int = 379;
      
      private static const PICTURE_OFFSET_Y:int = 111;
      
      private static const INFORMATION_ICON_OFFSET:int = 5;
      
      private static const DIVIDER_OFFSET:int = 33;
       
      
      public var titleTF:TextField = null;
      
      public var amountTF:TextField = null;
      
      public var typeTF:TextField = null;
      
      public var description1TF:TextField = null;
      
      public var description2TF:TextField = null;
      
      public var ribbon:MovieClip = null;
      
      public var uiPicture:IImage = null;
      
      public var uiDecoration:IImage = null;
      
      public var background:MovieClip = null;
      
      public var amountMc:MovieClip = null;
      
      public var hitMc:MovieClip = null;
      
      public var informationIcon:Sprite = null;
      
      public var divider:Sprite = null;
      
      private var _rendererData:MissionEventBoardsCardVO;
      
      private var _enabled:Boolean = true;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _amountTooltip:String = "";
      
      private var _descriptionTooltip:String = "";
      
      private var _ribbonTooltip:String = "";
      
      public function MissionsEventBoardsCardRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         preventAutosizing = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useHandCursor = true;
         mouseChildren = true;
         this.hitMc.mouseEnabled = true;
         this.hitMc.buttonMode = true;
         this.amountMc.addEventListener(MouseEvent.ROLL_OVER,this.onAmountRollOverHandler);
         this.amountMc.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.amountMc.buttonMode = true;
         this.informationIcon.addEventListener(MouseEvent.ROLL_OVER,this.onDescriptionRollOverHandler);
         this.informationIcon.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.informationIcon.visible = false;
         this.informationIcon.buttonMode = true;
         this.divider.mouseEnabled = false;
         this.ribbon.addEventListener(MouseEvent.ROLL_OVER,this.onRibbonRollOverHandler);
         this.ribbon.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.ribbon.buttonMode = true;
         this.uiPicture.addEventListener(Event.CHANGE,this.onPictureChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._rendererData != null && isInvalid(INVALID_DATA))
         {
            this.titleTF.htmlText = this._rendererData.title;
            this.amountTF.htmlText = App.utils.locale.integer(this._rendererData.amount);
            this.typeTF.htmlText = this._rendererData.type;
            this.description1TF.htmlText = this._rendererData.description1;
            this.description2TF.htmlText = this._rendererData.description2;
            this.divider.y = Math.round(this.typeTF.y + this.typeTF.textHeight - DIVIDER_OFFSET);
            this.ribbon.visible = this._rendererData.ribbon > 0;
            if(this.ribbon.visible)
            {
               this.ribbon.gotoAndStop(this._rendererData.ribbon);
               this.ribbon.y = this.divider.y + RIBBON_OFFSET;
               this.description1TF.y = this.ribbon.y + DESCRIPTION_OFFSET;
               this.description2TF.visible = false;
            }
            else
            {
               this.informationIcon.y = this.description1TF.y = this.divider.y + DESCRIPTION_OFFSET2;
               this.description2TF.y = this.description1TF.y + this.description1TF.textHeight;
            }
            this.informationIcon.visible = StringUtils.isNotEmpty(this._rendererData.descriptionTooltip);
            if(this.informationIcon.visible)
            {
               this.informationIcon.x = this.description1TF.x + (this.description1TF.textWidth + this.description1TF.width >> 1) + INFORMATION_ICON_OFFSET;
               this.informationIcon.y = this.description1TF.y + INFORMATION_ICON_OFFSET;
            }
            this._amountTooltip = this._rendererData.amountTooltip;
            this._descriptionTooltip = this._rendererData.descriptionTooltip;
            this._ribbonTooltip = this._rendererData.ribbonTooltip;
            this.background.gotoAndStop(this._rendererData.background);
            this.uiPicture.visible = StringUtils.isNotEmpty(this._rendererData.uiPicture);
            if(this.uiPicture.visible)
            {
               this.uiPicture.source = this._rendererData.uiPicture;
            }
            this.uiDecoration.visible = StringUtils.isNotEmpty(this._rendererData.uiDecoration);
            if(this.uiDecoration.visible)
            {
               this.uiDecoration.source = this._rendererData.uiDecoration;
            }
            this.enabled = this._rendererData.isAvailable;
         }
      }
      
      override protected function onDispose() : void
      {
         this.uiPicture.removeEventListener(Event.CHANGE,this.onPictureChangeHandler);
         this.uiPicture.dispose();
         this.uiPicture = null;
         this.uiDecoration.dispose();
         this.uiDecoration = null;
         this.titleTF = null;
         this.amountMc.removeEventListener(MouseEvent.ROLL_OVER,this.onAmountRollOverHandler);
         this.amountMc.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.amountMc = null;
         this.amountTF = null;
         this.typeTF = null;
         this.description1TF = null;
         this.description2TF = null;
         this.ribbon.removeEventListener(MouseEvent.ROLL_OVER,this.onRibbonRollOverHandler);
         this.ribbon.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.ribbon = null;
         this.background = null;
         this.hitMc = null;
         this.informationIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onDescriptionRollOverHandler);
         this.informationIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.informationIcon = null;
         this.divider = null;
         this._rendererData = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         super.handleClick(param1);
         dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK,true,false,_index,-1,-1,this,this._rendererData));
      }
      
      public function cleanUp() : void
      {
      }
      
      override public function set data(param1:Object) : void
      {
         if(this._rendererData != param1)
         {
            this._rendererData = MissionEventBoardsCardVO(param1);
            this._rendererData.blockID = this._rendererData.cardID;
            invalidate(INVALID_DATA);
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(this._enabled == param1)
         {
            return;
         }
         this.alpha = !!param1 ? Number(1) : Number(DISABLED_ALPHA);
         this._enabled = param1;
      }
      
      private function onAmountRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._amountTooltip);
      }
      
      private function onDescriptionRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._descriptionTooltip);
      }
      
      private function onRibbonRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._ribbonTooltip);
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onPictureChangeHandler(param1:Event) : void
      {
         this.uiPicture.x = Math.round(PICTURE_OFFSET_X - (this.uiPicture.width >> 1));
         this.uiPicture.y = Math.round(PICTURE_OFFSET_Y - (this.uiPicture.height >> 1));
      }
   }
}
