package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.TimersPanel;
   
   public class EventDestroyTimersPanelMeta extends TimersPanel
   {
       
      
      public var setComponentsOverlay:Function;
      
      public function EventDestroyTimersPanelMeta()
      {
         super();
      }
      
      public function setComponentsOverlayS(param1:Boolean, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setComponentsOverlay,"setComponentsOverlay" + Errors.CANT_NULL);
         this.setComponentsOverlay(param1,param2);
      }
   }
}
