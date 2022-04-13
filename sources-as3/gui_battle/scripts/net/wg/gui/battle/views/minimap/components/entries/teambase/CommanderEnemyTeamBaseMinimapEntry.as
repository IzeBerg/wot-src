package net.wg.gui.battle.views.minimap.components.entries.teambase
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.BATTLE_MINIMAP_CONSTS;
   import net.wg.gui.battle.views.minimap.BaseMinimap;
   import scaleform.gfx.MouseEventEx;
   
   public class CommanderEnemyTeamBaseMinimapEntry extends EnemyTeamBaseMinimapEntry
   {
       
      
      public var entryHit:Sprite = null;
      
      public function CommanderEnemyTeamBaseMinimapEntry()
      {
         super();
         this.entryHit.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.entryHit.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.entryHit.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         mouseEnabled = mouseChildren = true;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         mouseEnabled = mouseChildren = true;
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BaseMinimap = null;
         if(param1 is MouseEventEx && param1.target == this.entryHit)
         {
            _loc2_ = BaseMinimap.getParentMinimap(this);
            if(_loc2_)
            {
               _loc2_.onEntryMouseClickEvent(param1,x,y);
            }
         }
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:BaseMinimap = null;
         if(param1 is MouseEventEx && param1.target == this.entryHit)
         {
            _loc2_ = BaseMinimap.getParentMinimap(this);
            if(_loc2_)
            {
               _loc2_.onHoverEntry(-1);
               _loc2_.handleMouseOverUIMinimap(false);
            }
         }
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:BaseMinimap = null;
         if(param1 is MouseEventEx && param1.target == this.entryHit)
         {
            _loc2_ = BaseMinimap.getParentMinimap(this);
            if(_loc2_)
            {
               _loc2_.onHoverEntry(BATTLE_MINIMAP_CONSTS.CURSOR_ENTRY_BASE_ATTACK);
               _loc2_.handleMouseOverUIMinimap(true);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.entryHit.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.entryHit.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.entryHit.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.entryHit = null;
         super.onDispose();
      }
   }
}
