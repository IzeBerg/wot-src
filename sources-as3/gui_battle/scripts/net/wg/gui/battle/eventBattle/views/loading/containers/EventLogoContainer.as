package net.wg.gui.battle.eventBattle.views.loading.containers
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class EventLogoContainer extends UIComponentEx
   {
      
      private static const LOGO_X_OFFSET:Number = -37;
      
      private static const LOGO_Y_OFFSET:Number = -250;
       
      
      public var logo:UILoaderAlt = null;
      
      public function EventLogoContainer()
      {
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         this.logo.x = (param1 >> 1) + LOGO_X_OFFSET;
         this.logo.y = (param2 >> 1) + LOGO_Y_OFFSET;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.logo.source = RES_ICONS.MAPS_ICONS_EVENT_LOADING_INTROLOGO;
      }
      
      override protected function onDispose() : void
      {
         this.logo.dispose();
         this.logo = null;
         super.onDispose();
      }
   }
}
