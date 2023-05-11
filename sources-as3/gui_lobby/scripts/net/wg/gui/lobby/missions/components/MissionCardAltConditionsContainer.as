package net.wg.gui.lobby.missions.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionCardAltConditionsContainer extends MissionAltConditionsContainer
   {
       
      
      public var labelTFHit:Sprite;
      
      public function MissionCardAltConditionsContainer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            labelTF.y = separator.y + separator.height ^ 0;
            this.labelTFHit.x = labelTF.x;
            this.labelTFHit.y = labelTF.y;
            this.labelTFHit.width = labelTF.width;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.labelTFHit.buttonMode = true;
         this.labelTFHit.addEventListener(MouseEvent.ROLL_OUT,this.onContainerRollOutHandler);
         this.labelTFHit.addEventListener(MouseEvent.ROLL_OVER,this.onContainerRollOverHandler);
      }
      
      override protected function onDispose() : void
      {
         this.labelTFHit.removeEventListener(MouseEvent.ROLL_OUT,this.onContainerRollOutHandler);
         this.labelTFHit.removeEventListener(MouseEvent.ROLL_OVER,this.onContainerRollOverHandler);
         this.labelTFHit = null;
         super.onDispose();
      }
      
      private function onContainerRollOverHandler(param1:MouseEvent) : void
      {
         showTooltip();
      }
      
      private function onContainerRollOutHandler(param1:MouseEvent) : void
      {
         hideTooltip();
      }
   }
}
