package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.eventBattle.views.shared.EventDeploymentMapView;
   
   public class EventBossTeleportViewMeta extends EventDeploymentMapView
   {
       
      
      public var onTeleportPointClick:Function;
      
      public var onCancel:Function;
      
      public function EventBossTeleportViewMeta()
      {
         super();
      }
      
      public function onTeleportPointClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onTeleportPointClick,"onTeleportPointClick" + Errors.CANT_NULL);
         this.onTeleportPointClick(param1);
      }
      
      public function onCancelS() : void
      {
         App.utils.asserter.assertNotNull(this.onCancel,"onCancel" + Errors.CANT_NULL);
         this.onCancel();
      }
   }
}
