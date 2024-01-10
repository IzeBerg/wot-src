package net.wg.gui.cyberSport.views.unit
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.rally.controls.SlotDropIndicator;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
   import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
   import net.wg.gui.rally.views.room.TeamSectionWithDropIndicators;
   import net.wg.gui.rally.vo.RallySlotVO;
   import net.wg.gui.rally.vo.RallyVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CyberSportTeamSectionBase extends TeamSectionWithDropIndicators
   {
       
      
      public var lblTeamPoints:TextField;
      
      public var slot0:IRallySimpleSlotRenderer;
      
      public var slot1:IRallySimpleSlotRenderer;
      
      public var slot2:IRallySimpleSlotRenderer;
      
      public var slot3:IRallySimpleSlotRenderer;
      
      public var slot4:IRallySimpleSlotRenderer;
      
      public var slot5:IRallySimpleSlotRenderer;
      
      public var slot6:IRallySimpleSlotRenderer;
      
      public var dropTargerIndicator0:SlotDropIndicator;
      
      public var dropTargerIndicator1:SlotDropIndicator;
      
      public var dropTargerIndicator2:SlotDropIndicator;
      
      public var dropTargerIndicator3:SlotDropIndicator;
      
      public var dropTargerIndicator4:SlotDropIndicator;
      
      public var dropTargerIndicator5:SlotDropIndicator;
      
      public var dropTargerIndicator6:SlotDropIndicator;
      
      public function CyberSportTeamSectionBase()
      {
         super();
      }
      
      override public function cooldownSlots(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:IRallySimpleSlotRenderer = null;
         super.cooldownSlots(param1);
         if(rallyData && rallyData.isCommander)
         {
            _loc3_ = _slotsUi.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = _slotsUi[_loc2_];
               _loc4_.cooldown(param1);
               _loc2_++;
            }
         }
      }
      
      override public function getIndicatorsUI() : Vector.<ISlotDropIndicator>
      {
         return new <ISlotDropIndicator>[this.dropTargerIndicator0,this.dropTargerIndicator1,this.dropTargerIndicator2,this.dropTargerIndicator3,this.dropTargerIndicator4,this.dropTargerIndicator5,this.dropTargerIndicator6];
      }
      
      override protected function getMembersStr() : String
      {
         return CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS;
      }
      
      override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
      {
         var _loc2_:IRallySimpleSlotRenderer = null;
         var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6];
         var _loc3_:ISlotRendererHelper = this.getSlotHelper();
         for each(_loc2_ in _loc1_)
         {
            _loc2_.helper = _loc3_;
         }
         return _loc1_;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tooltipSubscribe([this.lblTeamPoints]);
         this.lblTeamPoints.text = CYBERSPORT.WINDOW_UNIT_TEAMPOINTS;
      }
      
      override protected function onDispose() : void
      {
         tooltipSubscribe([this.lblTeamPoints],false);
         this.lblTeamPoints = null;
         this.slot0 = null;
         this.slot1 = null;
         this.slot2 = null;
         this.slot3 = null;
         this.slot4 = null;
         this.slot5 = null;
         this.slot6 = null;
         this.dropTargerIndicator0 = null;
         this.dropTargerIndicator1 = null;
         this.dropTargerIndicator2 = null;
         this.dropTargerIndicator3 = null;
         this.dropTargerIndicator4 = null;
         this.dropTargerIndicator5 = null;
         this.dropTargerIndicator6 = null;
         super.onDispose();
      }
      
      override protected function updateComponents() : void
      {
         super.updateComponents();
         this.updateLblTeamPoints();
      }
      
      public function closeSlot(param1:uint, param2:Boolean, param3:uint, param4:String, param5:Boolean, param6:int) : void
      {
         var _loc7_:RallySlotVO = getSlotModel(param1) as RallySlotVO;
         App.utils.asserter.assertNotNull(_loc7_,"unitSlot" + Errors.CANT_NULL);
         _loc7_.selectedVehicleLevel = param3;
         _loc7_.compatibleVehiclesCount = param6;
         _loc7_.isClosed = param5;
         _loc7_.slotLabel = param4;
         _loc7_.playerStatus = 0;
         _loc7_.canBeTaken = param2;
         setSlotModel(param1,_loc7_);
         updateTeamLabel();
      }
      
      public function updateTotalLabel(param1:Boolean, param2:String, param3:int) : void
      {
         this.unitData.sumLevelsError = param1;
         this.unitData.sumLevelsInt = param3;
         this.unitData.sumLevels = param2;
         this.updateLblTeamPoints();
      }
      
      protected function getSlotHelper() : ISlotRendererHelper
      {
         throw new AbstractException("getSlotHelper" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function showTooltip(param1:String, param2:String) : void
      {
         var _loc3_:String = App.toolTipMgr.getNewFormatter().addHeader(param1,true).addBody(param2,true).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }
      
      private function updateLblTeamPoints() : void
      {
         this.lblTeamPoints.htmlText = this.unitData.sumLevels;
      }
      
      protected function get unitData() : RallyVO
      {
         return rallyData as RallyVO;
      }
      
      override protected function onControlRollOver(param1:MouseEvent) : void
      {
         if(param1.currentTarget == this.lblTeamPoints)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_UNIT_LEVEL,null,this.unitData.sumLevelsInt);
         }
      }
   }
}
