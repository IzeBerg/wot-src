package net.wg.gui.lobby.personalMissions.components.statusFooter
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.personalMissions.data.StatusFooterVO;
   import net.wg.gui.lobby.personalMissions.events.StatusFooterEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class StatusFooter extends UIComponentEx implements IUpdatableComponent
   {
      
      public static const FIRST_BLOCK_WIDTH:int = 630;
      
      private static const HEIGHT:int = 80;
      
      private static const SEPARATORS_X_SHIFT:int = 25;
      
      private static const SEPARATORS_CENTER_SHIFT:int = 15;
      
      private static const STATUS_TEXT_X_SHIFT:int = 20;
      
      private static const FREE_SHEET_BTN_X_SHIFT:int = 25;
      
      private static const FREE_SHEET_BTN_X_BIG:int = 668;
      
      private static const FREE_SHEET_BLOCK_X_SHIFT:int = -7;
      
      private static const STATUS_TEXT_Y_START:int = 27;
      
      private static const DESCR_X_SHIFT:int = 10;
      
      private static const TUTORIAL_TEXT_STYLE_FILTER:DropShadowFilter = new DropShadowFilter(0,0,16711680,1,16,16,2,2);
      
      private static const STATUS_TEXT_WIDTH:int = 495;
       
      
      public var statusText:TextField = null;
      
      public var descrText:TextField = null;
      
      public var skipTaskBtn:ISoundButtonEx = null;
      
      public var sheetsBlock:IUpdatableComponent = null;
      
      public var tankgirlsBlock:IUpdatableComponent = null;
      
      public var shadow:ISeparatorAsset = null;
      
      public var separator:Sprite = null;
      
      private var _shadowHitArea:Sprite = null;
      
      private var _data:StatusFooterVO = null;
      
      public function StatusFooter()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.shadow.setType(SeparatorConstants.MEDIUM_TYPE);
         this._shadowHitArea = new Sprite();
         addChild(this._shadowHitArea);
         this.shadow.hitArea = this._shadowHitArea;
         this.skipTaskBtn.addEventListener(ButtonEvent.CLICK,this.onSkipTaskBtnClickHandler);
         this.skipTaskBtn.mouseEnabledOnDisabled = true;
         this.skipTaskBtn.useHtmlText = true;
         this.statusText.addEventListener(MouseEvent.ROLL_OVER,this.onStatusTextRollOverHandler);
         this.statusText.addEventListener(MouseEvent.ROLL_OUT,this.onStatusTextRollOutHandler);
         this.statusText.y = STATUS_TEXT_Y_START;
         TextFieldEx.setVerticalAlign(this.statusText,TextFieldEx.VALIGN_CENTER);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.statusText.width = STATUS_TEXT_WIDTH;
            if(this._data.btnVisible)
            {
               this.statusText.width -= this.skipTaskBtn.width;
            }
            this.statusText.htmlText = this._data.statusText;
            this.skipTaskBtn.visible = this._data.btnVisible;
            this.skipTaskBtn.enabled = this._data.btnEnabled && this._data.btnVisible;
            if(this._data.btnVisible)
            {
               this.skipTaskBtn.label = this._data.btnLabel;
               this.skipTaskBtn.tooltip = this._data.tooltip;
            }
            this.statusText.filters = null;
            this.descrText.visible = false;
            if(this._data.isQuestInProgress)
            {
               this.statusText.filters = [TUTORIAL_TEXT_STYLE_FILTER];
               if(StringUtils.isNotEmpty(this._data.descrText))
               {
                  this.descrText.htmlText = this._data.descrText;
                  this.descrText.visible = true;
               }
            }
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = width - LobbyMetrics.MIN_STAGE_WIDTH >> 1;
            this.shadow.width = this.shadow.x = width;
            this.separator.x = _loc1_ - SEPARATORS_CENTER_SHIFT + SEPARATORS_X_SHIFT;
            this.statusText.x = this.separator.x + SEPARATORS_CENTER_SHIFT + STATUS_TEXT_X_SHIFT;
            if(this.descrText.visible)
            {
               this.descrText.x = this.statusText.x + this.statusText.textWidth + DESCR_X_SHIFT | 0;
            }
            if(this.skipTaskBtn.visible)
            {
               this.skipTaskBtn.x = this.statusText.numLines > 1 ? Number(FREE_SHEET_BTN_X_BIG) : Number(this.statusText.x + this.statusText.textWidth + FREE_SHEET_BTN_X_SHIFT | 0);
            }
            this.sheetsBlock.x = this.statusText.x + FIRST_BLOCK_WIDTH + FREE_SHEET_BLOCK_X_SHIFT;
            this.tankgirlsBlock.x = this.sheetsBlock.x - this.tankgirlsBlock.width >> 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.shadow.dispose();
         this.shadow = null;
         this.skipTaskBtn.removeEventListener(ButtonEvent.CLICK,this.onSkipTaskBtnClickHandler);
         this.skipTaskBtn.dispose();
         this.skipTaskBtn = null;
         this.sheetsBlock.dispose();
         this.sheetsBlock = null;
         this.tankgirlsBlock.dispose();
         this.tankgirlsBlock = null;
         this.statusText.removeEventListener(MouseEvent.ROLL_OVER,this.onStatusTextRollOverHandler);
         this.statusText.removeEventListener(MouseEvent.ROLL_OUT,this.onStatusTextRollOutHandler);
         this.statusText = null;
         this.separator = null;
         this.descrText = null;
         this._data = null;
         removeChild(this._shadowHitArea);
         this._shadowHitArea = null;
         super.onDispose();
      }
      
      public function showFreeSheetPopoverForTutor() : void
      {
         BasicFooterBlock(this.sheetsBlock).showPopover(true);
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = StatusFooterVO(param1);
            this.sheetsBlock.update(this._data.sheetsBlockData);
            this.tankgirlsBlock.update(this._data.tankgirlsBlockData);
            invalidateData();
         }
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      private function onSkipTaskBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new StatusFooterEvent(StatusFooterEvent.SKIP_TASK));
      }
      
      private function onStatusTextRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data && !this._data.btnVisible && StringUtils.isNotEmpty(this._data.tooltip))
         {
            App.toolTipMgr.showComplex(this._data.tooltip);
         }
      }
      
      private function onStatusTextRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
