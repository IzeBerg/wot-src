package net.wg.gui.lobby.fortifications.battleRoom
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import flash.utils.getQualifiedClassName;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.IndicationOfStatus;
   import net.wg.gui.components.controls.ButtonIconTextTransparent;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSimpleSlot;
   import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
   import net.wg.gui.lobby.fortifications.data.battleRoom.SortieSlotVO;
   import net.wg.gui.rally.constants.PlayerStatus;
   import net.wg.gui.rally.controls.BaseRallySlotHelper;
   import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
   import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.RallySlotRenderer;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.gui.utils.VO.UnitSlotProperties;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   
   public class SortieSlotHelper extends BaseRallySlotHelper
   {
      
      private static const GUN_ICON_H_OFFSET:int = 7;
      
      private static const PIXEL_PADDING:int = 1;
      
      private static const ICON_COMMANDER:int = 1;
      
      private static const ICON_LEGIONARY:int = 2;
      
      private static const GUNNER_ROLE:String = "gunner";
      
      private static const INSPIRE_ROLE:String = "inspire";
      
      private static const BOTH_ROLE:String = "gunnerAndInspire";
      
      private static const FROZEN_VEHICLE_STATE:String = "frozenVehicle";
       
      
      private var _removeBtnProps:UnitSlotProperties;
      
      private var _lockBtnProps:UnitSlotProperties;
      
      private var _vehBtnProps:UnitSlotProperties;
      
      public function SortieSlotHelper()
      {
         super();
         this._removeBtnProps = new UnitSlotProperties(237,21);
         this._lockBtnProps = new UnitSlotProperties(273,147);
         this._vehBtnProps = new UnitSlotProperties(130,0);
      }
      
      private static function updateSlotRemoveBtn(param1:SortieSlot, param2:Boolean, param3:String, param4:UnitSlotProperties, param5:String = "") : void
      {
         if(param1 != null && param1.removeBtn != null)
         {
            param1.removeBtn.visible = param2;
            param1.removeBtn.icon = param3;
            param1.removeBtn.width = param4.width;
            param1.removeBtn.label = param5;
         }
      }
      
      private static function onCommanderRollOverHandler(param1:RallySimpleSlotRenderer) : void
      {
         if(param1.commander.currentFrame == ICON_COMMANDER)
         {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_COMMANDER);
         }
         else
         {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_BATTLEROOMLEGIONARIES_HEADER);
         }
      }
      
      private static function onStatusIndicatorRollOverHandler(param1:RallySimpleSlotRenderer) : void
      {
         if(param1.statusIndicator.currentFrameLabel == IndicationOfStatus.STATUS_READY)
         {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_ISREADY);
         }
         else if(param1.statusIndicator.currentFrameLabel == IndicationOfStatus.STATUS_NORMAL)
         {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_NOTREADY);
         }
      }
      
      private static function onSlotLabelRollOverHandler(param1:IRallySlotVO) : void
      {
         if(param1 != null)
         {
            if(param1.player)
            {
               App.toolTipMgr.show(param1.player.getToolTip());
            }
         }
      }
      
      private static function onTakePlaceFirstTimeBtnRollOverHandler() : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_TAKEPLACEFIRSTTIMEBTN);
      }
      
      private static function onTakePlaceBtnRollOverHandler() : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_TAKEPLACEFIRSTTIMEBTN);
      }
      
      private static function onVehicleBtnRollOverHandler(param1:RallySimpleSlotRenderer, param2:IRallySlotVO, param3:* = null) : void
      {
         var _loc4_:ITooltipFormatter = null;
         switch(param1.vehicleBtn.currentState)
         {
            case CSVehicleButton.CHOOSE_VEHICLE:
               App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_SELECTVEHICLE);
               break;
            case CSVehicleButton.DEFAULT_STATE:
               App.toolTipMgr.showComplex(TOOLTIPS.MEDALION_NOVEHICLE);
               break;
            case CSVehicleButton.SELECTED_VEHICLE:
               if(param3 && param3.type == CSVehicleButton.ALERT_DATA_TYPE)
               {
                  _loc4_ = App.toolTipMgr.getNewFormatter();
                  if(param3.state == FROZEN_VEHICLE_STATE)
                  {
                     _loc4_.addBody(TOOLTIPS.VEHICLESTATUS_STRONGHOLDEVENTFROZEN_BODY,true);
                  }
                  else
                  {
                     _loc4_.addHeader(param3.state);
                     _loc4_.addBody(TOOLTIPS.FORTIFICATION_SORTIE_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY,true);
                  }
                  App.toolTipMgr.showComplex(_loc4_.make());
               }
               else if(param2.player)
               {
                  if(!UserTags.isCurrentPlayer(param2.player.tags))
                  {
                     App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_PLAYER_VEHICLE);
                  }
                  else if(param2.playerStatus != PlayerStatus.STATUS_READY)
                  {
                     App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_PLAYER_CHANGEVEHICLE);
                  }
                  else
                  {
                     App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_PLAYER_CANCELREADY);
                  }
               }
               break;
            default:
               App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.FORT_SORTIE_SLOT,null,param1.index,param2.rallyIdx);
         }
      }
      
      private static function updateVehBtn(param1:CSVehicleButton, param2:Boolean, param3:UnitSlotProperties, param4:String) : void
      {
         param1.showVehicleIcon = param2;
         param1.vCountMsg.x = param3.x;
         var _loc5_:TextField = param1.defaultMsg;
         _loc5_.x = param3.x - _loc5_.width;
         _loc5_.text = param4;
         var _loc6_:Number = _loc5_.width;
         App.utils.commons.updateTextFieldSize(_loc5_,true,false);
         _loc5_.x += _loc6_ - _loc5_.width;
      }
      
      override public function initControlsState(param1:IRallySimpleSlotRenderer) : void
      {
         var _loc3_:RallySimpleSlotRenderer = null;
         var _loc4_:Boolean = false;
         var _loc5_:SortieSimpleSlot = null;
         var _loc6_:SortieSlot = null;
         var _loc7_:RallySlotRenderer = null;
         var _loc8_:RallyLockableSlotRenderer = null;
         super.initControlsState(param1);
         var _loc2_:Boolean = false;
         if(param1 is RallySimpleSlotRenderer)
         {
            _loc2_ = true;
            _loc3_ = RallySimpleSlotRenderer(param1);
            _loc4_ = param1.index == 0;
            _loc3_.orderNo.visible = !_loc4_;
            _loc3_.commander.visible = false;
         }
         if(param1 is SortieSimpleSlot)
         {
            _loc5_ = SortieSimpleSlot(param1);
            _loc2_ = true;
            _loc5_.commander.visible = _loc4_;
            _loc5_.lockBackground.visible = true;
         }
         if(param1 is SortieSlot)
         {
            _loc2_ = true;
            _loc6_ = SortieSlot(param1);
            _loc6_.commander.visible = _loc4_;
            updateVehBtn(CSVehicleButton(_loc6_.vehicleBtn),false,this._vehBtnProps,FORTIFICATIONS.STRONGHOLDSLOT_SELECTEDVEHICLESCOUNT);
         }
         if(param1 is RallySlotRenderer)
         {
            _loc2_ = true;
            _loc7_ = RallySlotRenderer(param1);
            _loc7_.removeBtn.visible = false;
            _loc7_.selfBg.visible = false;
         }
         if(param1 is RallyLockableSlotRenderer)
         {
            _loc2_ = true;
            _loc8_ = RallyLockableSlotRenderer(param1);
            _loc8_.lockBackground.visible = true;
            _loc8_.setSlotLabelHtmlText(Values.EMPTY_STR);
         }
         if(!_loc2_)
         {
            App.utils.asserter.assert(false,"Wrong slot type passed \'" + getQualifiedClassName(param1));
         }
      }
      
      override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
      {
         var _loc6_:RallySimpleSlotRenderer = null;
         var _loc7_:SortieSlot = null;
         var _loc8_:SortieSlotVO = null;
         super.onControlRollOver(param1,param2,param3,param4);
         var _loc5_:Boolean = false;
         if(param2 is RallySimpleSlotRenderer)
         {
            _loc5_ = true;
            _loc6_ = RallySimpleSlotRenderer(param2);
            switch(param1)
            {
               case _loc6_.commander:
                  onCommanderRollOverHandler(_loc6_);
                  break;
               case _loc6_.statusIndicator:
                  onStatusIndicatorRollOverHandler(_loc6_);
                  break;
               case _loc6_.slotLabel:
                  onSlotLabelRollOverHandler(param3);
                  break;
               case _loc6_.takePlaceFirstTimeBtn:
                  onTakePlaceFirstTimeBtnRollOverHandler();
                  break;
               case _loc6_.takePlaceBtn:
                  onTakePlaceBtnRollOverHandler();
                  break;
               case _loc6_.vehicleBtn:
                  onVehicleBtnRollOverHandler(_loc6_,param3,param4);
            }
         }
         if(param2 is SortieSlot)
         {
            _loc5_ = true;
            _loc7_ = SortieSlot(param2);
            _loc8_ = SortieSlotVO(param3);
            if(param1 == _loc7_.removeBtn && _loc7_.removeBtn.icon == ButtonIconTextTransparent.ICON_CROSS)
            {
               if(_loc7_.hasFilters)
               {
                  App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_REMOVEFILTERS);
               }
               else
               {
                  App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_REMOVEBTN);
               }
            }
            else if(param1 == _loc7_.gunnerIcon)
            {
               if(_loc8_ != null && _loc8_.roleIcon != Values.EMPTY_STR)
               {
                  switch(_loc8_.roleIcon)
                  {
                     case GUNNER_ROLE:
                        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_GUNNERROLE);
                        break;
                     case INSPIRE_ROLE:
                        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_INSPIREROLE);
                        break;
                     case BOTH_ROLE:
                        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_BOTHROLE);
                  }
               }
            }
            else if(param1 == _loc7_.btnConfigure)
            {
               if(_loc7_.btnConfigure.enabled)
               {
                  App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_CONFIGUREBTNENABLED);
               }
               else
               {
                  App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_CONFIGUREBTNDISABLED);
               }
            }
         }
         if(!_loc5_)
         {
            App.utils.asserter.assert(false,"Wrong slot type passed \'" + getQualifiedClassName(param2));
         }
      }
      
      override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
      {
         var _loc4_:SortieSimpleSlot = null;
         var _loc5_:RallyLockableSlotRenderer = null;
         var _loc6_:RallySimpleSlotRenderer = null;
         var _loc7_:SortieSlot = null;
         var _loc8_:SortieSlotVO = null;
         var _loc9_:Boolean = false;
         if(!param2)
         {
            return;
         }
         super.updateComponents(param1,param2);
         var _loc3_:Boolean = false;
         if(param1 is SortieSimpleSlot)
         {
            _loc3_ = true;
            _loc4_ = SortieSimpleSlot(param1);
            _loc4_.lockBackground.visible = false;
         }
         if(param1 is RallyLockableSlotRenderer)
         {
            _loc3_ = true;
            _loc5_ = RallyLockableSlotRenderer(param1);
            _loc5_.lockBackground.visible = false;
            if(param2.isLocked)
            {
               _loc5_.orderNo.visible = false;
               _loc5_.slotLabel.visible = false;
               _loc5_.takePlaceFirstTimeBtn.visible = false;
               _loc5_.takePlaceBtn.visible = false;
               _loc5_.lockBackground.visible = true;
            }
         }
         if(param1 is RallySimpleSlotRenderer)
         {
            _loc3_ = true;
            _loc6_ = RallySimpleSlotRenderer(param1);
            _loc6_.commander.visible = param1.index == 0;
            if(param2.isLegionaries)
            {
               _loc6_.orderNo.visible = false;
               _loc6_.commander.visible = true;
               _loc6_.commander.gotoAndStop(ICON_LEGIONARY);
            }
         }
         if(param1 is SortieSlot)
         {
            _loc3_ = true;
            _loc7_ = SortieSlot(param1);
            _loc8_ = SortieSlotVO(param2);
            _loc7_.setStatus(_loc8_.playerStatus);
            _loc7_.candidateRating.text = _loc8_.rating;
            if(!_loc8_.isClosed)
            {
               if(_loc8_.isCommanderState)
               {
                  if(_loc8_.player)
                  {
                     updateSlotRemoveBtn(_loc7_,_loc7_.index > 0,ButtonIconTextTransparent.ICON_CROSS,this._removeBtnProps);
                  }
               }
               else
               {
                  _loc9_ = _loc8_.player && UserTags.isCurrentPlayer(_loc8_.player.tags);
                  _loc7_.removeBtn.visible = _loc9_;
                  if(_loc9_)
                  {
                     updateSlotRemoveBtn(_loc7_,_loc9_,ButtonIconTextTransparent.ICON_CROSS,this._removeBtnProps);
                  }
               }
               _loc7_.statusIndicator.visible = true;
            }
            else
            {
               updateSlotRemoveBtn(_loc7_,_loc8_.isCommanderState,ButtonIconTextTransparent.ICON_NO_ICON,this._lockBtnProps,CYBERSPORT.WINDOW_UNIT_UNLOCKSLOT);
               _loc7_.statusIndicator.visible = false;
            }
            if(_loc8_.isFreezed)
            {
               _loc7_.removeBtn.visible = false;
               _loc7_.vehicleBtn.enabled = false;
            }
            if(_loc8_.player)
            {
               _loc7_.setSpeakers(_loc8_.player.isPlayerSpeaking,true);
               _loc7_.selfBg.visible = UserTags.isCurrentPlayer(_loc8_.player.tags);
            }
            else
            {
               _loc7_.selfBg.visible = false;
               _loc7_.setSpeakers(false,true);
            }
            _loc7_.updateVoiceWave();
            if(param2.isLocked)
            {
               _loc7_.statusIndicator.visible = false;
               _loc7_.gunnerIcon.visible = false;
               _loc7_.btnConfigure.visible = false;
               _loc7_.typeFilters.visible = false;
               _loc7_.vehicleBtn.visible = false;
            }
            else if(_loc8_.roleIcon != Values.EMPTY_STR)
            {
               _loc7_.gunnerIcon.x = Math.round(_loc7_.x + _loc7_.slotLabel.x + _loc7_.slotLabel.textWidth + GUN_ICON_H_OFFSET | 0);
               _loc7_.gunnerIcon.y = Math.round(_loc7_.y + _loc7_.slotLabel.y + PIXEL_PADDING);
               _loc7_.gunnerIcon.visible = true;
               _loc7_.gunnerIcon.gotoAndStop(_loc8_.roleIcon);
            }
            else
            {
               _loc7_.gunnerIcon.visible = false;
            }
            if(_loc8_.selectedVehicle != null && _loc8_.selectedVehicle.state == FROZEN_VEHICLE_STATE)
            {
               _loc7_.vehicleBtn.showFrozenIcon = _loc8_.hasFrozenVehicle;
            }
         }
         if(!_loc3_)
         {
            App.utils.asserter.assert(false,"Wrong slot type passed \'" + getQualifiedClassName(param1));
         }
      }
      
      override protected function isShowSlotRestrictions(param1:RallySimpleSlotRenderer, param2:IRallySlotVO) : Boolean
      {
         return false;
      }
      
      override protected function onDispose() : void
      {
         this._removeBtnProps = null;
         this._lockBtnProps = null;
         this._vehBtnProps = null;
         super.onDispose();
      }
   }
}
