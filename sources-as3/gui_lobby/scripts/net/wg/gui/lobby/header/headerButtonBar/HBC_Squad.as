package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.components.ArrowDown;
   import net.wg.gui.lobby.header.headerButtonBar.container.PlatoonShieldIconContainer;
   import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
   import scaleform.clik.constants.InvalidationType;
   
   public class HBC_Squad extends HeaderButtonContentItem
   {
      
      public static const NORMAL_SIZE_PLATOON:int = 3;
      
      public static const SHORT_SIZE_PLATOON:int = 2;
      
      private static const UPDATE_SQUAD_STATE_ID:uint = 1;
      
      private static const RANDOM_SHIELD_ICON_PATTERN:String = "/squad.png";
      
      private static const NOT_RANDOM_SHIELD_ANIMATION_X:int = -4;
      
      private static const DIMENSIONS:Object = {
         "searchingPadding":15,
         "platoonOrSquadPadding":10,
         "createPadding":10,
         "shieldDistanceToText":19,
         "distanceBetweenTextAndSearch":-9,
         "minResCreateShieldPadding":10,
         "minResTripleShieldPadding":15,
         "minResSearchPadding":25,
         "minResArrowPadding":2,
         "additionalTextPadding":10
      };
       
      
      public var arrow:ArrowDown = null;
      
      public var textField:TextField = null;
      
      public var searchingAnimation:InviteIndicator = null;
      
      public var leftIconContainer:PlatoonShieldIconContainer = null;
      
      public var mainIconContainer:PlatoonShieldIconContainer = null;
      
      public var rightIconContainer:PlatoonShieldIconContainer = null;
      
      private var _squadDataVo:HBC_SquadDataVo = null;
      
      private var _isShort:Boolean = false;
      
      private var _isWideScreen:Boolean;
      
      private var _textFieldXDefault:int = -1;
      
      private var _containersDefPositionsX:Array = null;
      
      private var _arrowXDefault:int = -1;
      
      private var _containersOrder:Vector.<PlatoonShieldIconContainer> = null;
      
      private var _innerOrder:Vector.<Vector.<MovieClip>> = null;
      
      public function HBC_Squad()
      {
         this._isWideScreen = wideScreenPrc > WIDE_SCREEN_PRC_BORDER;
         super();
         minScreenPadding.left = 13;
         minScreenPadding.right = 11;
         additionalScreenPadding.left = 4;
         additionalScreenPadding.right = -2;
         maxFontSize = 14;
         this.leftIconContainer.leftBGShieldsIcon.visible = false;
         this.leftIconContainer.leftBGShieldsIconAnimation.visible = false;
         this.leftIconContainer.rightBGShieldsIcon.visible = false;
         this.leftIconContainer.rightBGShieldsIconAnimation.visible = false;
         this.rightIconContainer.leftBGShieldsIcon.visible = false;
         this.rightIconContainer.leftBGShieldsIconAnimation.visible = false;
         this.rightIconContainer.rightBGShieldsIcon.visible = false;
         this.rightIconContainer.rightBGShieldsIconAnimation.visible = false;
         this.mainIconContainer.isMain = true;
         this._containersOrder = new <PlatoonShieldIconContainer>[this.leftIconContainer,this.mainIconContainer,this.rightIconContainer];
         this._innerOrder = new <Vector.<MovieClip>>[new <MovieClip>[this.mainIconContainer.leftBGShieldsIcon,this.mainIconContainer.leftBGShieldsIconAnimation],new Vector.<MovieClip>(0),new <MovieClip>[this.mainIconContainer.rightBGShieldsIcon,this.mainIconContainer.rightBGShieldsIconAnimation]];
      }
      
      override public function onPopoverClose() : void
      {
         this.arrow.state = ArrowDown.STATE_NORMAL;
      }
      
      override public function onPopoverOpen() : void
      {
         this.arrow.state = ArrowDown.STATE_UP;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(UPDATE_SQUAD_STATE_ID))
         {
            _loc1_ = this._squadDataVo.squadExtendInfoVo.squadManStates.length && this._squadDataVo.squadExtendInfoVo.squadManStates.length <= NORMAL_SIZE_PLATOON;
            if(_loc1_)
            {
               switch(this._squadDataVo.squadExtendInfoVo.platoonState)
               {
                  case PlatoonShieldIconContainer.STATES.create:
                     this.positionMainIconContainer();
                     this.arrow.x = !!this._isWideScreen ? Number(this._arrowXDefault) : Number(this._arrowXDefault + DIMENSIONS.minResArrowPadding);
                     break;
                  case PlatoonShieldIconContainer.STATES.searching:
                     this.textField.x = this.searchingAnimation.x + this.searchingAnimation.width + DIMENSIONS.distanceBetweenTextAndSearch >> 0;
                     break;
                  case PlatoonShieldIconContainer.STATES.inPlatoon:
                     this.restoreDefaultPositions();
                     if(!this._isWideScreen)
                     {
                        this.mainIconContainer.x = this._containersDefPositionsX[0];
                     }
                     break;
                  case PlatoonShieldIconContainer.STATES.squadEvent:
                     this.mainIconContainer.x = this.textField.x + this.textField.width + (this.mainIconContainer.width >> 1);
               }
            }
            else
            {
               this.positionMainIconContainer();
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._containersDefPositionsX = [];
         var _loc1_:int = this._containersOrder.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._containersDefPositionsX.push(this._containersOrder[_loc2_].x);
            _loc2_++;
         }
         this._textFieldXDefault = this.textField.x;
         this._arrowXDefault = this.arrow.x;
         this.mainIconContainer.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.leftIconContainer.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.rightIconContainer.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.updateSize();
      }
      
      override protected function updateSize() : void
      {
         this._isWideScreen = wideScreenPrc > WIDE_SCREEN_PRC_BORDER;
         this.clearOrderList();
         if(this._isWideScreen && this._isShort)
         {
            this._containersOrder = new <PlatoonShieldIconContainer>[this.mainIconContainer,this.leftIconContainer,this.rightIconContainer];
         }
         else
         {
            this._containersOrder = new <PlatoonShieldIconContainer>[this.leftIconContainer,this.mainIconContainer,this.rightIconContainer];
         }
         this.updateContainersSizeScreen();
         var _loc1_:Boolean = this._squadDataVo.squadExtendInfoVo.squadManStates.length && this._squadDataVo.squadExtendInfoVo.squadManStates.length <= NORMAL_SIZE_PLATOON;
         this.textField.visible = this._isWideScreen && (this._squadDataVo.squadExtendInfoVo.platoonState !== PlatoonShieldIconContainer.STATES.inPlatoon || !_loc1_);
         this.updateIconsVisibility();
         if(this._isWideScreen)
         {
            if(this.isNeedUpdateFont())
            {
               updateFontSize(this.textField,useFontSize);
               needUpdateFontSize = false;
            }
            this.textField.width = this.textField.textWidth + TEXT_FIELD_MARGIN;
         }
         else
         {
            this.textField.width = 0;
         }
         var _loc2_:int = this.mainIconContainer.getIconSize(this._squadDataVo.squadExtendInfoVo.platoonState);
         var _loc3_:int = this.leftIconContainer.getIconSize(this._squadDataVo.squadExtendInfoVo.platoonState);
         var _loc4_:int = this.rightIconContainer.getIconSize(this._squadDataVo.squadExtendInfoVo.platoonState);
         var _loc5_:int = 0;
         if(this.searchingAnimation.visible)
         {
            _loc5_ = this.searchingAnimation.width;
         }
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this.textField.visible)
         {
            _loc6_ = this.textField.width;
            if(_loc6_ > 0)
            {
               _loc7_ = DIMENSIONS.additionalTextPadding;
            }
         }
         var _loc8_:int = this.getPaddingDependingOnState(this._squadDataVo.squadExtendInfoVo.platoonState);
         bounds.width = _loc2_ + _loc3_ + _loc4_ + _loc6_ + _loc5_ + _loc8_ + _loc7_;
         invalidate(UPDATE_SQUAD_STATE_ID);
         super.updateSize();
      }
      
      override protected function updateData() : void
      {
         var _loc2_:int = 0;
         this.mainIconContainer.setEventIcon(this._squadDataVo.icon);
         if(this._squadDataVo.icon.indexOf(RANDOM_SHIELD_ICON_PATTERN) > -1)
         {
            this.mainIconContainer.shieldsIconAnimation.x = 0;
         }
         else
         {
            this.mainIconContainer.shieldsIconAnimation.x = NOT_RANDOM_SHIELD_ANIMATION_X;
         }
         var _loc1_:Boolean = this._squadDataVo.squadExtendInfoVo.squadManStates.length && this._squadDataVo.squadExtendInfoVo.squadManStates.length <= NORMAL_SIZE_PLATOON;
         switch(this._squadDataVo.squadExtendInfoVo.platoonState)
         {
            case PlatoonShieldIconContainer.STATES.create:
               if(_loc1_)
               {
                  this.mainIconContainer.updateIconContainer(this._squadDataVo.squadExtendInfoVo,PlatoonShieldIconContainer.PLAYERS.current);
               }
               else
               {
                  this.mainIconContainer.updateIconContainer(this._squadDataVo.squadExtendInfoVo,PlatoonShieldIconContainer.PLAYERS.left);
               }
               this.textField.text = this._squadDataVo.buttonName;
               this.arrow.visible = this._squadDataVo.hasPopover;
               break;
            case PlatoonShieldIconContainer.STATES.searching:
               this.textField.text = PLATOON.HEADERBUTTON_SEARCHING;
               this.arrow.visible = this._squadDataVo.hasPopover;
               break;
            case PlatoonShieldIconContainer.STATES.inPlatoon:
               this.arrow.visible = false;
               if(_loc1_)
               {
                  this.textField.visible = false;
                  this.updateIconsVisibility();
                  _loc2_ = this._squadDataVo.squadExtendInfoVo.squadManStates.length;
                  if(_loc2_ == NORMAL_SIZE_PLATOON)
                  {
                     this.leftIconContainer.updateIconContainer(this._squadDataVo.squadExtendInfoVo,PlatoonShieldIconContainer.PLAYERS.left);
                     this.mainIconContainer.updateIconContainer(this._squadDataVo.squadExtendInfoVo,PlatoonShieldIconContainer.PLAYERS.current);
                     this.rightIconContainer.updateIconContainer(this._squadDataVo.squadExtendInfoVo,PlatoonShieldIconContainer.PLAYERS.right);
                  }
                  else if(_loc2_ == SHORT_SIZE_PLATOON)
                  {
                     this.leftIconContainer.updateIconContainer(this._squadDataVo.squadExtendInfoVo,PlatoonShieldIconContainer.PLAYERS.current);
                     this.mainIconContainer.updateIconContainer(this._squadDataVo.squadExtendInfoVo,PlatoonShieldIconContainer.PLAYERS.left);
                  }
               }
               else
               {
                  this.textField.text = this._squadDataVo.buttonName;
                  this.mainIconContainer.updateIconContainer(this._squadDataVo.squadExtendInfoVo,PlatoonShieldIconContainer.PLAYERS.left);
               }
         }
         invalidate(UPDATE_SQUAD_STATE_ID);
         super.updateData();
      }
      
      override protected function onDispose() : void
      {
         this.clearOrderList();
         var _loc1_:int = this._innerOrder.length;
         var _loc2_:int = Values.ZERO;
         while(_loc2_ < _loc1_)
         {
            this._innerOrder[_loc2_].splice(0,this._innerOrder[_loc2_].length);
            _loc2_++;
         }
         this._innerOrder.splice(0,_loc1_);
         this._innerOrder = null;
         if(this._containersDefPositionsX)
         {
            this._containersDefPositionsX.length = 0;
            this._containersDefPositionsX = null;
         }
         this.mainIconContainer.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.leftIconContainer.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.rightIconContainer.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.textField = null;
         this._squadDataVo = null;
         this.arrow.dispose();
         this.arrow = null;
         this.leftIconContainer.dispose();
         this.leftIconContainer = null;
         this.mainIconContainer.dispose();
         this.mainIconContainer = null;
         this.rightIconContainer.dispose();
         this.rightIconContainer = null;
         this.searchingAnimation.dispose();
         this.searchingAnimation = null;
         super.onDispose();
      }
      
      override protected function isNeedUpdateFont() : Boolean
      {
         return super.isNeedUpdateFont() || useFontSize != this.textField.getTextFormat().size;
      }
      
      private function clearOrderList() : void
      {
         this._containersOrder.splice(0,this._containersOrder.length);
         this._containersOrder = null;
      }
      
      private function restoreDefaultPositions() : void
      {
         var _loc2_:PlatoonShieldIconContainer = null;
         this.textField.x = this._textFieldXDefault;
         var _loc1_:int = this._containersOrder.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._containersOrder[_loc3_];
            _loc2_.x = !!_loc2_.visible ? Number(this._containersDefPositionsX[_loc3_]) : Number(Values.ZERO);
            _loc3_++;
         }
         this.arrow.x = this._arrowXDefault;
      }
      
      private function positionMainIconContainer() : void
      {
         this.restoreDefaultPositions();
         this.mainIconContainer.x = !!this._isWideScreen ? Number(this.textField.x + this.textField.width + DIMENSIONS.shieldDistanceToText >> 0) : Number(this._containersDefPositionsX[this._containersOrder.indexOf(this.leftIconContainer)]);
      }
      
      private function getPaddingDependingOnState(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = this._squadDataVo.squadExtendInfoVo.squadManStates.length && this._squadDataVo.squadExtendInfoVo.squadManStates.length <= NORMAL_SIZE_PLATOON;
         switch(param1)
         {
            case PlatoonShieldIconContainer.STATES.create:
               if(!_loc3_)
               {
                  _loc2_ = DIMENSIONS.createPadding;
               }
               else if(this._isWideScreen)
               {
                  _loc2_ = DIMENSIONS.createPadding;
               }
               else
               {
                  _loc2_ = DIMENSIONS.minResCreateShieldPadding;
               }
               break;
            case PlatoonShieldIconContainer.STATES.squadEvent:
            case PlatoonShieldIconContainer.STATES.inPlatoon:
               if(!_loc3_)
               {
                  _loc2_ = DIMENSIONS.createPadding;
               }
               else if(this._isWideScreen)
               {
                  _loc2_ = DIMENSIONS.platoonOrSquadPadding;
               }
               else
               {
                  _loc2_ = DIMENSIONS.minResTripleShieldPadding;
               }
               break;
            case PlatoonShieldIconContainer.STATES.searching:
               if(this._isWideScreen)
               {
                  _loc2_ = DIMENSIONS.searchingPadding;
               }
               else
               {
                  _loc2_ = DIMENSIONS.minResSearchPadding;
               }
         }
         return _loc2_;
      }
      
      private function setSideIconsVisibility(param1:Boolean, param2:int = 0) : void
      {
         var _loc3_:int = this._containersOrder.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._containersOrder[_loc4_].visible = param1 && _loc4_ < param2;
            _loc4_++;
         }
      }
      
      private function setSubiconsVisibility(param1:Boolean, param2:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = this._innerOrder.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this._innerOrder[_loc4_].length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               this._innerOrder[_loc4_][_loc6_].visible = param1 && _loc4_ < param2;
               _loc6_++;
            }
            _loc4_++;
         }
      }
      
      private function setHatVisibility(param1:Boolean) : void
      {
         this.mainIconContainer.isCommanderHatVisible(param1);
         this.leftIconContainer.isCommanderHatVisible(param1);
         this.rightIconContainer.isCommanderHatVisible(param1);
      }
      
      private function updateIconsVisibility() : void
      {
         this.searchingAnimation.visible = this._squadDataVo.squadExtendInfoVo.platoonState == PlatoonShieldIconContainer.STATES.searching;
         var _loc1_:Boolean = this._squadDataVo.squadExtendInfoVo.squadManStates.length && this._squadDataVo.squadExtendInfoVo.squadManStates.length <= NORMAL_SIZE_PLATOON;
         this.setHatVisibility(this._isWideScreen && _loc1_ && this._squadDataVo.squadExtendInfoVo.platoonState == PlatoonShieldIconContainer.STATES.inPlatoon);
         var _loc2_:int = this._squadDataVo.squadExtendInfoVo.squadManStates.length;
         if(this._squadDataVo.squadExtendInfoVo.platoonState == PlatoonShieldIconContainer.STATES.inPlatoon)
         {
            this.setSideIconsVisibility(this._isWideScreen && _loc1_,_loc2_);
            this.setSubiconsVisibility(!this._isWideScreen && _loc1_,_loc2_);
            this.mainIconContainer.visible = true;
         }
         else
         {
            this.setSideIconsVisibility(false);
            this.setSubiconsVisibility(false);
            this.mainIconContainer.visible = this._squadDataVo.squadExtendInfoVo.platoonState !== PlatoonShieldIconContainer.STATES.searching;
         }
      }
      
      private function updateContainersSizeScreen() : void
      {
         var _loc1_:PlatoonShieldIconContainer = null;
         for each(_loc1_ in this._containersOrder)
         {
            _loc1_.updateSizeScreen(this._isWideScreen);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         if(_baseDisposed)
         {
            return;
         }
         this._isWideScreen = wideScreenPrc > WIDE_SCREEN_PRC_BORDER;
         this._squadDataVo = HBC_SquadDataVo(param1);
         if(this._squadDataVo && this._squadDataVo.squadExtendInfoVo && this._squadDataVo.squadExtendInfoVo.squadManStates)
         {
            this._isShort = this._squadDataVo.squadExtendInfoVo.squadManStates.length == SHORT_SIZE_PLATOON;
            this.updateContainersSizeScreen();
         }
         super.data = param1;
      }
      
      private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidate(InvalidationType.DATA,InvalidationType.SIZE);
      }
   }
}
