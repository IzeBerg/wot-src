package net.wg.gui.battle.mapsTraining.views.minimap
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   
   public class ShootingPointMinimapEntry extends BattleUIComponent
   {
       
      
      public function ShootingPointMinimapEntry()
      {
         super();
         MinimapEntryController.instance.registerScalableEntry(this);
      }
      
      public function setState(param1:String, param2:Boolean = false) : void
      {
         gotoAndPlay(param1);
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this);
         super.onDispose();
      }
   }
}
