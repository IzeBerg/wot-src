package net.wg.gui.rally.controls
{
   import net.wg.data.constants.UserTags;
   import net.wg.gui.interfaces.IResettable;
   import net.wg.gui.rally.constants.PlayerStatus;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   
   public class BaseRallySlotHelper extends SlotRendererHelper
   {
       
      
      protected var isAlertIconVisible:Boolean = false;
      
      public function BaseRallySlotHelper()
      {
         super();
      }
      
      override public function initControlsState(param1:IRallySimpleSlotRenderer) : void
      {
         super.initControlsState(param1);
         var _loc2_:RallySimpleSlotRenderer = RallySimpleSlotRenderer(param1);
         if(_loc2_.takePlaceBtn)
         {
            _loc2_.takePlaceBtn.visible = false;
         }
         if(_loc2_.takePlaceFirstTimeBtn)
         {
            _loc2_.takePlaceFirstTimeBtn.visible = false;
         }
         _loc2_.vehicleBtn.visible = false;
         IResettable(_loc2_.vehicleBtn).reset();
      }
      
      override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         super.updateComponents(param1,param2);
         var _loc3_:RallySimpleSlotRenderer = RallySimpleSlotRenderer(param1);
         var _loc4_:Boolean = false;
         if(param2)
         {
            _loc5_ = Boolean(param2.player) ? Boolean(UserTags.isCurrentPlayer(param2.player.tags)) : Boolean(false);
            _loc4_ = _loc3_.index > 0 && param2.canBeTaken && !param2.isClosed && !param2.isFreezed && !param2.isCommanderState;
            if(_loc3_.takePlaceFirstTimeBtn)
            {
               _loc3_.takePlaceFirstTimeBtn.visible = _loc4_ && !param2.isCurrentUserInSlot;
            }
            if(_loc3_.takePlaceBtn)
            {
               _loc3_.takePlaceBtn.visible = _loc4_ && param2.isCurrentUserInSlot;
            }
            if(_loc3_.contextMenuArea)
            {
               _loc3_.contextMenuArea.visible = param2 && param2.player && !_loc5_;
            }
            if(!param2.isClosed)
            {
               _loc3_.vehicleBtn.visible = true;
               if(param2.selectedVehicle)
               {
                  _loc3_.vehicleBtn.setVehicle(param2.selectedVehicle);
               }
               else if(param2.isCommanderState)
               {
                  _loc3_.vehicleBtn.vehicleCount = -1;
                  _loc6_ = isShowSlotRestrictions(_loc3_,param2);
                  _loc3_.vehicleBtn.showCommanderSettings = _loc6_;
                  _loc3_.vehicleBtn.visible = Boolean(param2.player) || _loc3_.vehicleBtn.showCommanderSettings;
               }
               else if(!param2.isCommanderState && !param2.player)
               {
                  _loc3_.vehicleBtn.vehicleCount = _loc3_.index == 0 || !param2.hasRestrictions ? int(-1) : int(param2.compatibleVehiclesCount);
                  _loc3_.vehicleBtn.visible = Boolean(param2.player) || _loc3_.vehicleBtn.vehicleCount > -1;
               }
               else
               {
                  _loc3_.vehicleBtn.vehicleCount = -1;
                  _loc3_.vehicleBtn.visible = Boolean(param2.player);
               }
               _loc3_.vehicleBtn.selectState(!param2.selectedVehicle && param2.player && _loc5_,chooseVehicleText);
               if(param2.player)
               {
                  _loc3_.vehicleBtn.enabled = _loc5_ && param2.playerStatus != PlayerStatus.STATUS_READY;
                  _loc7_ = param2.playerStatus == PlayerStatus.STATUS_IN_BATTLE;
                  _loc3_.vehicleBtn.showAlertIcon = _loc5_;
                  this.isAlertIconVisible = _loc5_ && param2.selectedVehicle && !param2.selectedVehicle.isReadyToFight;
               }
            }
            else
            {
               _loc4_ = false;
               _loc3_.vehicleBtn.visible = false;
            }
            _loc3_.slotLabel.visible = !_loc4_;
         }
      }
   }
}
