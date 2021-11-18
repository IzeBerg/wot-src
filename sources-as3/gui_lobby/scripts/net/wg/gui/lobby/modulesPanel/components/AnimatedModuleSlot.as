package net.wg.gui.lobby.modulesPanel.components
{
   import flash.display.DisplayObject;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.modulesPanel.interfaces.IModuleSlot;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   
   public class AnimatedModuleSlot extends UIComponentEx implements IModuleSlot
   {
      
      private static const ANIMATION_START:String = "startAnimation";
       
      
      public var moduleSlot:ModuleSlot;
      
      public var moduleAnim:Image;
      
      public function AnimatedModuleSlot()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.moduleAnim.source = RES_ICONS.getModuleType(this.moduleSlot.type);
         }
      }
      
      override protected function onDispose() : void
      {
         this.moduleSlot.dispose();
         this.moduleSlot = null;
         this.moduleAnim.dispose();
         this.moduleAnim = null;
         super.onDispose();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return this.moduleSlot.canPlaySound(param1);
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.moduleSlot.getHitArea();
      }
      
      public function getSoundId() : String
      {
         return this.moduleSlot.getSoundId();
      }
      
      public function getSoundType() : String
      {
         return this.moduleSlot.getSoundType();
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.moduleSlot.getTargetButton();
      }
      
      public function playAnimation() : void
      {
         gotoAndPlay(ANIMATION_START);
      }
      
      public function resetAnimation() : void
      {
         gotoAndStop(1);
      }
      
      public function update(param1:Object) : void
      {
         this.moduleSlot.update(param1);
         invalidateData();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.moduleSlot.enabled = param1;
      }
      
      public function get type() : String
      {
         return this.moduleSlot.type;
      }
      
      public function set type(param1:String) : void
      {
         this.moduleSlot.type = param1;
      }
      
      public function get slotIndex() : int
      {
         return this.moduleSlot.slotIndex;
      }
      
      public function set slotIndex(param1:int) : void
      {
         this.moduleSlot.slotIndex = param1;
      }
      
      public function get slotData() : DeviceSlotVO
      {
         return this.moduleSlot.slotData;
      }
      
      public function get button() : Button
      {
         return this.moduleSlot.button;
      }
      
      public function get label() : String
      {
         return this.moduleSlot.label;
      }
      
      public function set label(param1:String) : void
      {
         this.moduleSlot.label = param1;
      }
      
      public function get autoRepeat() : Boolean
      {
         return this.moduleSlot.autoRepeat;
      }
      
      public function set autoRepeat(param1:Boolean) : void
      {
         this.moduleSlot.autoRepeat = param1;
      }
      
      public function get autoSize() : String
      {
         return this.moduleSlot.autoSize;
      }
      
      public function set autoSize(param1:String) : void
      {
         this.moduleSlot.autoSize = param1;
      }
      
      public function get data() : Object
      {
         return this.moduleSlot.data;
      }
      
      public function set data(param1:Object) : void
      {
         this.moduleSlot.data;
      }
      
      public function get selected() : Boolean
      {
         return this.moduleSlot.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this.moduleSlot.selected = param1;
      }
      
      public function get soundEnabled() : Boolean
      {
         return this.moduleSlot.soundEnabled;
      }
      
      public function set soundEnabled(param1:Boolean) : void
      {
         this.moduleSlot.soundEnabled = param1;
      }
      
      public function get soundId() : String
      {
         return this.moduleSlot.soundId;
      }
      
      public function set soundId(param1:String) : void
      {
         this.moduleSlot.soundId = param1;
      }
      
      public function get soundType() : String
      {
         return this.moduleSlot.soundType;
      }
      
      public function set soundType(param1:String) : void
      {
         this.moduleSlot.soundType = param1;
      }
      
      public function get toggle() : Boolean
      {
         return this.moduleSlot.toggle;
      }
      
      public function set toggle(param1:Boolean) : void
      {
         this.moduleSlot.toggle = param1;
      }
      
      public function get mouseEnabledOnDisabled() : Boolean
      {
         return this.moduleSlot.mouseEnabledOnDisabled;
      }
      
      public function set mouseEnabledOnDisabled(param1:Boolean) : void
      {
         this.moduleSlot.mouseEnabledOnDisabled = param1;
      }
      
      public function get tooltip() : String
      {
         return this.moduleSlot.tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this.moduleSlot.tooltip = param1;
      }
   }
}
