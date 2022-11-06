package net.wg.gui.bootcamp.controls
{
   import flash.display.BlendMode;
   
   public class BCIconTextBigButtonFx extends BCHighlightRendererBase
   {
      
      private static const OFFSET:Number = 2;
       
      
      public var glowBtn:BCLobbyTintHint = null;
      
      public function BCIconTextBigButtonFx()
      {
         super();
         this.blendMode = BlendMode.ADD;
      }
      
      override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         y += OFFSET;
         this.glowBtn.setProperties(param1,param2 - OFFSET,param3);
      }
      
      override protected function onDispose() : void
      {
         this.glowBtn.dispose();
         this.glowBtn = null;
         super.onDispose();
      }
   }
}
