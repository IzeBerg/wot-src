package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.filters.GlowFilter;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
   
   public class HBC_Account extends HeaderButtonContentItem
   {
      
      private static const BADGE_MARGIN:int = 5;
      
      private static const MIN_SCREEN_PADDING_LEFT:int = 9;
      
      private static const MIN_SCREEN_PADDING_RIGHT:int = 12;
      
      private static const ADD_SCREEN_PADDING_LEFT:int = 0;
      
      private static const ADD_SCREEN_PADDING_RIGHT:int = 6;
      
      private static const MIN_WIDTH:int = 126;
      
      private static const BADGE_MAX_SCREEN_ALPHA:Number = 1;
      
      private static const BADGE_NOT_MAX_SCREEN_ALPHA:Number = 0.6;
      
      private static const BADGE_OFFSET:int = 7;
      
      private static const ANONYMIZER_ICON_WIDTH:int = 16;
      
      private static const ANONYMIZER_ICON_HORIZONTAL_PADDING:int = 3;
      
      private static const WARNING_ICON_HORIZONTAL_PADDING:int = 11;
      
      private static const NOT_MAX_SCREEN_BADGE_OFFSET:int = -4;
      
      private static const ANONYMIZER_ICON_VERTICAL_PADDING:int = 16;
      
      private static const WARNING_ICON_VERTICAL_PADDING:int = 1;
      
      private static const WARNING_ICON_PADDING:int = 14;
      
      private static const BADGE_SIZE:int = 48;
      
      private static const GLOW_FILTER:GlowFilter = new GlowFilter(16711680,1,25,25,1.4);
       
      
      public var userName:UserNameField = null;
      
      public var badge:BadgeComponent = null;
      
      public var anonymizerIcon:Image = null;
      
      public var warningIcon:Image = null;
      
      private var _accountVo:HBC_AccountDataVo = null;
      
      private var _userNameOffset:int = 0;
      
      public function HBC_Account()
      {
         super();
         minScreenPadding.left = MIN_SCREEN_PADDING_LEFT;
         minScreenPadding.right = MIN_SCREEN_PADDING_RIGHT;
         additionalScreenPadding.left = ADD_SCREEN_PADDING_LEFT;
         additionalScreenPadding.right = ADD_SCREEN_PADDING_RIGHT;
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:int = this.userName.x + this.userName.textWidth + this._userNameOffset + this.anonymizerIconWidth << 0;
         if(this.warningIcon.visible)
         {
            _loc1_ += WARNING_ICON_PADDING;
            this.warningIcon.x = _loc1_ - WARNING_ICON_HORIZONTAL_PADDING;
         }
         bounds.width = _loc1_;
         super.updateSize();
      }
      
      override protected function updateData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(data)
         {
            this.badge.visible = this._accountVo.selectedBadge;
            this.anonymizerIcon.visible = this._accountVo.isAnonymized;
            this.warningIcon.visible = this._accountVo.isWarningIconVisible;
            this.userName.textColor = !!this._accountVo.isTeamKiller ? Number(App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAMKILLER).rgb) : Number(UserNameField.DEF_USER_NAME_COLOR);
            if(this._accountVo.isWarningIconVisible)
            {
               if(this.userName.filters.length == 0)
               {
                  this.userName.filters = [GLOW_FILTER];
               }
            }
            else if(this.userName.filters.length > 0)
            {
               this.userName.filters = [];
            }
            _loc1_ = 0;
            if(this.badge.visible)
            {
               this.badge.setData(this._accountVo.badgeVO);
               _loc1_ = BADGE_SIZE >> 1;
            }
            if(availableWidth < MIN_WIDTH)
            {
               availableWidth = MIN_WIDTH;
            }
            _loc2_ = availableWidth - _loc1_ - this.anonymizerIconWidth;
            if(this.warningIcon.visible)
            {
               _loc2_ -= WARNING_ICON_PADDING;
            }
            if(this._accountVo.userVO != null)
            {
               this.userName.width = _loc2_;
               this.userName.userVO = this._accountVo.userVO;
               this.userName.validateNow();
            }
            if(this.badge.visible)
            {
               if(BADGE_SIZE + this.userName.textWidth + BADGE_MARGIN < _loc2_)
               {
                  _loc1_ = BADGE_SIZE + BADGE_MARGIN;
                  this.badge.alpha = BADGE_MAX_SCREEN_ALPHA;
                  this.badge.x = BADGE_OFFSET;
               }
               else
               {
                  this.badge.alpha = BADGE_NOT_MAX_SCREEN_ALPHA;
                  this.badge.x = NOT_MAX_SCREEN_BADGE_OFFSET;
               }
            }
            _loc3_ = BADGE_OFFSET;
            _loc4_ = _loc1_ + this.userName.textWidth + this.anonymizerIconWidth;
            if(_loc4_ < MIN_WIDTH)
            {
               _loc3_ = (availableWidth > MIN_WIDTH ? MIN_WIDTH : availableWidth) - _loc4_ >> 1;
            }
            if(!this.badge.visible)
            {
               this._userNameOffset = _loc3_ + leftPadding - rightPadding >> 1;
            }
            else
            {
               this._userNameOffset = 0;
            }
            this.userName.x = _loc3_ + _loc1_ - this._userNameOffset;
            if(this.anonymizerIcon.visible)
            {
               this.anonymizerIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ICON_EYE;
               this.anonymizerIcon.x = this.userName.x + this.userName.textWidth + ANONYMIZER_ICON_HORIZONTAL_PADDING;
               this.anonymizerIcon.y = ANONYMIZER_ICON_VERTICAL_PADDING;
            }
            if(this.warningIcon.visible)
            {
               this.warningIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTBIGICON;
               this.warningIcon.y = WARNING_ICON_VERTICAL_PADDING;
            }
         }
         super.updateData();
      }
      
      override protected function onDispose() : void
      {
         this._accountVo = null;
         this.anonymizerIcon.dispose();
         this.anonymizerIcon = null;
         this.warningIcon.dispose();
         this.warningIcon = null;
         this.userName.dispose();
         this.userName = null;
         this.badge.dispose();
         this.badge = null;
         super.onDispose();
      }
      
      override public function set data(param1:Object) : void
      {
         this._accountVo = HBC_AccountDataVo(param1);
         super.data = param1;
      }
      
      private function get anonymizerIconWidth() : int
      {
         return int(this.anonymizerIcon.visible) * (ANONYMIZER_ICON_WIDTH + ANONYMIZER_ICON_HORIZONTAL_PADDING) << 0;
      }
   }
}
