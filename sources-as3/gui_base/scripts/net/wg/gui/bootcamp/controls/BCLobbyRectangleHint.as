package net.wg.gui.bootcamp.controls
{
   import flash.display.MovieClip;
   
   public class BCLobbyRectangleHint extends BCHighlightRendererBase
   {
      
      private static const PADDING:Number = 9;
      
      private static const SCALE_FACTOR:Number = 0.0075;
       
      
      public var fxMask:MovieClip = null;
      
      public var border:MovieClip = null;
      
      public var fx:MovieClip = null;
      
      public function BCLobbyRectangleHint()
      {
         super();
      }
      
      override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         this.fxMask.width = param1;
         this.fxMask.height = param2;
         if(this.border.mcBorder)
         {
            this.border.mcBorder.width = param1 + (PADDING << 1);
            this.border.mcBorder.height = param2 + (PADDING << 1);
         }
         this.fx.scaleX = this.fx.scaleY = param2 * SCALE_FACTOR;
         this.fx.x = (this.border.width >> 1) - PADDING;
         this.fx.y = (this.border.height >> 1) - PADDING;
         if(this.border.visible != param3)
         {
            this.border.visible = param3;
         }
      }
      
      override protected function onDispose() : void
      {
         this.fxMask = null;
         this.border = null;
         this.fx = null;
         super.onDispose();
      }
   }
}
