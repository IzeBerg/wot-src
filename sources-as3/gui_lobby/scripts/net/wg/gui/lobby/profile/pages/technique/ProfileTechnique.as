package net.wg.gui.lobby.profile.pages.technique
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.Aliases;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.PROFILE_DROPDOWN_KEYS;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.events.TechniqueListComponentEvent;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import net.wg.gui.lobby.profile.components.ResizableInvalidationTypes;
   import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
   import net.wg.gui.lobby.profile.pages.technique.data.RatingButtonVO;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import net.wg.infrastructure.base.meta.IProfileTechniqueMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileTechniqueMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class ProfileTechnique extends ProfileTechniqueMeta implements IProfileTechniqueMeta
   {
      
      private static const LIST_OFFSET_X:int = 105;
      
      private static const ADDITIONAL_LIST_OFFSET:int = -35;
      
      private static const ADDITIONAL_LIST_OFFSET_SMALL:int = 200;
      
      private static const ADDITIONAL_STACK_OFFSET_SMALL:int = 105;
      
      private static const ADDITIONAL_STACK_OFFSET_WINDOWED:int = 14;
      
      private static const ADDITIONAL_LIST_HEIGHT:int = 103;
      
      private static const ADDITIONAL_STACK_HEIGHT:int = 80;
      
      private static const WINDOW_LIST_ADDITIONAL_SIZE:int = 10;
      
      private static const SMALL_SCALE:Number = 0.85;
      
      private static const STACK_OFFSET_X:int = 578;
      
      private static const STACK_OFFSET_OFFSET_X_SMALL:int = 600;
      
      private static const DEFAULT_TECHNIQUE_RENDERER_LINKAGE:String = "TechniqueRenderer_UI";
      
      private static const PRESTIGE_TECHNIQUE_RENDERER_LINKAGE:String = "PrestigeTechniqueRenderer_UI";
      
      private static const BATTLEROYALE_TECHNIQUE_RENDERER_LINKAGE:String = "BattleRoyaleTechniqueRendererUI";
      
      private static const INVALIDATE_PRESTIGE_VISIBILITY:String = "invPrestigeVisibility";
      
      private static const CONTENT_Y_DEFAULT:int = 156;
      
      private static const CONTENT_Y_WINDOWED:int = 39;
      
      private static const CONTENT_Y_SEASON_DROPDOWN:int = 210;
      
      private static const CONTENT_Y_SEASON_DROPDOWN_WINDOWED:int = 89;
       
      
      public var lblSeasonDropdown:TextField = null;
      
      public var seasonDropdown:DropdownMenu = null;
      
      public var listComponent:TechniqueListComponent = null;
      
      public var stackComponent:TechniqueStackComponent = null;
      
      public var emptyScreen:ProfileTechniqueEmptyScreen = null;
      
      protected var techniqueInitVO:TechStatisticsInitVO = null;
      
      private var _otherPlayerData:Boolean = false;
      
      private var _isPrestigeEnabled:Boolean = false;
      
      private var _isPrestigeWidgetInited:Boolean = false;
      
      public function ProfileTechnique()
      {
         super();
      }
      
      override public function as_responseDossier(param1:String, param2:Object, param3:String, param4:String) : void
      {
         super.as_responseDossier(param1,param2,param3,param4);
         if(param1 == PROFILE_DROPDOWN_KEYS.BATTLE_ROYALE_SOLO || param1 == PROFILE_DROPDOWN_KEYS.BATTLE_ROYALE_SQUAD)
         {
            this.listComponent.techniqueList.itemRendererName = BATTLEROYALE_TECHNIQUE_RENDERER_LINKAGE;
         }
         else
         {
            this.listComponent.techniqueList.itemRendererName = !!this.techniqueInitVO.isPrestigeEnabled ? PRESTIGE_TECHNIQUE_RENDERER_LINKAGE : DEFAULT_TECHNIQUE_RENDERER_LINKAGE;
         }
         this.emptyScreen.text = param4;
      }
      
      override public function as_setInitData(param1:Object) : void
      {
         if(this.techniqueInitVO)
         {
            this.techniqueInitVO.dispose();
         }
         this.techniqueInitVO = new TechStatisticsInitVO(param1);
         this.applyInitData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.listComponent.addEventListener(TechniqueListComponentEvent.SELECTED_COLUMN_CHANGE,this.onListComponentSelectedColumnChangeHandler);
         this.listComponent.addEventListener(TechniqueListComponent.SELECTED_INDEX_CHANGED,this.onListComponentSelectedIndexChangedHandler,false,0,true);
         this.stackComponent.addEventListener(ProfileTechniqueEvent.VIEW_RATING_BTN_CLICK,this.onStackComponentViewRatingBtnClickHandler);
         this.stackComponent.addEventListener(ProfileTechniqueEvent.PRESTIGE_WIDGET_ENABLED,this.onStackComponentPrestigeWidgetEnabledHandler);
         this.stackComponent.addEventListener(ProfileTechniqueEvent.PRESTIGE_WIDGET_DISABLED,this.onStackComponentPrestigeWidgetDisabledHandler);
         this.seasonDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onSeasonDropdownIndexChangeHandler);
      }
      
      override protected function setRatingButton(param1:RatingButtonVO) : void
      {
         this.stackComponent.updateRatingButton(param1);
      }
      
      override protected function setBtnCounters(param1:Vector.<CountersVo>) : void
      {
         this.stackComponent.setBtnCounters(param1);
      }
      
      override protected function applyData(param1:Object) : void
      {
         var _loc5_:TechniqueListVehicleVO = null;
         var _loc6_:Object = null;
         var _loc2_:DataProvider = new DataProvider();
         var _loc3_:Boolean = false;
         var _loc4_:Array = param1 as Array;
         if(_loc4_)
         {
            for each(_loc6_ in _loc4_)
            {
               _loc5_ = new TechniqueListVehicleVO(_loc6_);
               _loc2_.push(_loc5_);
            }
            _loc3_ = _loc2_.length > 0;
         }
         this.stackComponent.enableAwardsButton(battlesType != PROFILE_DROPDOWN_KEYS.FORTIFICATIONS_BATTLES && battlesType != PROFILE_DROPDOWN_KEYS.FORTIFICATIONS_SORTIES && battlesType != PROFILE_DROPDOWN_KEYS.CLAN && battlesType != PROFILE_DROPDOWN_KEYS.STATICTEAM && battlesType != PROFILE_DROPDOWN_KEYS.STATICTEAM_SEASON);
         this.listComponent.vehicles = _loc2_;
         this.emptyScreen.visible = !_loc3_;
         this.listComponent.visible = this.stackComponent.visible = _loc3_;
      }
      
      override protected function applyResizing() : void
      {
         this.x = (currentDimension.x >> 1) - centerOffset;
         var _loc1_:int = Math.min(currentDimension.x,ProfileConstants.MIN_APP_WIDTH);
         var _loc2_:Boolean = App.appWidth < StageSizeBoundaries.WIDTH_1280;
         this.emptyScreen.x = _loc1_ - this.emptyScreen.width >> 1;
         if(isWindowed)
         {
            this.listComponent.y = this.stackComponent.y = !!this.seasonDropdown.visible ? Number(CONTENT_Y_SEASON_DROPDOWN_WINDOWED) : Number(CONTENT_Y_WINDOWED);
         }
         else
         {
            this.listComponent.y = this.stackComponent.y = !!this.seasonDropdown.visible ? Number(CONTENT_Y_SEASON_DROPDOWN) : Number(CONTENT_Y_DEFAULT);
         }
         var _loc3_:int = currentDimension.y - this.listComponent.y + ADDITIONAL_LIST_HEIGHT;
         var _loc4_:int = currentDimension.y - this.stackComponent.y + ADDITIONAL_STACK_HEIGHT;
         var _loc5_:Boolean = isWindowed || !_loc2_;
         if(isWindowed)
         {
            _loc3_ += WINDOW_LIST_ADDITIONAL_SIZE;
            _loc4_ += ADDITIONAL_STACK_OFFSET_WINDOWED;
         }
         if(!_loc5_)
         {
            _loc3_ += ADDITIONAL_LIST_OFFSET_SMALL;
            _loc4_ += ADDITIONAL_STACK_OFFSET_SMALL;
         }
         else
         {
            _loc3_ += ADDITIONAL_LIST_OFFSET;
         }
         this.listComponent.setSize(currentDimension.x,_loc3_);
         this.stackComponent.setViewSize(_loc1_ - this.stackComponent.x,_loc4_);
         var _loc6_:Number = !!_loc5_ ? Number(1) : Number(SMALL_SCALE);
         var _loc7_:int = !!_loc5_ ? int(0) : int(LIST_OFFSET_X);
         var _loc8_:int = !!_loc5_ ? int(STACK_OFFSET_X) : int(STACK_OFFSET_OFFSET_X_SMALL);
         this.listComponent.scaleX = this.listComponent.scaleY = _loc6_;
         this.stackComponent.scaleX = this.stackComponent.scaleY = _loc6_;
         this.listComponent.x = _loc7_;
         this.stackComponent.x = _loc8_;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_PRESTIGE_VISIBILITY))
         {
            this.stackComponent.updatePrestigeVisibility(this._isPrestigeEnabled,this._otherPlayerData);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.listComponent != null)
         {
            this.listComponent.removeEventListener(TechniqueListComponentEvent.SELECTED_COLUMN_CHANGE,this.onListComponentSelectedColumnChangeHandler);
            this.listComponent.removeEventListener(TechniqueListComponent.SELECTED_INDEX_CHANGED,this.onListComponentSelectedIndexChangedHandler);
            this.listComponent.dispose();
            this.listComponent = null;
         }
         if(this.stackComponent != null)
         {
            this.stackComponent.removeEventListener(ProfileTechniqueEvent.VIEW_RATING_BTN_CLICK,this.onStackComponentViewRatingBtnClickHandler);
            this.stackComponent.removeEventListener(ProfileTechniqueEvent.PRESTIGE_WIDGET_ENABLED,this.onStackComponentPrestigeWidgetEnabledHandler);
            this.stackComponent.removeEventListener(ProfileTechniqueEvent.PRESTIGE_WIDGET_DISABLED,this.onStackComponentPrestigeWidgetDisabledHandler);
            this.stackComponent.dispose();
            this.stackComponent = null;
         }
         if(this.emptyScreen != null)
         {
            if(this.emptyScreen.parent)
            {
               this.emptyScreen.parent.removeChild(this.emptyScreen);
            }
            this.emptyScreen.dispose();
            this.emptyScreen = null;
         }
         this.lblSeasonDropdown = null;
         this.seasonDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onSeasonDropdownIndexChangeHandler);
         this.seasonDropdown.dispose();
         this.seasonDropdown = null;
         this.techniqueInitVO.dispose();
         this.techniqueInitVO = null;
         super.onDispose();
      }
      
      override protected function responseVehicleDossier(param1:ProfileVehicleDossierVO) : void
      {
         this.stackComponent.updateTankData(param1);
         this.updateStackComponentLabel(this.listComponent.getSelectedItem());
      }
      
      public function as_setPrestigeVisible(param1:Boolean) : void
      {
         if(this._isPrestigeEnabled != param1)
         {
            this._isPrestigeEnabled = param1;
            invalidate(INVALIDATE_PRESTIGE_VISIBILITY);
         }
      }
      
      protected function applyInitData() : void
      {
         var _loc1_:Array = null;
         this.listComponent.headerDataProvider = this.techniqueInitVO.tableHeader;
         this.listComponent.setSelectedTableColumn(this.techniqueInitVO.selectedColumn,this.techniqueInitVO.selectedColumnSorting);
         battlesDropdown.dataProvider = this.techniqueInitVO.dropDownProvider;
         this.lblSeasonDropdown.htmlText = this.techniqueInitVO.dropdownSeasonLabel;
         this.lblSeasonDropdown.visible = this.seasonDropdown.visible = this.techniqueInitVO.showSeasonDropdown;
         if(this.techniqueInitVO.seasonItems != null)
         {
            _loc1_ = this.techniqueInitVO.seasonItems as Array;
            App.utils.asserter.assertNotNull(_loc1_,Errors.INVALID_TYPE + Array);
            if(_loc1_.length > 0)
            {
               this.seasonDropdown.dataProvider = new DataProvider(_loc1_);
               this.seasonDropdown.selectedIndex = this.techniqueInitVO.seasonIndex;
               this.seasonDropdown.enabled = this.techniqueInitVO.seasonEnabled;
               this.seasonDropdown.validateNow();
            }
         }
         invalidate(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
      }
      
      private function updateStackComponentLabel(param1:TechniqueListVehicleVO) : void
      {
         if(param1 != null)
         {
            this.stackComponent.updateLabel(param1.userName,param1.typeIconPath);
            if(this._otherPlayerData != param1.isOtherPlayer)
            {
               this._otherPlayerData = param1.isOtherPlayer;
               invalidate(INVALIDATE_PRESTIGE_VISIBILITY);
            }
         }
      }
      
      private function onSeasonDropdownIndexChangeHandler(param1:ListEvent) : void
      {
         setSeasonS(param1.itemData.key);
      }
      
      override public function set isWindowed(param1:Boolean) : void
      {
         super.isWindowed = param1;
      }
      
      private function onListComponentSelectedIndexChangedHandler(param1:Event = null) : void
      {
         var _loc2_:TechniqueListVehicleVO = this.listComponent.getSelectedItem();
         this.updateStackComponentLabel(_loc2_);
         if(_loc2_ != null)
         {
            requestDataS(_loc2_.id);
         }
      }
      
      private function onListComponentSelectedColumnChangeHandler(param1:TechniqueListComponentEvent) : void
      {
         setSelectedTableColumnS(param1.selectedColumn,param1.selectedColumnSorting);
      }
      
      private function onStackComponentViewRatingBtnClickHandler(param1:ProfileTechniqueEvent) : void
      {
         showVehiclesRatingS();
      }
      
      private function onStackComponentPrestigeWidgetEnabledHandler(param1:ProfileTechniqueEvent) : void
      {
         var _loc2_:GFInjectComponent = this.stackComponent.prestigeWidget;
         if(this._isPrestigeEnabled && _loc2_)
         {
            this._isPrestigeWidgetInited = true;
            registerFlashComponentS(_loc2_,!!this._otherPlayerData ? Aliases.PROFILE_PRESTIGE_EMBLEM_WIDGET : Aliases.PROFILE_PRESTIGE_WIDGET);
         }
      }
      
      private function onStackComponentPrestigeWidgetDisabledHandler(param1:ProfileTechniqueEvent) : void
      {
         if(this._isPrestigeWidgetInited)
         {
            this._isPrestigeWidgetInited = false;
            unregisterFlashComponentS(!!this._otherPlayerData ? Aliases.PROFILE_PRESTIGE_EMBLEM_WIDGET : Aliases.PROFILE_PRESTIGE_WIDGET);
         }
      }
   }
}
