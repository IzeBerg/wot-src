package net.wg.gui.lobby.rankedBattles19.components.rankAward
{
   import flash.geom.Point;
   import net.wg.gui.lobby.rankedBattles19.components.ImageContainer;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public class AwardLeague extends UIComponentEx implements IUIComponentEx
   {
      
      private static const IMAGE_POSITIONS:Point = new Point(-250,-140);
       
      
      public var league:ImageContainer = null;
      
      public function AwardLeague()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.league.setImgPoint(IMAGE_POSITIONS);
         this.league.setSource(RES_ICONS.MAPS_ICONS_RANKEDBATTLES_LEAGUE_LEAGUE_INDEFINITE_PROGRESS);
      }
      
      override protected function onDispose() : void
      {
         this.league.dispose();
         this.league = null;
         super.onDispose();
      }
   }
}
