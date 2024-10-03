package net.wg.white_tiger.gui.battle.views.wtMinimap
{
   import flash.display.Sprite;
   import net.wg.gui.battle.views.minimap.containers.MinimapEntriesContainer;
   
   public class WTDeploymentMapEntriesContainer extends MinimapEntriesContainer
   {
       
      
      public var deploymentPoints:Sprite = null;
      
      public function WTDeploymentMapEntriesContainer()
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
