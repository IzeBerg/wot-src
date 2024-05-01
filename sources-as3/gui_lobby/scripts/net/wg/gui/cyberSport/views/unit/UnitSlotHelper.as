package net.wg.gui.cyberSport.views.unit
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.ButtonIconTextTransparent;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.rally.controls.BaseRallySlotHelper;
   import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.IRallySlotWithRating;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.gui.rally.vo.RallySlotVO;
   import net.wg.gui.utils.VO.UnitSlotProperties;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   
   public class UnitSlotHelper extends BaseRallySlotHelper
   {
      
      private static const DESELECTED_VEHICLE_LEVEL_ALPHA:Number = 0.33;
      
      private static const SLOT_LABEL_GAP:Number = 10;
      
      private static const DEFAULT_NUMBER_TEXT:String = "0";
      
      private static const DEFAULT_STRING_TEXT:String = "";
      
      private static const UNLOCK_SLOT_KEY:String = "unlockSlot";
      
      private static const LOCK_SLOT_KEY:String = "lockSlot";
       
      
      protected var removeBtnProps:UnitSlotProperties;
      
      protected var lockBtnProps:UnitSlotProperties;
      
      public function UnitSlotHelper()
      {
         super();
         this.removeBtnProps = new UnitSlotProperties(237,23);
         this.lockBtnProps = new UnitSlotProperties(273,147);
      }
      
      private static function updateSlotRemoveBtn(param1:SlotRenderer, param2:Boolean, param3:String, param4:UnitSlotProperties, param5:String) : void
      {
         if(param1 != null && param1.removeBtn != null)
         {
            param1.removeBtn.visible = param2;
            param1.removeBtn.icon = param3;
            param1.removeBtn.width = param4.width;
            param1.removeBtn.x = param4.x;
            param1.removeBtn.label = param5;
         }
      }
      
      private static function onSlotLabelRollOverHandler(param1:RallySimpleSlotRenderer, param2:RallySlotVO) : void
      {
         if(param2.isClosed)
         {
            App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_SLOTLABELCLOSED);
         }
         else if(param2.compatibleVehiclesCount == 0 && !param2.player)
         {
            if(param2.isCommanderState)
            {
               if(param2.restrictions && (param2.restrictions[0] || param2.restrictions[1]))
               {
                  App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT,null,param1.index,param2.rallyIdx);
               }
            }
            else
            {
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_SLOTLABELUNAVAILABLE);
            }
         }
         else if(param2.player)
         {
            App.toolTipMgr.show(param2.player.getToolTip());
         }
      }
      
      private static function onTakePlaceBtnRollOverHandler() : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_TAKEPLACEBTN);
      }
      
      private static function onTakePlaceFirstTimeBtnRollOverHandler() : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_TAKEPLACEFIRSTTIMEBTN);
      }
      
      private static function onVehicleBtnRollOverHandler(param1:RallySimpleSlotRenderer, param2:RallySlotVO, param3:* = null) : void
      {
         var _loc4_:ITooltipFormatter = null;
         switch(param1.vehicleBtn.currentState)
         {
            case CSVehicleButton.CHOOSE_VEHICLE:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_SELECTVEHICLE);
               break;
            case CSVehicleButton.DEFAULT_STATE:
               App.toolTipMgr.showComplex(TOOLTIPS.MEDALION_NOVEHICLE);
               break;
            case CSVehicleButton.SELECTED_VEHICLE:
               if(param3 && param3.type == CSVehicleButton.ALERT_DATA_TYPE)
               {
                  _loc4_ = App.toolTipMgr.getNewFormatter();
                  _loc4_.addHeader(param3.state);
                  _loc4_.addBody(TOOLTIPS.CYBERSPORT_UNIT_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY,true);
                  App.toolTipMgr.showComplex(_loc4_.make());
               }
               else
               {
                  App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT_SELECTED,null,param1.index,param2.rallyIdx);
               }
               break;
            default:
               App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT,null,param1.index,param2.rallyIdx);
         }
      }
      
      private static function setPlayerRating(param1:IRallySimpleSlotRenderer, param2:RallySlotVO) : void
      {
         var _loc3_:IRallySlotWithRating = null;
         var _loc4_:TextField = null;
         var _loc5_:TextField = null;
         if(param1 is IRallySlotWithRating)
         {
            _loc3_ = IRallySlotWithRating(param1);
            _loc4_ = _loc3_.slotLabelTextField;
            _loc5_ = _loc3_.ratingTextField;
            _loc3_.setRatingLabelHtmlText(param2.player.rating);
            _loc5_.visible = true;
            _loc4_.width = _loc5_.x + _loc5_.width - _loc4_.x - _loc5_.textWidth - SLOT_LABEL_GAP;
         }
      }
      
      override public function initControlsState(param1:IRallySimpleSlotRenderer) : void
      {
         var _loc2_:SimpleSlotRenderer = null;
         var _loc3_:SlotRenderer = null;
         super.initControlsState(param1);
         if(param1 is SimpleSlotRenderer)
         {
            _loc2_ = SimpleSlotRenderer(param1);
            if(_loc2_.ratingTF != null)
            {
               _loc2_.ratingTF.text = DEFAULT_STRING_TEXT;
               _loc2_.ratingTF.visible = false;
            }
            _loc2_.lockBackground.visible = false;
         }
         if(param1 is SlotRenderer)
         {
            _loc3_ = SlotRenderer(param1);
            _loc3_.setStatus(0);
            if(_loc3_.ratingTF != null)
            {
               _loc3_.ratingTF.text = DEFAULT_STRING_TEXT;
               _loc3_.ratingTF.visible = false;
            }
            _loc3_.levelLbl.mouseEnabled = false;
            _loc3_.removeBtn.visible = false;
            _loc3_.levelLbl.visible = true;
            _loc3_.levelLbl.text = DEFAULT_NUMBER_TEXT;
            _loc3_.levelLbl.alpha = DESELECTED_VEHICLE_LEVEL_ALPHA;
            _loc3_.lockBackground.visible = false;
         }
      }
      
      override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
      {
         var _loc5_:RallySlotVO = null;
         var _loc6_:RallySimpleSlotRenderer = null;
         var _loc7_:SlotRenderer = null;
         var _loc8_:String = null;
         super.onControlRollOver(param1,param2,param3,param4);
         if(!param3)
         {
            return;
         }
         if(param2 is RallySimpleSlotRenderer)
         {
            _loc5_ = RallySlotVO(param3);
            _loc6_ = RallySimpleSlotRenderer(param2);
            switch(param1)
            {
               case _loc6_.slotLabel:
                  onSlotLabelRollOverHandler(_loc6_,_loc5_);
                  break;
               case _loc6_.takePlaceBtn:
                  onTakePlaceBtnRollOverHandler();
                  break;
               case _loc6_.takePlaceFirstTimeBtn:
                  onTakePlaceFirstTimeBtnRollOverHandler();
                  break;
               case _loc6_.vehicleBtn:
                  onVehicleBtnRollOverHandler(_loc6_,_loc5_,param4);
            }
         }
         if(param2 is SlotRenderer)
         {
            _loc7_ = SlotRenderer(param2);
            if(param1 == _loc7_.removeBtn && _loc7_.removeBtn.icon == ButtonIconTextTransparent.ICON_LOCK)
            {
               _loc8_ = App.toolTipMgr.getNewFormatter().addHeader(MENU.contextmenu(!!param3.isClosed ? UNLOCK_SLOT_KEY : LOCK_SLOT_KEY),true).addBody(DEFAULT_STRING_TEXT,true).make();
               if(_loc8_.length > 0)
               {
                  App.toolTipMgr.showComplex(_loc8_);
               }
            }
         }
      }
      
      override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
      {
         var _loc3_:SlotRenderer = null;
         var _loc4_:Boolean = false;
         super.updateComponents(param1,param2);
         this.updateCommonControls(param1,param2);
         if(param1)
         {
            if(param1 is SlotRenderer)
            {
               _loc3_ = SlotRenderer(param1);
               if(param2)
               {
                  _loc3_.setStatus(param2.playerStatus);
                  _loc3_.levelLbl.text = String(param2.selectedVehicleLevel);
                  _loc3_.levelLbl.alpha = Boolean(param2.selectedVehicleLevel) ? Number(1) : Number(DESELECTED_VEHICLE_LEVEL_ALPHA);
                  if(!param2.isClosed)
                  {
                     if(param2.isCommanderState)
                     {
                        if(param2.player)
                        {
                           updateSlotRemoveBtn(_loc3_,_loc3_.index > 0,ButtonIconTextTransparent.ICON_CROSS,this.removeBtnProps,DEFAULT_STRING_TEXT);
                        }
                     }
                     else
                     {
                        _loc4_ = false;
                        if(param2 && param2.player)
                        {
                           _loc4_ = param2.player && UserTags.isCurrentPlayer(param2.player.tags);
                        }
                        _loc3_.removeBtn.visible = _loc4_;
                        if(_loc4_)
                        {
                           updateSlotRemoveBtn(_loc3_,_loc4_,ButtonIconTextTransparent.ICON_CROSS,this.removeBtnProps,DEFAULT_STRING_TEXT);
                        }
                     }
                  }
                  _loc3_.statusIndicator.visible = true;
               }
               else
               {
                  updateSlotRemoveBtn(_loc3_,param2.isCommanderState,ButtonIconTextTransparent.ICON_NO_ICON,this.lockBtnProps,CYBERSPORT.WINDOW_UNIT_UNLOCKSLOT);
               }
               if(param2 && param2.player)
               {
                  _loc3_.setSpeakers(param2.player.isPlayerSpeaking,true);
                  _loc3_.selfBg.visible = UserTags.isCurrentPlayer(param2.player.tags);
                  _loc3_.commander.visible = param2.player.isCommander;
               }
               else
               {
                  _loc3_.commander.visible = false;
                  _loc3_.selfBg.visible = false;
                  _loc3_.setSpeakers(false,true);
               }
               _loc3_.orderNo.visible = !_loc3_.commander.visible;
               _loc3_.updateVoiceWave();
            }
         }
      }
      
      private function updateCommonControls(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
      {
         var _loc5_:TextField = null;
         var _loc6_:IRallySlotWithRating = null;
         var _loc3_:RallySlotVO = RallySlotVO(param2);
         var _loc4_:Object = param1;
         if(_loc3_)
         {
            if(!_loc3_.isClosed)
            {
               _loc5_ = _loc4_.ratingTF;
               if(_loc3_.player)
               {
                  if(_loc5_ != null)
                  {
                     setPlayerRating(param1,_loc3_);
                  }
                  formatPlayerName(param1,param2);
               }
               else if(_loc5_ != null)
               {
                  if(param1 is IRallySlotWithRating)
                  {
                     _loc6_ = IRallySlotWithRating(param1);
                     _loc6_.setRatingLabelHtmlText(DEFAULT_STRING_TEXT);
                  }
                  _loc5_.visible = false;
               }
            }
            else
            {
               _loc4_.lockBackground.visible = true;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeBtnProps = null;
         this.lockBtnProps = null;
         super.onDispose();
      }
   }
}
