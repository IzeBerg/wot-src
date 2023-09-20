package net.wg.gui.components.crosshairPanel.components.wt
{
   import flash.display.MovieClip;
   
   public class PlasmaIndicator extends MovieClip
   {
      
      private static const VALUE_LABEL:String = "value";
      
      private static const VALUE_LABEL_END:String = "end";
       
      
      public var wtReticle:MovieClip = null;
      
      public var plasmaDamageIndicator:PlasmaDamageTF = null;
      
      public function PlasmaIndicator()
      {
         super();
         this.visible = false;
         this.plasmaDamageIndicator.visible = false;
      }
      
      public function showPlasma(param1:Number, param2:Boolean, param3:String) : void
      {
         this.visible = true;
         var _loc4_:Boolean = param1 != 0;
         if(this.plasmaDamageIndicator)
         {
            this.plasmaDamageIndicator.label = param3;
            this.plasmaDamageIndicator.visible = _loc4_;
         }
         if(!param2)
         {
            this.wtReticle.gotoAndStop(VALUE_LABEL + param1 + VALUE_LABEL_END);
            return;
         }
         this.wtReticle.gotoAndPlay(VALUE_LABEL + param1);
      }
      
      public function setPlasmaDamageIndicatorPosition(param1:Number, param2:Number) : void
      {
         this.plasmaDamageIndicator.x = param1;
         this.plasmaDamageIndicator.y = param2;
      }
      
      public function setPlasmaDamageIndicatorScale(param1:Number) : void
      {
         this.plasmaDamageIndicator.scaleX = this.plasmaDamageIndicator.scaleY = param1;
      }
   }
}
