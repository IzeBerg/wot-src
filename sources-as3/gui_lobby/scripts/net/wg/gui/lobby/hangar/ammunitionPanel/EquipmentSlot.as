package net.wg.gui.lobby.hangar.ammunitionPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.modulesPanel.components.DeviceSlot;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class EquipmentSlot extends DeviceSlot
   {
      
      private static const EMPTY:String = "empty";
      
      private static const AFFECTS_TTC_ALPHA:Number = 1;
      
      private static const NOT_AFFECTS_TTC_ALPHA:Number = 0.5;
       
      
      public var moduleType:ModuleTypesUIWithFill = null;
      
      public var locked:MovieClip = null;
      
      public var alertIcon:Image = null;
      
      public var greenBorderMc:MovieClip = null;
      
      public var equipSlotHighlight:MovieClip = null;
      
      public var countTF:TextField = null;
      
      public var equipSlotOverlay:MovieClip = null;
      
      public var background:MovieClip = null;
      
      public function EquipmentSlot()
      {
         super();
         preventAutosizing = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.equipSlotOverlay)
         {
            this.equipSlotOverlay.mouseEnabled = this.equipSlotOverlay.mouseChildren = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this.moduleType.dispose();
         this.moduleType = null;
         this.locked = null;
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.greenBorderMc = null;
         this.equipSlotHighlight = null;
         this.countTF = null;
         this.equipSlotOverlay = null;
         this.background = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         super.draw();
         if(slotData != null && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = isEmpty();
            _loc2_ = !!_loc1_ ? EMPTY : slotData.moduleLabel;
            _loc3_ = type == FITTING_TYPES.BOOSTER;
            _loc4_ = slotData.affectsAtTTC;
            this.moduleType.setModuleTypeIcon(_loc2_);
            this.locked.visible = !!_loc3_ ? Boolean(false) : (!!_loc1_ ? Boolean(false) : Boolean(!slotData.removable));
            this.moduleType.alpha = _loc1_ || _loc4_ ? Number(AFFECTS_TTC_ALPHA) : Number(NOT_AFFECTS_TTC_ALPHA);
            this.greenBorderMc.visible = slotData.highlight;
            this.alertIcon.visible = !_loc4_;
            if(this.alertIcon.visible && StringUtils.isEmpty(this.alertIcon.source))
            {
               this.alertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ICON_ALERT_32X32;
            }
            _loc5_ = slotData.bgHighlightType;
            _loc6_ = StringUtils.isNotEmpty(_loc5_);
            this.equipSlotHighlight.visible = _loc6_;
            if(_loc6_)
            {
               this.equipSlotHighlight.gotoAndStop(_loc5_);
            }
            _loc7_ = StringUtils.isNotEmpty(slotData.overlayType);
            this.equipSlotOverlay.visible = _loc7_;
            if(_loc7_)
            {
               this.equipSlotOverlay.gotoAndStop(slotData.overlayType);
            }
            _loc8_ = slotData.countValue;
            if(_loc8_ > 0 && _loc4_)
            {
               this.countTF.text = _loc8_.toString();
               this.countTF.visible = true;
            }
            else
            {
               this.countTF.visible = false;
            }
         }
      }
   }
}
