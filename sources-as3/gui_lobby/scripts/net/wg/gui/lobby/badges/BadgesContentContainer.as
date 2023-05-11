package net.wg.gui.lobby.badges
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.lobby.badges.components.BadgeRenderer;
   import net.wg.gui.lobby.badges.data.BadgeVO;
   import net.wg.gui.lobby.badges.data.BadgesGroupVO;
   import net.wg.gui.lobby.badges.events.BadgesEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class BadgesContentContainer extends UIComponentEx
   {
      
      private static const INV_START_BADGE:String = "inv_start_badge";
      
      private static const TITLE_GAP:int = 25;
      
      private static const LISTS_GAP:int = 31;
      
      private static const RENDERER_WIDTH:int = 360;
      
      private static const RENDERER_HEIGHT:int = 148;
      
      private static const RENDERERS_HORIZONTAL_GAP:int = 26;
      
      private static const RENDERERS_VERTICAL_GAP:int = 2;
      
      private static const START_Y:int = 22;
       
      
      public var receivedList:SimpleTileList = null;
      
      public var notReceivedList:SimpleTileList = null;
      
      public var notReceivedTitle:TextField = null;
      
      private var _receivedBadges:BadgesGroupVO = null;
      
      private var _notReceivedBadges:BadgesGroupVO = null;
      
      private var _currentBadge:BadgeRenderer = null;
      
      private var _topShift:int = 0;
      
      private var _hasNotReceived:Boolean = false;
      
      public function BadgesContentContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(BadgesEvent.BADGE_RENDERER_CLICK,this.onBadgeRendererClickHandler);
         this.receivedList.itemRenderer = this.notReceivedList.itemRenderer = App.utils.classFactory.getClass(Linkages.BADGE_RENDERER_UI);
         this.receivedList.tileWidth = this.notReceivedList.tileWidth = RENDERER_WIDTH;
         this.receivedList.tileHeight = this.notReceivedList.tileHeight = RENDERER_HEIGHT;
         this.receivedList.horizontalGap = this.notReceivedList.horizontalGap = RENDERERS_HORIZONTAL_GAP;
         this.receivedList.verticalGap = this.notReceivedList.verticalGap = RENDERERS_VERTICAL_GAP;
         this.receivedList.autoSize = this.notReceivedList.autoSize = true;
         this.receivedList.x = this.notReceivedList.x = RENDERERS_HORIZONTAL_GAP >> 1;
      }
      
      override protected function draw() : void
      {
         var _loc1_:BadgeVO = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(this._receivedBadges != null && isInvalid(InvalidationType.DATA))
         {
            this.receivedList.dataProvider = this._receivedBadges.badgesData;
            invalidateSize();
            invalidate(INV_START_BADGE);
         }
         if(this._notReceivedBadges != null && isInvalid(InvalidationType.DATA))
         {
            this.notReceivedList.dataProvider = this._notReceivedBadges.badgesData;
            this.notReceivedTitle.htmlText = this._notReceivedBadges.title;
            this._hasNotReceived = this._notReceivedBadges.badgesData.length > 0;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.receivedList.y = this._topShift + START_Y;
            this.receivedList.width = this.notReceivedList.width = _width;
            this.receivedList.validateNow();
            this.notReceivedTitle.visible = this._hasNotReceived;
            if(this._hasNotReceived)
            {
               this.notReceivedTitle.x = _width - this.notReceivedTitle.width >> 1;
               this.notReceivedTitle.y = this.receivedList.y + this.receivedList.height + LISTS_GAP | 0;
               this.notReceivedList.y = this.notReceivedTitle.y + this.notReceivedTitle.height + TITLE_GAP | 0;
               this.notReceivedList.validateNow();
               height = this.notReceivedList.y + this.notReceivedList.height | 0;
            }
            else
            {
               height = this.receivedList.y + this.receivedList.height | 0;
            }
         }
         if(this._receivedBadges != null && isInvalid(INV_START_BADGE))
         {
            if(this._currentBadge)
            {
               this._currentBadge.selected = false;
            }
            _loc2_ = this._receivedBadges.badgesData.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = this._receivedBadges.badgesData[_loc3_];
               if(_loc1_.selected)
               {
                  this._currentBadge = BadgeRenderer(this.receivedList.getRendererAt(_loc3_));
                  this._currentBadge.selected = true;
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(BadgesEvent.BADGE_RENDERER_CLICK,this.onBadgeRendererClickHandler);
         this.receivedList.dispose();
         this.receivedList = null;
         this.notReceivedList.dispose();
         this.notReceivedList = null;
         this.notReceivedTitle = null;
         this._receivedBadges = null;
         this._notReceivedBadges = null;
         this._currentBadge = null;
         super.onDispose();
      }
      
      public function deselectBadge() : void
      {
         if(this._currentBadge != null)
         {
            this._currentBadge.selected = false;
         }
      }
      
      public function setNotReceivedBadges(param1:BadgesGroupVO) : void
      {
         if(this._notReceivedBadges != param1)
         {
            this._notReceivedBadges = param1;
            invalidateData();
         }
      }
      
      public function setReceivedBadges(param1:BadgesGroupVO) : void
      {
         if(this._receivedBadges != param1)
         {
            this._receivedBadges = param1;
            invalidateData();
         }
      }
      
      public function setTopShift(param1:int) : void
      {
         if(this._topShift != param1)
         {
            this._topShift = param1;
            invalidateSize();
         }
      }
      
      private function dispatchBadgeChangeEvent() : void
      {
         var _loc1_:BadgesEvent = null;
         if(this._currentBadge != null)
         {
            _loc1_ = new BadgesEvent(BadgesEvent.BADGE_CHANGE);
            _loc1_.badgeID = this._currentBadge.getBadgeID();
            _loc1_.selected = this._currentBadge.selected;
            dispatchEvent(_loc1_);
         }
      }
      
      private function onBadgeRendererClickHandler(param1:Event) : void
      {
         var _loc2_:BadgeRenderer = BadgeRenderer(param1.target);
         if(this._currentBadge == _loc2_)
         {
            this._currentBadge.selected = !this._currentBadge.selected;
         }
         else
         {
            if(this._currentBadge != null)
            {
               this._currentBadge.selected = false;
            }
            this._currentBadge = _loc2_;
            this._currentBadge.selected = true;
         }
         this.dispatchBadgeChangeEvent();
      }
   }
}
