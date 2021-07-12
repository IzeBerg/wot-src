package net.wg.gui.battle.views.minimap.components.entries.arty
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   
   public class ArtyMarkerMinimapEntry extends BattleUIComponent
   {
       
      
      public var animMc:MovieClip = null;
      
      public function ArtyMarkerMinimapEntry()
      {
         super();
         MinimapEntryController.instance.registerScalableEntry(this);
      }
      
      override protected function onDispose() : void
      {
         this.animMc.stop();
         this.animMc = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         this.animMc.visible = true;
         this.animMc.gotoAndPlay(1);
      }
   }
}
