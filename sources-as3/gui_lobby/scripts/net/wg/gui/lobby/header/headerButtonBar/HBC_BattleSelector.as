package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.counters.Counter;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.IHeaderButtonResizableItem;
   import net.wg.gui.lobby.components.ArrowDown;
   import net.wg.gui.lobby.header.LobbyHeader;
   import net.wg.gui.lobby.header.headerButtonBar.container.AnimBGContainer;
   import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class HBC_BattleSelector extends HeaderButtonContentItem implements IHeaderButtonResizableItem
   {
      
      private static const ARROW_MARGIN:int = 6;
      
      private static const ICON_MARGIN:int = 5;
      
      private static const MAX_TEXT_WIDTH_NARROW_SCREEN:int = 104;
      
      private static const MAX_TEXT_WIDTH_WIDE_SCREEN:int = 40;
      
      private static const MAX_TEXT_WIDTH_MAX_SCREEN:int = 500;
      
      private static const WIDTH_FOR_TEXT:int = 45;
      
      private static var NEW_COUNTER_CONTAINER_ID:String = "HBC_BattleSelectorCountersContainer";
       
      
      public var textField:TextField = null;
      
      public var icon:UILoaderAlt = null;
      
      public var arrow:ArrowDown = null;
      
      public var highlight:AnimBGContainer = null;
      
      private var _battleTypeVo:HBC_BattleTypeVo = null;
      
      private var _iconWidth:int = 0;
      
      private var _counterProps:ICounterProps;
      
      private var _counterManager:ICounterManager;
      
      public function HBC_BattleSelector()
      {
         this._counterProps = new CounterProps();
         this._counterManager = App.utils.counterManager;
         super();
         minScreenPadding.left = 10;
         minScreenPadding.right = 10;
         additionalScreenPadding.left = 0;
         additionalScreenPadding.right = 4;
         maxFontSize = 14;
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.icon.addEventListener(UILoaderEvent.IOERROR,this.onIconLoadIoerrorHandler);
      }
      
      override public function onPopoverClose() : void
      {
         this.arrow.state = ArrowDown.STATE_NORMAL;
      }
      
      override public function onPopoverOpen() : void
      {
         this.arrow.state = ArrowDown.STATE_UP;
      }
      
      override protected function updateSize() : void
      {
         bounds.width = this.arrow.x + this.arrow.width;
         super.updateSize();
      }
      
      override protected function updateData() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         var _loc1_:Boolean = this.highlight.visible;
         if(data)
         {
            this._counterManager.disposeCountersForContainer(NEW_COUNTER_CONTAINER_ID);
            this.icon.source = this._battleTypeVo.battleTypeIcon;
            _loc2_ = availableWidth > this.icon.width + this.arrow.width + WIDTH_FOR_TEXT;
            this.textField.visible = _loc2_;
            if(_loc2_)
            {
               this.textField.x = Boolean(this._battleTypeVo.battleTypeIcon) ? (Boolean(this._iconWidth) ? Number(this.icon.x + this._iconWidth) : Number(this.icon.x + this.icon.width + ICON_MARGIN)) : Number(0);
               _loc3_ = -this.textField.x + MAX_TEXT_WIDTH_NARROW_SCREEN;
               switch(screen)
               {
                  case LobbyHeader.WIDE_SCREEN:
                     _loc3_ += wideScreenPrc * MAX_TEXT_WIDTH_WIDE_SCREEN;
                     break;
                  case LobbyHeader.MAX_SCREEN:
                     _loc3_ += wideScreenPrc * MAX_TEXT_WIDTH_WIDE_SCREEN + maxScreenPrc * MAX_TEXT_WIDTH_MAX_SCREEN;
               }
               if(availableWidth > 0)
               {
                  _loc3_ = availableWidth - (ARROW_MARGIN + this.textField.x + this.arrow.width);
               }
               this.textField.width = _loc3_;
               if(this.isNeedUpdateFont())
               {
                  updateFontSize(this.textField,useFontSize);
                  needUpdateFontSize = false;
               }
               App.utils.commons.truncateTextFieldText(this.textField,this._battleTypeVo.battleTypeName);
               this.textField.width = this.textField.textWidth + TEXT_FIELD_MARGIN;
               this.arrow.x = this.textField.x + this.textField.width + ARROW_MARGIN ^ 0;
               this._counterProps = new CounterProps(10,-3,TextFormatAlign.LEFT,true,Linkages.COUNTER_UI,CounterProps.DEFAULT_TF_PADDING,false,Counter.EMPTY_STATE);
            }
            else
            {
               this.arrow.x = this.getMinArrowPositionX() | 0;
               this._counterProps = new CounterProps(5,-3,TextFormatAlign.LEFT,true,Linkages.COUNTER_UI,CounterProps.DEFAULT_TF_PADDING,false,Counter.EMPTY_STATE);
            }
            if(StringUtils.isNotEmpty(this._battleTypeVo.eventBgLinkage))
            {
               this.highlight.setAnimLinkage(this._battleTypeVo.eventBgLinkage);
               if(!_loc1_)
               {
                  this.highlight.visible = true;
                  this.highlight.playAnim();
               }
            }
            else
            {
               this.hideHighlight();
            }
            if(this._battleTypeVo.hasNew)
            {
               this._counterManager.setCounter(this.arrow,"",NEW_COUNTER_CONTAINER_ID,this._counterProps);
            }
         }
         else if(_loc1_)
         {
            this.hideHighlight();
         }
         super.updateData();
      }
      
      override protected function isNeedUpdateFont() : Boolean
      {
         return super.isNeedUpdateFont() || useFontSize != this.textField.getTextFormat().size;
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.icon.removeEventListener(UILoaderEvent.IOERROR,this.onIconLoadIoerrorHandler);
         this._battleTypeVo = null;
         this.textField.filters = null;
         this.textField = null;
         this.icon.dispose();
         this.icon = null;
         this.arrow.dispose();
         this.arrow = null;
         this.highlight.dispose();
         this.highlight = null;
         this._counterManager.disposeCountersForContainer(NEW_COUNTER_CONTAINER_ID);
         this._counterManager = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.highlight.mouseEnabled = this.highlight.mouseChildren = false;
         this.hideHighlight();
      }
      
      public function getActualWidth() : Number
      {
         return bounds.width + leftPadding + rightPadding;
      }
      
      public function getMinAvailableWidth() : Number
      {
         return this.getMinArrowPositionX() + this.arrow.width + leftPadding + rightPadding;
      }
      
      private function hideHighlight() : void
      {
         this.highlight.visible = false;
         this.highlight.stopAnim();
      }
      
      private function getMinArrowPositionX() : Number
      {
         return this.icon.x + this.icon.width + (ARROW_MARGIN >> 1);
      }
      
      override public function set data(param1:Object) : void
      {
         this._battleTypeVo = HBC_BattleTypeVo(param1);
         if(!this._battleTypeVo.battleTypeIcon)
         {
            this._iconWidth = 0;
         }
         super.data = param1;
      }
      
      private function onIconLoadIoerrorHandler(param1:UILoaderEvent) : void
      {
         this._iconWidth = 0;
         invalidate(InvalidationType.DATA,InvalidationType.SIZE);
      }
      
      private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         this._iconWidth = param1.target.width;
         invalidate(InvalidationType.DATA,InvalidationType.SIZE);
      }
   }
}
