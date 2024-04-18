package net.wg.gui.lobby.badges
{
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.lobby.badges.data.BadgeSuffixVO;
   import net.wg.gui.lobby.badges.data.BadgesGroupVO;
   import net.wg.gui.lobby.badges.data.BadgesStaticDataVO;
   import net.wg.gui.lobby.badges.events.BadgesEvent;
   import net.wg.infrastructure.base.meta.IBadgesPageMeta;
   import net.wg.infrastructure.base.meta.impl.BadgesPageMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.InputEvent;
   
   public class BadgesPage extends BadgesPageMeta implements IBadgesPageMeta
   {
      
      private static const INV_BACKGROUND_SIZE:String = "InvBackgroundSize";
      
      private static const RENDERER_WIDTH_SMALL:int = 772;
      
      private static const RENDERER_WIDTH_LARGE:int = 1158;
      
      private static const RENDERER_WIDTH_SWITCH:int = 1600;
      
      private static const SCROLL_TOP:int = 167;
      
      private static const SCROLL_BOTTOM:int = -3;
      
      private static const SCROLL_STEP_FACTOR:int = 40;
      
      private static const SCROLL_BAR_VALUE:String = "ScrollBar";
      
      private static const SCROLL_BAR_MARGIN:int = 15;
      
      private static const HEIGHT_SMALL:int = 900;
      
      private static const CONTENT_TOP_SHIFT:int = 25;
       
      
      public var header:BadgesHeader = null;
      
      public var scrollPane:ResizableScrollPane = null;
      
      private var _content:BadgesContentContainer;
      
      private var _waiting:Waiting;
      
      private var _waitingMessage:String;
      
      private var _showWaiting:Boolean;
      
      public function BadgesPage()
      {
         super();
         fadeAnimat = true;
         this._content = BadgesContentContainer(this.scrollPane.target);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         setViewSize(param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true);
         this.header.addEventListener(BadgesEvent.BACK_BUTTON_CLICK,this.onBackButtonClickHandler);
         this.header.addEventListener(BadgesEvent.BADGE_DESELECT,this.onBadgeDeselectHandler);
         this.header.addEventListener(BadgesEvent.SUFFIX_BADGE_SELECT,this.onSuffixBadgeSelectHandler);
         this.header.addEventListener(BadgesEvent.SUFFIX_BADGE_DESELECT,this.onSuffixBadgeDeselectHandler);
         this.scrollPane.scrollBarMargin = SCROLL_BAR_MARGIN;
         this.scrollPane.scrollBar = SCROLL_BAR_VALUE;
         this.scrollPane.y = SCROLL_TOP;
         this.scrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
         setBackground(RES_ICONS.MAPS_ICONS_LOBBY_SETTINGS_BLURED_BG);
         this._content.addEventListener(BadgesEvent.BADGE_CHANGE,this.onContentBadgeChangeHandler);
      }
      
      override protected function setReceivedBadges(param1:BadgesGroupVO) : void
      {
         this._content.setReceivedBadges(param1);
      }
      
      override protected function setNotReceivedBadges(param1:BadgesGroupVO) : void
      {
         this._content.setNotReceivedBadges(param1);
      }
      
      override protected function setStaticData(param1:BadgesStaticDataVO) : void
      {
         this.header.update(param1.header);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(isInvalid(WindowViewInvalidationType.WAITING_INVALID))
         {
            this.applyWaitingChanges(width,height);
         }
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = _width < RENDERER_WIDTH_SWITCH ? int(RENDERER_WIDTH_SMALL) : int(RENDERER_WIDTH_LARGE);
            _loc2_ = _height - SCROLL_TOP - SCROLL_BOTTOM;
            this.scrollPane.setSize(_width,_loc2_);
            this.header.width = _width;
            this._content.setTopShift(App.appHeight < HEIGHT_SMALL ? int(0) : int(CONTENT_TOP_SHIFT));
            this._content.width = _loc1_;
            this._content.x = _width - _loc1_ >> 1;
            this._content.validateNow();
            invalidate(INV_BACKGROUND_SIZE);
         }
         if(isInvalid(INV_BACKGROUND_SIZE))
         {
            updateBG();
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         if(this._waiting && this._waiting.parent)
         {
            this._waiting.parent.removeChild(this._waiting);
         }
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
         this.header.removeEventListener(BadgesEvent.BACK_BUTTON_CLICK,this.onBackButtonClickHandler);
         this.header.removeEventListener(BadgesEvent.BADGE_DESELECT,this.onBadgeDeselectHandler);
         this.header.removeEventListener(BadgesEvent.SUFFIX_BADGE_SELECT,this.onSuffixBadgeSelectHandler);
         this.header.removeEventListener(BadgesEvent.SUFFIX_BADGE_DESELECT,this.onSuffixBadgeDeselectHandler);
         this.header.dispose();
         this.header = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this._content.removeEventListener(BadgesEvent.BADGE_CHANGE,this.onContentBadgeChangeHandler);
         this._content = null;
         if(this._waiting)
         {
            this._waiting.dispose();
            this._waiting = null;
         }
         super.onDispose();
      }
      
      override protected function setSelectedBadge(param1:BadgeVisualVO, param2:Boolean) : void
      {
         this.header.setBadgeData(param1,param2);
      }
      
      override protected function setBadgeSuffix(param1:BadgeSuffixVO) : void
      {
         this.header.setBadgeSuffix(param1);
      }
      
      public function as_hideWaiting() : void
      {
         this.showWaiting = false;
      }
      
      public function as_showWaiting(param1:String, param2:Object) : void
      {
         this.showWaitingMessage(param1);
      }
      
      protected function showWaitingMessage(param1:String) : void
      {
         this._waitingMessage = param1;
         this.showWaiting = true;
      }
      
      protected function applyWaitingChanges(param1:int, param2:int) : void
      {
         if(this._showWaiting)
         {
            if(!this._waiting)
            {
               this._waiting = new Waiting();
               addChild(this._waiting);
               this._waiting.setSize(param1,param2);
               this._waiting.validateNow();
            }
            this._waiting.setMessage(this._waitingMessage);
         }
         if(this._waiting)
         {
            if(this._showWaiting)
            {
               this._waiting.show();
            }
            else
            {
               this._waiting.hide();
            }
         }
      }
      
      override public function get isModal() : Boolean
      {
         return true;
      }
      
      public function set showWaiting(param1:Boolean) : void
      {
         if(this._showWaiting != param1)
         {
            this._showWaiting = param1;
            invalidate(WindowViewInvalidationType.WAITING_INVALID);
         }
      }
      
      private function onSuffixBadgeSelectHandler(param1:BadgesEvent) : void
      {
         onSelectSuffixBadgeS(param1.badgeID);
      }
      
      private function onSuffixBadgeDeselectHandler(param1:BadgesEvent) : void
      {
         onDeselectSuffixBadgeS();
      }
      
      private function onBackButtonClickHandler(param1:Event) : void
      {
         onBackClickS();
      }
      
      private function onContentBadgeChangeHandler(param1:BadgesEvent) : void
      {
         if(param1.selected)
         {
            onSelectBadgeS(param1.badgeID);
         }
         else
         {
            onDeselectBadgeS();
         }
      }
      
      private function onEscapeKeyDownHandler(param1:InputEvent) : void
      {
         onBackClickS();
      }
      
      private function onBadgeDeselectHandler(param1:BadgesEvent) : void
      {
         this._content.deselectBadge();
         onDeselectBadgeS();
      }
   }
}
