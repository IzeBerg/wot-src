package net.wg.gui.cyberSport.views.respawn
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSlotsVO;
   import net.wg.gui.rally.controls.RallyInvalidationType;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.gui.rally.views.room.BaseTeamSection;
   import net.wg.gui.rally.vo.RallyVO;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   
   public class RespawnTeamSection extends BaseTeamSection implements IFocusContainer
   {
      
      private static const INVALID_TOTAL_POINTS:String = "invalidTotalPoints";
      
      private static const STATUS_START_Y_POS:Number = 437;
      
      private static const FIGHT_BTN_TOP_MARGIN:Number = 4;
       
      
      public var lblTeamPoints:TextField;
      
      public var slot0:IRallySimpleSlotRenderer;
      
      public var slot1:IRallySimpleSlotRenderer;
      
      public var slot2:IRallySimpleSlotRenderer;
      
      public var slot3:IRallySimpleSlotRenderer;
      
      public var slot4:IRallySimpleSlotRenderer;
      
      public var slot5:IRallySimpleSlotRenderer;
      
      public var slot6:IRallySimpleSlotRenderer;
      
      private var _totalSumStr:String = "";
      
      public function RespawnTeamSection()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.lblTeamPoints = null;
         this.slot0 = null;
         this.slot1 = null;
         this.slot2 = null;
         this.slot3 = null;
         this.slot4 = null;
         this.slot5 = null;
         this.slot6 = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this._totalSumStr == Values.EMPTY_STR)
         {
            this._totalSumStr = CYBERSPORT.RESPAWN_TEAM_POINTS;
         }
         tooltipSubscribe([this.lblTeamPoints]);
         lblStatus.y = STATUS_START_Y_POS;
         btnFight.y = lblStatus.y + lblStatus.height + FIGHT_BTN_TOP_MARGIN;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_TOTAL_POINTS))
         {
            this.lblTeamPoints.htmlText = this._totalSumStr;
         }
         if(isInvalid(RallyInvalidationType.RALLY_DATA) && rallyData)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      override protected function updateComponents() : void
      {
         super.updateComponents();
      }
      
      override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
      {
         var _loc2_:IRallySimpleSlotRenderer = null;
         var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6];
         var _loc3_:ISlotRendererHelper = new RespawnSlotHelper();
         var _loc4_:Number = 0;
         for each(_loc2_ in _loc1_)
         {
            _loc2_.helper = _loc3_;
            _loc2_.index = _loc4_;
            _loc4_++;
         }
         return _loc1_;
      }
      
      override protected function getMembersStr() : String
      {
         return CYBERSPORT.RESPAWN_TEAM_TEAMMEMBERS;
      }
      
      override protected function getSlotVO(param1:Object) : IRallySlotVO
      {
         return new LegionariesSlotsVO(param1);
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         var _loc1_:RespawnTeamSlot = this.getHimSelfSlot();
         return _loc1_ != null ? _loc1_.vehicleBtn as InteractiveObject : null;
      }
      
      public function updateTotalLabel(param1:Boolean, param2:String, param3:int) : void
      {
         this.updateLevelLabels(param2);
         this.unitData.sumLevelsError = param1;
         this.unitData.sumLevelsInt = param3;
      }
      
      private function updateLevelLabels(param1:String) : void
      {
         this._totalSumStr = param1;
         invalidate(INVALID_TOTAL_POINTS);
      }
      
      private function getHimSelfSlot() : RespawnTeamSlot
      {
         var _loc2_:Number = NaN;
         var _loc1_:RespawnTeamSlot = null;
         if(_slotsUi && _slotsUi.length)
         {
            _loc2_ = 0;
            while(_loc2_ < _slotsUi.length)
            {
               _loc1_ = _slotsUi[_loc2_] as RespawnTeamSlot;
               App.utils.asserter.assertNotNull(_loc1_,"respawnSlot" + Errors.CANT_NULL);
               if(_loc1_.isHimSelf)
               {
                  break;
               }
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function get unitData() : RallyVO
      {
         return rallyData as RallyVO;
      }
      
      private function get rallyVO() : RallyVO
      {
         return rallyData as RallyVO;
      }
      
      override protected function onControlRollOver(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.lblTeamPoints:
               if(this.rallyVO)
               {
                  App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_UNIT_LEVEL,null,this.rallyVO.sumLevelsInt);
               }
         }
      }
   }
}
