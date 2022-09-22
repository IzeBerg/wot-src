package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsMapPlanVO;
   import net.wg.gui.lobby.personalMissions.events.PlanRegionEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class PersonalMissionsPlan extends UIComponentEx
   {
      
      private static const FIRST_Z_INDEX:int = 2;
      
      private static const SECOND_Z_INDEX:int = 3;
       
      
      public var region1:PersonalMissionsPlanRegion = null;
      
      public var region2:PersonalMissionsPlanRegion = null;
      
      public var region3:PersonalMissionsPlanRegion = null;
      
      public var region4:PersonalMissionsPlanRegion = null;
      
      public var region5:PersonalMissionsPlanRegion = null;
      
      public var region6:PersonalMissionsPlanRegion = null;
      
      public var region7:PersonalMissionsPlanRegion = null;
      
      public var region8:PersonalMissionsPlanRegion = null;
      
      public var region9:PersonalMissionsPlanRegion = null;
      
      public var region10:PersonalMissionsPlanRegion = null;
      
      public var region11:PersonalMissionsPlanRegion = null;
      
      public var region12:PersonalMissionsPlanRegion = null;
      
      public var region13:PersonalMissionsPlanRegion = null;
      
      public var region14:PersonalMissionsPlanRegion = null;
      
      public var region15:PersonalMissionsPlanRegion = null;
      
      public var awardsBlock:PersonalMissionsRegionAwards = null;
      
      private var _regions:Vector.<PersonalMissionsPlanRegion> = null;
      
      private var _model:PersonalMissionsMapPlanVO = null;
      
      private var _topZOffset:int = 1;
      
      public function PersonalMissionsPlan()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:Sprite = null;
         super.configUI();
         this.awardsBlock.mouseChildren = this.awardsBlock.mouseEnabled = false;
         this._regions = new <PersonalMissionsPlanRegion>[this.region1,this.region2,this.region3,this.region4,this.region5,this.region6,this.region7,this.region8,this.region9,this.region10,this.region11,this.region12,this.region13,this.region14,this.region15];
         for each(_loc1_ in this._regions)
         {
            _loc1_.addEventListener(ButtonEvent.CLICK,this.onRegionClickHandler);
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onRegionMouseOverHandler);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(this._model != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               _loc1_ = this._model.regions.length;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  this._regions[_loc2_].setData(this._model.regions[_loc2_]);
                  this._regions[_loc2_].validateNow();
                  _loc2_++;
               }
               this.awardsBlock.setData(this._model.awardsBlockVO);
               this.trySetInProgressOnTop();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:PersonalMissionsPlanRegion = null;
         for each(_loc1_ in this._regions)
         {
            _loc1_.removeEventListener(ButtonEvent.CLICK,this.onRegionClickHandler);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onRegionMouseOverHandler);
            _loc1_.dispose();
         }
         this._regions.splice(0,this._regions.length);
         this._regions = null;
         this.awardsBlock.dispose();
         this.awardsBlock = null;
         this.region1 = null;
         this.region2 = null;
         this.region3 = null;
         this.region4 = null;
         this.region5 = null;
         this.region6 = null;
         this.region7 = null;
         this.region8 = null;
         this.region9 = null;
         this.region10 = null;
         this.region11 = null;
         this.region12 = null;
         this.region13 = null;
         this.region14 = null;
         this.region15 = null;
         this._model = null;
         super.onDispose();
      }
      
      public function setData(param1:PersonalMissionsMapPlanVO) : void
      {
         if(param1 != null && param1 != this._model)
         {
            this._model = param1;
            invalidateData();
         }
      }
      
      private function trySetInProgressOnTop() : void
      {
         var _loc1_:PersonalMissionsPlanRegion = null;
         for each(_loc1_ in this._regions)
         {
            if(_loc1_.regionState == PERSONAL_MISSIONS_ALIASES.REGION_IN_PROGRESS || _loc1_.regionState == PERSONAL_MISSIONS_ALIASES.REGION_ON_PAUSE)
            {
               setChildIndex(_loc1_,numChildren - FIRST_Z_INDEX);
               this._topZOffset = SECOND_Z_INDEX;
               return;
            }
         }
         this._topZOffset = FIRST_Z_INDEX;
      }
      
      private function onRegionMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:PersonalMissionsPlanRegion = PersonalMissionsPlanRegion(param1.target);
         if(_loc2_.isEnabled() && _loc2_.regionState != PERSONAL_MISSIONS_ALIASES.REGION_IN_PROGRESS && _loc2_.regionState != PERSONAL_MISSIONS_ALIASES.REGION_ON_PAUSE)
         {
            setChildIndex(_loc2_,numChildren - this._topZOffset);
         }
      }
      
      private function onRegionClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:PersonalMissionsPlanRegion = PersonalMissionsPlanRegion(param1.target);
         if(_loc2_.isEnabled())
         {
            dispatchEvent(new PlanRegionEvent(PlanRegionEvent.CLICK,PersonalMissionsPlanRegion(param1.target).id,true));
         }
      }
   }
}
