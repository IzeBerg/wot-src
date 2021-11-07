package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   
   public class BattleResultsMedalsList extends MedalsList
   {
       
      
      public var bgShape:MovieClip = null;
      
      public function BattleResultsMedalsList()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bgShape.width = width;
         this.bgShape.height = height;
      }
      
      override protected function onDispose() : void
      {
         this.bgShape = null;
         super.onDispose();
      }
   }
}
