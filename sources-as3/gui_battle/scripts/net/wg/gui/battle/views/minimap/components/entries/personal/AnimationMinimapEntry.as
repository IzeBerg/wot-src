package net.wg.gui.battle.views.minimap.components.entries.personal
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.components.entries.vehicle.MarkerTopAnimation;
   
   public class AnimationMinimapEntry extends BattleUIComponent
   {
       
      
      public var mcTopAnimation:MarkerTopAnimation = null;
      
      public var mcBearer:MovieClip = null;
      
      public function AnimationMinimapEntry()
      {
         super();
         this.mcBearer.visible = false;
         this.mcBearer.stop();
         MinimapEntryController.instance.registerScalableEntry(this);
      }
      
      public function setAnimation(param1:String) : void
      {
         this.mcTopAnimation.playAnim(param1);
      }
      
      public function setFlagBearer(param1:Boolean) : void
      {
         if(param1)
         {
            this.mcBearer.visible = true;
            this.mcBearer.play();
         }
         else
         {
            this.mcBearer.visible = false;
            this.mcBearer.stop();
         }
      }
      
      override protected function onDispose() : void
      {
         this.mcTopAnimation = null;
         this.mcBearer = null;
         MinimapEntryController.instance.unregisterScalableEntry(this);
         super.onDispose();
      }
   }
}
