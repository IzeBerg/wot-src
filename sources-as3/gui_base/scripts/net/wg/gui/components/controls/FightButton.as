package net.wg.gui.components.controls
{
   import flash.geom.Rectangle;
   
   public class FightButton extends SoundButton
   {
       
      
      public function FightButton()
      {
         super();
      }
      
      public function getRectangle() : Rectangle
      {
         var _loc1_:Rectangle = new Rectangle();
         _loc1_.x = this.x + hitMc.x;
         _loc1_.width = hitMc.width;
         return _loc1_;
      }
   }
}
