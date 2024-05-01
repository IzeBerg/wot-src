package net.wg.gui.lobby.missions.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionCardConditionRenderer extends MissionConditionRenderer
   {
       
      
      public var descTFHit:Sprite;
      
      public function MissionCardConditionRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.descTFHit.removeEventListener(MouseEvent.MOUSE_OVER,this.onDescTFHitMouseOverHandler);
         this.descTFHit.removeEventListener(MouseEvent.MOUSE_OUT,this.onDescTFHitMouseOutHandler);
         this.descTFHit = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(rendererData != null && isInvalid(InvalidationType.DATA))
         {
            this.descTFHit.width = descTF.width;
            this.descTFHit.height = descTF.height;
            this.descTFHit.x = descTF.x;
            this.descTFHit.y = descTF.y;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         Sprite(icon).buttonMode = true;
         Sprite(icon).mouseEnabled = true;
         hit.buttonMode = true;
         progressBar.buttonMode = true;
         this.descTFHit.buttonMode = true;
         this.descTFHit.addEventListener(MouseEvent.MOUSE_OVER,this.onDescTFHitMouseOverHandler);
         this.descTFHit.addEventListener(MouseEvent.MOUSE_OUT,this.onDescTFHitMouseOutHandler);
      }
      
      private function onDescTFHitMouseOutHandler(param1:MouseEvent) : void
      {
         hideToolTip();
      }
      
      private function onDescTFHitMouseOverHandler(param1:MouseEvent) : void
      {
         showTooltip();
      }
   }
}
