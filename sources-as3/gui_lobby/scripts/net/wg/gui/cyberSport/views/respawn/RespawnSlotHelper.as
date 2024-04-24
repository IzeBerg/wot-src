package net.wg.gui.cyberSport.views.respawn
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.rally.controls.BaseRallySlotHelper;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   
   public class RespawnSlotHelper extends BaseRallySlotHelper
   {
      
      private static const ALLY_LEVEL_ALPHA:Number = 0.33;
      
      private static const DEFAULT_TEXT:String = "0";
       
      
      public function RespawnSlotHelper()
      {
         super();
      }
      
      override public function initControlsState(param1:IRallySimpleSlotRenderer) : void
      {
         super.initControlsState(param1);
         var _loc2_:RespawnTeamSlot = param1 as RespawnTeamSlot;
         App.utils.asserter.assertNotNull(_loc2_,"unitSlot" + Errors.CANT_NULL);
         _loc2_.levelLbl.visible = true;
         _loc2_.levelLbl.text = DEFAULT_TEXT;
         _loc2_.levelLbl.alpha = ALLY_LEVEL_ALPHA;
      }
      
      override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
      {
         var _loc7_:ITooltipFormatter = null;
         super.onControlRollOver(param1,param2,param3,param4);
         var _loc5_:RespawnTeamSlot = param2 as RespawnTeamSlot;
         App.utils.asserter.assertNotNull(_loc5_,"unitSlot" + Errors.CANT_NULL);
         var _loc6_:IRallySlotVO = param3 as IRallySlotVO;
         if(_loc6_ && _loc5_)
         {
            switch(param1)
            {
               case _loc5_.slotLabel:
                  if(_loc6_.isClosed)
                  {
                     App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_SLOTLABELCLOSED);
                  }
                  else if(_loc6_.compatibleVehiclesCount == 0 && !_loc6_.player && !_loc6_.isCommanderState)
                  {
                     App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_SLOTLABELUNAVAILABLE);
                  }
                  else if(_loc6_.player)
                  {
                     App.toolTipMgr.show(_loc6_.player.getToolTip());
                  }
                  break;
               case _loc5_.vehicleBtn:
                  if(_loc5_.vehicleBtn.currentState == CSVehicleButton.CHOOSE_VEHICLE)
                  {
                     App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_SELECTVEHICLE);
                  }
                  else if(_loc5_.vehicleBtn.currentState == CSVehicleButton.DEFAULT_STATE)
                  {
                     App.toolTipMgr.showComplex(TOOLTIPS.MEDALION_NOVEHICLE);
                  }
                  else if(_loc5_.vehicleBtn.currentState == CSVehicleButton.SELECTED_VEHICLE)
                  {
                     if(param4 && param4.type == CSVehicleButton.ALERT_DATA_TYPE)
                     {
                        _loc7_ = App.toolTipMgr.getNewFormatter();
                        _loc7_.addHeader(param4.state);
                        _loc7_.addBody(TOOLTIPS.CYBERSPORT_UNIT_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY,true);
                        App.toolTipMgr.showComplex(_loc7_.make());
                     }
                     else
                     {
                        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT_SELECTED,null,param2.index,_loc6_.rallyIdx);
                     }
                  }
                  else
                  {
                     App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT,null,param2.index,_loc6_.rallyIdx);
                  }
            }
         }
      }
      
      override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
      {
         var _loc3_:RespawnTeamSlot = null;
         var _loc4_:IRallySlotVO = null;
         super.updateComponents(param1,param2);
         _loc3_ = param1 as RespawnTeamSlot;
         _loc4_ = param2 as IRallySlotVO;
         if(_loc3_ && _loc4_)
         {
            _loc3_.slotLabel.visible = true;
            _loc3_.levelLbl.text = String(_loc4_.selectedVehicleLevel);
            _loc3_.levelLbl.alpha = Boolean(_loc4_.selectedVehicleLevel) ? Number(1) : Number(ALLY_LEVEL_ALPHA);
            if(_loc4_.player)
            {
               _loc3_.setSpeakers(_loc4_.player.isPlayerSpeaking,true);
               _loc3_.selfBg.visible = UserTags.isCurrentPlayer(_loc4_.player.tags);
               _loc3_.commander.visible = _loc4_.player.isCommander;
            }
            else
            {
               _loc3_.commander.visible = false;
               _loc3_.selfBg.visible = false;
               _loc3_.setSpeakers(false,true);
            }
         }
      }
   }
}
