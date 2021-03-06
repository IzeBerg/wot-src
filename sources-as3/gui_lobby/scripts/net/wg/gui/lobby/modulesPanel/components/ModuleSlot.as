package net.wg.gui.lobby.modulesPanel.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
   import net.wg.gui.lobby.modulesPanel.interfaces.IModuleSlot;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class ModuleSlot extends DeviceSlot implements IModuleSlot
   {
       
      
      public var levelMC:MovieClip = null;
      
      public var disabledBg:MovieClip = null;
      
      public var icon:ModuleTypesUIWithFill = null;
      
      public function ModuleSlot()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.mouseEnabled = this.icon.mouseChildren = false;
         this.levelMC.mouseEnabled = this.levelMC.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.levelMC = null;
         this.disabledBg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(slotData && isInvalid(InvalidationType.DATA))
         {
            this.levelMC.gotoAndStop(slotData.level);
            this.icon.setModuleTypeIcon(slotData.slotType);
            _loc1_ = slotData.extraModuleInfo;
            if(isEmpty() || StringUtils.isEmpty(_loc1_))
            {
               this.icon.hideExtraIcon();
            }
            else
            {
               this.icon.showExtraIcon();
               this.icon.setExtraIconBySource(_loc1_);
            }
            invalidateState();
         }
         if(this.disabledBg && isInvalid(InvalidationType.STATE))
         {
            this.disabledBg.visible = slotData && slotData.isDisabledBgVisible;
         }
      }
      
      public function playAnimation() : void
      {
      }
      
      public function resetAnimation() : void
      {
      }
   }
}
