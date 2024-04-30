package net.wg.gui.lobby.header.headerButtonBar
{
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.header.headerButtonBar.container.HBPlatoonShieldIconContainer;
   import net.wg.gui.lobby.header.headerButtonBar.container.PlatoonShieldIconContainer;
   import scaleform.clik.constants.InvalidationType;
   
   public class HBC_HBSquad extends HBC_Squad
   {
      
      public static const HB_SIZE_PLATOON:int = 5;
      
      private static const MAX_SCREEN_PRC_HB:Number = 1;
       
      
      public var hbEventIconContainer1:PlatoonShieldIconContainer = null;
      
      public var hbEventIconContainer2:PlatoonShieldIconContainer = null;
      
      public function HBC_HBSquad()
      {
         super();
         setVisibilityContainerIcons(this.hbEventIconContainer1,false);
         setVisibilityContainerIcons(this.hbEventIconContainer2,false);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hbEventIconContainer1.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.hbEventIconContainer2.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         updateSize();
      }
      
      override protected function onDispose() : void
      {
         this.hbEventIconContainer1.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.hbEventIconContainer2.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.hbEventIconContainer1.dispose();
         this.hbEventIconContainer1 = null;
         this.hbEventIconContainer2.dispose();
         this.hbEventIconContainer2 = null;
         super.onDispose();
      }
      
      override protected function updateSquadState() : void
      {
         var _loc1_:uint = squadDataVo.squadExtendInfoVo.squadManStates.length;
         restoreDefaultPositions();
         if(isWideScreen && _loc1_ == 0)
         {
            mainIconContainer.x = textField.x + textField.width + DIMENSIONS.shieldDistanceToText | 0;
         }
      }
      
      override protected function updateSquadSize() : void
      {
         isWideScreen = maxScreenPrc >= MAX_SCREEN_PRC_HB;
         updateContainersSizeScreen();
         var _loc1_:String = squadDataVo.squadExtendInfoVo.platoonState;
         var _loc2_:int = squadDataVo.squadExtendInfoVo.squadManStates.length;
         textField.visible = isWideScreen && (_loc1_ !== PlatoonShieldIconContainer.STATES.inPlatoon || !_loc2_);
         this.updateIconsVisibility();
         if(isWideScreen)
         {
            if(isNeedUpdateFont())
            {
               updateFontSize(textField,useFontSize);
               needUpdateFontSize = false;
            }
            textField.width = textField.textWidth + TEXT_FIELD_MARGIN;
         }
         else
         {
            textField.width = 0;
         }
         var _loc3_:int = mainIconContainer.getIconSize(_loc1_);
         var _loc4_:int = leftIconContainer.getIconSize(_loc1_);
         var _loc5_:int = rightIconContainer.getIconSize(_loc1_);
         var _loc6_:int = this.hbEventIconContainer1.getIconSize(_loc1_);
         var _loc7_:int = this.hbEventIconContainer2.getIconSize(_loc1_);
         var _loc8_:int = 0;
         if(searchingAnimation.visible)
         {
            _loc8_ = searchingAnimation.width;
         }
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(textField.visible)
         {
            _loc9_ = textField.width;
            if(_loc9_ > 0)
            {
               _loc10_ = DIMENSIONS.additionalTextPadding;
            }
         }
         var _loc11_:int = this.getPaddingDependingOnState(_loc1_);
         bounds.width = _loc6_ + _loc7_ + _loc3_ + _loc4_ + _loc5_ + _loc9_ + _loc8_ + _loc11_ + _loc10_;
      }
      
      override protected function updateSquadData() : void
      {
         mainIconContainer.setEventIcon(squadDataVo.icon);
         var _loc1_:int = squadDataVo.squadExtendInfoVo.squadManStates.length;
         switch(squadDataVo.squadExtendInfoVo.platoonState)
         {
            case PlatoonShieldIconContainer.STATES.create:
               arrow.visible = true;
               mainIconContainer.updateIconContainer(squadDataVo.squadExtendInfoVo,HBPlatoonShieldIconContainer.PLAYERS.current);
               textField.text = squadDataVo.buttonName;
               break;
            case PlatoonShieldIconContainer.STATES.inPlatoon:
               arrow.visible = false;
               if(_loc1_ > 0)
               {
                  textField.visible = false;
                  leftIconContainer.updateIconContainer(squadDataVo.squadExtendInfoVo,HBPlatoonShieldIconContainer.PLAYERS.left);
                  rightIconContainer.updateIconContainer(squadDataVo.squadExtendInfoVo,HBPlatoonShieldIconContainer.PLAYERS.right);
                  this.hbEventIconContainer1.updateIconContainer(squadDataVo.squadExtendInfoVo,HBPlatoonShieldIconContainer.PLAYERS.hb1);
                  this.hbEventIconContainer2.updateIconContainer(squadDataVo.squadExtendInfoVo,HBPlatoonShieldIconContainer.PLAYERS.hb2);
               }
               else
               {
                  textField.text = squadDataVo.buttonName;
               }
               mainIconContainer.updateIconContainer(squadDataVo.squadExtendInfoVo,HBPlatoonShieldIconContainer.PLAYERS.current);
         }
      }
      
      override protected function setSideIconsVisibility(param1:Boolean, param2:int = 0) : void
      {
         super.setSideIconsVisibility(param1,param2);
         this.hbEventIconContainer1.visible = this.hbEventIconContainer2.visible = param1;
      }
      
      override protected function updateIconsVisibility() : void
      {
         searchingAnimation.visible = squadDataVo.squadExtendInfoVo.platoonState == PlatoonShieldIconContainer.STATES.searching;
         var _loc1_:Boolean = squadDataVo.squadExtendInfoVo.squadManStates.length && squadDataVo.squadExtendInfoVo.squadManStates.length <= HB_SIZE_PLATOON;
         this.setHatVisibility(isWideScreen && _loc1_ && squadDataVo.squadExtendInfoVo.platoonState == PlatoonShieldIconContainer.STATES.inPlatoon);
         var _loc2_:int = squadDataVo.squadExtendInfoVo.squadManStates.length;
         if(squadDataVo.squadExtendInfoVo.platoonState == PlatoonShieldIconContainer.STATES.inPlatoon)
         {
            this.setSideIconsVisibility(isWideScreen && _loc1_,_loc2_);
            setSubiconsVisibility(!isWideScreen && _loc1_,_loc2_);
            mainIconContainer.visible = true;
         }
         else
         {
            this.setSideIconsVisibility(false);
            setSubiconsVisibility(false);
            mainIconContainer.visible = squadDataVo.squadExtendInfoVo.platoonState !== PlatoonShieldIconContainer.STATES.searching;
         }
      }
      
      override protected function getPaddingDependingOnState(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = squadDataVo.squadExtendInfoVo.squadManStates.length && squadDataVo.squadExtendInfoVo.squadManStates.length <= HB_SIZE_PLATOON;
         switch(param1)
         {
            case PlatoonShieldIconContainer.STATES.create:
               if(!_loc3_)
               {
                  _loc2_ = DIMENSIONS.createPadding;
               }
               else if(isWideScreen)
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
               else if(isWideScreen)
               {
                  _loc2_ = DIMENSIONS.platoonOrSquadPadding;
               }
               else
               {
                  _loc2_ = DIMENSIONS.minResTripleShieldPadding;
               }
               break;
            case PlatoonShieldIconContainer.STATES.searching:
               if(isWideScreen)
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
      
      override protected function setHatVisibility(param1:Boolean) : void
      {
         this.hbEventIconContainer1.isCommanderHatVisible(param1);
         this.hbEventIconContainer2.isCommanderHatVisible(param1);
         super.setHatVisibility(param1);
      }
      
      private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidate(InvalidationType.DATA,InvalidationType.SIZE);
      }
   }
}
