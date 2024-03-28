package net.wg.gui.lobby.personalMissions.components
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalMissionVehicleAward extends UIComponentEx
   {
       
      
      public var loader:UILoaderAlt = null;
      
      public function PersonalMissionVehicleAward()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.loader.x = -this.loader.width >> 1;
            this.loader.y = -this.loader.height >> 1;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.loader.autoSize = false;
         this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.loader.dispose();
         this.loader = null;
         super.onDispose();
      }
      
      public function setVehicleSrc(param1:String) : void
      {
         this.loader.source = param1;
      }
      
      private function onLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateSize();
      }
   }
}
