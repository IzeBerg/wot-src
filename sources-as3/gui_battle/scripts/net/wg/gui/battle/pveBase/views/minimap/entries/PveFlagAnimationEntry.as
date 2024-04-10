package net.wg.gui.battle.pveBase.views.minimap.entries
{
   public class PveFlagAnimationEntry extends PveScalableEntry
   {
      
      public static const ANIMATE:String = "animate";
       
      
      public function PveFlagAnimationEntry()
      {
         super();
      }
      
      public function animate() : void
      {
         gotoAndPlay(ANIMATE);
      }
   }
}
