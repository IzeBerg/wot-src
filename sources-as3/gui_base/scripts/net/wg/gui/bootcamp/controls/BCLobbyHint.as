package net.wg.gui.bootcamp.controls
{
   import flash.display.MovieClip;
   
   public class BCLobbyHint extends BCHighlightRendererBase
   {
      
      private static const PADDING:Number = 9;
      
      private static const GLOW_SCALE_X:Number = 0.00514;
      
      private static const GLOW_SCALE_Y:Number = 0.0052;
       
      
      public var border:MovieClip = null;
      
      public var fx:MovieClip = null;
      
      public function BCLobbyHint()
      {
         super();
      }
      
      override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         if(this.border.mcBorder)
         {
            this.border.mcBorder.width = param1 + (PADDING << 1);
            this.border.mcBorder.height = param2 + (PADDING << 1);
         }
         if(this.border.visible != param3)
         {
            this.border.visible = param3;
         }
         this.fx.scaleX = param1 * GLOW_SCALE_X;
         this.fx.scaleY = param2 * GLOW_SCALE_Y;
         this.fx.x = param1 >> 1;
         this.fx.y = param2 >> 1;
      }
      
      override protected function onDispose() : void
      {
         this.border = null;
         this.fx = null;
         super.onDispose();
      }
   }
}
