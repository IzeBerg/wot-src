package net.wg.gui.battle.eventBattle.views.minimap
{
   import flash.display.Sprite;
   import net.wg.gui.battle.views.minimap.containers.MinimapEntriesContainer;
   
   public class EventDeploymentMapEntriesContainer extends MinimapEntriesContainer
   {
       
      
      public var deploymentPoints:Sprite = null;
      
      public function EventDeploymentMapEntriesContainer()
      {
         super();
         this.deploymentPoints.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.deploymentPoints = null;
         super.onDispose();
      }
      
      public function set isDeploymentMode(param1:Boolean) : void
      {
         this.deploymentPoints.visible = param1;
      }
   }
}
