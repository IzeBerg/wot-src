package net.wg.gui.battle.commander.views.spawnMenu.items.components
{
   import flash.display.BlendMode;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class AllyVehicleItemIcon extends BattleUIComponent
   {
       
      
      public var normalIconLayout:UILoaderAlt = null;
      
      public var hoveredIconLayout:UILoaderAlt = null;
      
      public function AllyVehicleItemIcon()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hoveredIconLayout.blendMode = BlendMode.SCREEN;
      }
      
      override protected function onDispose() : void
      {
         this.normalIconLayout.dispose();
         this.normalIconLayout = null;
         this.hoveredIconLayout.dispose();
         this.hoveredIconLayout = null;
         super.onDispose();
      }
      
      public function set source(param1:String) : void
      {
         this.normalIconLayout.source = this.hoveredIconLayout.source = param1;
      }
   }
}
