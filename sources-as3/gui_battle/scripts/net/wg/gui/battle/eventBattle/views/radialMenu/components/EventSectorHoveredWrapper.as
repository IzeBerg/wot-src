package net.wg.gui.battle.eventBattle.views.radialMenu.components
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.eventBattle.views.radialMenu.EventRadialMenu;
   import net.wg.gui.battle.views.radialMenu.components.SectorHoveredWrapper;
   
   public class EventSectorHoveredWrapper extends SectorHoveredWrapper
   {
       
      
      public var ally:BattleAtlasSprite = null;
      
      public var enemy:BattleAtlasSprite = null;
      
      public function EventSectorHoveredWrapper()
      {
         super();
         this.ally.imageName = BATTLEATLAS.RADIAL_SINGLE_BG_ALLY_HOVER;
         this.enemy.imageName = BATTLEATLAS.RADIAL_SINGLE_BG_ENEMY_HOVER;
      }
      
      public function setRadialState(param1:String) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc2_:Boolean = param1 == EventRadialMenu.DEFAULT_STATE;
         _loc3_ = param1 == EventRadialMenu.ALLY_STATE;
         _loc4_ = param1 == EventRadialMenu.ENEMY_STATE;
         light.visible = _loc2_;
         this.ally.visible = _loc3_;
         this.enemy.visible = _loc4_;
      }
   }
}
