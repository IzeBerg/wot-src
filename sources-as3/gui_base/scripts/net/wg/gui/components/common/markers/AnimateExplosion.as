package net.wg.gui.components.common.markers
{
   public class AnimateExplosion extends HealthBarAnimatedPart
   {
       
      
      public function AnimateExplosion()
      {
         super();
      }
      
      public function setColorAndDamageType(param1:String, param2:String) : void
      {
         setAnimationType(param1 + "_" + param2);
      }
   }
}
