package net.wg.gui.lobby.profile.pages.technique
{
   import flash.events.Event;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PROFILE_DROPDOWN_KEYS;
   import net.wg.gui.events.TechniqueListComponentEvent;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import net.wg.gui.lobby.profile.data.SectionLayoutManager;
   import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
   import net.wg.gui.lobby.profile.pages.technique.data.RatingButtonVO;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import net.wg.infrastructure.base.meta.IProfileTechniqueMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileTechniqueMeta;
   import scaleform.clik.data.DataProvider;
   
   public class ProfileTechnique extends ProfileTechniqueMeta implements IProfileTechniqueMeta
   {
      
      private static const CURRENT_DIMENSION_INVALID:String = "cdInv";
      
      private static const ADDITIONAL_LIST_HEIGHT:int = 3;
      
      private static const MIN_HEIGHT:int = 525;
      
      private static const MAX_HEIGHT:int = 740;
      
      private static const DEFAULT_TECHNIQUE_RENDERER_LINKAGE:String = "TechniqueRenderer_UI";
      
      private static const BATTLEROYALE_TECHNIQUE_RENDERER_LINKAGE:String = "BattleRoyaleTechniqueRendererUI";
       
      
      public var listComponent:TechniqueListComponent = null;
      
      public var stackComponent:TechniqueStackComponent = null;
      
      public var emptyScreen:ProfileTechniqueEmptyScreen = null;
      
      protected var techniqueInitVO:TechStatisticsInitVO = null;
      
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
            this.listComponent.techniqueList.itemRendererName = DEFAULT_TECHNIQUE_RENDERER_LINKAGE;
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
      }
      
      override protected function setRatingButton(param1:RatingButtonVO) : void
      {
         this.stackComponent.updateRatingButton(param1);
      }
      
      override protected function setBtnCounters(param1:Vector.<CountersVo>) : void
      {
         this.stackComponent.setBtnCounters(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         layoutManager = new SectionLayoutManager(MIN_HEIGHT,MAX_HEIGHT);
         layoutManager.registerComponents(this.listComponent,this.stackComponent);
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
         if(layoutManager != null)
         {
            layoutManager.setDimension(currentDimension.x,currentDimension.y);
         }
         this.x = (currentDimension.x >> 1) - centerOffset;
         var _loc1_:int = Math.min(currentDimension.x,ProfileConstants.MIN_APP_WIDTH);
         this.emptyScreen.x = _loc1_ - this.emptyScreen.width >> 1;
         this.listComponent.setSize(currentDimension.x,currentDimension.y - this.listComponent.y + ADDITIONAL_LIST_HEIGHT);
         this.stackComponent.setViewSize(_loc1_ - this.stackComponent.x,currentDimension.y - this.stackComponent.y);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(currentDimension && isInvalid(CURRENT_DIMENSION_INVALID))
         {
            this.applyResizing();
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
         this.techniqueInitVO.dispose();
         this.techniqueInitVO = null;
         super.onDispose();
      }
      
      override protected function responseVehicleDossier(param1:ProfileVehicleDossierVO) : void
      {
         this.stackComponent.updateTankData(param1);
         this.updateStackComponentLabel(this.listComponent.getSelectedItem());
      }
      
      protected function applyInitData() : void
      {
         this.listComponent.headerDataProvider = this.techniqueInitVO.tableHeader;
         this.listComponent.setSelectedTableColumn(this.techniqueInitVO.selectedColumn,this.techniqueInitVO.selectedColumnSorting);
         battlesDropdown.dataProvider = this.techniqueInitVO.dropDownProvider;
      }
      
      private function updateStackComponentLabel(param1:TechniqueListVehicleVO) : void
      {
         if(param1 == null)
         {
            this.stackComponent.updateLabel(Values.EMPTY_STR,null);
         }
         else
         {
            this.stackComponent.updateLabel(param1.userName,param1.typeIconPath);
         }
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
   }
}
